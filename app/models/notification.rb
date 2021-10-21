class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  belongs_to :post, optional: true
  belongs_to :post_commment, optional: true
  belongs_to :active, class_name: 'Listener', optional: true ,dependent: :destroy
  belongs_to :passive, class_name: 'Listener', optional: true ,dependent: :destroy
end
