#!/usr/bin/env coffee

fs = require 'fs'
_ = require 'lodash'

folders = [
  '../backbone-meetup/img'
  '../ouishare-labs-camp-3/img'
  '../captions/img'
]

allowedExtensions = [ 'jpg', 'png', 'gif' ]


images = []

folders.forEach (folder)->
  imgs = fs.readdirSync(folder)
  path = "/slides/" + folder.replace('../', '')
  imgs = imgs.map (img)-> "#{path}/#{img}"
  images = images.concat imgs

images = _.filter images, (img)->
  extension = img.split('img/')[1].split('.')[1]
  extension in allowedExtensions

data = {images: images}

fs.writeFile './images-list.json', JSON.stringify(data), (err, info)->
  if err? then console.error('err', err)
  else console.log('success', images)