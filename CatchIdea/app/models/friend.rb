class Friend < ApplicationRecord
	belongs_to :user
	has_many :idea
	validates :email,
		presence: true,
		uniqueness: true
end

