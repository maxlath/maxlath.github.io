const fs = require('fs')
const _ = require('./utils')
const metaFiles = ['index.html', 'data.json', 'partials']
const buildLi = require('./build_li')
const { addToTag } = require('./build_tags')

module.exports = folder => {
  // get files names
  const innerList = fs.readdirSync(folder)
    .filter(isntMetaFile)
    .filter(isntRedirect)
    .map(buildLi.bind(null, folder))
    // SIDE EFFECT
    .map(spreadByTags)
    .sort(_.sortByDescendingDate)
    .map(_.property('html'))
    .join('\n')

  return `<ul>${innerList}</ul>`
}

const isntMetaFile = name => (!(metaFiles).includes(name)) && !/html$/.test(name)

const isntRedirect = name => !(redirects).includes(name)

const redirects = [
  'accelerer-le-darwinisme-economique-de-la-transition-ecologique'
]

const spreadByTags = li => {
  if (li.data.tags != null) {
    li.data.tags.forEach(addToTag.bind(null, li))
  }
  return li
}
