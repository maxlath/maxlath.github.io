/*
 * decaffeinate suggestions:
 * DS101: Remove unnecessary use of Array.from
 * DS102: Remove unnecessary code created because of implicit returns
 * DS207: Consider shorter constiations of null checks
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
const _ = require('../lib/utils')

const combinations = array => {
  const results = []
  console.log('array', array)
  while (array.length > 0) {
    const key1 = array.pop()
    array.forEach(key2 => results.push([key1, key2]))
  }

  return results
}

module.exports = tagsList => {
  const tagsGraph = {
    nodes: [],
    links: []
  }

  const tagMap = {}
  let id = 0

  const groupId = P31 => {
    if (P31) {
      return P31.replace(/^Q/, '')
    } else {
      return 0
    }
  }

  tagsList.forEach(function (tag) {
    const name = tag.tag
    tagMap[name] = id
    id += 1
    const group = groupId(tag.data.P31)
    return tagsGraph.nodes.push({
      name,
      group,
      url: `/tags/${name}`
    })
  })

  const linkStrenght = {}

  const increaseLinkStrenght = couple => {
    let a, b
    const [key1, key2] = Array.from(couple)
    if (key1 > key2) {
      [a, b] = [key1, key2]
    } else {
      [a, b] = [key2, key1]
    }

    if (!linkStrenght[a]) { linkStrenght[a] = {} }
    if (!linkStrenght[a][b]) { linkStrenght[a][b] = 0 }
    return linkStrenght[a][b] += 1
  }

  tagsList.forEach(tag => tag.items.forEach(function (item) {
    const { tags } = item.data
    if (tags != null) {
      const couples = combinations(tags)
      return couples.forEach(couple => // console.log 'couple', couple
        increaseLinkStrenght(couple))
    } else {
      return console.log('TAGS NOT FOUND'.red, Object.keys(item))
    }
  }))

  for (const tag1 in linkStrenght) {
    const linkedTags = linkStrenght[tag1]
    for (const tag2 in linkedTags) {
      const linkValue = linkedTags[tag2]
      tagsGraph.links.push({
        source: tagMap[tag1],
        target: tagMap[tag2],
        value: linkValue
      })
    }
  }

  return _.writeJson('./tags/graph.json', tagsGraph)
}
