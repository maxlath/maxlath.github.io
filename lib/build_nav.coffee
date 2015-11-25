module.exports = (data)->
  { id, parent } = data
  breadcrumb = buildBreadcrumb parent, id
  """
    <a id='home' href='/' title='home'>home</a>
    #{breadcrumb}
  """

buildBreadcrumb = (parent, id)->
  parents = if parent? then parent.split '/' else  []
  parents.push id

  breadcrumb = ''
  href = '/'
  while parents.length > 0
    el = parents.shift()
    href += "#{el}/"
    breadcrumb += buildLink href, el

  return breadcrumb

buildLink = (href, name)->
  """
  <i class="fa fa-angle-right"></i>
  <a href="#{href}">#{name}</a>
  """