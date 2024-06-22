class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :zipcode, length: { maximum: 7 }
  validates :address, length: { maximum: 200 }
  validates :introduction, length: { maximum: 10_000 }

end
