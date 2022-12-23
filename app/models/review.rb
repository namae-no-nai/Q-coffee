class Review < ApplicationRecord
	belongs_to :user
  belongs_to :coffee
  has_many :review_likes, dependent: :destroy

  validates :content, presence: true
  validates :rating, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 5 }
end