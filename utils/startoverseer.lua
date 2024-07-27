--- @type Mq
local mq = require('mq')
local easy = '\ar[\aoEasy\ar]'
local function StartOverseer()
    if mq.TLO.Lua.Script('overseer').Status() ~= "RUNNING" then
        --mq.cmd('/beep')
        mq.cmdf('/dgtell all %s - Overseer Crashed', mq.TLO.Me.CleanName())
        mq.delay('5s')
        print(easy, '\agStarting Up Overseer!')
        mq.cmdf('/mqlog Overseer Crashed %s',mq.TLO.Me.CleanName())
        mq.cmd('/lua run overseer')
    end
end

return StartOverseer