var enableSubmit = function() {

  $('#box_submit').click(function() {
    disableSubmit();

    if ($('#status').length === 0) {
      $('#supermanager').before('<div id="status"></status>');
    }

    $('#status').attr('class', 'busy').html('<p>De opstelling wordt gecontroleerd..</p>').hide().slideDown('slow', function() {
      $.post('/update_superteam', Supermanager.exportData(), function(data) {
        if (data.status == 'error') {
          if (data.message.length == 1 || typeof data.message == 'string') {
            $('#status').attr('class', 'error').html('<p>' + data.message + '</p>');
          } else if (data.message.length > 1) {
            $('#status').attr('class', 'error').html(HTMLHelper.buildList(data.message));
          }
          enableSubmit();
        }
        else if (data.status == 'success') {
          window.location.reload();
        }
      }, 'json');
    });
  });
};

var clickSubmit = function() {
  $('#box_submit').click();
}

var disableSubmit = function() {
  $('#box_submit').unbind('mouseleave').unbind('click').bind('mouseenter', function() {
    $(this).css('cursor', 'default');
  });
};
