fs = require 'fs'
require 'colors'
mkdirp = require 'mkdirp'
{ copy } = require 'copy-paste'

module.exports = _ = require 'lodash'

_.extend _,
  readFile: (path, cb)->
    cb or= FileOpCb 'read', path
    fs.readFile path, 'utf-8', cb
  readFileSync: (path)-> fs.readFileSync path, 'utf-8'
  writeFile: (path, content, mkdirp=false)->
    if mkdirp then mkFileDirpSync path
    fs.writeFile path, content, FileOpCb('write', path)
  writeFileSync: (path, content, mkdirp=false)->
    if mkdirp then mkFileDirpSync path
    fs.writeFileSync path, content
  readJsonSync: (path)->
    # allow to pass an absolute path
    unless path[0] is '/'
      cwd = process.cwd()
      path = "#{cwd}/#{path}"
    # weirdly can't make it work without passing the cwd oO
    return require path

  writeJsonSync: (path, content)->
    _.writeFileSync path, JSON.stringify content, null, 2

  mkdirpSync: (path)-> mkdirp.sync path

  getFolderData: (folder)-> _.readJsonSync "#{folder}/data.json"

  log: (label, obj, color='cyan')->
    if typeof obj is 'string' then console.log label[color], obj
    else
      console.log "-------#{label}-------"[color]
      console.log obj
      console.log "----------------------"[color]
    return obj

  Log: (label)-> _.log.bind(null, label)

  capitalizeFirstLetter: (text)-> text[0].toUpperCase() + text[1..-1]

  rootSection: (path)->
    path
    .replace '^/', ''
    .split('/')[0]

  throwError: (message, context)->
    console.log message.red, context
    throw new Error(message)

  getIdFromTitle: (title)->
    title
    .toLowerCase()
    .replace /\s/g, '-'

  attributeString: (name, val)-> if val? then "#{name}='#{val}'" else ''

  toLogicalDayFormat: (date)->
    d = new Date date
    d.toISOString().split('T')[0].split('-').reverse().join('-')

  warn: (label, obj)->
    if obj? then _.log label, obj, 'yellow'
    else console.log label.yellow

  cb: (str)->
    copy str
    console.log "Copied to Clipboard:".green, str

  forceArray: (obj)->
    if obj instanceof Array then obj
    else [ obj ]

mkFileDirpSync = (filePath)->
  folder = filePath.split('/').slice(0, -1).join('/')
  _.mkdirpSync folder

FileOpCb = (label, path)->
  return cb = (err, res)->
    if err? then logOp label, path, err, 'red'
    else logOp label, path, res or 'ok', 'green'


logOp = (label, path, obj, color)->
  console.log "#{label}: #{path}"[color], obj
