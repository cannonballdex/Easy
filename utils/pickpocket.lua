--- @type Mq
local mq = require('mq')
local function Pickpocket()
    local easy = '\ar[\aoEasy\ar]'
    local function Checked()
        return not mq.TLO.Me.Hovering()
        and not mq.TLO.Me.Invulnerable()
        and not mq.TLO.Me.Silenced()
        and not mq.TLO.Me.Mezzed()
        and not mq.TLO.Me.Charmed()
        and not mq.TLO.Me.Feigning()
    end
    if mq.TLO.Me.Skill('Pick Pockets')() > 0 and mq.TLO.Me.Standing() and not mq.TLO.Me.Sitting() and mq.TLO.Target.ID() > 0 and mq.TLO.Me.AbilityReady('Pick Pockets')() and Checked() and mq.TLO.Me.Casting() == nil and not mq.TLO.Me.Combat() and mq.TLO.Target.Type() == 'NPC' and mq.TLO.Target.Distance() < 50 then
        print(easy, '\ayYou begin to Pick Pockets!')
        mq.cmd('/doability "Pick Pockets"')
    end
end

return Pickpocket