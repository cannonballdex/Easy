--- @type Mq
local mq = require('mq')
local function UseGear()
    local easy = '\ar[\aoEasy\ar]'
    local gear_variables = {
        Back_Buff = mq.TLO.Me.Inventory('back').Spell() or nil,
        Charm_Buff = mq.TLO.Me.Inventory('charm').Spell() or nil,
        mymana = mq.TLO.Me.PctMana() or 0,
        hovering = mq.TLO.Me.Hovering()
    }
    if mq.TLO.Me.Inventory('back').Spell() ~= nil and mq.TLO.Me.Buff(gear_variables.Back_Buff)() == nil and not mq.TLO.Me.Buff('Cloak of Bloodbarbs')() and not mq.TLO.Me.Moving()then
        if mq.TLO.Me.Subscription() ~= 'GOLD' and mq.TLO.Me.Inventory('back').Prestige() then
            return
        end
        if mq.TLO.Me.Inventory('back').TimerReady() and not mq.TLO.Me.Moving() then
            mq.cmdf('/useitem %s', mq.TLO.Me.Inventory('back')())
        end
    end
    if mq.TLO.Me.Inventory('charm').Spell() ~= nil and mq.TLO.Me.Buff(gear_variables.Charm_Buff)() == nil and not mq.TLO.Me.Moving() then
        if mq.TLO.Me.Subscription() ~= 'GOLD' and mq.TLO.Me.Inventory('charm').Prestige() then
            return
        end
        if mq.TLO.Me.Inventory('charm').TimerReady() and not mq.TLO.Me.Moving() then
            mq.cmdf('/useitem %s', mq.TLO.Me.Inventory('charm')())
        end
    end
    if mq.TLO.Me.Class.CanCast() then
        --Wand of Pelagic Transvergence
        if mq.TLO.FindItemCount('Wand of Pelagic Transvergence')() > 0 and mq.TLO.FindItem("Wand of Pelagic Transvergence").TimerReady() == 0 and gear_variables.mymana <= 50 and gear_variables.mymana >= 1 and not gear_variables.hovering then
            print(easy, '\agUsing:\ap Wand of Pelagic Transvergence.')
            mq.cmdf("/useitem %s", 'Wand of Pelagic Transvergence')
            mq.delay(500)
            while mq.TLO.Me.Casting() do mq.delay(250) end
        end
        --Wand of Phantasmal Transvergence
        if mq.TLO.FindItemCount('Wand of Phantasmal Transvergence')() > 0 and mq.TLO.FindItem("Wand of Phantasmal Transvergence").TimerReady() == 0 and gear_variables.mymana <= 50 and gear_variables.mymana >= 1 and not gear_variables.hovering then
            print(easy, '\agUsing:\ap Wand of Phantasmal Transvergence.')
            mq.cmdf("/useitem %s", 'Wand of Phantasmal Transvergence')
            mq.delay(500)
            while mq.TLO.Me.Casting() do mq.delay(250) end
        end
        --Summoned: Dazzling Modulation Shard
        if mq.TLO.FindItemCount('Summoned: Dazzling Modulation Shard')() > 0 and mq.TLO.FindItem("Summoned: Dazzling Modulation Shard").TimerReady() == 0 and gear_variables.mymana <= 50 and gear_variables.mymana >= 1 and not gear_variables.hovering then
            print(easy, '\agUsing:\ap Summoned: Dazzling Modulation Shard.')
            mq.cmdf("/useitem %s", 'Summoned: Dazzling Modulation Shard')
            mq.delay(500)
            while mq.TLO.Me.Casting() do mq.delay(250) end
        end
    end
end

return UseGear