--- @type Mq
local mq = require('mq')
local function CloseBook()
    if mq.TLO.Window('SpellBookWnd').Open() then
        mq.delay(10000)
        mq.cmd('/invoke ${Window[SpellBookWnd].DoClose}')
    end
end
return CloseBook