class Origin < ApplicationRecord
	has_many :coffee

	validates :name, presence: true
end