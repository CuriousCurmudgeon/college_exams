class User < ApplicationRecord
  validates :first_name, :last_name, :phone_number, presence: true
  # TODO: There is a probably a more canonical way to format and validate
  # phone numbers. I'm not worrying about that here. This just ensures
  # that the phone number only has digits. I thought about enforcing length
  # as well, but that opens up a whole can of worms around international
  # numbers. Out of scope for this exercise.
  validates :phone_number, numericality: { only_integer: true }
end
