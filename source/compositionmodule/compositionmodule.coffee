compositionmodule = {name: "compositionmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["compositionmodule"]?  then console.log "[compositionmodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
fs = require("fs")
m = require("mustache")

############################################################
p = null

############################################################
compositionmodule.initialize = ->
    log "compositionmodule.initialize"
    p = allModules.pathmodule
    return

############################################################
class Composition
    constructor: (@basePath) ->
        @outputPath = p.outputPath(@basePath)
        templatePath = p.compositionTemplatePath(@basePath)
        @template = fs.readFileSync(templatePath, "utf-8")
        @components = {}
        return
    
    ############################################################
    readComponents: -> await @digestAllFiles()

    ############################################################
    writeResult: ->
        writeObject = {
            components:[]
        }
        for name,obj of @components
            obj.name = name
            writeObject.components.push(obj)
        
        result = m.render(@template, writeObject)
        fs.writeFileSync(@outputPath, result)
        return

    ############################################################
    digestAllFiles: ->
        allFiles = fs.readdirSync(@basePath)
        promises = (@digestFilename(name) for name in allFiles)
        await Promise.all(promises)
        return

    digestFilename: (name) ->
        tokens = name.split(".")
        if tokens.length == 1 then await @digestDirectory(name)
        if tokens.length == 2 then await @digestFile(tokens[0], tokens[1])
        return

    digestDirectory: (name) ->
        comp = @components[name]
        comp = {} unless comp?
        @components[name] = comp
        
        base = p.resolve(@basePath, name)

        nextFiles = fs.readdirSync(base)
        nextFiles = filterByName(nextFiles, name)
        
        for file in nextFiles
            try
                id = p.extension(file)
                path = p.resolve(base, file)
                content = fs.readFileSync(path, "utf-8")
                comp[id] = content unless comp[id]?
            catch err then log err

        return

    digestFile: (name, extension) ->
        comp = @components[name]
        comp = {} unless comp?
        @components[name] = comp
        
        try
            id = extension
            path = p.resolve(@basePath, name+"."+extension)
            content = fs.readFileSync(path, "utf-8")
            comp[id] = content
        catch err then log err
        return

############################################################
filterByName = (fileNames, name) ->
    result = []
    result.push(fileName) for fileName in fileNames when fileName.split(".")[0] == name
    return result

############################################################
compositionmodule.autocompose = (basePath) ->
    log "compositionmodule.autocompose"
    composition = new Composition(basePath)
    await composition.readComponents()
    await composition.writeResult()

    return
    
module.exports = compositionmodule