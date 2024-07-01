# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable # rubocop:disable Rails/HasManyOrHasOneDependent

  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 10_000 }
end
