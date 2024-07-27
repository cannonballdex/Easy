--- @type Mq
local mq = require('mq')
local function OldBulwark()
    local easy = '\ar[\aoEasy\ar]'
	if mq.TLO.FindItemCount('Bulwark of Many Portals')() > 0 and mq.TLO.FindItem('Bulwark of Many Portals').Charges() < 1 and not mq.TLO.Me.Hovering() and not mq.TLO.Me.Casting() then
		if mq.TLO.Cursor.ID() ~= nil then
            print(easy, '\agClearing Cursor \ap '..mq.TLO.Cursor.Name())
            mq.cmd.autoinventory()
        end
        mq.cmd('/ctrl /itemnotify "Bulwark of Many Portals" leftmouseup')
		mq.delay('1s')
        if mq.TLO.Cursor.ID() == 85491 then
		    mq.cmd.destroy()
                print(easy, '\arDestroyed:\ay (Empty) \apBulwark of Many Portals.')
        end
	end
end

return OldBulwark