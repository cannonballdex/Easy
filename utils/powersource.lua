--- @type Mq
local mq = require('mq')
local function PowerSource()
    local easy = '\ar[\aoEasy\ar]'
    if mq.TLO.Me.Inventory('21')() ~= nil then
        MySource = mq.TLO.Me.Inventory('21').Name()
        MySourceID = mq.TLO.Me.Inventory('21').ID()
        MySourceCount = mq.TLO.FindItemCount(MySourceID)()
        MySourcePower = mq.TLO.Me.Inventory('powersource').Power()
    end
    while MySource == nil or MySource == 'NONE' do
        MySource = mq.TLO.Me.Inventory('powersource').Name()
        MySourceID = mq.TLO.Me.Inventory('powersource').ID()
        if MySource ~= nil then
            MySourceCount = mq.TLO.FindItemCount(MySourceID)()
            MySourcePower = mq.TLO.Me.Inventory('powersource').Power()
        end
        if MySource == nil then
            MySource = 'NONE'
            MySourceCount = 0
            MySourcePower = 0
        end
        break
    end
    if mq.TLO.Me.Inventory('powersource').Name() ~= MySource and mq.TLO.FindItem(MySource)() ~= nil then
        mq.cmdf('/itemnotify "%s" leftmouseup',MySource)
        if mq.TLO.Cursor() == MySource then
            mq.cmd('/ctrl /itemnotify powersource leftmouseup')
        end
        mq.delay('1s')
        if mq.TLO.Window('ConfirmationDialogBox').Open() then
            mq.TLO.Window('ConfirmationDialogBox').Child('CD_Yes_Button').LeftMouseUp()
        end
        print(easy, '\ayUnCheck or Equip a Power Source to use one.')
        mq.delay('1s')
        mq.cmd.autoinventory()
    end
    if mq.TLO.FindItem(MySource).Power() == 0 and mq.TLO.FindItem(MySource)() ~= nil then
        mq.cmd('/ctrl /itemnotify powersource leftmouseup')
        if mq.TLO.FindItem(MySource).Power() == 0 and mq.TLO.Cursor.Name() == MySource and mq.TLO.Cursor.Name() ~= nil then
            mq.cmd.destroy()
            print(easy, '\arDestroyed:\ap Spent Power Source.')
            mq.delay(10)
        end
        if mq.TLO.FindItem(MySource)() == nil then
            print('\ayYou have not equipped a Power Sources.')
            print('\ayYou need to equip or uncheck Power Source.')
            mq.delay(10)
        end
        mq.delay('1s')
    end
end

return PowerSource