class Coffee < ApplicationRecord
  has_many :reviews, dependent: :delete_all
  belongs_to :origin
  belongs_to :user
end