module.exports = data => {
  const { id, parent } = data
  const breadcrumb = buildBreadcrumb(parent, id)
  return `<a id='home' href='/' title='home'>home</a> ${breadcrumb}`
}

const buildBreadcrumb = (parent, id) => {
  const parents = (parent != null) ? parent.split('/') : []
  parents.push(id)

  let breadcrumb = ''
  let href = '/'
  while (parents.length > 0) {
    const el = parents.shift()
    href += `${el}/`
    breadcrumb += buildLink(href, el)
  }

  return breadcrumb
}

const buildLink = (href, name) => `<i class="fa fa-angle-right"></i><a href="${href}">${name}</a>`
