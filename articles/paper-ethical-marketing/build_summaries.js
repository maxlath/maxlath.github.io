#!/usr/bin/env node
const __ = require('config').universalPath
const _ = __.require('lib', 'utils')

const parts = [1, 2, 3].map(num => {
  const name = `part-${num}`
  const part = require(`./${name}/structure`)
  const path = part.path = `${__dirname}/${name}`
  part.data = _.getFolderData(path)
  part.num = num
  return part
})

var recursiveBuild = (child) => {
  const { id, level, title, children } = child

  const dotedId = id.replace(/-/g, '.')

  let innerHtml = `<a href='#${id}' class='deep-${level}'>
  <span class='rank'>${dotedId}</span><span class='title'>${title}</span>
</a>`
  if (children.length > 0) {
    const innerList = children.map(recursiveBuild).join('')
    innerHtml += `<ul>${innerList}</ul>`
  }

  return `<li class='deep-${level}'>${innerHtml}</li>`
}

const romanFigures = [ 'I', 'II', 'III' ]

const buildSummary = (part) => {
  const { children, path, data, num } = part
  const { title } = data
  let html = children.map(recursiveBuild).join('')
  const romanFig = romanFigures[num - 1]
  html = `<h1 class="highlight">${romanFig}.<span class="titletab"></span> ${title}</h1>
<ul class='structure panel'>${html}</ul>`

  return _.writeFile(`${path}/partials/summary.html`, html, true)
}

parts.forEach(buildSummary)
