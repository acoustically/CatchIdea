class User < ApplicationRecord
	has_many :friends
	has_many :ideas
	validates :email,
		presence: true,
		uniqueness: true
	validates :password,
		presence: true,
		length: { minimum: 6, too_short: "more then 6 letter" }
	validates :name,
		presence: true,
		length: { minimum: 2, too_short: "more then 2 letter" }
end
