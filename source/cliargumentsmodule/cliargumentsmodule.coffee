cliargumentsmodule = {name: "cliargumentsmodule"}
##############################################################
#region logPrintFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["cliargumentsmodule"]?  then console.log "[cliargumentsmodule]: " + arg
    return
#endregion

##############################################################
#region node_modules
meow = require("meow")
{ cwd } = require('process')
#endregion

##############################################################
cliargumentsmodule.initialize = () ->
    log "cliargumentsmodule.initialize"
    return

##############################################################
#region internal functions
getHelpText = ->
    log "getHelpText"
    return """
        Usage
            $ auto-compose arg1
    
        Options
            optional:

                arg1, --path <path/to/root/dir> -p <path/to/root/dir>
                    the directory to start autocomposing
                    cwd(current working directory) is default
                
                --recursive, -r
                    recursive switch, if present it would recursively autocompose
                    doing so in depth-first style 
                
        Examples
            $  auto-compose /home/user/code/autocompose-sources/ -r
            ...
            
    """

getOptions = ->
    log "getOptions"
    return {
        flags:
            path: 
                type: "string"
                alias: "p"
            recursive:
                type: "boolean"
                alias: "r"

    }

extractMeowed = (meowed) ->
    log "extractMeowed"

    path = cwd()
    recursive = false

    if meowed.input[0] then path = meowed.input[0]
    if meowed.flags.path then path = meowed.flags.source
    
    if meowed.flags.recursive then recursive = true
    
    return {path,recursive}

#endregion

##############################################################
#region exposed functions
cliargumentsmodule.extractArguments = ->
    log "cliargumentsmodule.extractArguments"
    options = getOptions()
    meowed = meow(getHelpText(), getOptions())
    extract = extractMeowed(meowed)
    return extract

#endregion exposed functions

module.exports = cliargumentsmodule