module WorkImage
  extend ActiveSupport::Concern

  def show_image(theme_id, index)
    theme_images = Image.theme_images(theme_id)
    image = theme_images[index]

    {
      theme: Theme.find(theme_id).name,
      name: image.name,
      file: image.file,
      index: index,
      images_count: theme_images.size
    }
  end
end
