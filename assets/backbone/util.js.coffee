@module = (name, moduleContents) ->
  module = @
  for m in name.split(".")
    module = (module[m] ?= {})
  if moduleContents?
    moduleContents.call(module)

