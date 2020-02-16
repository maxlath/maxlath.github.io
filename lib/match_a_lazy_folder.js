const { lazyFolders } = require('config')

module.exports = folder => {
  const parts = folder.split('/')
  const absoluteParts = []
  let intermediayPart = ''

  parts.forEach(part => {
    intermediayPart = `${intermediayPart}${part}`
    absoluteParts.push(intermediayPart)
    return intermediayPart += '/'
  })

  return absoluteParts.some(part => lazyFolders.includes(part))
}
