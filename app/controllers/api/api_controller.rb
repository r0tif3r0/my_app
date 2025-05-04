module Api
  class ApiController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:next_image, :prev_image]

    def next_image
      process_image(:next)
    end

    def prev_image
      process_image(:prev)
    end

    private

    def process_image(direction)
      theme = Theme.find_by(id: params[:theme_id])
      return render_error("Theme not found") unless theme
      return render_error("No images in theme") if theme.images.empty?

      current_index = params[:index].to_i
      images = theme.images.order(:id).to_a
      new_index = calculate_new_index(direction, current_index, images.size)
      
      image = images[new_index]
      return render_error("Image not found") unless image

      render json: image_response(image, new_index)
    rescue => e
      render json: { status: "error", message: e.message }, status: 500
    end

    def calculate_new_index(direction, current_index, length)
      case direction
      when :next then (current_index + 1) % length
      when :prev then (current_index - 1) % length
      else current_index
      end
    end

    def image_response(image, new_index)
      {
        status: "success",
        new_image_index: new_index,
        file: ActionController::Base.helpers.image_path("pictures/#{image.file}"),
        name: image.name,
        image_id: image.id,
        already_rated: current_user_rated?(image),
        user_rating: current_user_rating(image),
        average_rating: image.ave_value,
        theme_id: image.theme.id,
        already_rated_message: I18n.t('work.index.already_rated'),
        your_rating_label: I18n.t('work.index.your_rating'),
        rate_button_text: I18n.t('work.index.rate_button'),
        ave_value_label: I18n.t('work.index.ave_rating'),
      }
    end

    def current_user_rated?(image)
      current_user.values.exists?(image_id: image.id)
    end

    def current_user_rating(image)
      current_user.values.find_by(image_id: image.id)&.value
    end

    def render_error(message)
      render json: { status: "error", message: message }, status: 404
    end
  end
end