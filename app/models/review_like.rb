class ReviewLike < ApplicationRecord
	belongs_to :user
	belongs_to :review

	has_one :coffee, through: :review
end