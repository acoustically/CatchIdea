class User < ApplicationRecord
	has_many :friends
	has_and_belongs_to_many :ideas
=begin
	validates :email,
		presence: true,
		uniqueness: true
	validates :password,
		presence: true,
		length: { minimum: 6, too_short: "more then 6 letter" }
	validates :name,
		presence: true,
		length: { minimum: 2, too_short: "more then 2 letter" }
=end
end
