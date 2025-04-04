class Image < ApplicationRecord
  belongs_to :theme

  def next_image
    Image.where("id > ? AND theme_id = ?", id, theme_id).first
  end

  def prev_image
    Image.where("id < ? AND theme_id = ?", id, theme_id).last
  end

  def file_url
    "pictures/#{file}"
  end
end
