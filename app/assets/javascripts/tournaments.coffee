jQuery ->
    #Currency/formatted-num plugins courtesy of Allan Jardine (http://sprymedia.co.uk/)
    jQuery.extend jQuery.fn.dataTableExt.oSort,
      "currency-pre": (a) ->
        a = (if (a is "-") then 0 else a.replace(/[^\d\-\.]/g, ""))
        parseFloat a

      "currency-asc": (a, b) ->
        a - b

      "currency-desc": (a, b) ->
        b - a

    jQuery.extend jQuery.fn.dataTableExt.oSort,
      "formatted-num-pre": (a) ->
        a = (if (a is "-" or a is "") then 0 else a.replace(/[^\d\-\.]/g, ""))
        parseFloat a

      "formatted-num-asc": (a, b) ->
        a - b

      "formatted-num-desc": (a, b) ->
        b - a

    $('#tournaments-table').dataTable({
      "sDom": "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
      "sPaginationType": "bootstrap",
      "aoColumns": [
                null,
                null,
                null,
                { "sType": "currency" },
                { "sType": "formatted-num"}
            ]})