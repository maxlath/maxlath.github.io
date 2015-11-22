module.exports = (data)->
  { title, subtitle, description, image } = data

  innerPreview = "<h3 class='title'>#{title}</h3>"
  if subtitle? then innerPreview += "<span class='subtitle'>#{subtitle}</span>"

  if description?
    description = description[0..200] + '...'
    innerPreview += "<p class='description'>#{description}</p>"

  """
  <div class='preview-cover' style='background-image: url(#{image})'>
    <div class='inner-preview'>#{innerPreview}</div>
  </div>
  """