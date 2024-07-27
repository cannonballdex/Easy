--- @type Mq
local mq = require('mq')
local function RespawnBind()
    if mq.TLO.Me.Hovering() then
        mq.cmd('/beep')
        mq.cmd('/beep')
        mq.cmd('/beep')
        mq.cmd('/nomodkey /notify RespawnWnd RW_SelectButton LeftMouseUp')
    end
end

return RespawnBind