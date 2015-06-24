#!/usr/bin/env coffee
fs = require 'fs'
text = ''

process.stdout.write '|'

read = (name)->
  slide = not name.match /header|footer|custom/

  if slide then templHeader()
  text += fs.readFileSync "./partial/#{name}"
  text = replaceAside(text)
  text = replaceRollIn(text)
  if slide then templFooter()

writeOutput = (name)->
  current = fs.readFileSync './index.html', 'utf-8'
  if text isnt current
    fs.writeFileSync './index.html', text
    console.log '\nbuilt', new Date()

templHeader = -> text += "<section data-markdown><script type='text/template'>"
templFooter = -> text += "</script></section>"
replaceAside = (text)->
  text.replace /\[\[([^[]+)\]\]/g, '<aside class="notes" data-markdown>$1</aside>'
replaceRollIn = (text)->
  text.replace /&&&/g, '<!-- .element: class="fragment roll-in" -->'

partials = fs.readdirSync './partial/'
partials.forEach read

writeOutput()
