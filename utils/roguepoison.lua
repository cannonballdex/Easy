--- @type Mq
local mq = require('mq')
local function RoguePoison()
    local easy = '\ar[\aoEasy\ar]'
    local function Checked()
        return not mq.TLO.Me.Hovering()
        and not mq.TLO.Me.Invulnerable()
        and not mq.TLO.Me.Silenced()
        and not mq.TLO.Me.Mezzed()
        and not mq.TLO.Me.Charmed()
        and not mq.TLO.Me.Feigning()
    end
    local legs = mq.TLO.Me.Inventory('18')()
    if mq.TLO.Me.Class.ShortName() == 'ROG' and Checked() and not mq.TLO.Me.Invis() and not mq.TLO.Me.Sitting() then
        if mq.TLO.Me.Inventory('legs').TimerReady() == 0 and not mq.TLO.Me.Moving() and mq.TLO.Me.FreeInventory() >= 5 and not mq.TLO.Me.Invis() then
            if mq.TLO.Me.FreeInventory() <= 7 then
                print(easy, '\agRog Poison: \arYou are just about out of room to summon poison')
            end
            if mq.TLO.Cursor.ID() ~= nil then
                print(easy, '\agCursor Keep: \ap '..mq.TLO.Cursor.Name())
                mq.cmd.autoinventory()
            end
            mq.cmdf('/itemnotify "%s" rightmouseup',legs)
            mq.delay('3s')
            if mq.TLO.Cursor.ID() ~= nil then
                print(easy, '\agRog Keep: \ap '..mq.TLO.Cursor.Name())
                mq.cmd.autoinventory()
            end
            mq.delay('2s')
            mq.cmd.doability('sneak')
            mq.delay('2s')
            mq.cmd.doability('hide')
        end
    end
end
return RoguePoison