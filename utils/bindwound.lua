--- @type Mq
local mq = require('mq')
local function BindWound()
    local easy = '\ar[\aoEasy\ar]'
    local function Checked()
        return not mq.TLO.Me.Hovering()
        and not mq.TLO.Me.Invulnerable()
        and not mq.TLO.Me.Silenced()
        and not mq.TLO.Me.Mezzed()
        and not mq.TLO.Me.Charmed()
        and not mq.TLO.Me.Feigning()
    end
    for p = 0, mq.TLO.Group.Members() do
        if Checked() and mq.TLO.Group.Member(p).Distance() ~= nil and mq.TLO.Group.Member(p).PctHPs() < 90 then
            if mq.TLO.FindItemCount('Bandage')() > 0 and mq.TLO.Me.Skill('Bind Wound')() > 0 and mq.TLO.Me.AbilityReady('Bind Wound')() and Checked() and mq.TLO.Me.Casting() == nil and not mq.TLO.Me.Combat() and not mq.TLO.Navigation.Active() and mq.TLO.Me.XTarget() == 0 then
                if nil ~= mq.TLO.Macro() then
                    mq.cmd('/mqp')
                end
                mq.cmdf('/target id %s',mq.TLO.Group.Member(p).ID())
            ::BindMore::
            if mq.TLO.Group.Member(p).Distance() > 20 then
                mq.cmdf('/nav id %s',mq.TLO.Target.ID())
                while mq.TLO.Navigation.Active() do mq.delay(100) end
            end
                mq.cmd('/doability "Bind Wound"')
                mq.delay('10s')
                while not mq.TLO.Me.AbilityReady('Bind Wound')() do mq.delay(100) end
                if Checked() and mq.TLO.Group.Member(p).Distance() ~= nil and mq.TLO.Group.Member(p).PctHPs() < 90 and mq.TLO.FindItemCount('Bandage')() > 0 and mq.TLO.Me.XTarget() == 0 then
                    goto BindMore
                else
                    if mq.TLO.Macro.Paused() then
                        mq.cmd('/mqp')
                    end
                    break
                end
            end
        end
    end
end
return BindWound