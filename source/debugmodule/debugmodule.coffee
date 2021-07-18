debugmodule = {name: "debugmodule"}

##############################################################################
debugmodule.initialize = () ->
    # console.log "debugmodule.initialize - nothing to do"
    return

##############################################################################
debugmodule.modulesToDebug = 
    unbreaker: true
    # cliargumentsmodule: true
    # compositionmodule: true
    # configmodule: true
    # mainprocessmodule: true
    # pathmodule: true
    # recursemodule: true
    # startupmodule: true
    
module.exports = debugmodule