window.TorrentsPub ?= {}

class TorrentsPub.ColorGenerator
  goldenRatioConjugate: 0.618033988749895
  startingNumber: 40
  id: 1

  nextColor: ->
    @template ?= JST["templates/scraper/colors"]
    @startingNumber += @goldenRatioConjugate
    @startingNumber *= 4
    @startingNumber %= 255
    @id += 1
    style = @template
      id:     @id,
      base:   "hsl(#{@startingNumber}, 50%, 97%)",
      bright: "hsl(#{@startingNumber}, 60%, 95%)",
      border: "hsl(#{@startingNumber}, 50%, 75%)"
    $("head").append(style)
    "color-#{@id}"
    

