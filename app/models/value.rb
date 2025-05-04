class Value < ApplicationRecord
  belongs_to :user
  belongs_to :image

  validates :value, 
    numericality: { 
      only_integer: true,
      in: 1..10 
    },
    presence: true

  validates :user_id, 
    uniqueness: { 
      scope: :image_id,
      message: "вы уже оценивали это изображение" 
    }
end