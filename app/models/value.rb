class Value < ApplicationRecord
  belongs_to :user
  belongs_to :image
  validates :value, numericality: { in: 1..100 }
end
