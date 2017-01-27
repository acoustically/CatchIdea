class Idea < ApplicationRecord
	has_many :contents
	has_many :participants
	has_and_belongs_to_many :users

	validates :names,
      presence: true
end
