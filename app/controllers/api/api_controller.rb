module Api
  class ApiController < ApplicationController
    # Отключение проверки CSRF для API
    skip_before_action :verify_authenticity_token, only: [ :next_image, :prev_image ]

    def next_image
      process_image(:next)
    end

    def prev_image
      process_image(:prev)
    end

    private

    def process_image(direction)
      theme_id = params[:theme_id].to_i
      index = params[:index].to_i

      theme = Theme.find_by(id: theme_id)

      if theme.nil? || theme.qty_items.zero?
        return render json: { status: "error", message: "Theme not found or empty" }, status: 404
      end

      length = theme.qty_items

      new_index = direction == :next ? (index + 1) % length : (index - 1) % length

      image = theme.images.order(:id).offset(new_index).first

      if image
        render json: {
          status: "success",
          new_image_index: new_index,
          file: ActionController::Base.helpers.image_path("pictures/#{image.file}"),
          name: image.name,
          image_id: image.id,
          images_arr_size: length
        }
      else
        render json: { status: "error", message: "Image not found" }, status: 404
      end
    rescue => e
      render json: { status: "error", message: e.message }, status: 500
    end
  end
end
