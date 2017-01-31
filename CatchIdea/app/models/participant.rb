class Participant < ApplicationRecord
	belongs_to :idea
	has_many :contents
end
