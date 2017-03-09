class Idea < ApplicationRecord
	has_many :contents
	has_many :participants
	has_and_belongs_to_many :users

	validates :name,
      presence: true
  validates :deadline_time,
      presence: true

	def validate_associated_records_for_users

	end
end
