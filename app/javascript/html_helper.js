window.HTMLHelper = (function () {
  return {
    buildElement: function (element, attrs, closed, text) {
      if (arguments.length == 2 && typeof arguments[1] == "string") {
        return this.buildElement(element, null, false, attrs);
      }
      if (arguments.length == 3 && typeof arguments[2] == "string") {
        return this.buildElement(element, attrs, false, closed);
      }
      var html = "<" + element;
      if (attrs) {
        Object.keys(attrs).forEach(function (key) {
          html += " " + key + '="' + attrs[key] + '"';
        });
      }
      if (closed) {
        return html + " />";
      }
      return html + ">" + (typeof text == "undefined" ? "" : text) + "</" + element + ">";
    },
    buildLabel: function (text, attrs) {
      return this.buildElement("label", text, attrs);
    },
    buildSelect: function (id, items, selected) {
      var html = '<select id="' + id + '">',
        optgroup = false;
      for (var i = 0, len = items[0].length; i < len; ++i) {
        if (items[0][i] === "optgroup") {
          if (optgroup) {
            html += "</optgroup>";
          }
          html += '<optgroup label="' + items[1][i] + '">';
          optgroup = true;
        } else {
          html +=
            '<option value="' +
            items[0][i] +
            '"' +
            (selected == items[0][i] ? ' selected="selected"' : "") +
            ">" +
            items[1][i] +
            "</option>";
        }
      }
      if (optgroup) {
        html += "</optgroup>";
      }
      return html + "</select>";
    },
    populateSelect: function (selector, items) {
      var ele = $(selector).html("");

      var buildOptions = function (items) {
        delete items.__proto__; // ?
        var html;
        for (var i in items) {
          if (typeof items[i] === "string") {
            html += HTMLHelper.buildElement("option", { value: i }, items[i]);
          }
        }
        return html;
      };

      for (var i in items) {
        if (typeof items[i] === "object") {
          var html = '<optgroup label="' + i + '">' + buildOptions(items[i]) + "</optgroup>";
          ele.append(html.replace("undefined", ""));
        } else if (typeof items[i] === "string") {
          var obj = {};
          obj[i] = items[i];
          ele.append(buildOptions(obj));
        }
      }
    },
    buildList: function (items, ordered) {
      var html = ordered ? "<ol>" : "<ul>";
      for (var i = 0, len = items.length; i < len; ++i) {
        html += "<li>" + items[i] + "</li>";
      }
      return html + (ordered ? "</ol>" : "</ul>");
    },
  };
})();
