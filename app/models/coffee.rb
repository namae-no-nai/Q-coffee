class Coffee < ApplicationRecord
  MAIN_CATEGORIES = %w[taste sensory roast].freeze

  has_many :reviews, dependent: :delete_all
  belongs_to :origin
  belongs_to :user

  validates :name, :farm, :brand, :sensory, :roast, :taste, :store, presence: true
  validates :name, uniqueness: true

  include PgSearch::Model
  pg_search_scope :global_search,
                  against: { name: 'A', farm: 'C', taste: 'B',
                             brand: 'B', sensory: 'B', roast: 'D' },
                  associated_against: {
                    origin: { name: 'A' }
                  },
                  using: {
                    tsearch: { prefix: true }
                  }

  pg_search_scope :category_search,
                  against: { farm: 'A', taste: 'A',
                             brand: 'D', sensory: 'A', roast: 'B' },
                  associated_against: {
                    origin: { name: 'A' }
                  },
                  using: {
                    tsearch: { prefix: true }
                  }
end
