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
fs = require("fs")
############################################################
p  = null
composition = null


############################################################
recursemodule.initialize = ->
    log "recursemodule.initialize"
    p = allModules.pathmodule
    composition = allModules.compositionmodule
    return

############################################################
goDepthFirst = (base) ->
    log "goDepthFirst"
    options = {withFileTypes:true}
    allFiles = fs.readdirSync(base, options)

    promises = []
    for file in allFiles when file.isDirectory()
        promises.push(recurseStep(p.resolve(base, file.name)))
    
    await Promise.all(promises)
    return

recurseStep = (base) ->
    log "recurseStep"
    await goDepthFirst(base)
    await composition.autocompose(base)
    return


############################################################
recursemodule.start = ->
    log "recursemodule.start"
    await recurseStep(p.root)
    return

    
module.exports = recursemodule