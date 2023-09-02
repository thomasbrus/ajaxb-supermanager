$(document).ready(function () {
  enableSubmit();

  if (!$(document.body).text().includes("Superteam is opgeslagen")) {
    validateSuperTeam();
  }

  Supermanager.initialize();

  $("#box_formation ul > li > a").click(function () {
    Supermanager.showModal($(this), $(this).text());
  });

  $("#box_coach > p > a").click(function () {
    Supermanager.showModal($(this), "Kies een coach", "coach");
  });

  $("#box_bonusplayer > p > a").click(function () {
    Supermanager.showModal($(this), "Kies een bonusspeler", "bonusplayer");
  });

  $(".box a").click(function () {
    return false;
  });
});
