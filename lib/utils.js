const fs = require('fs')
const chalk = require('tiny-chalk')
const { red } = chalk
const mkdirp = require('mkdirp')
const { copy } = require('copy-paste')
const _ = require('lodash')

module.exports = _

const fullData = {}

_.extend(_, {
  readFile: (path, cb) => {
    if (!cb) { cb = FileOpCb('read', path) }
    return fs.readFile(path, 'utf-8', cb)
  },
  readFileSync: path => fs.readFileSync(path, 'utf-8') ,
  writeFile: (path, content, mkdirp) => {
    if (mkdirp == null) { mkdirp = false }
    if (mkdirp) { mkFileDirpSync(path) }
    return fs.writeFile(path, content, FileOpCb('write', path))
  },
  writeFileSync: (path, content, mkdirp) => {
    if (mkdirp == null) { mkdirp = false }
    if (mkdirp) { mkFileDirpSync(path) }
    return fs.writeFileSync(path, content)
  },
  readJsonSync: path => {
    // allow to pass an absolute path
    if (path[0] !== '/') {
      const cwd = process.cwd()
      path = `${cwd}/${path}`
    }
    // weirdly can't make it work without passing the cwd oO
    return require(path)
  },

  writeJson: (path, content) => {
    return _.writeFile(path, JSON.stringify(content, null, 2))
  },
  writeJsonSync: (path, content) => {
    return _.writeFileSync(path, JSON.stringify(content, null, 2))
  },

  mkdirpSync: path => mkdirp.sync(path) ,

  getFolderData: folder => {
    const currentData = fullData[folder]
    if (currentData != null) {
      return currentData
    } else {
      return fullData[folder] = _.readJsonSync(`${folder}/data.json`)
    }
  },

  persistData: () => {
    console.log('persisting data...'.grey)
    _.writeFileSync('./full_data.json', JSON.stringify(fullData, null, 2))
    return console.log('done!'.green)
  },

  log: (label, obj, color) => {
    if (color == null) color = 'cyan'
    if (typeof obj === 'string') {
      console.log(chalk[color](label), obj)
    } else {
      console.log(chalk[color](`-------${label}-------`))
      console.log(obj)
      console.log(chalk[color]('----------------------'))
    }
    return obj
  },

  Log: label => _.log.bind(null, label) ,

  rootSection: path => {
    return path
      .replace('^/', '')
      .split('/')[0]
  },

  throwError: (message, context) => {
    console.log(red(message), context)
    throw new Error(message)
  },

  getIdFromTitle: _.kebabCase,

  attributeString: (name, val) => { if (val != null) { return `${name}='${val}'` } else { return '' } },

  toLogicalDayFormat: date => {
    const d = new Date(date)
    return d.toISOString().split('T')[0].split('-').reverse().join('-')
  },

  warn: (label, obj) => {
    if (obj != null) {
      return _.log(label, obj, 'yellow')
    } else {
      return console.log(label.yellow)
    }
  },

  cb: str => {
    copy(str)
    return console.log('Copied to Clipboard:'.green, str)
  },

  forceArray: obj => {
    if (obj instanceof Array) {
      return obj
    } else {
      return [obj]
    }
  },

  sortByDescendingDate: (a, b) => a.data.date < b.data.date ? 1 : -1
}
)

const mkFileDirpSync = filePath => {
  const folder = filePath.split('/').slice(0, -1).join('/')
  return _.mkdirpSync(folder)
}

const FileOpCb = (label, path) => {
  let cb
  return cb = (err, res) => {
    if (err != null) {
      return logOp(label, path, err, 'red')
    } else {
      return logOp(label, path, res || 'ok', 'green')
    }
  }
}

const logOp = (label, path, obj, color) => {
  console.log(chalk[color](`${label}: ${path}`), obj)
}
