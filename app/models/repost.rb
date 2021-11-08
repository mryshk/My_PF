class Repost < ApplicationRecord
  belongs_to :listener
  belongs_to :post
end
