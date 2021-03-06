defaultLocale = require "../core/locale/languages/en_US.coffee"

module.exports = (text, opts) ->

  return "" unless text

  opts = {} unless opts
  key  = opts.key

  # If it's a sentence, just capitalize the first letter.
  if text.charAt(text.length - 1) is "."
    return text.charAt(0).toUpperCase() + text.substr(1)

  locale = if "locale" of this then @locale.value else defaultLocale
  smalls = locale.lowercase.map (b) -> b.toLowerCase()
  bigs   = locale.uppercase
  bigs   = bigs.concat(bigs.map (b) -> b + "s")
  biglow = bigs.map (b) -> b.toLowerCase()

  text.replace /\S*/g, (txt, i) ->

    if txt

      if /^[^\W\s]/.test(txt)
        prefix = ""
      else
        prefix = txt.charAt(0)
        txt = txt.slice(1)

      bigindex = biglow.indexOf(txt.toLowerCase())

      if bigindex >= 0
        new_txt = bigs[bigindex]
      else if smalls.indexOf(txt.toLowerCase()) >= 0 and
              i isnt 0 and i isnt text.length - 1
        new_txt = txt.toLowerCase()
      else
        new_txt = txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()

      prefix + new_txt

    else ""
