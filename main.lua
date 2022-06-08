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
end
--------------------------------------------------------------
-- Create directories
for _,v in next,{'conf','progress','record','replay','cache','lib'} do
    local info=love.filesystem.getInfo(v)
    if not info then
        love.filesystem.createDirectory(v)
    elseif info.type~='directory' then
        love.filesystem.remove(v)
        love.filesystem.createDirectory(v)
    end
end
--------------------------------------------------------------
-- Config Zenitha
STRING.install()
Zenitha.setAppName('Techmino')
Zenitha.setVersionText(VERSION.appVer)
Zenitha.setFirstScene('main_1')
Zenitha.setMaxFPS(260)
Zenitha.setUpdateFreq(100)
Zenitha.setDrawFreq(60/260*100)
do-- Zenitha.setDrawCursor
    local gc=love.graphics
    Zenitha.setDrawCursor(function(_,x,y)
        if not SETTINGS.system.sysCursor then
            gc.setColor(1,1,1)
            gc.setLineWidth(2)
            gc.translate(x,y)
            gc.rotate(love.timer.getTime()%MATH.tau)
            gc.rectangle('line',-10,-10,20,20)
            if love.mouse.isDown(1) then gc.rectangle('line',-6,-6,12,12) end
            if love.mouse.isDown(2) then gc.rectangle('fill',-4,-4,8,8) end
            if love.mouse.isDown(3) then gc.line(-8,-8,8,8) gc.line(-8,8,8,-8) end
            gc.setColor(1,1,1,.626)
            gc.line(0,-20,0,20)
            gc.line(-20,0,20,0)
        end
    end)
end
Zenitha.setOnGlobalKey('f11',function()
    SETTINGS.system.fullscreen=not SETTINGS.system.fullscreen
    saveSettings()
end)
Zenitha.setOnFnKeys({
    function() MES.new('info',("System:%s[%s]\nLuaVer:%s\nJitVer:%s\nJitVerNum:%s"):format(SYSTEM,jit.arch,_VERSION,jit.version,jit.version_num)) end,
    function() MES.new('check',PROFILE.switch() and "Profile start!" or "Profile report copied!") end,
    function() if love['_openConsole'] then love['_openConsole']() end end,
    function() for k,v in next,_G do print(k,v) end end,
    function() local w=WIDGET.getSelected() print(w and w:getInfo() or "No widget selected") end,
    function() end,
    function() end,
})

SCR.setSize(1600,1000)
BGM.setMaxSources(20)
VOC.setDiversion(.62)

DEBUG.checkLoadTime("Configuring Zenitha")
--------------------------------------------------------------
DEBUG.logLoadTime()
