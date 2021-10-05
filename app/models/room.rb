class Room < ApplicationRecord
  has_many :listener_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
end
