--- @type Mq
local mq = require('mq')
local function UseMount()
    local easy = '\ar[\aoEasy\ar]'
    local mount = mq.TLO.Me.Inventory('ammo').Spell() or nil
    
    if mq.TLO.Me.Inventory('ammo').Spell() ~= nil and mq.TLO.Me.Buff(mount)() == nil and not mq.TLO.Me.Moving()then
        if mq.TLO.Me.Subscription() ~= 'GOLD' and mq.TLO.Me.Inventory('ammo').Prestige() then
            return
        end
        if mq.TLO.Me.Inventory('ammo').TimerReady() and not mq.TLO.Me.Moving() then
            mq.cmdf('/useitem %s', mq.TLO.Me.Inventory('ammo')())
        end
    end
end

return UseMount