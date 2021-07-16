mainprocessmodule = {name: "mainprocessmodule"}
#region logPrintFunctions
##############################################################################
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["mainprocessmodule"]?  then console.log "[mainprocessmodule]: " + arg
    return
olog = (o) -> log "\n" + ostr(o)
ostr = (o) -> JSON.stringify(o, null, 4)
print = (arg) -> console.log(arg)
#endregion

############################################################
#region modulesFromEnvironment
p = null
recurse = null
composition = null
#endregion

############################################################
mainprocessmodule.initialize = ->
    log "mainprocessmodule.initialize"
    p = allModules.pathmodule
    recurse = allModules.recursemodule
    composition = allModules.compositionmodule
    return 


############################################################
#region exposedFunctions
mainprocessmodule.execute = (e) ->
    log "mainprocessmodule.execute"
    
    await p.digestPath(e.path)

    if e.recursive then await recurse.start()
    else await composition.autocompose(p.root)

    return

#endregion

module.exports = mainprocessmodule
