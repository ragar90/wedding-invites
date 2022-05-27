class Guest < ApplicationRecord
  belongs_to :parent_guest, class_name: 'Guest', inverse_of: :co_guests, optional: true
  has_many :co_guests, class_name: 'Guest', foreign_key: :parent_guest_id, inverse_of: :parent_guest
  accepts_nested_attributes_for :co_guests
  enum status: {
    invited: "INVITED",
    confirmed: "CONFIRMED",
    not_attending: "NOT_ATTENDING"
  }

end
