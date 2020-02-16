const _ = require('./utils')
const marked = require('./marked')

module.exports = (content, level, data, link) => {
  let innerWrap = buildInnerWrap(content, level, data)
  innerWrap = addLink(innerWrap, link)

  // don't wrap it in a section if its already the highest level
  // as there is no more point in making it a sections
  // and <main> will already have its id
  if (level === 1) {
    return innerWrap
  } else {
    return wrapItAll(data, innerWrap)
  }
}

const buildInnerWrap = (content, level, data) => {
  let { title, fullTitle, subtitle, description } = data
  if (fullTitle != null) { title = marked(fullTitle) }
  let innerWrap = `<h${level} class='title'>${title}</h${level}>`
  if (subtitle != null) {
    innerWrap += `<span class='legend'>${subtitle}</span>`
  }

  innerWrap += content
  return innerWrap
}

const addLink = (innerWrap, link) => {
  if (link != null) {
    innerWrap += `<div class='more'>
  <a href='${link}'><i class="fa fa-angle-right"></i>see all</a>
</div>`
  }
  return innerWrap
}

const wrapItAll = (data, innerWrap) => {
  const { id } = data
  return `<section id='${id}'>${innerWrap}</section>`
}
