class WorkController < ApplicationController
  def index
    @theme = nil
    @image = nil

    if @image
      @next_image = @image.next_image
      @prev_image = @image.prev_image
    end
  end

  def display_theme
    @theme = Theme.find_by(id: params[:theme_id])

    if @theme.nil?
      redirect_to work_path, alert: "Тема не найдена!"
      return
    end

    @image = @theme.images.first

    if @image
      redirect_to show_image_path(image_id: @image.id, theme_id: @theme.id)
    else
      redirect_to work_path, alert: "В этой теме нет изображений"
    end
  end

  def show_image
    @image = Image.find_by(id: params[:image_id])
    @theme = Theme.find_by(id: params[:theme_id])

    if @image.nil?
      redirect_to work_path, alert: "Изображение не найдено"
      return
    end

    if @theme.nil?
      @theme = @image.theme # Получаем тему из изображения
    end

    render :index
  end
end
