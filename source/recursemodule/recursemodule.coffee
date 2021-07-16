recursemodule = {name: "recursemodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["recursemodule"]?  then console.log "[recursemodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
p  = null

############################################################
recursemodule.initialize = ->
    log "recursemodule.initialize"
    p = allModules.pathmodule
    return

############################################################
recursemodule.start = ->
    log "recursemodule.start"
    return

    
module.exports = recursemodule