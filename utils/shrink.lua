--- @type Mq
local mq = require('mq')
local function Shrink()
    local easy = '\ar[\aoEasy\ar]'
    local function printf(...)
        print(string.format(...))
    end
    local function Alive()
        return mq.TLO.NearestSpawn('pc')() ~= nil
    end
    local function Checked()
        return not mq.TLO.Me.Hovering()
        and not mq.TLO.Me.Invulnerable()
        and not mq.TLO.Me.Silenced()
        and not mq.TLO.Me.Mezzed()
        and not mq.TLO.Me.Charmed()
        and not mq.TLO.Me.Feigning()
        and not mq.TLO.Me.Moving()
    end
    local Group_Count = mq.TLO.Group.Members()
    local shrink_abilities = {
        [9503] = 'Group Shrink SHM',
        [7025] = 'Group Shrink BST',
    }
    
    if Alive() and Checked() and Group_Count > 0 then
        for g = 0, Group_Count do
            local groupmember = mq.TLO.Group.Member(g)
            if groupmember.Distance() == nil or groupmember.Height() == nil then
                return
            end
            if Alive() and Checked() and groupmember.Height() > 2.04 and groupmember.Distance() < 200 then
                for shrink_ability, name in pairs(shrink_abilities) do
                    if mq.TLO.Me.AltAbilityReady(tostring(shrink_ability))() then
                        mq.cmd('/alt activate ' .. shrink_ability)
                        printf('%s \agUsing Shrink Ability \at%s', easy, name)
                        while mq.TLO.Me.Casting() do
                            mq.delay('1s')
                        end
                    end
                end
            end
        end
    end    
end

return Shrink