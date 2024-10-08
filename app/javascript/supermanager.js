window.Supermanager = (function () {
  var modal,
    storage = {
      "player-a-1": {},
      "player-b-1": {},
      "player-b-2": {},
      "player-b-3": {},
      "player-b-4": {},
      "player-c-1": {},
      "player-c-2": {},
      "player-c-3": {},
      "player-d-1": {},
      "player-d-2": {},
      "player-d-3": {},
      coach: {},
      bonusplayer: {},
    };

  return {
    loadPlayers: function (club, position, amount, selected) {
      $.getJSON("/players", { club: club || "ajax", position: position || "a", amount: amount || 5 }, function (players) {
        HTMLHelper.populateSelect("#player", players);
        Supermanager.stopLoading($("#player"));
        if (selected) {
          $("#player").val(selected);
        }
      });
    },
    loadPositions: function (selected) {
      HTMLHelper.populateSelect("#position", { a: "Doelman", b: "Verdediger", c: "Middenvelder", d: "Aanvaller" });
      if (selected) {
        $("#position").val(selected);
      }
    },
    loadClubs: function (selected, blacklist) {
      $.getJSON(
        "/clubs",
        function (clubs) {
          for (var index in this) {
            delete clubs[this[index]];
          }
          HTMLHelper.populateSelect("#club", clubs);
          Supermanager.stopLoading($("#club"));
          if (selected) {
            $("#club").val(selected);
          }
        }.bind(blacklist)
      );
    },
    loadCoaches: function (selected) {
      $.getJSON("/coaches", function (coaches) {
        HTMLHelper.populateSelect("#coach", coaches);
        Supermanager.stopLoading($("#coach"));
        if (selected) {
          $("#coach").val(selected);
        }
      });
    },
    initialize: function () {
      $.getJSON("/superteam", function (superteam) {
        for (var pos in superteam) {
          var opener = $("#" + pos + " > a");
          var type = null;

          if (pos == "coach" || pos == "bonusplayer") {
            opener = $("#box_" + pos + " > p > a");
            type = pos;
          }

          var club = superteam[pos].club;
          var position = superteam[pos].position;
          var person = superteam[pos].id;
          var amount = parseInt(superteam[pos].value);
          var text = superteam[pos].name;
          Supermanager.display(pos, type, opener, club, position, person, amount, text);
        }
        Supermanager.calculateBudget();
      });
    },
    display: function (pos, type, opener, club, position, person, amount, text) {
      if (typeof text === "undefined") text = storage[pos].emptyText;
      storage[pos].club = club;
      if (type == "coach") {
        storage[pos].coach = person;
      } else {
        storage[pos].position = position;
        storage[pos].player = person;
        if (!type) {
          storage[pos].amount = amount;
        }
      }
      opener.text(text);

      if (!type) {
        opener.parent().css("backgroundImage", "url('" + this.lookupShirtUrl(club) + "')");
      }
    },
    showModal: function (opener, title, type) {
      var pos = type || opener.parent().attr("id"),
        player = storage[pos].player,
        club = storage[pos].club,
        position = type ? storage[pos].position : pos.split("-")[1],
        amount = type == "bonusplayer" ? 2 : null;
      var coach;

      if (type == "coach") {
        coach = storage.coach.coach;
      }

      if (!storage[pos].emptyText) {
        storage[pos].emptyText = title;
      }

      if (!this.modal) {
        var html =
          '<form id="form_players">' +
          HTMLHelper.buildElement("p", HTMLHelper.buildElement("select", { id: "club" })) +
          HTMLHelper.buildElement("p", HTMLHelper.buildElement("select", { id: "position" })) +
          HTMLHelper.buildElement("p", HTMLHelper.buildElement("select", { id: "player" })) +
          HTMLHelper.buildElement("p", HTMLHelper.buildElement("select", { id: "coach" })) +
          HTMLHelper.buildElement(
            "p",
            '<span><a id="buttonCancel" href="#">Wissen</a></span>' +
              HTMLHelper.buildElement("input", { type: "button", value: "Akkoord", id: "buttonOK" }, true)
          ) +
          "</form>";
        this.modal = new Boxy(html, { title: title, modal: true, draggable: true, closeable: true });
      } else {
        this.modal.setTitle(storage[pos].emptyText);
        this.modal.center();
        this.modal.show();
      }

      $("#club").parent().show();
      $("#position").parent().hide();
      $("#player").parent().show();
      $("#coach").parent().hide();

      switch (type) {
        case "bonusplayer":
          $("#position").parent().show();
          break;
        case "coach":
          {
            $("#club").parent().hide();
            $("#player").parent().hide();
            $("#coach").parent().show();
          }
          break;
      }

      this.startLoading($("#club, #player, #coach"));

      if (type !== "coach") {
        this.loadClubs(club, type === "bonusplayer" ? ["aja", "psv", "fey"] : []);
        this.loadPositions(position);
        this.loadPlayers(club, type ? storage[pos].position : position, amount, player);
      } else {
        this.loadCoaches(coach);
      }

      $("#club, #position").bind("change", function () {
        Supermanager.loadPlayers($("#club").val(), $("#position").val(), amount);
      });

      $(".boxy-modal-blackout").click(function () {
        Supermanager.hideModal();
      });

      $("#buttonCancel, #buttonOK").bind("click", function () {
        $("#buttonCancel, #buttonOK, #club, #position").unbind();

        if ($(this).attr("id") == "buttonCancel") {
          Supermanager.display(pos, type, opener);
        }

        if ($(this).attr("id") == "buttonOK") {
          var optgroupLabel = $("#player :selected").parent().attr("label");

          Supermanager.display(
            pos,
            type,
            opener,
            $("#club").val(),
            $("#position").val(),
            type == "coach" ? $("#coach").val() : $("#player").val(),
            type == "coach" || $("#player").val() == -1 ? null : optgroupLabel ? optgroupLabel.substr(1, 1) : null,
            type == "coach" ? $("#coach :selected").text() : $("#player :selected").text()
          );
        }

        Supermanager.calculateBudget();
        Supermanager.hideModal();

        return false;
      });
    },
    hideModal: function () {
      $("#buttonCancel, #buttonOK").unbind("click");
      Supermanager.modal.hide();
    },
    calculateBudget: function () {
      var budget = 36;
      for (var i in storage) {
        budget = storage[i].amount && i !== "bonusplayer" ? budget - storage[i].amount : budget;
      }
      $("#box_budget > p")
        .html("&euro;" + budget + ".000.000")
        .addClass(budget < 0 ? "debt" : null);
    },
    startLoading: function (ele) {
      ele.parent().addClass("loading");
      ele.css("visibility", "hidden");
    },
    stopLoading: function (ele) {
      ele.parent().removeClass("loading");
      ele.css("visibility", "visible");
    },
    exportData: function () {
      return storage;
    },
    lookupShirtUrl: function (club) {
      return window.lookupShirtUrl(club);
    },
  };
})();
