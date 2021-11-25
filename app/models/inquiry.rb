class Inquiry < ApplicationRecord

  # バリデーション
  validates :name, presence: true
  validates :email, presence: true
  validates :message, presence: true
end
