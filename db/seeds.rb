# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Очистка данных
[ Image, Theme, User, Value ].each do |model|
  model.delete_all
  model.reset_pk_sequence
end

# Темы
Theme.create([
  { name: "AUDI", qty_items: 5 },
  { name: "BMW", qty_items: 5 },
  { name: "FORD", qty_items: 5 }
])

# Изображения
Image.create([
  { name: 'Audi A3', file: 'audi_a3.jpg', theme_id: 1 },
  { name: 'Audi A6', file: 'audi_a6.jpg', theme_id: 1 },
  { name: 'Audi A8', file: 'audi_a8.jpg', theme_id: 1 },
  { name: 'Audi Q5', file: 'audi_q5.jpg', theme_id: 1 },
  { name: 'Audi Q7', file: 'audi_q7.jpg', theme_id: 1 },
  { name: 'BMW 3-series', file: 'bmw_3-series.jpg', theme_id: 2 },
  { name: 'BMW 5-series', file: 'bmw_5-series.jpg', theme_id: 2 },
  { name: 'BMW X1', file: 'bmw_x1.jpg', theme_id: 2 },
  { name: 'BMW X5', file: 'bmw_x5.jpg', theme_id: 2 },
  { name: 'BMW X6', file: 'bmw_x6.jpg', theme_id: 2 },
  { name: 'Ford Fiesta', file: 'ford_fiesta.jpg', theme_id: 3 },
  { name: 'Ford Focus', file: 'ford_focus.jpg', theme_id: 3 },
  { name: 'Ford Kuga', file: 'ford_kuga.jpg', theme_id: 3 },
  { name: 'Ford Mondeo', file: 'ford_mondeo.jpg', theme_id: 3 },
  { name: 'Ford Ranger', file: 'ford_ranger.jpg', theme_id: 3 }
])
