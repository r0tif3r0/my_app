//= require jquery
//= require jquery_ujs
//= require_tree .
//= require rails-ujs
//= require turbolinks

window.I18n = {
  work: {
    already_rated: "<%= t('work.already_rated') %>",
    your_rating: "<%= t('work.your_rating') %>"
  }
};

document.querySelectorAll('.dropdown').forEach(item => {
  item.addEventListener('click', function(e) {
    this.classList.toggle('open');
  });
});

document.addEventListener('DOMContentLoaded', function() {

  $('.btn-prev').click(function(e) {
      e.preventDefault();
      loadImage('prev');
  });

  $('.btn-next').click(function(e) {
      e.preventDefault();
      loadImage('next');
  });

  function loadImage(direction) {
      let themeId = $('#theme_id').val(); // Основной вариант
      if (!themeId) {
          themeId = $('input[name="theme_id"]').val(); // Альтернативный поиск
      }
      
      const currentIndex = parseInt($('#current_index').val());

      if (!themeId || isNaN(currentIndex)) {
          alert("Сначала выберите тему!");
          return;
      }

      $.ajax({
        url: `/api/${direction}_image`,
        type: 'GET',
        data: {
          theme_id: themeId,
          index: currentIndex
        },
        success: function(response) {
          updateImage(response);
        },
        error: function(xhr) {
          console.error('Ошибка:', xhr.responseJSON);
        }
      });
  }

  function updateImage(data) {
    // Обновление основных данных
    $('#current_index').val(data.new_image_index);
    $('.image-caption').text(data.name);
    $('.main-image').attr('src', data.file);
    console.log(data)
    // Обновление блока оценки
    updateRatingSection(data);

    const newUrl = `/image/${data.image_id}`;
    window.history.pushState({ path: newUrl }, '', newUrl);
  }
  
  function updateRatingSection(data) {
    const ratingControls = $('.rating-controls');
    ratingControls.empty(); // Очищаем текущее содержимое
  
    if (data.already_rated) {
      // Создаем блок с информацией о уже поставленной оценке
      const ratedHtml = `
        <div class="rated-info">
          <p>${data.already_rated_message}</p>
          <p>${data.your_rating_label}: ${data.user_rating}</p>
          <p>${data.ave_value_label}: ${data.average_rating}</p>
        </div>
      `;
      ratingControls.html(ratedHtml);
    } else {
      // Создаем форму для новой оценки
      const csrfToken = $('meta[name="csrf-token"]').attr('content');
      const formHtml = `
        <form action="/values" method="post">
          <input type="hidden" name="authenticity_token" value="${csrfToken}">
          <input type="hidden" name="image_id" value="${data.image_id}">
          <input type="hidden" name="theme_id" value="${data.theme_id}">
          
          <div class="slider-container">
            <input type="range" class="rating-slider" 
              name="value" min="1" max="10" value="1" step="1">
            <div class="slider-labels">
              ${Array.from({length: 10}, (_, i) => `<span>${i + 1}</span>`).join('')}
            </div>
          </div>
          
          <button type="submit" class="rate-button">${data.rate_button_text}</button>
        </form>
      `;
      ratingControls.html(formHtml);
    }
  }
});