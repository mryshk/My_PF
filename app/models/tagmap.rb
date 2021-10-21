class Tagmap < ApplicationRecord
  belongs_to :tag, dependent: :destroy
  belongs_to :post, dependent: :destroy

  validates :post_id, presence: true
  validates :tag_id, presence: true
end
