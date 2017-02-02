class Friend < ApplicationRecord
	belongs_to :user
	has_many :idea
	validates :user_id, uniqueness: { scope: :current_id}
end

