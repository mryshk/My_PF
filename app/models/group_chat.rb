class GroupChat < ApplicationRecord
  belongs_to :group
  belongs_to :listener
end
