class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'Listener'
  belongs_to :followed, class_name: 'Listener'
end
