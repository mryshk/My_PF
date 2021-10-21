class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'Listener',dependent: :destroy
  belongs_to :followed, class_name: 'Listener',dependent: :destroy
end
