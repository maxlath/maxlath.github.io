module.exports = (data)->
  { title, description, image } = data
  preview = """
    <div class='cover' style='background-image: url(#{image})'>
      <h3>#{title}</h3>
    </div>
    """
  if description? then preview += "<p>#{description}</p>"

  return preview
