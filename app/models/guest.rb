class Guest < ApplicationRecord
  belongs_to :parent_guest, class_name: 'Guest', inverse_of: :co_guests
  has_many :co_guests, class_name: 'Guest', foreign_key: :parent_guest_id, inverse_of: :parent_guest
end
