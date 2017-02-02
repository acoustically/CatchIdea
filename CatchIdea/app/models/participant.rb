class Participant < ApplicationRecord
	belongs_to :idea
	has_many :contents
	validates :user_id, uniqueness: { scope: :idea_id }
end
