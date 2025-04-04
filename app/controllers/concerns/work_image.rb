module WorkImage
  extend ActiveSupport::Concern

  included do
    before_action :set_current_user, only: [ :show_image ]
  end

  def show_image(theme_id, image_index)
    theme = Theme.find(theme_id)
    images = theme.images.order(:id)
    return unless images.any?

    image = images[image_index]
    {
      index: image_index,
      name: image.name,
      file: image.file_url, # Используем file_url, если есть метод
      image_id: image.id,
      user_valued: current_user_valuation(image.id),
      value: user_rating_value(image.id),
      common_ave_value: image.average_rating,
      images_arr_size: images.size
    }
  end

  private

  def set_current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user_valuation(image_id)
    Value.exists?(user_id: @current_user&.id, image_id: image_id)
  end

  def user_rating_value(image_id)
    Value.find_by(user_id: @current_user&.id, image_id: image_id)&.value || 0
  end
end
