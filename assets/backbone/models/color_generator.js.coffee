window.TorrentsPub ?= {}

class TorrentsPub.ColorGenerator
  goldenRatioConjugate: 0.618033988749895

  constructor: ->
    @reset()
    @colors = {}
    @template = JST["templates/scraper/colors"]

  nextColor: ->
    @startingNumber += @goldenRatioConjugate
    @startingNumber *= 6
    @startingNumber %= 255
    @colors[@id] ?= (=>
      style = @template
        id:     @id,
        base:   "hsl(#{@startingNumber}, 50%, 97%)",
        bright: "hsl(#{@startingNumber}, 60%, 92%)",
        border: "hsl(#{@startingNumber}, 50%, 75%)"
      $("head").append(style)
      result = "color-#{@id}"
      @id += 1
      result
    )()

  reset: ->
    @id = 1
    @startingNumber = 15
    

