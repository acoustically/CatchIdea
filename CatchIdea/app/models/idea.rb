class Idea < ApplicationRecord
	has_many :contents
	has_many :participants
end
