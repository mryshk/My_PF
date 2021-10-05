class Chat < ApplicationRecord
  belongs_to :listener
  belongs_to :room
end
