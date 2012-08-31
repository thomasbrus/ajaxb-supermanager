//= require ./html_helper.js

var Supermanager = (function() {
  var modal, storage = {
    'player-a-1': {},
    'player-b-1': {}, 'player-b-2': {}, 'player-b-3': {}, 'player-b-4': {},
    'player-c-1': {}, 'player-c-2': {}, 'player-c-3': {},
    'player-d-1': {}, 'player-d-2': {}, 'player-d-3': {},
    'coach': {},
    'bonusplayer': {}
  };
    
  return {
    loadPlayers: function(club, position, amount, selected) {
      $.getJSON('/xhr/spelers', { club: club || 'ado', position: position || 'a', amount: amount || 5}, function(players) {
        HTMLHelper.populateSelect('#player', players);
        Supermanager.stopLoading($('#player'));
        $('#player').val(selected);
      });
    },
    loadPositions: function(selected) {
      HTMLHelper.populateSelect('#position', {a: 'Doelman', b: 'Verdediger', c: 'Middenvelder', d: 'Aanvaller'});
      $('#position').val(selected);
    },
    loadClubs: function(selected) {
      $.getJSON('/xhr/clubs', function(clubs) {
        HTMLHelper.populateSelect('#club', clubs);
        Supermanager.stopLoading($('#club'));
        $('#club').val(selected);
      });
    },
    loadCoaches: function(selected) {
      $.getJSON('/xhr/coaches', function(coaches) {
        HTMLHelper.populateSelect('#coach', coaches);
        Supermanager.stopLoading($('#coach'));
        $('#coach').val(selected);
      });
    },
    // Boxy.linkedTo()
    showModal: function(opener, title, type) {
      var pos = type || opener.parent().attr('id'),
        player = storage[pos].player,
        club = storage[pos].club,
        position = (type ? storage[pos].position : pos.split('-')[1]),
        amount = (type == 'bonusplayer' ? 2 : null);
        
      if (type == 'coach') {
        var coach = storage['coach'].coach  
      }
      
      if ( ! storage[pos].emptyText) {
        storage[pos].emptyText = title;
      }

      if ( ! this.modal) {
        var html = 
        '<form id="form_players">'+ 
          HTMLHelper.buildElement('p', HTMLHelper.buildElement('select', {id: 'club'})) +
          HTMLHelper.buildElement('p', HTMLHelper.buildElement('select', {id: 'position'})) +
          HTMLHelper.buildElement('p', HTMLHelper.buildElement('select', {id: 'player'})) + 
          HTMLHelper.buildElement('p', HTMLHelper.buildElement('select', {id: 'coach'})) +                
          HTMLHelper.buildElement('p', '<span><a id="buttonCancel" href="#">Wissen</a></span>' + 
          HTMLHelper.buildElement('input', {type: 'button', value: 'Akkoord', 'id': 'buttonOK'}, true)) +
        '</form>';
        this.modal = new Boxy(html, {title: title, modal: true, draggable: true, closeable: false});
      } else {
        this.modal.setTitle(storage[pos].emptyText);
        this.modal.center();
        this.modal.show();
      }
    
      $('#club').parent().show();
      $('#position').parent().hide();
      $('#player').parent().show();
      $('#coach').parent().hide();
      
      switch (type) {
        case 'bonusplayer': $('#position').parent().show(); break;
        case 'coach': {
          $('#club').parent().hide();
          $('#player').parent().hide();
          $('#coach').parent().show();
        }
        break;
      }
      
      this.startLoading($('#club, #player, #coach'));
            
      if (type !== 'coach') {
        this.loadClubs(club);
        this.loadPositions(position);
        this.loadPlayers(club, type ? storage[pos].position : position, amount, player);
      } else {
        this.loadCoaches(coach);
      }
              
      $('#club, #position').bind('change', function() {
        Supermanager.loadPlayers($('#club').val(), $('#position').val(), amount);
      });
      
      $('#buttonCancel, #buttonOK').bind('click', function() {
        $('#buttonCancel, #buttonOK, #club, #position').unbind();
      
        var ABC = function(club, position, person, amount, text) {
          storage[pos].club = club;
          if (type == 'coach') {
            storage[pos].coach = person;
          } else {
            storage[pos].position = position;
            storage[pos].player = person;
            if ( ! type) {
              storage[pos].amount = amount; 
            }
          }
          opener.text(text ? text : storage[pos].emptyText);
          
          if ( ! type) {
            opener.parent().css('backgroundImage', "url('/img/shirts/" + (club ? club : "no_sponsor") + ".png')");
          }
        }
        
        if ($(this).attr('id') == 'buttonCancel') {
          ABC();
        }
        
        if ($(this).attr('id') == 'buttonOK') {
          ABC($('#club').val(),
            $('#position').val(),
            type == 'coach' ? $('#coach').val() : $('#player').val(),
            type == 'coach' || $('#player').val() == -1 ? null : $('#player :selected').parent().attr('label').substr(1, 1),
            type == 'coach' ? $('#coach :selected').text() : $('#player :selected').text());
        }
        
        Supermanager.calculateBudget();
        Supermanager.modal.hide();
                
        return false;
      });
      

    },
    calculateBudget: function() {
      var budget = 36;      
      for (i in storage) {
        budget = storage[i].amount && i !== 'bonusplayer' ? budget - storage[i].amount : budget;  
      }
      $('#box_budget > p').html('&euro;' + budget + '.000.000').addClass(budget < 0 ? 'debt' : null);
    },
    startLoading: function(ele) {
      ele.parent().addClass('loading');
      ele.css('visibility', 'hidden');
    },
    stopLoading: function(ele) {
      ele.parent().removeClass('loading');
      ele.css('visibility', 'visible');
    },
    exportData: function() {
      return storage;
    }
  }
})();