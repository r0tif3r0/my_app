//= require jquery
//= require jquery_ujs
//= require_tree .
//= require rails-ujs
//= require turbolinks

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
      $('#current_index').val(data.new_image_index);
      $('.image-caption').text(data.name);
      $('.main-image').attr('src', data.file);

      const newUrl = `/image/${data.image_id}`;
      window.history.pushState({ path: newUrl }, '', newUrl);
  }
});