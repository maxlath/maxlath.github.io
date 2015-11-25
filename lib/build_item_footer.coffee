_ = require './utils'

module.exports = (data)->
  { parent, id, date } = data
  date = formatDate date
  url = "/#{parent}/#{id}"
  """
  <div class="date panel">#{date} - <a href="#{url}" title="permalink">Permalink</a></div>
  <hr>
  <div class="panel"><p><a href="http://creativecommons.org/licenses/by-sa/3.0/"><img src="http://i.creativecommons.org/l/by-sa/3.0/88x31.png" border="0" alt="Creative Commons License" /></a><br />This work is published under a <a href="http://creativecommons.org/licenses/by-sa/3.0/">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>. Quoted text couldn't be affected by this license.</p></div>
  <hr>
  """

formatDate = (date)->
  parts = _.toLogicalDayFormat(date).split '-'
  monthNum = Number parts[1]
  console.log 'monthText[monthNum]', monthNum, monthText[monthNum]
  parts[1] = monthText[monthNum]
  return parts.join ' '

monthText = [
  0
  'Jan.'
  'Feb.'
  'March'
  'April'
  'May'
  'June'
  'Jul.'
  'Aug.'
  'Sept.'
  'Nov.'
  'Dec.'
]


