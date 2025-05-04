class ValuesController < ApplicationController

  def create
    @value = current_user.values.build(value_params)
    
    respond_to do |format|
      if @value.save
        update_image_average(@value.image)
        format.html { 
          redirect_back(fallback_location: root_path, notice: t('.success')) 
        }
        format.json { render json: { average: @value.image.ave_value }, status: :created }
      else
        format.html { 
          redirect_back(fallback_location: root_path, 
                      alert: @value.errors.full_messages.join(', ')) 
        }
        format.json { render json: @value.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def value_params
    params.permit(:image_id, :value)
  end
  
  def update_image_average(image)
    # Получаем среднее значение оценок через прямую связь
    average = Value.where(image_id: image.id).average(:value)
    
    # Обновляем с проверкой на наличие оценок
    image.update(ave_value: average ? average.round(2) : 0.0)
  end
end