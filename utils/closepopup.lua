--- @type Mq
local mq = require('mq')
local function ClosePopUp()
    if mq.TLO.Window('AlertWnd').Open() then
        mq.delay('5s')
        mq.cmd('/notify AlertWnd "ALW_Dismiss_button" leftmouseup')
    end
end
return ClosePopUp