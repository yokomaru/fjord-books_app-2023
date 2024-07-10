# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :mentioning_relations, class_name: 'Mention', dependent: :destroy
  has_many :mentionned_relations, class_name: 'Mention', foreign_key: 'mentioned_report_id', dependent: :destroy, inverse_of: :report
  has_many :mentioning_reports, through: :mentioning_relations, source: :mentioned_report
  has_many :mentioned_reports, through: :mentionned_relations, source: :report

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def save_with_mentions
    Report.transaction do
      save!
      self.mentioning_report_ids = fetch_report_ids(content)
    end
  rescue ActiveRecord::RecordInvalid => e
    logger.error e.message
    logger.error e.backtrace.join("\n")
    errors.add(:report, 'の保存に失敗しました')
    false
  end

  def update_with_mentions(params)
    Report.transaction do
      update!(params)
      self.mentioning_report_ids = fetch_report_ids(content)
    end
  rescue ActiveRecord::RecordInvalid => e
    logger.error e.message
    logger.error e.backtrace.join("\n")
    errors.add(:report, 'の更新に失敗しました')
    false
  end

  private

  def fetch_report_ids(content)
    registered_report_ids = Report.all.ids
    report_ids = URI.extract(content).map do |url|
      matched_report = url.match(%r{http://localhost:3000/reports/(\d+)(/|$)})
      report_id = matched_report[1].to_i if matched_report.present?
      report_id if registered_report_ids.include?(report_id)
    end
    report_ids.compact.uniq
  end
end
