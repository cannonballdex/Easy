--- @type Mq
local mq = require('mq')
local function LootCheck ()
    local easy = '\ar[\aoEasy\ar]'
    if mq.TLO.Group.Leader() == mq.TLO.Me.CleanName() and mq.TLO.Window('AdvancedLootWnd').Open() and mq.TLO.SpawnCount('npccorpse radius 300')() > 0 and not mq.TLO.Me.Hovering() and mq.TLO.Me.FreeInventory() >= 5 and (mq.TLO.Group.Member(1)() == 'pc' or mq.TLO.Group.Members() > 2) then
        if mq.TLO.Me.FreeInventory() <= 7 then
            print(easy, '\agAuto Loot: \arYou are just about out of room to loot')
        end
        mq.cmd('/notify AdvancedLootWnd "ADLW_CLLSetCmbo" leftmouseup')
        mq.delay('1s')
        mq.cmd('/notify AdvancedLootWND ADLW_CLLSetCmbo ListSelect ${Window[AdvancedLootWnd].Child[ADLW_CLLSetCmbo].List[${Me.CleanName}]}')
        mq.delay('1s')
        mq.cmd('/notify AdvancedLootWnd "ADLW_CLLSetBtn" leftmouseup')
        mq.delay('1s')
        if mq.TLO.Window('AdvancedLootWnd').Open() and mq.TLO.Window('ConfirmationDialogBox').Open() then
            mq.cmd('/notify ConfirmationDialogBox CD_YES_Button leftmouseup')
        end
        mq.delay('2s')
        if mq.TLO.Window('AdvancedLootWnd').Open() then
            mq.cmd('/notify AdvancedLootWnd "ADLW_PLL_LeaveAllBtn" leftmouseup')
            mq.delay('1s')
        end
        if mq.TLO.Window('AdvancedLootWnd').Open() then
            mq.cmd('/notify AdvancedLootWND ADLW_CLLSetCmbo ListSelect ${Window[AdvancedLootWnd].Child[ADLW_CLLSetCmbo].List[Leave on Corpse]}')
            mq.delay('1s')
            mq.cmd('/notify AdvancedLootWnd "ADLW_CLLSetBtn" leftmouseup')
        end
    else
        if mq.TLO.Group.Leader() == mq.TLO.Me.CleanName() and mq.TLO.Window('AdvancedLootWnd').Open() and not mq.TLO.Me.Hovering() then
            mq.cmd('/notify AdvancedLootWnd "ADLW_PLL_LeaveAllBtn" leftmouseup')
        end
    end
end

return LootCheck