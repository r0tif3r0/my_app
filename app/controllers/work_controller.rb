class WorkController < ApplicationController
  def index
    @theme = Theme.first
    @image = @theme&.images&.first # Безопасная навигация

    if @image
      @next_image = @image.next_image
      @prev_image = @image.prev_image
    end
  end

  def display_theme
    @theme = Theme.find(params[:theme_id])
    @image = @theme.images.first

    if @image
      redirect_to show_image_path(@image.id)
    else
      redirect_to work_path, alert: "В этой теме нет изображений"
    end
  end

  def show_image
    @image = Image.find(params[:image_id])
    @next_image = @image.next_image
    @prev_image = @image.prev_image

    render :index
  rescue ActiveRecord::RecordNotFound
    redirect_to work_path, alert: "Изображение не найдено"
  end
end
