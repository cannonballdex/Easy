--- @type Mq
local mq = require('mq')
local function Fellowship()
    local easy = '\ar[\aoEasy\ar]'
    local function Checked()
        return not mq.TLO.Me.Hovering()
        and not mq.TLO.Me.Invulnerable()
        and not mq.TLO.Me.Silenced()
        and not mq.TLO.Me.Mezzed()
        and not mq.TLO.Me.Charmed()
        and not mq.TLO.Me.Feigning()
    end
    if mq.TLO.Me.Fellowship.CampfireZone() ~= mq.TLO.Zone.Name() and mq.TLO.Me.Fellowship.Campfire() and mq.TLO.FindItem("Fellowship Registration Insignia").TimerReady() == 0 and Checked() then
        mq.cmd('/makemevisible')
        mq.cmdf("/useitem %s", 'Fellowship Registration Insignia')
        mq.delay('5s')
        mq.cmd('/makemevisible')
        mq.cmdf("/useitem %s", 'Fellowship Registration Insignia')
        mq.delay(10)
        print(easy, '\ayClicking back to camp!')
    end
end

return Fellowship