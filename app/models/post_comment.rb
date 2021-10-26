class PostComment < ApplicationRecord
  belongs_to :listener
  belongs_to :post
  has_many :notifications
end
