var enableSubmit = function() {
  
  $('#box_submit').click(function() {
    disableSubmit();
    
    if ( ! $('#status').length) {
      $('#content').prepend('<div id="status"></status>');
    }
    
    $('#status').attr('class', 'busy').html('<p>De opstelling wordt gecontroleerd..</p>').hide().slideDown('slow', function() {
      $.post('/xhr/supermanager', Supermanager.exportData(), function(data) {
        if (data.status == 'error') {
          if (data.message.length == 1 || typeof data.message == 'string') {
            $('#status').attr('class', 'error').html('<p>' + data.message + '</p>');
          } else if (data.message.length > 1) {
            $('#status').attr('class', 'error').html(HTMLHelper.buildList(data.message));
          }
          
          enableSubmit();
        }
        else if (data.status == 'success') {
          document.location.replace('/meedoen/bevestiging');
        }
      }, 'json')
    });
  });

  $('#box_submit').bind('mouseenter', function() {
    $(this).css('background', 'url(/assets/submit_hover.jpg) no-repeat').css('cursor', 'pointer');
  }).bind('mouseleave', function() {
    $(this).css('background', 'url(/assets/submit.jpg) no-repeat').css('cursor', 'default');
  });
}

var disableSubmit = function() {
  $('#box_submit').unbind('mouseleave').unbind('click').bind('mouseenter', function() {
    $(this).css('cursor', 'default');
  }); 
}

$(document).ready(function() {
  enableSubmit();

  $('#box_formation ul > li > a').click(function() {
    Supermanager.showModal($(this), $(this).text());
  });
  
  $('#box_coach > p > a').click(function() {
    Supermanager.showModal($(this), 'Kies een coach', 'coach');
  });
  
  $('#box_bonusplayer > p > a').click(function() {
    Supermanager.showModal($(this), 'Kies een bonusspeler', 'bonusplayer');
  });
    
  $('.box a').click(function() {
    return false; 
  });
});