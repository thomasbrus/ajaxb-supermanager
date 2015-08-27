var enableSubmit = function() {

  $('#box_submit').click(function() {
    disableSubmit();

    if ($('#status').length === 0) {
      $('.content').prepend('<div id="status"></status>');
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

  $('#box_submit').bind('mouseenter', function() {
    $(this).css('background', 'url(/assets/submit_hover.jpg) no-repeat').css('cursor', 'pointer');
  }).bind('mouseleave', function() {
    $(this).css('background', 'url(/assets/submit.jpg) no-repeat').css('cursor', 'default');
  });
};

var disableSubmit = function() {
  $('#box_submit').unbind('mouseleave').unbind('click').bind('mouseenter', function() {
    $(this).css('cursor', 'default');
  });
};
