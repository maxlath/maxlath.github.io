# base = " http://crossorigin.me/https://github.com/maxlath/maxlath.github.io/tree/master/slides/"
# url1 = "#{base}backbone-meetup/img"
# url2 = "#{base}ouishare-labs-camp-3/img"

fetchImages = (url)->
  $.get url
  .then displayImages
  .fail console.error.bind(null, 'fetchImages err')

displayImages = (res)->
  { images } = res
  console.log 'images', images
  html = ''
  images.forEach (img)->
    html += "<a href='#{img}' target='_blank'><img src='#{img}'/></a>"

  $('#gallery').html html


fetchImages 'images-list.json'
