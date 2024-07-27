--- @type Mq
local mq = require('mq')
local function Lesson()
    local easy = '\ar[\aoEasy\ar]'
    local function Alive()
        return mq.TLO.NearestSpawn('pc')() ~= nil
    end
    if Alive() and not mq.TLO.Me.Moving() and mq.TLO.Me.AltAbilityReady("481")() and not mq.TLO.Me.Invis() and not mq.TLO.Me.Hovering() and not mq.TLO.Me.Sitting() and not mq.TLO.Me.Buff('Lesson of the Devoted')() and not mq.TLO.Me.Buff('Bottle of Adventure')() then
        print(easy, '\atUsing Lesson.')
                mq.cmdf('/noparse /alt act 481')
                mq.delay('1s')
        end
    end

return Lesson