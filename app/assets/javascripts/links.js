
$(document).ready(function () {
// will call refreshPartial every 15 seconds
    setInterval(refreshPartial, 15000)

});

// calls action refreshing the partial
function refreshPartial() {
  $.ajax({
    url: "links/refresh"
 })
}
