--- @type Mq
local mq = require('mq')
local function RemoveLev()
    local easy = '\ar[\aoEasy\ar]'
    if mq.TLO.Me.Levitating() then
        print(easy, '\atRemoving Levitation.')
        mq.cmd('/removelev')
    end
end

return RemoveLev