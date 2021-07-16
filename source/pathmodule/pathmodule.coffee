pathmodule = {name: "pathmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["pathmodule"]?  then console.log "[pathmodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
p = require("path")
fs = require("fs")

############################################################
pathmodule.root = ""

############################################################
pathmodule.initialize = ->
    log "pathmodule.initialize"
    return


############################################################
extractCompositionFile = (base)->
    log "digestAutocompositionFile"
    result = {}
    result.name = p.basename(base)
    
    allFiles = fs.readdirSync(base)

    for file in allFiles
        tokens = file.split(".") 
        if tokens[0] == "autocomposition"
            if tokens.length  != 3
                throw new Error("autocomposition file does not contain 2 '.' characters!")
            result.ending = tokens[1]
            return result

    throw new Error("We did not find a autocomposition file!")
    return
    
############################################################
getCompositionFileName = (base) ->
    log "getCompositionFileName"
    allFiles = fs.readdirSync(base)

    for file in allFiles
        tokens = file.split(".") 
        if tokens[0] == "autocomposition"
            if tokens.length  != 3
                throw new Error("autocomposition file does not contain 2 '.' characters!")
            return file

    throw new Error("We did not find a autocomposition file!")
    return


############################################################
pathmodule.digestPath = (lePath) ->
    log "pathmodule.digestPath"
    pathmodule.root = p.resolve(lePath)
    return

pathmodule.compositionTemplatePath = (base) -> 
    return p.resolve(base, getCompositionFileName(base))

pathmodule.outputPath = (base) -> 
    {name,ending} = extractCompositionFile(base)
    return p.resolve(base, name+"."+ending)

pathmodule.resolve = p.resolve

pathmodule.extension = (lePath) -> p.extname(lePath).slice(1)

module.exports = pathmodule