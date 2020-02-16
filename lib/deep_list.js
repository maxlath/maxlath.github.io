module.exports = {
  newNode: (title, parent, baseId) => {
    const node = {
      title,
      children: []
    }

    if (parent != null) {
      node.level = parent.level + 1
      node.id = parent.id + '-' + (parent.children.length + 1)
      parent.children.push(node)
    } else {
      node.level = 0
      node.id = baseId
    }

    return node
  }
}
