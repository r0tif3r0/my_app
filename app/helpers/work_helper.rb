module WorkHelper
  def image_data(theme, data)
    {
      values_qty: data[:values_qty],
      theme: theme.name,
      theme_id: theme.id,
      current_user_id: data[:current_user_id],
      index: data[:index],
      images_count: data[:images_arr_size],
      image_id: data[:image_id],
      name: data[:name],
      file_url: image_path(data[:file]),
      user_valued: data[:user_valued],
      current_value: data[:value],
      average_value: data[:common_ave_value]
    }
  end
end
