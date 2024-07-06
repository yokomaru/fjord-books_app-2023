# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :icon

  validate :icon_type

  has_one_attached :icon do |attachable|
    attachable.variant :thumbnail, resize_to_limit: [200, 200]
    attachable.variant :preview, resize_to_limit: [100, 100]
  end

  def icon_atacched?
    icon.attached?
  end

  private

  def icon_type
    extention = %('image/jpeg image/png image/gif')
    return if icon_atacched? && icon.blob.content_type.in?(extention)

    errors.add(:icon, 'はjpegまたはpngまたはgif形式でアップロードしてください')
  end
end
