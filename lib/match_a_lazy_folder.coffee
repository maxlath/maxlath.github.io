{ lazyFolders } = require 'config'

module.exports = (folder)->
  parts = folder.split '/'
  absoluteParts = []
  intermediayPart = ''

  parts.forEach (part)->
    intermediayPart = "#{intermediayPart}#{part}"
    absoluteParts.push intermediayPart
    intermediayPart += '/'

  return absoluteParts.some (part)-> part in lazyFolders
