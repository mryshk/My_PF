class GroupChat < ApplicationRecord
  belongs_to :group, dependent: :destroy
  belongs_to :listener, dependent: :destroy
end
