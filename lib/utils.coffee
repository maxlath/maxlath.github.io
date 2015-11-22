fs = require 'fs'
require 'colors'
mkdirp = require 'mkdirp'

module.exports = _ =
  readFile: (path, cb)->
    cb or= FileOpCb 'read', path
    fs.readFile path, 'utf-8', cb
  readFileSync: (path)-> fs.readFileSync path, 'utf-8'
  writeFile: (path, content)->
    # console.log 'content', content
    fs.writeFile path, content, FileOpCb('write', path)
  writeFileSync: (path, content)-> fs.writeFileSync path, content
  readJsonSync: (path)->
    cwd = process.cwd()
    # weirdly can't make it work without passing the cwd oO
    return require "#{cwd}/#{path}"

  writeJsonSync: (path, content)->
    _.writeFileSync path, JSON.stringify content, null, 4

  mkdirSync: (path)->
    mkdirp.sync path
    _.log 'mkdir', path

  getFolderData: (folder)-> _.readJsonSync "#{folder}/data.json"

  log: (label, obj)->
    console.log "-------#{label}-------".cyan
    console.log obj
    console.log "----------------------".cyan
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

FileOpCb = (label, path)->
  return cb = (err, res)->
    if err? then logOp label, path, err, 'red'
    else logOp label, path, res or 'ok', 'green'


logOp = (label, path, obj, color)->
  console.log "#{label}: #{path}"[color], obj
