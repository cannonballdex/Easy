--- @type Mq
local mq = require('mq')
local lastTells2 = {}
local function RelayTells()
    local lastTells = mq.TLO.MacroQuest.LastTell()
    if lastTells == lastTells2 then
        return
    end
    if lastTells ~= nil then
        mq.cmdf('/dgtell all \ayTell to \ag%s \ay- from \ag%s', mq.TLO.Me.CleanName(), mq.TLO.MacroQuest.LastTell())
        lastTells2 = mq.TLO.MacroQuest.LastTell()
    end
end

return RelayTells