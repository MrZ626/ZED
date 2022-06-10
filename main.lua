-- #  _______ ______ _____   #
-- # |__   __|  ____|  __ \  #
-- #    | |  | |__  | |  | | #
-- #    | |  |  __| | |  | | #
-- #    | |  | |____| |__| | #
-- #    |_|  |______|_____/  #

-------------------------------------------------------------
-- Load Zenitha
require("Zenitha")
--------------------------------------------------------------
-- Global Vars Declaration
VERSION=require"version"
--------------------------------------------------------------
-- System setting
math.randomseed(os.time()*626)
love.setDeprecationOutput(false)
love.keyboard.setTextInput(false)
if MOBILE then
    local w,h,f=love.window.getMode()
    f.resizable=false
    love.window.setMode(w,h,f)
    love.window.setFullscreen(true)
end
--------------------------------------------------------------
-- Config Zenitha
STRING.install()
Zenitha.setAppName('ZED')
Zenitha.setVersionText(VERSION.appVer)
Zenitha.setFirstScene('editor')
Zenitha.setMaxFPS(60)
Zenitha.setUpdateFreq(100)
Zenitha.setDrawFreq(100)
Zenitha.setDrawCursor(NULL)
Zenitha.setClickFX(false)

SCR.setSize(1400,900)

DEBUG.checkLoadTime("Configuring Zenitha")
--------------------------------------------------------------
SCN.add('editor',require'scene/editor')
--------------------------------------------------------------
DEBUG.logLoadTime()
