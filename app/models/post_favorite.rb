class PostFavorite < ApplicationRecord
  belongs_to :listener,dependent: :destroy
  belongs_to :post,dependent: :destroy
end
