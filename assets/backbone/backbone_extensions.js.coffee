Backbone.Model.prototype.toViewJSON = ->
  _.clone(@attributes)

Backbone.Model.prototype.toJSON = ->
  if @attrWhitelist?
    _.pick(@attributes, @attrWhitelist)
  else
    _.clone(@attributes)


