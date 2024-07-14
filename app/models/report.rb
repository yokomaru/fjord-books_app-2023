# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :mentioning_relations, class_name: 'Mention', dependent: :destroy
  has_many :mentioned_relations, class_name: 'Mention', foreign_key: 'mentioned_report_id', dependent: :destroy, inverse_of: :report
  has_many :mentioning_reports, through: :mentioning_relations, source: :mentioned_report
  has_many :mentioned_reports, through: :mentioned_relations, source: :report

  validates :title, presence: true
  validates :content, presence: true

  FORMAT_REPORT_URL = %r{http://localhost:3000/reports/(\d+)/?}

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
    write_error_logs(e)
    errors.add(:base, :report_invalid_save_with_mentions)
    false
  end

  def update_with_mentions(params)
    Report.transaction do
      update!(params)
      self.mentioning_report_ids = fetch_report_ids(content)
    end
  rescue ActiveRecord::RecordInvalid => e
    write_error_logs(e)
    errors.add(:base, :report_invalid_update_with_mentions)
    false
  end

  private

  def fetch_report_ids(content)
    registered_report_ids = Report.all.ids
    report_ids = content.scan(FORMAT_REPORT_URL).flatten.map(&:to_i).map do |report_id|
      report_id if registered_report_ids.include?(report_id)
    end
    report_ids.compact.uniq
  end

  def write_error_logs(error)
    logger.error error.message
    logger.error error.backtrace.join("\n")
  end
end
