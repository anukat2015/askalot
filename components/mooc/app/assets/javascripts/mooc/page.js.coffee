$(document).ready ->
  url = $('#login-url').attr('href')

  setTimeout (-> window.top.location.href = url), 5000 if url != undefined