--  Easy.lua - Cannonballdex - 2022-AUG-28

---@type Mq
local mq = require('mq')
require 'ImGui'
local LIP = require('../lib/LIP')
local ICONS = require('mq.Icons')
local UseGear = require('utils.usegear')
--local PowerSource = require('utils.powersource')
local Shrink = require('utils.shrink')
local StartOverseer = require('utils.startoverseer')
local RelayTells = require('utils.relaytells')
local RemoveLev = require('utils.removelev')
local Lesson = require('utils.lesson')
local LootCheck = require('utils.lootcheck')
local Fellowship = require('utils.fellowship')
local BindWound = require('utils.bindwound')
local Begging = require('utils.begging')
local Pickpocket = require('utils.pickpocket')
local RespawnBind = require('utils.respawnbind')
local ClosePopUp = require('utils.closepopup')
local OldBulwark = require('utils.oldbulwark')
local CloseBook = require('utils.closebook')
local RoguePoison = require('utils.roguepoison')
local UseMount = require('utils.usemount')
local SETTINGS_FILE = ''
local SETTINGS_PATH = ''
local LOOT_FILE = ''
local LOOT_CONFIG_CHECK = ''
local Version = 'BETA v10.0'
local current_plat = 0
local Macro = ''
mq.cmdf('/%s pause on', mq.TLO.CWTN.Command())
print('\arWarning: \ayThis script does not run with CWTN plugin, CWTN has been paused')
local function save_settings()
    LIP.save(SETTINGS_PATH, SETTINGS)
end
local function loot_file_exists(LOOT_CONFIG)
    local file = io.open(LOOT_CONFIG, "r")
    if file ~= nil then
        io.close(file)
        return true
    else
        return false
    end
end
local function file_exists(path)
    local file = io.open(path, "r")
    if file ~= nil then
        io.close(file)
        return true
    else
        return false
    end
end
local easy = '\ao[\apEasy\ao]'

local DefaultSets = {
    aa_rez=false,
    auto_loot=false,
    begging=false,
    ber_burn=false,
    bind_wound=false,
    brd_burn=false,
    bst_burn=false,
    campfire=false,
    check_parcel=false,
    clear_cursor=false,
    clear_rods=false,
    close_book=false,
    close_popup=true,
    clr_burn=false,
    corpse_recovery=false,
    dannet_load=true,
    destroy_bulwark=true,
    destroy_rods=false,
    dru_burn=false,
    edibles_pok_gl=false,
    enc_burn=false,
    endless_turkey=false,
    fellowship=false,
    font_size=1,
    forage=false,
    forage_safezones=false,
    force_drink=false,
    force_feed=false,
    get_drunk=false,
    grab_globes=false,
    group_shrink=false,
    gm_alert=false,
    lazy_merc=true,
    lesson=false,
    mag_burn=false,
    mag_cauldron=false,
    mnk_burn=false,
    nec_burn=false,
    only_show_missing=false,
    only_show_spawned=false,
    pal_burn=false,
    pickpocket=false,
    pc_alert=false,
    pop_merc=false,
    power_source=false,
    relay_tells=false,
    remove_levitation=false,
    respawn_bind=false,
    revive_merc=true,
    revive_merc_suspended=false,
    rng_burn=false,
    rog_burn=false,
    rog_poison=false,
    scoot_camp=false,
    shd_burn=false,
    shm_burn=false,
    start_overseer=false,
    summon_bread=false,
    summon_brew=false,
    summon_cookies=false,
    summon_milk=false,
    summon_tea=false,
	summon_water=false,
    teach_languages=false,
    toon_assist=false,
    use_mount=false,
    war_burn=false,
    wiz_burn=false,
    working_merc=true
}
    local CHAR_CONFIG = 'Char_' .. mq.TLO.EverQuest.Server() .. '_' .. mq.TLO.Me.CleanName() .. '_Config'

    CONFIG_DIR = mq.TLO.MacroQuest.Path() .. "\\lua\\Easy\\"
    SETTINGS_FILE = 'Easy.ini'
    SETTINGS_PATH = CONFIG_DIR..SETTINGS_FILE
    LOOT_FILE = 'config.lua'
    LOOT_CONFIG_CHECK = CONFIG_DIR..LOOT_FILE
    if loot_file_exists(LOOT_CONFIG_CHECK) then
        LOOT_CONFIG = require('Easy.config')
    else
        LOOT_CONFIG = require('Easy.config_default')
    end
    local LOOT_CONFIG = LOOT_CONFIG
    if file_exists(SETTINGS_PATH) then
        SETTINGS = LIP.load(SETTINGS_PATH)
    else
        SETTINGS = {
            [CHAR_CONFIG] = DefaultSets
        }
        save_settings()
    end

    -- if this character doesn't have the sections in the ini, create them
    if SETTINGS[CHAR_CONFIG] == nil then
        SETTINGS[CHAR_CONFIG] = DefaultSets
        save_settings()
    end

     -- populate variables from loaded data
     local saved_settings = {
        aa_rez = SETTINGS[CHAR_CONFIG]['aa_rez'],
        auto_loot = SETTINGS[CHAR_CONFIG]['auto_loot'],
        begging = SETTINGS[CHAR_CONFIG]['begging'],
        ber_burn = SETTINGS[CHAR_CONFIG]['ber_burn'],
        bind_wound = SETTINGS[CHAR_CONFIG]['bind_wound'],
        brd_burn = SETTINGS[CHAR_CONFIG]['brd_burn'],
        bst_burn = SETTINGS[CHAR_CONFIG]['bst_burn'],
        campfire = SETTINGS[CHAR_CONFIG]['campfire'],
        check_parcel = SETTINGS[CHAR_CONFIG]['check_parcel'],
        clear_cursor = SETTINGS[CHAR_CONFIG]['clear_cursor'],
        clear_rods = SETTINGS[CHAR_CONFIG]['clear_rods'],
        close_book = SETTINGS[CHAR_CONFIG]['close_book'],
        close_popup = SETTINGS[CHAR_CONFIG]['close_popup'],
        corpse_recovery = SETTINGS[CHAR_CONFIG]['corpse_recovery'],
        clr_burn = SETTINGS[CHAR_CONFIG]['clr_burn'],
        dannet_load = SETTINGS[CHAR_CONFIG]['dannet_load'],
        destroy_bulwark = SETTINGS[CHAR_CONFIG]['destroy_bulwark'],
        destroy_rods = SETTINGS[CHAR_CONFIG]['destroy_rods'],
        dru_burn = SETTINGS[CHAR_CONFIG]['dru_burn'],
        edibles_pok_gl = SETTINGS[CHAR_CONFIG]['edibles_pok_gl'],
        enc_burn = SETTINGS[CHAR_CONFIG]['enc_burn'],
        endless_turkey = SETTINGS[CHAR_CONFIG]['endless_turkey'],
        fellowship = SETTINGS[CHAR_CONFIG]['fellowship'],
        font_size = SETTINGS[CHAR_CONFIG]['font_size'],
        forage = SETTINGS[CHAR_CONFIG]['forage'],
        forage_safezones = SETTINGS[CHAR_CONFIG]['forage_safezones'],
        force_drink = SETTINGS[CHAR_CONFIG]['force_drink'],
        force_feed = SETTINGS[CHAR_CONFIG]['force_feed'],
        get_drunk = SETTINGS[CHAR_CONFIG]['get_drunk'],
        grab_globes = SETTINGS[CHAR_CONFIG]['grab_globes'],
        group_shrink = SETTINGS[CHAR_CONFIG]['group_shrink'],
        gm_alert = SETTINGS[CHAR_CONFIG]['gm_alert'],
        lazy_merc = SETTINGS[CHAR_CONFIG]['lazy_merc'],
        lesson = SETTINGS[CHAR_CONFIG]['lesson'],
        mag_burn = SETTINGS[CHAR_CONFIG]['mag_burn'],
        mag_cauldron = SETTINGS[CHAR_CONFIG]['mag_cauldron'],
        mnk_burn = SETTINGS[CHAR_CONFIG]['mnk_burn'],
        nec_burn = SETTINGS[CHAR_CONFIG]['nec_burn'],
        only_show_missing = SETTINGS[CHAR_CONFIG]['only_show_missing'],
        only_show_spawned = SETTINGS[CHAR_CONFIG]['only_show_spawned'],
        pal_burn = SETTINGS[CHAR_CONFIG]['pal_burn'],
        pc_alert = SETTINGS[CHAR_CONFIG]['pc_alert'],
        pickpocket = SETTINGS[CHAR_CONFIG]['pickpocket'],
        pop_merc = SETTINGS[CHAR_CONFIG]['pop_merc'],
        power_source = SETTINGS[CHAR_CONFIG]['power_source'],
        relay_tells = SETTINGS[CHAR_CONFIG]['relay_tells'],
        remove_levitation = SETTINGS[CHAR_CONFIG]['remove_levitation'],
        respawn_bind = SETTINGS[CHAR_CONFIG]['respawn_bind'],
        revive_merc = SETTINGS[CHAR_CONFIG]['revive_merc'],
        revive_merc_suspended = SETTINGS[CHAR_CONFIG]['revive_merc_suspended'],
        rng_burn = SETTINGS[CHAR_CONFIG]['rng_burn'],
        rog_burn = SETTINGS[CHAR_CONFIG]['rog_burn'],
        rog_poison = SETTINGS[CHAR_CONFIG]['rog_poison'],
        scoot_camp = SETTINGS[CHAR_CONFIG]['scoot_camp'],
        shd_burn = SETTINGS[CHAR_CONFIG]['shd_burn'],
        shm_burn = SETTINGS[CHAR_CONFIG]['shm_burn'],
        start_overseer = SETTINGS[CHAR_CONFIG]['start_overseer'],
        summon_brew = SETTINGS[CHAR_CONFIG]['summon_brew'],
        summon_cookies = SETTINGS[CHAR_CONFIG]['summon_cookies'],
        summon_milk = SETTINGS[CHAR_CONFIG]['summon_milk'],
        summon_picnic = SETTINGS[CHAR_CONFIG]['summon_picnic'],
        summon_tea = SETTINGS[CHAR_CONFIG]['summon_tea'],
        summon_bread = SETTINGS[CHAR_CONFIG]['summon_bread'],
		summon_water = SETTINGS[CHAR_CONFIG]['summon_water'],
        teach_languages = SETTINGS[CHAR_CONFIG]['teach_languages'],
        toon_assist = SETTINGS[CHAR_CONFIG]['toon_assist'],
        use_mount = SETTINGS[CHAR_CONFIG]['use_mount'],
        war_burn = SETTINGS[CHAR_CONFIG]['war_burn'],
        wiz_burn = SETTINGS[CHAR_CONFIG]['wiz_burn'],
        working_merc = SETTINGS[CHAR_CONFIG]['working_merc']
    }

    --Default Customized Settings--
    local defaults = {
        EAT_LEVEL = 3500,
        DRINK_LEVEL = 3500,
        GET_DRUNK_LEVEL = 180,
        COOKIES_TO_SUMMON = 20,
        SPICED_TEA_TO_SUMMON = 20,
        WARM_MILK_TO_SUMMON = 20,
        ELVEN_WINE_TO_SUMMON = 20,
        AFTERNOON_TEA_TO_SUMMON = 20,
        REFRESHING_MILK_TO_SUMMON = 20,
        JUMJUM_CAKE_TO_SUMMON = 20,
        PLUMP_SYLVAN_BERRIES_TO_SUMMON = 20,
        SPICY_WOLF_SANDWICH_TO_SUMMON = 20,
        BRELL_ALE_TO_SUMMON = 20,
        ALE_TO_SUMMON = 20,
        COOKED_TURKEY_TO_SUMMON = 20,
        BURNED_BREAD_TO_SUMMON = 20,
        MURKY_GLOBE_TO_SUMMON = 20,
        SCOOT_DISTANCE = 500,
        ALERT_DISTANCE = 500,
        TOON_ASSIST_PCT_ON = 98,
        TOON_ASSIST_PCT_OFF = 80,
        TOON_ASSIST_TARGET_DIST = 25,
        START_BURN = 98,
        STOP_BURN = 2,
        PARCEL_ZONES = {
            751, 737, 738, 345, 712
        }
    }
--Force Feed
local food = LOOT_CONFIG.food
--Force Drink
local drink = LOOT_CONFIG.drink
--Force Drunk
local liquor = LOOT_CONFIG.liquor
--Forage Items to Destroy
local FORAGE_DESTROY = LOOT_CONFIG.FORAGE_DESTROY
--Forage Items to Keep
local FORAGE_KEEP = LOOT_CONFIG.FORAGE_KEEP
--Mod Rods to Destroy
local MOD_RODS_TO_DESTROY = LOOT_CONFIG.MOD_RODS_TO_DESTROY
--Mod Rods to Inventory
local MOD_RODS_TO_INVENTORY = LOOT_CONFIG.MOD_RODS_TO_INVENTORY
--Cauldron Items to Destroy
local CAULDRON_TO_DESTROY = LOOT_CONFIG.CAULDRON_TO_DESTROY
--Cauldron Items to Keep
local CAULDRON_TO_KEEP = LOOT_CONFIG.CAULDRON_TO_KEEP
--Instance Zones to Show DanNet Peer Count
local INSTANCE_ZONE = LOOT_CONFIG.INSTANCE_ZONE
--End of Default Customized Settings--

--Multi check function
local function Checked()
    return not mq.TLO.Me.Hovering()
    and not mq.TLO.Me.Invulnerable()
    and not mq.TLO.Me.Silenced()
    and not mq.TLO.Me.Mezzed()
    and not mq.TLO.Me.Charmed()
    and not mq.TLO.Me.Feigning()
end
--Cheap Delay for GUI
local function Alive()
    return mq.TLO.NearestSpawn('pc')() ~= nil
end

--Hunter Stuffs
-- ICONS for the checkboxes
local done = mq.FindTextureAnimation('A_TransparentCheckBoxPressed')
local notDone = mq.FindTextureAnimation('A_TransparentCheckBoxNormal')
-- print format function
local function printf(...)
    print(string.format(...))
end
local settings_hud = {
    oldZone = 0,
    myZone = mq.TLO.Zone.ID,
    minimize = false,
    totalDone = ''
}
local function onlyShowMissing()
    saved_settings.only_show_missing = true
end
local function ShowMissing()
    saved_settings.only_show_missing = false
end
local function onlyShowSpawned()
    saved_settings.only_show_spawned = true
end
local function ShowSpawned()
    saved_settings.only_show_spawned = false
end
-- shortening the mq bind for achievements 
local myAch = mq.TLO.Achievement

-- Table that will store the spawnnames of the Hunter achievement
local myHunterSpawn = {}

-- Current Achievemment information
local curAch = {}

-- nameMap that maps wrong achievement objective names to the ingame name.
local nameMap = {
    ["Pli Xin Liako"]           = "Pli Xin Laiko",
    ["Xetheg, Luclin's Warder"] = "Xetheg, Luclin`s Warder",
    ["Itzal, Luclin's Hunter"]  = "Itzal, Luclin`s Hunter",
    ["Ol' Grinnin' Finley"]     = "Ol` Grinnin` Finley",
    ["Howling Spectre"]         = "Howling Spectre",
    ["Ebon lotus"]              = "Ebon Lotus",
    ["Bloodvein"]               = "Bloodvein"
}

-- Zonemap that maps zoneID's to Achievement Indexes, for zones that are speshul!
local zoneMap = {
    [58]  = 105880,  --Hunter of Crushbone                  Clan Crusbone=crushbone

    [66]  = 106680,  --Hunter of The Ruins of Old Guk       The Reinforced Ruins of Old Guk=gukbottom
    [73]  = 107380,  --Hunter of the Permafrost Caverns     Permafrost Keep=permafrost
    [81]  = 258180,  --Hunter of The Temple of Droga        The Temple of Droga=droga
    [83]  = 208380,  --Hunter of The Swamp of No Hope       The Hunter of The Swamp of No Hope=swampofnohope
    [87]  = 208780,  --Hunter of The Burning Wood           The Burning Woods=burningwood
    [89]  = 208980,  --Hunter of The Ruins of Old Sebilis   The Reinforced Ruins of Old Sebilis=sebilis
    [108] = 250880,  --Hunter of Veeshan's Peak             Veeshan's Peak=veeshan
    [116] = 311680,  --Hunter of Eastern Wastes             Old Eastern Wastes=eastwastes

    [207] = 520780,  --Hunter of Torment, the Plane of Pain Plane of Torment=potorment
    [455] = 1645560, --Hunter of Kurn's Tower               Kurn's Tower=oldkurn
    [318] = 908300,  --Hunter of Dranik's Hollows           Dranik's Hollows (A)=dranikhollowsa
    [319] = 908300,  --Hunter of Dranik's Hollows           Dranik's Hollows (B)=dranikhollowsb
    [320] = 908300,  --Hunter of Dranik's Hollows           Dranik's Hollows (C)=dranikhollowsc
    [328] = 908600,  --Hunter of Catacombs of Dranik        Catacombs of Dranik (A)=dranikcatacombsa
    [329] = 908600,  --Hunter of Catacombs of Dranik        Catacombs of Dranik (B)=dranikcatacombsb
    [330] = 908600,  --Hunter of Catacombs of Dranik        Catacombs of Dranik (C)=dranikcatacombsc
    [331] = 908700,  --Hunter of Sewers of Dranik           Sewers of Dranik (A)=draniksewersa
    [332] = 908700,  --Hunter of Sewers of Dranik           Sewers of Dranik (B)=draniksewersb
    [333] = 908700,  --Hunter of Sewers of Dranik           Sewers of Dranik (C)=draniksewersc
    [474] = 1647460, --Hunter of Old city of Dranik Scar    City of Dranik=olddranik

    [700] = 1870060, --Hunter of The Feerrott               The Feerrott=Feerrott2
    [772] = 2177270, --Hunter of West Karana (Ethernere)    Ethernere Tainted West Karana=ethernere
    [76]  = 2320180, --Hunter of the Plane of Hate: Broken Mirror  Plane of hate Revisited=hateplane
    [788] = 2478880, --Hunter of The Temple of Droga        Temple of Droga=drogab
    [791] = 2479180, --Hunter of Frontier Mountains         Frontier Mountains=frontiermtnsb
    [800] = 2480080, --Hunter of Chardok                    Chardok=chardoktwo

    [813] = 2581380, --Hunter of The Howling Stones         Howling Stones=charasistwo
    [814] = 2581480, --Hunter of The Skyfire Mountains      Skyfire Mountains=skyfiretwo
    [815] = 2581580, --Hunter of The Overthere              The Overthere=overtheretwo
    [816] = 2581680, --Hunter of Veeshan's Peak             Veeshan's Peak=veeshantwo

    [824] = 2782480, --Hunter of The Eastern Wastes         The Eastern Wastes=eastwastestwo
    [825] = 2782580, --Hunter of The Tower of Frozen Shadow The Tower of Frozen Shadow=frozenshadowtwo
    [826] = 2782680, --Hunter of The Ry`Gorr Mines          The Ry`Gorr Mines=crystaltwoa
    [827] = 2782780, --Hunter of The Great Divide           The Great Divide=greatdividetwo
    [828] = 2782880, --Hunter of Velketor's Labyrinth       Velketor's Labyrinth=velketortwo
    [829] = 2782980, --Hunter of Kael Drakkel               Kael Drakkel=kaeltwo
    [830] = 2783080, --Hunter of Crystal Caverns            Crystal Caverns=crystaltwob

    [831] = 2807601, --Hunter of The Sleeper's Tomb         The Sleeper's Tomb=sleepertwo
    [832] = 2807401, --Hunter of Dragon Necropolis          Dragon Necropolis=necropolistwo
    [833] = 2807101, --Hunter of Cobalt Scar                Cobalt Scar=cobaltscartwo
    [834] = 2807201, --Hunter of The Western Wastes         The Western Wastes=westwastestwo
    [835] = 2807501, --Hunter of Skyshrine                  Skyshrine=skyshrinetwo
    [836] = 2807301, --Hunter of The Temple of Veeshan      The Temple of Veeshan=templeveeshantwo

    [843] = 2908100, --Hunter of Maiden's Eye               Maiden's Eye=maidentwo
    [844] = 2908200, --Hunter of Umbral Plains              Umbral Plains=umbraltwo
    [846] = 2908400, --Hunter of Vex Thal                   Vex Thal=vexthaltwo
    [847] = 2908500, --Hunter of Shadow Valley              zone name has an extra space

    [851] = 3008500, --Hunter of Ruins of Shadow Haven      Ruins of Shadow Haven=shadowhaventwo
    [852] = 3008300, --Hunter of Shar Vahl, Divided         Shar Vahl, Divided=sharvahltwo
    [853] = 3008400, --Hunter of Paludal Depths             Paludal Depths=paludaltwo
    [854] = 3008200, --Hunter of Shadeweaver's Tangle       Shadeweaver's Tangle=shadeweavertwo

    [734] = 1973360, --Hunter of The Sepulcher of Order     Sepulcher of Order East=eastseupulcher
    [735] = 1973360, --Hunter of The Suplucher of Order     Sepulcher of Order West=westsepulcher

    }
    local function AchID()
        if zoneMap[mq.TLO.Zone.ID()] or myAch('Hunter of the '..mq.TLO.Zone.Name()).ID() then
            return zoneMap[mq.TLO.Zone.ID()] or myAch('Hunter of the '..mq.TLO.Zone.Name()).ID()
        else
            return myAch('Hunter of '..mq.TLO.Zone.Name()).ID()
        end
    end

    local function findspawn(spawn)
    if nameMap[spawn] then spawn = nameMap[spawn] end
        local mySpawn = mq.TLO.Spawn(string.format('npc "%s"', spawn))
        if mySpawn.CleanName() == spawn then
            return mySpawn.ID()
        end
        return 0
    end
    local function getPctCompleted()
        local tmp = 0
        for index, hunterSpawn in ipairs(myHunterSpawn) do
            if myAch(curAch.ID).Objective(hunterSpawn).Completed() then
                tmp = tmp + 1
            end
        end
        settings_hud.totalDone = string.format('%d/%d',tmp, curAch.Count)
        if tmp == curAch.Count then settings_hud.totalDone = 'Completed!' end
        return tmp / curAch.Count
    end

    local function drawCheckBox(spawn)
        if myAch(curAch.ID).Objective(spawn).Completed() then
            ImGui.DrawTextureAnimation(done, 15, 15)
            ImGui.SameLine()
        else
            ImGui.DrawTextureAnimation(notDone, 15, 15)
            ImGui.SameLine()
        end
    end

    local function textEnabled(spawn)
        ImGui.PushStyleColor(ImGuiCol.Text, 0.690, 0.553, 0.259, 1)
        ImGui.PushStyleColor(ImGuiCol.HeaderHovered, 0.33, 0.33, 0.33, 0.5)
        ImGui.PushStyleColor(ImGuiCol.HeaderActive, 0.0, 0.66, 0.33, 0.5)
        local selSpawn = ImGui.Selectable(spawn, false, ImGuiSelectableFlags.AllowDoubleClick)
        ImGui.PopStyleColor(3)
        if selSpawn and ImGui.IsMouseDoubleClicked(0) then
            mq.cmdf('/nav id %d log=error' , findspawn(spawn))
            printf('\ayMoving to \ag%s',spawn)
        end
    end

    local function hunterProgress()
        local x, y = ImGui.GetContentRegionAvail()
        ImGui.PushStyleColor(ImGuiCol.PlotHistogram, 0.690, 0.553, 0.259, 0.5)
        ImGui.PushStyleColor(ImGuiCol.FrameBg, 0.33, 0.33, 0.33, 0.5)
        ImGui.SetWindowFontScale(0.85)
        ImGui.Indent(2)
        ImGui.ProgressBar(getPctCompleted(), x-4, 14, settings_hud.totalDone)
        ImGui.PopStyleColor(2)
        ImGui.SetWindowFontScale(1)
    end

    local function createLines(spawn)
        if findspawn(spawn) ~= 0 then
            drawCheckBox(spawn)
            textEnabled(spawn)
        elseif not saved_settings.only_show_spawned then
            drawCheckBox(spawn)
            ImGui.TextDisabled(spawn)
        end
    end

    local function RenderHunter()
        hunterProgress()
        if not settings_hud.minimize then ImGui.Separator() end
        for index, hunterSpawn in ipairs(myHunterSpawn) do
            if not settings_hud.minimize then
                if saved_settings.only_show_missing then
                    if not myAch(curAch.ID).Objective(hunterSpawn).Completed() then
                        createLines(hunterSpawn)
                    end
                else
                    createLines(hunterSpawn)
                end
            end
        end
    end

    local function updateTables()
        myHunterSpawn = {}
        curAch = {}

        if AchID() ~= nil then
            curAch = {
                ID = AchID(),
                Name = myAch(AchID()).Name(),
                Count = myAch(AchID()).ObjectiveCount()
            }
            printf('\a#f8bd21\ayUpdating... \agEasy Hunter\ao (\a#b08d42%s\a#f8bd21)', curAch.Name)
            local i = 0
            repeat
                if myAch(AchID()).ObjectiveByIndex(i)() ~= nil then
                    table.insert(myHunterSpawn,myAch(AchID()).ObjectiveByIndex(i)())
                end
                i = i + 1
            until #myHunterSpawn == curAch.Count
            printf('\a#f8bd21\ayUpdating... \agEasy Hunter \atDone\ao (\a#b08d42%s\a#f8bd21)', curAch.Name)
        else
            print('\a#f8bd21\ayNo Hunts found in \a#b08d42'..mq.TLO.Zone())
        end
    end

    local function RenderTitle()
        ImGui.SetWindowFontScale(1.15)
        local title = 0
        if curAch.ID then
            title = curAch.Name
        else
            title = mq.TLO.Zone.Name()
        end
        ImGui.SetCursorPosX((ImGui.GetWindowWidth() - ImGui.CalcTextSize(title)) * 0.5)
        ImGui.TextColored(0.973, 0.741, 0.129, 1, title)
        ImGui.SetWindowFontScale(1)
    end

local state = {}
state.settings = {}
state.settings.showLineSeparators = true
local Open, ShowUI = true, true
local pause_switch = false
local pause_switch_all = false
local gm_switch = false
local spawned_switch = false
local missing_switch = false
local zoneid = nil
local ingnoreguild = true
local MySource = mq.TLO.Me.Inventory('21')()
local MySourceID = mq.TLO.Me.Inventory('powersource').ID()
local MySourceCount = mq.TLO.FindItemCount(MySourceID)()
local MySourcePower = mq.TLO.Me.Inventory('powersource').Power()
local CampFireZone = mq.TLO.Me.Fellowship.CampfireZone()
local CampfireDuration = mq.TLO.Me.Fellowship.CampfireDuration.TotalSeconds()
local Invis_IVU_Status = "NO"
local Root_Status = "NO"
local Snare_Status = "NO"
local Levitate_Status = "NO"
local expansion_owned = "Pre-TOL"
local timeDisplayNorrath = string.format("%02d:%02d", mq.TLO.GameTime.Hour(), mq.TLO.GameTime.Minute())
local timeDisplayEarth = os.date("%H:%M:%S")
local peerCountDanNet
local zonePeerCount = (string.format('zone_%s_%s', mq.TLO.EverQuest.Server(), mq.TLO.Zone.ShortName()))

if mq.TLO.Plugin('mq2dannet')() == nil and saved_settings.dannet_load then
    mq.cmd('/plugin dannet')
    print('\agPlugin \atMQ2DanNet \ay is required.')
    print('\ayLOADING.. \agPlugin \atDanNet')
    mq.delay('3s')
    if mq.TLO.DanNet.FullNames() then
        mq.cmd('/dnet fullnames off')
    end
end
if mq.TLO.Plugin('mq2dannet')() ~= nil and saved_settings.dannet_load then
    peerCountDanNet = mq.TLO.DanNet.PeerCount()
end

print('\ayLoading... \ao[\apEasy.lua\ao] \awby \agCannonballdex \at'..Version..'')
print('\ao[\apEasy Help\ao]\ag /easy \aw - For a list of help commands')
if mq.TLO.Me.Inventory('21')() == nil then
        print('\ayYou will need to equip a \agPower Source\ay to use one.')
    end
    local function HelpMarker(desc)
		if ImGui.IsItemHovered() then
			ImGui.BeginTooltip()
			ImGui.PushTextWrapPos(ImGui.GetFontSize() * 35.0)
			ImGui.Text(desc)
			ImGui.PopTextWrapPos()
			ImGui.EndTooltip()
		end
	end

-------------------------------------------------
------------------ Off Zones --------------------
-------------------------------------------------
local offzones = {
    151, 152, 202, 203, 344, 345, 346, 712, 737, 751
    }

-------------------------------------------------
------------------ On Zones --------------------
-------------------------------------------------
local onzones = {
   1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36,
   37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70,
   71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103,
   104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130,
   131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 153, 154, 155, 156, 157, 158, 159,
   160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186,
   187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215,
   216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242,
   243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269,
   270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296,
   297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323,
   324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340, 341, 342, 343, 347, 348, 349, 350, 351, 352, 353,
   354, 355, 356, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 379, 379, 380,
   381, 382, 383, 384, 385, 386, 387, 388, 389, 390, 391, 392, 393, 394, 395, 386, 397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407,
   408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 444,
   445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471,
   472, 473, 474, 475, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 700, 701, 702, 703, 704, 705,
   706, 707, 708, 709, 710, 711, 713, 714, 724, 725, 726, 727, 728, 729, 230, 731, 732, 733, 734, 735, 752, 753, 754, 755, 756, 758, 759,
   763, 764, 765, 768, 769, 770, 771, 772, 773, 774, 775, 777, 778, 779, 780, 781, 782, 783, 784, 785, 787, 788, 789, 790, 791, 792, 793,
   794, 795, 798, 800, 813, 814, 815, 816, 817, 818, 819, 820, 821, 822, 823, 824, 825, 826, 827, 828, 829, 830, 831, 832, 833, 834, 835,
   836, 837, 838, 839, 840, 841, 842, 843, 844, 845, 846, 847, 848, 849, 850, 851, 852, 853, 854, 855, 856, 857, 858, 859, 860, 861, 862,
   863, 864, 865, 869, 870, 871, 872, 873, 874, 875, 974, 975, 904, 996, 997, 998
  }

-------------------------------------------------
------------------ Campfire ---------------------
-------------------------------------------------
local function Campfire()
    for k = 1, #onzones do
        if mq.TLO.Zone.ID() == onzones[k] and mq.TLO.Me.Fellowship.Campfire() == false and not mq.TLO.Me.Hovering() and mq.TLO.SpawnCount('radius 50 fellowship')() > 2 then
            mq.cmd('/windowstate FellowshipWnd open')
            mq.delay('1s')
            mq.cmd('/nomodkey /notify FellowshipWnd FP_Subwindows tabselect 2')
            mq.delay('1s')
            mq.cmd('/nomodkey /notify FellowshipWnd FP_RefreshList leftmouseup')
            mq.delay('1s')
            mq.cmd('/nomodkey /notify FellowshipWnd FP_CampsiteKitList listselect 1')
            mq.delay('1s')
            mq.cmd('/nomodkey /notify FellowshipWnd FP_CreateCampsite leftmouseup')
            mq.delay('1s')
            mq.cmd('/windowstate FellowshipWnd close')
            mq.delay('1s')
            if mq.TLO.Me.Fellowship.Campfire() then
                print(easy, ' \ag You Have A Campfire')
            end
            mq.delay('1s')
        end
    end
end

-------------------------------------------------
------------------ Grab Globes ------------------
-------------------------------------------------
local function GrabGlobes()
    for k = 1, #onzones do
        if mq.TLO.Zone.ID() == onzones[k] and Alive() then
        local shinydist = mq.TLO.Ground.Search('glowing').Distance3D()
            if shinydist and shinydist <= 20 then
                if mq.TLO.Cursor.ID() ~= nil then
                    print(easy, ' \agCursor Keep: \ap '..mq.TLO.Cursor.Name())
                    mq.cmd('/autoinv')
                end
                mq.TLO.Ground.Search("glowing").Grab()
                mq.delay(500)
                if mq.TLO.Cursor.ID() ~= nil then
                    print(easy, ' \agInventory Cursor \ap '..mq.TLO.Cursor.Name())
                    mq.cmd('/autoinv')
                    if mq.TLO.Cursor.ID() ~= nil then
                        print(easy, ' \agCursor Keep: \ap '..mq.TLO.Cursor.Name())
                        mq.cmd('/autoinv')
                    end
                end
            end
        end
    end
end

-------------------------------------------------
------------------ Power Source -----------------
-------------------------------------------------
local function PowerSource()
    local easy = '\ao[\apEasy\ao]'
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
        print(easy, ' \ayUnCheck or Equip a Power Source to use one.')
        mq.delay('1s')
        mq.cmd('/autoinv')
    end
    if mq.TLO.FindItem(MySource).Power() == 0 and mq.TLO.FindItem(MySource)() ~= nil then
        mq.cmd('/ctrl /itemnotify powersource leftmouseup')
        if mq.TLO.FindItem(MySource).Power() == 0 and mq.TLO.Cursor.Name() == MySource and mq.TLO.Cursor.Name() ~= nil then
            mq.cmd('/destroy')
            print(easy, ' \arDestroyed:\ap Spent Power Source.')
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
-------------------------------------------------
------------------ Pop Mercenary ----------------
-------------------------------------------------
local function PopMerc()
    if mq.TLO.Mercenary.State() == 'SUSPENDED' and mq.TLO.Window('MMGW_ManageWnd/MMGW_SuspendButton').Enabled() and not mq.TLO.Me.Hovering() and Alive() then
        mq.cmd('/nomodkey /notify MMGW_ManageWnd MMGW_SuspendButton LeftMouseUp')
        print(easy, ' \agPopping Mercenary')
    end
end

-------------------------------------------------
------------------ Revive Mercenary -------------
-------------------------------------------------
local function ReviveMerc()
    if mq.TLO.Mercenary.State() == 'DEAD' and mq.TLO.Window('MMGW_ManageWnd/MMGW_SuspendButton').Enabled() and not mq.TLO.Me.Hovering() and Alive() then
        mq.cmd('/nomodkey /notify MMGW_ManageWnd MMGW_SuspendButton LeftMouseUp')
        print(easy, ' \agReviving Mercenary')
    end
end

-------------------------------------------------
---------- Revive Mercenary Suspended -----------
-------------------------------------------------
local function ReviveMercSuspended()
    if mq.TLO.Mercenary.State() == 'SUSPENDED' and mq.TLO.Group.Members() < 5 and mq.TLO.Window('MMGW_ManageWnd/MMGW_SuspendButton').Enabled() and not mq.TLO.Me.Hovering() and Alive() then
        mq.cmd('/nomodkey /notify MMGW_ManageWnd MMGW_SuspendButton LeftMouseUp')
        print(easy, ' \agReviving Mercenary')
    end
end

-------------------------------------------------
---------------------- Working Mercenary --------
-------------------------------------------------
local function WorkingMerc()
    for j = 1, #onzones do
        if mq.TLO.Zone.ID() == onzones[j] and mq.TLO.Mercenary.State() == 'ACTIVE' and mq.TLO.Mercenary.Stance() ~= 'Balanced' and mq.TLO.Mercenary.Stance() ~= 'Aggressive' and not mq.TLO.Me.Hovering() then
            print(easy, ' \agMercenary is Back to Work!')
            print(easy, ' \aoYou have left a lazy zone')
            mq.delay('3s')
            print(easy, ' \aySetting \atMercenary \ayStance')
            if mq.TLO.Mercenary.Class() == 'Cleric' then
                mq.cmd('/nomodkey /stance Balanced')
                print(easy, ' \aySetting \atMercenary \ayStance to Balanced')
            else
                mq.cmd('/nomodkey /stance Aggressive')
                print(easy, ' \aySetting \atMercenary \ayStance to Aggressive')
            end
            mq.delay('3s')
        end
    end
end

-------------------------------------------------
---------------------- Lazy Mercenary -----------
-------------------------------------------------
local function LazyMerc()
    for i = 1, #offzones do
        if mq.TLO.Zone.ID() == offzones[i] and mq.TLO.Mercenary.State() == 'ACTIVE' and mq.TLO.Mercenary.Stance() ~= 'Passive' and not mq.TLO.Me.Hovering() then
            print(easy, ' \arMercenary Just Got Lazy!')
            print(easy, ' \aoYou have entered a lazy zone')
            mq.delay('3s')
            print(easy, ' \aySetting \atMercenary \ayto \agPassive')
            mq.cmd('/nomodkey /stance Passive')
            mq.delay('3s')
        end
    end
end

-------------------------------------------------
---------------- Forage -------------------------
-------------------------------------------------
local function Forage()
    if not saved_settings.forage_safezones then
        for j = 1, #offzones do
            if mq.TLO.Zone.ID() == offzones[j] then
                return
            end
        end
    end
    if mq.TLO.Me.Skill('Forage')() > 0 and mq.TLO.Me.Standing() and not mq.TLO.Me.Sitting() and mq.TLO.Me.FreeInventory() >= 5 and mq.TLO.Me.AbilityReady('Forage')() and Checked() and mq.TLO.Me.Casting() == nil and not mq.TLO.Me.Combat() then
        if mq.TLO.Me.FreeInventory() <= 7 then
        print(easy, ' \ag Forage \arYou are just about out of room to forage')
        end
        if mq.TLO.Cursor.ID() ~= nil then
            print(easy, ' \agCursor Keep: \ap '..mq.TLO.Cursor.Name())
            mq.cmd('/autoinv')
        end
        mq.cmd('/doability forage')
        mq.delay('1s')
        ::RecheckForaged::
            for _, item in pairs(FORAGE_DESTROY) do
                if mq.TLO.Cursor.ID() ~= nil and mq.TLO.Cursor.Name() == item then
                    print(easy, ' \ag Forage \arDestroyed: \ap '..mq.TLO.Cursor.Name())
                    mq.cmd('/destroy')
                    mq.delay(500)
                end
            end
            for _, item in pairs(FORAGE_KEEP) do
                if mq.TLO.Cursor.ID() ~= nil and mq.TLO.Cursor.Name() == item then
                    print(easy, ' \ag Forage \agKeep: \ap '..mq.TLO.Cursor.Name())
                    mq.cmd('/autoinv')
                    mq.delay(500)
                end
            end
        if mq.TLO.Cursor.ID() ~= nil then
            print(easy, ' \ag Forage \agKeep:\ay(Not Defined) \ap '..mq.TLO.Cursor.Name())
            mq.cmd('/autoinv')
            mq.delay('1s')
            goto RecheckForaged
        end

    end
end

-------------------------------------------------
---------------- Scoot Camp ---------------------
-------------------------------------------------
local GateClass = {'CLR', 'DRU', 'SHM', 'NEC', 'MAG', 'ENC', 'WIZ'}
local NoGateClass = {'WAR', 'SHD', 'MNK', 'ROG', 'BRD', 'PAL', 'BST', 'BER', 'RNG'}
local trigger = function ()
    if not zoneid then
        zoneid = mq.TLO.Zone.ID()
        mq.cmd('/beep')			
    end
    local function Gate()
        mq.cmdf('/alt act %s',mq.TLO.Me.AltAbility('Gate')())
        mq.delay('3s')
    end
    if GateClass then
        mq.cmd('/stopcast')
        mq.delay(10)
        Gate()
    end
    if NoGateClass then
        mq.cmd('/stopcast')
        mq.delay(10)
        if mq.TLO.FindItemCount('Bulwark of Many Portals')() > 0 then
            mq.cmdf("/useitem %s", 'Bulwark of Many Portals')
        end
        while not mq.TLO.Me.AltAbilityReady('Throne of Heroes')() do
            mq.delay(10)
        end
        if mq.TLO.Me.AltAbilityReady('Throne of Heroes')() and zoneid == mq.TLO.Zone.ID() then
            mq.cmdf('/alt act %s', mq.TLO.Me.AltAbility('Throne of Heroes'))
        end
    end
    print('\ayPC is near Getting OUT of Camp')
    mq.delay('1s')
    while mq.TLO.Me.Casting() do mq.delay(250) end
end

local CheckDistance = function ()
    if mq.TLO.Group.Members() == 0 then
        return
    end
    if mq.TLO.Group.Members() then
        local MemberIDs = {}
        for i = 0, mq.TLO.Group.Members() do
            MemberIDs[mq.TLO.Group.Member(i).ID()] = true
        end
        if mq.TLO.SpawnCount('pc')() and mq.TLO.SpawnCount('pc')() > mq.TLO.Group.Members() then
            for i = 1, mq.TLO.Group.Members()+1 do
                if not MemberIDs[mq.TLO.NearestSpawn(i..', pc').ID()] and mq.TLO.NearestSpawn(i..', pc').Distance() <= defaults.SCOOT_DISTANCE then
                    if ingnoreguild and mq.TLO.Me.Guild() ~= mq.TLO.NearestSpawn(i..', pc').Guild() then
                        print(mq.TLO.NearestSpawn(i..', pc').Name()..' is nearby! (Distance: '..string.format('%.0f' , mq.TLO.NearestSpawn(i..', pc').Distance())..')')
                        trigger()
                    elseif not ingnoreguild then
                        print(mq.TLO.NearestSpawn(i..', pc').Name()..' is nearby! (Distance: '..string.format('%.0f' , mq.TLO.NearestSpawn(i..', pc').Distance())..')')
                        trigger()
                    end
                end
            end
        end
    end
    while zoneid and zoneid ~= mq.TLO.Zone.ID() do
        mq.delay('1s')
    end
end

-------------------------------------------------
---------------- Mage Cauldron ------------------
-------------------------------------------------
local SPELLS_TO_TRY = {
    "Summon Cauldron of Endless Abundance Rk. III",
    "Summon Cauldron of Endless Abundance Rk. II",
    "Summon Cauldron of Endless Abundance",
    "Summon Cauldron of Endless Bounty Rk. III",
    "Summon Cauldron of Endless Bounty Rk. II",
    "Summon Cauldron of Endless Bounty",
    "Summon Cauldron of Endless Goods",
    "Summon Cauldron of Many Things"
}

--Cauldrons to Try From Best to Worst--
local CAULDRONS_TO_TRY = {
    "Cauldron of Endless Abundance III",
    "Cauldron of Endless Abundance II",
    "Cauldron of Endless Abundance",
    "Cauldron of Countless Goods III",
    "Cauldron of Countless Goods II",
    "Cauldron of Countless Goods",
    "Cauldron of Endless Goods",
    "Cauldron of Many Things"
}

local CheckCauldron = function ()
    if mq.TLO.Me.Class.ShortName() == 'MAG' and not mq.TLO.Me.Invis() and not mq.TLO.Me.Combat() and not mq.TLO.Cursor.ID() and Checked() and not mq.TLO.Me.Sitting() then
        if mq.TLO.FindItemCount(109884)() == 0 and mq.TLO.FindItemCount(109883)() == 0 and mq.TLO.FindItemCount(109882)() == 0 and mq.TLO.FindItemCount(85480)() == 0 and mq.TLO.FindItemCount(85481)() == 0 and mq.TLO.FindItemCount(85482)() == 0 and mq.TLO.FindItemCount(52880)() == 0 and mq.TLO.FindItemCount(52795)() == 0 and not mq.TLO.Me.Moving() then
            if mq.TLO.Plugin('mq2mage')() then
                mq.cmd('/docommand /mag pause on')
            end
            for i,v in pairs(SPELLS_TO_TRY) do
                if tostring(mq.TLO.Me.Book(v)) ~= 'NULL' then
                    mq.cmdf('/memspell 1 "%s"', v)
                    mq.delay('5s')
                    mq.cmdf('/cast %s', v)
                    mq.delay('2s')
                    if mq.TLO.Cursor.ID() ~= nil then
                        print(easy, ' \agInventory Cursor \ap '..mq.TLO.Cursor.Name())
                        mq.cmd('/autoinv')
                    end
                break
                end
            end
            if mq.TLO.Plugin('mq2mage')() then
                mq.cmd('/docommand /mag pause off')
                mq.delay('1s')
            end
        end
        for i,v in pairs(CAULDRONS_TO_TRY) do
            if mq.TLO.FindItem(v)() ~= nil and not mq.TLO.Me.Moving() and mq.TLO.FindItem(v).TimerReady() == 0 and mq.TLO.Me.FreeInventory() >= 5 and not mq.TLO.Me.Combat() and not mq.TLO.Me.Hovering() and not mq.TLO.Me.Invis() and not mq.TLO.Me.Casting() then
                if mq.TLO.Me.FreeInventory() <= 7 then
                    print(easy, ' \agCauldron: \arYou are just about out of room to use cauldron')
                    end
                if mq.TLO.Cursor.ID() ~= nil then
                    print(easy, ' \agCursor Keep: \ap '..mq.TLO.Cursor.Name())
                    mq.cmd('/autoinv')
                end
                mq.cmdf("/useitem %s", v)
                mq.delay('11s')
                for _, item in pairs(CAULDRON_TO_KEEP) do
                    if mq.TLO.Cursor.ID() ~= nil and mq.TLO.Cursor.Name() == item then
                        print(easy, ' \agCauldron Keep: \ap '..mq.TLO.Cursor.Name())
                        mq.cmd('/autoinv')
                        mq.delay('1s')
                    end
                    if mq.TLO.Cursor.ID() ~= nil and mq.TLO.Cursor.Name() == item then
                        print(easy, ' \agCauldron Keep: \ap '..mq.TLO.Cursor.Name())
                        mq.cmd('/autoinv')
                        mq.delay(500)
                    end
                end
                for _, item in pairs(CAULDRON_TO_DESTROY) do
                    if mq.TLO.Cursor.ID() ~= nil and mq.TLO.Cursor.Name() == item then
                        print(easy, ' \arCauldron Destroyed: \ap '..mq.TLO.Cursor.Name())
                        mq.cmd('/destroy')
                        mq.delay('1s')
                    end
                    if mq.TLO.Cursor.ID() ~= nil and mq.TLO.Cursor.Name() == item then
                        print(easy, ' \arCauldron Destroyed: \ap '..mq.TLO.Cursor.Name())
                        mq.cmd('/destroy')
                        mq.delay(500)
                    end
                end
                if mq.TLO.Cursor.ID() ~= nil then
                    print(easy, ' \agCauldron \agKeep:\ay(Not Defined) \ap '..mq.TLO.Cursor.Name())
                    mq.cmd('/autoinv')
                    mq.delay('1s')
                end
                if mq.TLO.Cursor.ID() ~= nil then
                    print(easy, ' \agCauldron \agKeep:\ay(Not Defined) \ap '..mq.TLO.Cursor.Name())
                    mq.cmd('/autoinv')
                    mq.delay(500)
                end
            end
        end
    end
end

-------------------------------------------------
---------------- Destroy Mod Rods ---------------
-------------------------------------------------
local function DestroyModRod()
    for _, mod_destroy in pairs(MOD_RODS_TO_DESTROY) do
        if mq.TLO.FindItem(mod_destroy)() then
            mq.cmdf('/ctrl /itemnotify "%s" leftmouseup', mod_destroy)
            end
        if mq.TLO.Cursor.ID() ~= nil and mq.TLO.Cursor.Name() == mod_destroy then
            print(easy, ' \arMod Rod Destroyed: \ap '..mq.TLO.Cursor.Name())
            mq.cmd('/destroy')
            mq.delay(500)
            if mq.TLO.Cursor.ID() ~= nil then
                print(easy, ' \agClearing Cursor: \ap '..mq.TLO.Cursor.Name())
                mq.cmd('/autoinv')
            end
        end
    end
end

---------------------------------------------
---------------- Block Spells ---------------
---------------------------------------------
local function block_spells()
    print(easy, ' \ayAdding Mod Rods, Summoned Food and Summoned Water to the Blocked Spell List')
    mq.cmd('/blockspell add me 18798 18799 18800 26841 26842 26843 14731 14732 14733 10763 10700 2538 3188 1503 52 53 55 56 6893 6895 50 10700 10763 10764 10765')
end

-------------------------------------------------
---------------- Wee'er Harvester ---------------
-------------------------------------------------
local function WeeHarvester()
    if mq.TLO.FindItem('Wee\'er Harvester')() and mq.TLO.FindItemCount('85830')() < defaults.BURNED_BREAD_TO_SUMMON and mq.TLO.FindItem('=Wee\'er Harvester').TimerReady() == 0 and mq.TLO.Me.FreeInventory() >= 5 and not mq.TLO.Me.Combat() and not mq.TLO.Me.Invis() and not mq.TLO.Me.Sitting() and Checked() and not mq.TLO.Me.Moving() and (mq.TLO.Zone.ID() ~= 344 and mq.TLO.Zone.ID() ~= 202 or saved_settings.edibles_pok_gl) then
        if mq.TLO.Me.FreeInventory() <= 7 then
            print(easy, ' \agWee\'er Harvester: \arYou are just about out of room to summon burned bread')
        end
        if mq.TLO.Cursor.ID() ~= nil then
            print(easy, ' \agCursor Keep: \ap '..mq.TLO.Cursor.Name())
            mq.cmd('/autoinv')
        end
        mq.cmdf("/useitem %s", 'Wee\'er Harvester')
        mq.delay('1s')
        if mq.TLO.Cursor.ID() ~= nil then
            print(easy, ' \agWee\'er Harvester Keep: \ap '..mq.TLO.Cursor.Name())
            mq.cmd('/autoinv')
            if mq.TLO.Cursor.ID() ~= nil then
                print(easy, ' \agCursor Keep: \ap '..mq.TLO.Cursor.Name())
                mq.cmd('/autoinv')
            end
        end
    end
end

-------------------------------------------------
------------- Bigger Belt of the River ----------
-------------------------------------------------
local function BiggerBelt()
    if mq.TLO.FindItem('Bigger Belt of the River')() and mq.TLO.FindItemCount('85829')() < defaults.MURKY_GLOBE_TO_SUMMON and mq.TLO.FindItem('=Bigger Belt of the River').TimerReady() == 0 and mq.TLO.Me.FreeInventory() >= 5 and not mq.TLO.Me.Combat() and not mq.TLO.Me.Invis() and not mq.TLO.Me.Sitting() and Checked() and not mq.TLO.Me.Moving() and (mq.TLO.Zone.ID() ~= 344 and mq.TLO.Zone.ID() ~= 202 or saved_settings.edibles_pok_gl) then
        if mq.TLO.Me.FreeInventory() <= 7 then
            print(easy, ' \agBigger Belt of the River: \arYou are just about out of room to summon water globes')
        end
        if mq.TLO.Cursor.ID() ~= nil then
            print(easy, ' \agCursor Keep: \ap '..mq.TLO.Cursor.Name())
            mq.cmd('/autoinv')
        end
        mq.cmdf("/useitem %s", 'Bigger Belt of the River')
        mq.delay('1s')
        if mq.TLO.Cursor.ID() ~= nil then
            print(easy, ' \agBigger Belt of the River Keep: \ap '..mq.TLO.Cursor.Name())
            mq.cmd('/autoinv')
            if mq.TLO.Cursor.ID() ~= nil then
                print(easy, ' \agCursor Keep: \ap '..mq.TLO.Cursor.Name())
                mq.cmd('/autoinv')
            end
        end
    end
end

-------------------------------------------------
---------------- Cookie Dispenser ---------------
-------------------------------------------------
local function CookieDispenser()
    if mq.TLO.FindItem('Fresh Cookie Dispenser')() and mq.TLO.FindItemCount('71980')() < defaults.COOKIES_TO_SUMMON and mq.TLO.FindItem('=Fresh Cookie Dispenser').TimerReady() == 0 and mq.TLO.Me.FreeInventory() >= 5 and not mq.TLO.Me.Combat() and not mq.TLO.Me.Invis() and not mq.TLO.Me.Sitting() and Checked() and not mq.TLO.Me.Moving() and (mq.TLO.Zone.ID() ~= 344 and mq.TLO.Zone.ID() ~= 202 or saved_settings.edibles_pok_gl) then
        if mq.TLO.Me.FreeInventory() <= 7 then
            print(easy, ' \agCookie Dispenser: \arYou are just about out of room to summon cookies')
        end
        if mq.TLO.Cursor.ID() ~= nil then
            print(easy, ' \agCursor Keep: \ap '..mq.TLO.Cursor.Name())
            mq.cmd('/autoinv')
        end
        mq.cmdf("/useitem %s", 'Fresh Cookie Dispenser')
        mq.delay('1s')
        if mq.TLO.Cursor.ID() ~= nil then
            print(easy, ' \agFresh Cookie Dispenser Keep: \ap '..mq.TLO.Cursor.Name())
            mq.cmd('/autoinv')
            if mq.TLO.Cursor.ID() ~= nil then
                print(easy, ' \agCursor Keep: \ap '..mq.TLO.Cursor.Name())
                mq.cmd('/autoinv')
            end
        end
    end
end

-------------------------------------------------
---------------- Iced Tea Dispenser -------------
-------------------------------------------------
local function TeaDispenser()
    if mq.TLO.FindItem('Spiced Iced Tea Dispenser')() and mq.TLO.FindItemCount('107807')() < defaults.SPICED_TEA_TO_SUMMON and mq.TLO.FindItem('=Spiced Iced Tea Dispenser').TimerReady() == 0 and mq.TLO.Me.FreeInventory() >= 5 and not mq.TLO.Me.Combat() and not mq.TLO.Me.Invis() and not mq.TLO.Me.Sitting() and Checked() and not mq.TLO.Me.Moving() and (mq.TLO.Zone.ID() ~= 344 and mq.TLO.Zone.ID() ~= 202 or saved_settings.edibles_pok_gl) then
        if mq.TLO.Me.FreeInventory() <= 7 then
            print(easy, ' \agIced Tea Dispenser: \arYou are just about out of room to summon tea')
        end
        if mq.TLO.Cursor.ID() ~= nil then
            print(easy, ' \agCursor Keep: \ap '..mq.TLO.Cursor.Name())
            mq.cmd('/autoinv')
        end
        mq.cmdf("/useitem %s", 'Spiced Iced Tea Dispenser')
        mq.delay('1s')
        if mq.TLO.Cursor.ID() ~= nil then
            print(easy, ' \agSpiced Iced Tea Dispenser Keep: \ap '..mq.TLO.Cursor.Name())
            mq.cmd('/autoinv')
            if mq.TLO.Cursor.ID() ~= nil then
                print(easy, ' \agCursor Keep: \ap '..mq.TLO.Cursor.Name())
                mq.cmd('/autoinv')
            end
        end
    end
end

-------------------------------------------------
---------------- Warm Milk Dispenser ------------
-------------------------------------------------
local function MilkDispenser()
    if mq.TLO.FindItem('Warm Milk Dispenser')() and mq.TLO.FindItemCount('52199')() < defaults.WARM_MILK_TO_SUMMON and mq.TLO.FindItem('=Warm Milk Dispenser').TimerReady() == 0 and mq.TLO.Me.FreeInventory() >= 5 and not mq.TLO.Me.Combat() and not mq.TLO.Me.Invis() and not mq.TLO.Me.Sitting() and Checked() and not mq.TLO.Me.Moving() and (mq.TLO.Zone.ID() ~= 344 and mq.TLO.Zone.ID() ~= 202 or saved_settings.edibles_pok_gl) then
        if mq.TLO.Me.FreeInventory() <= 7 then
            print(easy, ' \agMilk Dispenser: \arYou are just about out of room to summon milk')
        end
        if mq.TLO.Cursor.ID() ~= nil then
            print(easy, ' \agCursor Keep: \ap '..mq.TLO.Cursor.Name())
            mq.cmd('/autoinv')
        end
        mq.cmdf("/useitem %s", 'Warm Milk Dispenser')
        mq.delay('1s')
        if mq.TLO.Cursor.ID() ~= nil then
            print(easy, ' \agWarm Milk Dispenser Keep: \ap '..mq.TLO.Cursor.Name())
            mq.cmd('/autoinv')
            if mq.TLO.Cursor.ID() ~= nil then
                print(easy, ' \agCursor Keep: \ap '..mq.TLO.Cursor.Name())
                mq.cmd('/autoinv')
            end
        end
    end
end

-------------------------------------------------
---------------- Packed Picnic Basket -----------
-------------------------------------------------
local function PicnicDispenser()
    if mq.TLO.FindItem('Packed Picnic Basket')() and
        (mq.TLO.FindItemCount('61994')() < defaults.ELVEN_WINE_TO_SUMMON
            or mq.TLO.FindItemCount('61993')() < defaults.AFTERNOON_TEA_TO_SUMMON
                or mq.TLO.FindItemCount('61992')() < defaults.REFRESHING_MILK_TO_SUMMON
                    or mq.TLO.FindItemCount('61997')() < defaults.JUMJUM_CAKE_TO_SUMMON
                        or mq.TLO.FindItemCount('61996')() < defaults.PLUMP_SYLVAN_BERRIES_TO_SUMMON
                            or mq.TLO.FindItemCount('61995')() < defaults.SPICY_WOLF_SANDWICH_TO_SUMMON)
                                and mq.TLO.FindItem('=Packed Picnic Basket').TimerReady() == 0 and mq.TLO.Me.FreeInventory() >= 5 and not mq.TLO.Me.Combat() and not mq.TLO.Me.Invis() and not mq.TLO.Me.Sitting() and Checked() and not mq.TLO.Me.Moving() and (mq.TLO.Zone.ID() ~= 344 and mq.TLO.Zone.ID() ~= 202 or saved_settings.edibles_pok_gl) then
        if mq.TLO.Me.FreeInventory() <= 7 then
            print(easy, ' \agPicnic Dispenser: \arYou are just about out of room to summon picnic')
        end
        if mq.TLO.Cursor.ID() ~= nil then
            print(easy, ' \agCursor Keep: \ap '..mq.TLO.Cursor.Name())
            mq.cmd('/autoinv')
        end
        mq.cmdf("/useitem %s", 'Packed Picnic Basket')
        mq.delay('1s')
        if mq.TLO.Cursor.ID() ~= nil then
            print(easy, ' \agPacked Picnic Basket Keep: \ap '..mq.TLO.Cursor.Name())
            mq.cmd('/autoinv')
            if mq.TLO.Cursor.ID() ~= nil then
                print(easy, ' \agCursor Keep: \ap '..mq.TLO.Cursor.Name())
                mq.cmd('/autoinv')
            end
        end
    end
end

-------------------------------------------------
-------------- Brell's Brew Dispenser -----------
-------------------------------------------------
local function BrewDispenser()
    if mq.TLO.FindItem('Brell\'s Brew Dispenser')() and mq.TLO.FindItemCount('48994')() < defaults.BRELL_ALE_TO_SUMMON and mq.TLO.FindItem('=Brell\'s Brew Dispenser').TimerReady() == 0 and mq.TLO.Me.FreeInventory() >= 5 and not mq.TLO.Me.Combat() and not mq.TLO.Me.Invis() and not mq.TLO.Me.Sitting() and Checked() and not mq.TLO.Me.Moving() and (mq.TLO.Zone.ID() ~= 344 and mq.TLO.Zone.ID() ~= 202 or saved_settings.edibles_pok_gl) then
        if mq.TLO.Me.FreeInventory() <= 7 then
            print(easy, ' \agBrew Dispenser: \arYou are just about out of room to summon brew')
        end
        if mq.TLO.Cursor.ID() ~= nil then
            print(easy, ' \agCursor Keep: \ap '..mq.TLO.Cursor.Name())
            mq.cmd('/autoinv')
        end
        mq.cmdf("/useitem %s", 'Brell\'s Brew Dispenser')
        mq.delay('1s')
        if mq.TLO.Cursor.ID() ~= nil then
            print(easy, ' \agBrell\'s Brew Dispenser Keep: \ap '..mq.TLO.Cursor.Name())
            mq.cmd('/autoinv')
            if mq.TLO.Cursor.ID() ~= nil then
                print(easy, ' \agCursor Keep: \ap '..mq.TLO.Cursor.Name())
                mq.cmd('/autoinv')
            end
        end
    end
end

-------------------------------------------------
-------------- Brell's Fishing Pole -------------
-------------------------------------------------
local function BrellsFishingPole()
    if mq.TLO.FindItemCount('Brell\'s Fishin\' Pole')() == 0 and mq.TLO.FindItem('Fisherman\'s Companion')() then
        mq.cmdf('/useitem %s', "Fisherman\'s Companion")
        mq.delay('10s')
        if mq.TLO.Cursor.ID() ~= nil then
            print(easy, ' \agCursor Keep: \ap '..mq.TLO.Cursor.Name())
            mq.cmd('/autoinv')
        end
    end
    if mq.TLO.FindItem('Brell\'s Fishin\' Pole')() and mq.TLO.FindItemCount('8991')() < defaults.ALE_TO_SUMMON and mq.TLO.FindItem('=Brell\'s Fishin\' Pole').TimerReady() == 0 and mq.TLO.Me.FreeInventory() >= 5 and not mq.TLO.Me.Combat() and not mq.TLO.Me.Invis() and not mq.TLO.Me.Sitting() and Checked() and not mq.TLO.Me.Moving() and (mq.TLO.Zone.ID() ~= 344 and mq.TLO.Zone.ID() ~= 202 or saved_settings.edibles_pok_gl) then
        if mq.TLO.Me.FreeInventory() <= 7 then
            print(easy, ' \agBrell\'s Fishing Pole: \arYou are just about out of room to summon brew')
        end
        if mq.TLO.Cursor.ID() ~= nil then
            print(easy, ' \agCursor Keep: \ap '..mq.TLO.Cursor.Name())
            mq.cmd('/autoinv')
        end
        mq.cmdf("/useitem %s", 'Brell\'s Fishin\' Pole')
        mq.delay('3s')
        if mq.TLO.Cursor.ID() ~= nil then
            print(easy, ' \agBrell\'s Fishin\' Pole Keep: \ap '..mq.TLO.Cursor.Name())
            mq.cmd('/autoinv')
            if mq.TLO.Cursor.ID() ~= nil then
                print(easy, ' \agCursor Keep: \ap '..mq.TLO.Cursor.Name())
                mq.cmd('/autoinv')
            end
        end
    end
end

-------------------------------------------------
---------------- Endless Turkeys ----------------
-------------------------------------------------
local function TurkeyDispenser()
    if mq.TLO.FindItem('Endless Turkeys')() and mq.TLO.FindItemCount('56064')() < defaults.COOKED_TURKEY_TO_SUMMON and mq.TLO.FindItem('=Endless Turkeys').TimerReady() == 0 and mq.TLO.Me.FreeInventory() >= 5 and not mq.TLO.Me.Combat() and not mq.TLO.Me.Invis() and not mq.TLO.Me.Sitting() and Checked() and not mq.TLO.Me.Moving() and (mq.TLO.Zone.ID() ~= 344 and mq.TLO.Zone.ID() ~= 202 or saved_settings.edibles_pok_gl) then
        if mq.TLO.Me.FreeInventory() <= 7 then
            print(easy, ' \agTurkey Dispenser: \arYou are just about out of room to summon turkey')
        end
        if mq.TLO.Cursor.ID() ~= nil then
            print(easy, ' \agCursor Keep: \ap '..mq.TLO.Cursor.Name())
            mq.cmd('/autoinv')
        end
        mq.cmdf("/useitem %s", 'Endless Turkeys')
        mq.delay('1s')
        if mq.TLO.Cursor.ID() ~= nil then
            print(easy, ' \agEndless Turkey Keep: \ap '..mq.TLO.Cursor.Name())
            mq.cmd('/autoinv')
            if mq.TLO.Cursor.ID() ~= nil then
                print(easy, ' \agCursor Keep: \ap '..mq.TLO.Cursor.Name())
                mq.cmd('/autoinv')
            end
        end
    end
end

-------------------------------------------------
---------------- Force Feed ---------------------
-------------------------------------------------
local function ForceFeed()
    if (mq.TLO.Zone.ID() ~= 344 and mq.TLO.Zone.ID() ~= 202 or saved_settings.edibles_pok_gl) and Checked() then
        for _, v in pairs(food) do
            if mq.TLO.FindItem('=' .. v)() and mq.TLO.Me.Hunger() <= defaults.EAT_LEVEL then
                if mq.TLO.Cursor.ID() ~= nil then
                    print(easy, ' \agCursor Keep: \ap '..mq.TLO.Cursor.Name())
                    mq.cmd('/autoinv')
                end
                print(easy, ' \agForce Feed: \ap '..v)
                mq.cmdf('/useitem "%s"', v)
            end
        end
    end
end

-------------------------------------------------
---------------- Force Drink --------------------
-------------------------------------------------
local function ForceDrink()
    if (mq.TLO.Zone.ID() ~= 344 and mq.TLO.Zone.ID() ~= 202 or saved_settings.edibles_pok_gl) and Checked() then
        for _, j in pairs(drink) do
            if mq.TLO.FindItem('=' .. j)() and mq.TLO.Me.Thirst() <= defaults.DRINK_LEVEL then
                if mq.TLO.Cursor.ID() ~= nil then
                    print(easy, ' \agCursor Keep: \ap '..mq.TLO.Cursor.Name())
                    mq.cmd('/autoinv')
                end
                print(easy, ' \agForce Drink: \ap '..j)
                mq.cmdf('/useitem "%s"', j)
            end
        end
    end
end

-------------------------------------------------
---------------- Get Drunk ----------------------
-------------------------------------------------
local function GetDrunk()
    if (mq.TLO.Zone.ID() ~= 344 and mq.TLO.Zone.ID() ~= 202 or saved_settings.edibles_pok_gl) and Checked() then
        for _, k in pairs(liquor) do
            if mq.TLO.FindItem('=' .. k)() and mq.TLO.Me.Drunk() <= defaults.GET_DRUNK_LEVEL then
                if mq.TLO.Cursor.ID() ~= nil then
                    print(easy, ' \agCursor Keep: \ap '..mq.TLO.Cursor.Name())
                    mq.cmd('/autoinv')
                end
                print(easy, ' \agGet Drunk: \ap '..k)
                mq.cmdf('/useitem "%s"', k)
            end
        end
    end
end

-------------------------------------------------
---------------- Clear ModRods ------------------
-------------------------------------------------
local function ClearModRods()
    for _, mod_keep in pairs(MOD_RODS_TO_INVENTORY) do
        if mq.TLO.Cursor.ID() ~= nil and mq.TLO.Cursor.Name() == mod_keep then
            if mq.TLO.Cursor.ID() ~= nil then
                print(easy, ' \agMod Rod Keep: \ap '..mq.TLO.Cursor.Name())
                mq.cmd('/autoinv')
                if mq.TLO.Cursor.ID() ~= nil then
                    print(easy, ' \agCursor Keep: \ap '..mq.TLO.Cursor.Name())
                    mq.cmd('/autoinv')
                end
            end
        end
    end
end

-------------------------------------------------
---------------- Clear Cursor -------------------
-------------------------------------------------
local function ClearCursor()
    if mq.TLO.Cursor.ID() ~= nil then
        print(easy, ' \agClearing Cursor \ap '..mq.TLO.Cursor.Name())
        mq.cmd('/autoinv')
        if mq.TLO.Cursor.ID() ~= nil then
            print(easy, ' \agClearing Cursor: \ap '..mq.TLO.Cursor.Name())
            mq.cmd('/autoinv')
        end
    end
end

-------------------------------------------------
---------------- PC Alert -----------------------
-------------------------------------------------
local function trigger2()
    if not zoneid then
        zoneid = mq.TLO.Zone.ID()
        mq.cmd('/beep')
        mq.delay('2s')
        mq.cmd('/beep')
        mq.cmd('/beep')
        mq.delay('2s')
        mq.cmd('/beep')
        mq.cmd('/beep')
    end
end
local CheckDistance2 = function ()
    for i = 1, #offzones do
        if mq.TLO.Group.Members() == 0 or mq.TLO.Zone.ID() == offzones[i] then
            return
        end
    end
    if mq.TLO.Group.Members() then
        local MemberIDs = {}
        for j=0,mq.TLO.Group.Members() do
            MemberIDs[mq.TLO.Group.Member(j).ID()] = true
        end
        if mq.TLO.SpawnCount('pc')() and mq.TLO.SpawnCount('pc')() > mq.TLO.Group.Members() then
            for j=1,mq.TLO.Group.Members()+1 do
                if not MemberIDs[mq.TLO.NearestSpawn(j..', pc').ID()] and mq.TLO.NearestSpawn(j..', pc').Distance() <= defaults.ALERT_DISTANCE then
                    if ingnoreguild and mq.TLO.Me.Guild() ~= mq.TLO.NearestSpawn(j..', pc').Guild() then
                        print(mq.TLO.NearestSpawn(j..', pc').Name()..' is nearby! (Distance: '..string.format('%.0f' , mq.TLO.NearestSpawn(j..', pc').Distance())..')')
                        trigger2()
                    elseif not ingnoreguild then
                        print(mq.TLO.NearestSpawn(j..', pc').Name()..' is nearby! (Distance: '..string.format('%.0f' , mq.TLO.NearestSpawn(j..', pc').Distance())..')')
                        trigger2()
                    end
                end
            end
        end
    end
end
local GMCHECK = function ()
    if mq.TLO.SpawnCount("GM")() > 0 then
        gm_switch = true
    end
end

-------------------------------------------------
---------------- Check Parcel -------------------
-------------------------------------------------
local function CheckParcel()
    for g = 1, #defaults.PARCEL_ZONES do
        if (mq.TLO.Window('PlayerWindow/PW_ParcelsIcon')() == 'TRUE' or mq.TLO.Window('PlayerWindow/PW_ParcelsOverLimitIcon')() == 'TRUE') and mq.TLO.Zone.ID() == defaults.PARCEL_ZONES[g] and not mq.TLO.Me.Hovering() then
        if mq.TLO.Zone.ID() == 345 then
                mq.cmd('/nav spawn Yenny')
                while mq.TLO.Me.Moving() do
                    mq.delay(10)
                end
                mq.cmd('/target Yenny')
            mq.delay('3s')
            mq.cmd('/usetarget')
            mq.delay('3s')
            mq.cmd('/notify MerchantWnd MW_MerchantSubwindows tabselect 3')
            mq.delay(100)
            mq.cmd('/notify MerchantWnd MW_Retrieve_All_Button leftmouseup')
            while (mq.TLO.Window('PlayerWindow/PW_ParcelsIcon')() == 'TRUE') and mq.TLO.Window('MerchantWnd')() or mq.TLO.Window('PlayerWindow/PW_ParcelsOverLimitIcon')() == 'TRUE' and mq.TLO.Window('MerchantWnd')() do
                if (mq.TLO.Window('PlayerWnd/PW_ParcelsIcon')() == 'TRUE') then
                    mq.cmd('/notify MerchantWnd MW_Retrieve_All_Button leftmouseup')
                    mq.delay('5s')
                end
            end
        else
            if mq.TLO.Zone.ID() == 712 then
            mq.cmd('/nav spawn Postmaster')
            while mq.TLO.Me.Moving() do
                mq.delay(10)
            end
            mq.delay('2s')
            mq.cmd('/target Postmaster')
            mq.delay('3s')
            mq.cmd('/usetarget')
            mq.delay('3s')
            mq.cmd('/notify MerchantWnd MW_Retrieve_All_Button leftmouseup')
            while (mq.TLO.Window('PlayerWindow/PW_ParcelsIcon')() == 'TRUE') and mq.TLO.Window('MerchantWnd')() or mq.TLO.Window('PlayerWindow/PW_ParcelsOverLimitIcon')() == 'TRUE' and mq.TLO.Window('MerchantWnd')() do
                if (mq.TLO.Window('PlayerWnd/PW_ParcelsIcon')() == 'TRUE') then
                    mq.cmd('/notify MerchantWnd MW_Retrieve_All_Button leftmouseup')
                    mq.delay('5s')
                end
            end
        else
            mq.cmd('/nav spawn parcel')
            while mq.TLO.Me.Moving() do
                mq.delay(10)
            end
            mq.delay('2s')
            mq.cmd('/target Parcel')
            mq.delay('3s')
            mq.cmd('/usetarget')
            mq.delay('3s')
            mq.cmd('/notify MerchantWnd MW_Retrieve_All_Button leftmouseup')
            while (mq.TLO.Window('PlayerWindow/PW_ParcelsIcon')() == 'TRUE') and mq.TLO.Window('MerchantWnd')() or mq.TLO.Window('PlayerWindow/PW_ParcelsOverLimitIcon')() == 'TRUE' and mq.TLO.Window('MerchantWnd')() do
                if (mq.TLO.Window('PlayerWnd/PW_ParcelsIcon')() == 'TRUE') then
                    mq.cmd('/notify MerchantWnd MW_Retrieve_All_Button leftmouseup')
                    mq.delay('5s')
                end
            end
        end
    end
            mq.cmd('/windowstate MerchantWnd close')
        end
    end
end

-------------------------------------------
---------------- Rez Check ----------------
-------------------------------------------
local function RezCheck ()
    if mq.TLO.Plugin('mq2dannet')() ~= nil and saved_settings.dannet_load then
        if mq.TLO.Me.Class.ShortName() == 'CLR' or mq.TLO.Me.Class.ShortName() == 'DRU' or mq.TLO.Me.Class.ShortName() == 'SHM' or mq.TLO.Me.Class.ShortName() == 'PAL' or mq.TLO.Me.Class.ShortName() == 'NEC' and Checked() and not mq.TLO.Me.Invis() then
            for peer in string.gmatch(mq.TLO.DanNet.Peers(), "([^|]+)") do
                if mq.TLO.Me.Hovering() then
                    break
                end
                local maxdistance = 100
                local spawnsearch = string.format('pccorpse %s radius %s', peer, maxdistance)
                local corpse_count = mq.TLO.SpawnCount(spawnsearch)()
                if corpse_count ~= 0 then
                    printf('%s has %s corpse(s) within %s feet', peer, corpse_count, maxdistance )
                    for corpse = 1, corpse_count do
                        local corpse_ID = mq.TLO.NearestSpawn(corpse, spawnsearch).ID()
                        printf('Rezzing corpse: %s - %s', corpse, mq.TLO.Target.CleanName())
                        mq.cmdf('/mqtarget id %s', corpse_ID)
                        mq.cmd('/corpse')
                        mq.delay('1s')
                        local abilities = {
                            [3800] = 'Blessing of Resurrection CLR',
                            [404] = 'Call of the Wild DRU SHM',
                            [2051] = 'Rejuvenation of Spirit DRU SHM',
                            [3711] = 'Gift of Resurrection PAL',
                            [676] = 'Convergence',
                        }
                        for ability, name in pairs(abilities) do
                            if mq.TLO.Me.AltAbilityReady(tostring(ability))() and mq.TLO.Me.Class.ShortName() ~= 'NEC' then
                                mq.cmd('/alt activate ' .. ability)
                                printf('Using ability %s', name)
                            end
                            if mq.TLO.Me.AltAbilityReady(tostring(ability))() and mq.TLO.Me.Class.ShortName() == 'NEC' and mq.TLO.FindItemCount(9963)() >= 1 then
                                mq.cmd('/alt activate ' .. ability)
                                printf('Using ability %s', name)
                            end
                        end
                        mq.delay(500)
                        while mq.TLO.Me.Casting() do
                            mq.delay('1s')
                        end
                    end
                    printf('Rezzed %s', peer)
                end
            end
        end
    end
end

-------------------------------------------------
---------------- Toon Assist --------------------
-------------------------------------------------
local ToonAssist = function()
zonePeerCount = (string.format('zone_%s_%s', mq.TLO.EverQuest.Server(), mq.TLO.Zone.ShortName()))

if mq.TLO.Plugin('mq2dannet')() ~= nil then
---@diagnostic disable-next-line: redundant-parameter
    local peercount = mq.TLO.DanNet.PeerCount('melee')()
    local targetHP = mq.TLO.Target.PctHPs() or 0
    local tank = mq.TLO.Me.CleanName()
    local mob_id = mq.TLO.Target.ID()
    local zonePeerAssist = (string.format('zone_%s_%s', mq.TLO.EverQuest.Server(), mq.TLO.Zone.ShortName()))
    if peercount > 1 and targetHP <= 97 and targetHP >= 90 and not mq.TLO.Me.Moving() and mq.TLO.Target.Distance() <= 25 and not mq.TLO.Me.Hovering() and mq.TLO.Target.Aggressive() == true and not mq.TLO.Me.Hovering() and mq.TLO.Target.ID() ~= 0 and mq.TLO.Me.XTarget() >= 1 then
        print(easy, ' \ar Calling \aw- \aoToon Assist.')
            mq.cmdf('/noparse /dge '..zonePeerCount..' /nav id %s', mob_id)
            mq.delay(250)
            --mq.cmdf('/noparse /dge tank /nav id %s', mob_id)
            --mq.delay(250)
            mq.cmdf('/noparse /dge '..zonePeerCount..' /assist %s', tank)
            mq.delay(250)
            --mq.cmdf('/noparse /dge tank /assist %s', tank)
            --mq.delay(250)
            mq.cmd('/noparse /dge '..zonePeerCount..' /attack on')
            mq.delay(250)
            mq.cmd('/noparse /dge priest /attack off')
            mq.cmd('/noparse /dge caster /attack off')
            mq.delay(10)
        end
    end
end

-------------------------------------------------
-----------Corpse Recovery ----------------------
-------------------------------------------------
local mindistance = 75
local maxdistance = 5000

function Fetch_Distance( x1, y1, x2, y2 )
    return (x2-x1) + (y2-y1)
end

local function drag (corpsid, corpse)
    print('\aw[Corpse Drag] \atNeed to recover a corpse.')
    if mq.TLO.Me.Combat() then
        while mq.TLO.Me.Combat() do
            mq.delay(100)
        end
    end
    if mq.TLO.Me.Hovering() then
        while mq.TLO.Me.Hovering() do
            mq.delay(100)
        end
    end
    mq.cmd('/squelch /multiline ; /mqpause on; /stick off; /moveto stop; /nav stop')
    local x = mq.TLO.Me.X()
    local y = mq.TLO.Me.Y()
    local z = mq.TLO.Me.Z()
    local myname = mq.TLO.Me.Name()
    if Alive() and mq.TLO.Me.Invis() == false and mq.TLO.Me.Class.ShortName() == 'BRD' then
        mq.cmd('/twist stop')
        mq.cmd('/alt activate 231')
        mq.cmd('/dgga /removelev')
    end
    if Alive() and mq.TLO.Me.Invis('SOS')() == false and mq.TLO.Me.Class.ShortName() == 'ROG' then
        mq.cmd('/makemevisible')
        mq.cmd('/dismount')
        mq.delay(500)
        if mq.TLO.Me.Sneaking() == false then
            while mq.TLO.Me.AbilityReady('Sneak')() == false do
                mq.delay(10)
            end
            mq.cmd('/doability sneak')
        end
        while mq.TLO.Me.AbilityReady('Hide')() == false do
            mq.delay(10)
        end
        mq.cmd('/doability hide')
        mq.cmd('/removelev')
    end
    mq.cmdf('/tar id %s', corpsid)
    mq.cmdf('/dex %s /consent %s', corpse, myname)
    mq.delay(100)
    if Alive() and mq.TLO.Navigation.PathExists('target')() then
        while mq.TLO.Target.Distance() ~= nil and mq.TLO.Target.Distance() >= 21 do
            if mq.TLO.Navigation.Active() == false then
                mq.cmd('/nav target log=off')
            end
            mq.delay(100)
        end
        if Alive() and mq.TLO.Target.Distance() ~= nil and mq.TLO.Target.Distance() <= 20 then
            mq.cmd('/squelch /corpsedrag')
        end
        mq.cmd('/squelch /multiline ; /mqpause on; /stick off; /moveto stop; /nav stop')
        mq.delay(100)
        mq.cmdf('/squelch /nav locxyz %s %s %s log=off', x, y, z)
        while Fetch_Distance(mq.TLO.Me.X(), mq.TLO.Me.Y(), x, y) >= 20 do
            if mq.TLO.Navigation.Active() == false then
                mq.cmdf('/squelch /nav locxyz %s %s %s log=off', x, y, z)
            end
            mq.delay(100)
        end
        while mq.TLO.Navigation.Active() do
            mq.delay(100)
        end
        mq.cmd('/corpsedrop')
        mq.cmd('/squelch /mqpause off')
        print('\aw[Corpse Drag] \agCorpse Recover Complete.')
    else
        print('\aw[Corpse Drag] \arNavigation path does not exist to corpse')
    end
end
local function CorpseRecovery ()
    if (mq.TLO.Me.Class.ShortName() == 'ROG' or mq.TLO.Me.Class.ShortName() == 'BRD') and Checked() and not mq.TLO.Me.Combat() and mq.TLO.Me.XTarget() == 0 and mq.TLO.Zone.ID() ~= 344 then
    local corpsecount = mq.TLO.SpawnCount('pccorpse radius '..maxdistance)()
        if corpsecount == nil then
            return
        end
        if corpsecount ~= nil then
            for c = 1, corpsecount do
                --set the corpse variables
                local corpsename = mq.TLO.NearestSpawn(c..',pccorpse radius '..maxdistance).CleanName()
                local corpseid = mq.TLO.NearestSpawn(c..',pccorpse radius '..maxdistance).ID()
                local raidcount = mq.TLO.Raid.Members()
                local groupcount = mq.TLO.Group.Members()
                local guild = mq.TLO.Me.Guild()
                local guildcorpsecount = mq.TLO.SpawnCount('guild corpse radius '..maxdistance)()
                --Guild Drag
                if guildcorpsecount > 0 then
                    for i = 1, guildcorpsecount do
                        local guildcorpseid = mq.TLO.NearestSpawn(i..',guild corpse radius '..maxdistance).ID()
                        local guildmembercorpse = mq.TLO.NearestSpawn(i..',guild corpse radius '..maxdistance).CleanName()
                        local guildmemeberguild = mq.TLO.NearestSpawn(i..',guild corpse radius '..maxdistance).Guild()
                        if guildmemeberguild == guild then
                            if mq.TLO.Spawn('id '..guildcorpseid).Distance() >= mindistance and mq.TLO.Navigation.PathExists('id '..guildcorpseid)() then
                                print('Easy Drag Guild Corpse')
                                drag(guildcorpseid, guildmembercorpse)
                            end
                        end
                    end
                else
                --Raid Drag
                if raidcount > 0 then
                    for r = 1, raidcount do
                        local raidmember = mq.TLO.Raid.Member(r)()
                        local corpseadd = "'s corpse"
                        local raidcorpsename = string.format("%s%s", raidmember, corpseadd)
                        if corpsename == raidcorpsename then 
                            if mq.TLO.Spawn('id '..corpseid).Distance() >= mindistance and mq.TLO.Navigation.PathExists('id '..corpseid)() then
                                printf('\ag[\apEasy\at]\ag Drag Raid Corpse \at%s',raidmember)
                                drag(corpseid, raidmember)
                            end
                        end
                    end
                else
                --Group Drag
                    if groupcount > 0 then
                        for g = 1, groupcount do
                            local groupmember = mq.TLO.Group.Member(g)()
                            local corpseadd = "'s corpse"
                            local groupcorpsename = string.format("%s%s", groupmember, corpseadd)
                            if corpsename == groupcorpsename then
                                if mq.TLO.Spawn('id '..corpseid).Distance() >= mindistance and mq.TLO.Navigation.PathExists('id '..corpseid)() then
                                    printf('\ag[\apEasy\at]\ag Drag Group Corpse \at%s',groupmember)
                                    drag(corpseid, groupmember)
                                end
                            end
                        end
                    end
                end
            end
        end

            --DanNet Drag
            if mq.TLO.Plugin('mq2dannet')() ~= nil and saved_settings.dannet_load and not mq.TLO.Me.Hovering() and mq.TLO.Zone.ID() ~= 344 then
            local dannetscount = mq.TLO.DanNet.PeerCount()
                if dannetscount == nil then
                    return
                end
                for peers in string.gmatch(mq.TLO.DanNet.Peers(), "([^|]+)") do
                    local maxeddistance = 5000
                    local mininum_distance = 75
                    local spawnedsearch = string.format('pccorpse %s radius %s', peers, maxeddistance)
                    local corpses_count = mq.TLO.SpawnCount(spawnedsearch)()
                        for corpse = 1, corpses_count do
                            local corpse_ID = mq.TLO.NearestSpawn(corpse, spawnedsearch).ID()
                            if Alive() and corpse_ID ~= nil and Checked() and mq.TLO.Spawn('id '..corpse_ID).Distance() >= mininum_distance and mq.TLO.Navigation.PathExists('id '..corpse_ID)() then
                                printf('%s has %s corpse(s) within %s feet', peers, corpses_count, maxeddistance )
                                mq.cmdf('/mqtarget id %s', corpse_ID)
                                printf('Dragging Corpse: ID - %s - %s', corpse_ID, mq.TLO.Target.CleanName())
                                mq.cmdf('/dge all /consent %s',mq.TLO.Me.CleanName())
                                print(easy, ' \atCorpse Recovery '..mq.TLO.Target.CleanName()..'')
                                mq.delay('1s')
                                if Alive() and mq.TLO.Spawn('id '..corpse_ID)() ~= nil and mq.TLO.Spawn('id '..corpse_ID).Distance() >= mininum_distance and mq.TLO.Navigation.PathExists('id '..corpse_ID)() then
                                    drag(corpse_ID, mq.TLO.Target.CleanName())
                                    printf('\agRecovered \at%s', peers)
                                end
                                print('\ayCHECKING NEXT CORPSE')
                            end
                        mq.delay(1000)
                    end
                end
            end
        end
    end
end

-------------------------------------------------
---------------- Language Trainer ---------------
-------------------------------------------------
local function Language()
    if mq.TLO.Group.Members() >= 1 then
        for lang = 1, 25 +1 do
            mq.cmdf('/language %s', lang)
            mq.delay(500)
            mq.cmd('/gsay Teaching what I know.')
        end
        mq.delay('1s')
        if mq.TLO.Plugin('mq2dannet') ~= nil and saved_settings.dannet_load then
            mq.cmd('/dgza /language 4')
        end
    end
end

-------------------------------------------------
------------------ ENC Burn NOT DONE ---------------------
-------------------------------------------------

local ENC_BURN = function ()
    local enc_burn_variables = {
        targethp = mq.TLO.Target.PctHPs() or 0,
        targetdistance = mq.TLO.Target.Distance() or 0,
        myhp = mq.TLO.Me.PctHPs() or 0,
        maintank = mq.TLO.Group.MainTank.CleanName(),
        myendurance = mq.TLO.Me.PctEndurance(),
        xtarget = mq.TLO.Me.XTarget(),
        mymana = mq.TLO.Me.PctMana() or 0,
        maintankdistance = mq.TLO.Group.MainTank.Distance() or 0,
        targetlevel = mq.TLO.Target.Level() or 0,
        mepoisoned = mq.TLO.Me.CountersPoison() or 0,
        mypethp = mq.TLO.Me.Pet.PctHPs() or 0,
        mypetdistance = mq.TLO.Me.Pet.Distance() or 0,
        mypet = mq.TLO.Me.Pet.CleanName(),
        spell_rank = '',
        spell_ready = '',
        combat_true = mq.TLO.Me.Combat(),
        aggressive = mq.TLO.Target.Aggressive(),
        xtargetdistance = mq.TLO.Me.XTarget(1).Distance() or 0,
        hovering = mq.TLO.Me.Hovering()
        }
    local function EncBurn()
        return not mq.TLO.Me.Hovering()
        and not mq.TLO.Me.Invulnerable()
        and not mq.TLO.Me.Silenced()
        and not mq.TLO.Me.Mezzed()
        and not mq.TLO.Me.Charmed()
        and not mq.TLO.Me.Feigning()
        and mq.TLO.Target.Aggressive()
        and mq.TLO.Me.XTarget() >= 1
        and enc_burn_variables.targetdistance <= 100
        and enc_burn_variables.targetdistance >= 1
        and enc_burn_variables.targethp >= defaults.STOP_BURN
        and enc_burn_variables.targethp <= defaults.START_BURN
        and mq.TLO.Target.ID() ~= 0
        and not mq.TLO.Me.Moving()
        and mq.TLO.Me.Buff('Resurrection Sickness')() == nil
    end
    local function EncEngage()
        if Alive() and mq.TLO.Me.XTarget() ~= 0 then
            return mq.TLO.Me.XTarget(1).ID() >= 1
            and enc_burn_variables.xtargetdistance <= 50
            and enc_burn_variables.xtargetdistance >= 25
            and not mq.TLO.Navigation.Active()
        end
    end
    local function EncAggro()
        if Alive() then
            if mq.TLO.Navigation.Active() then mq.cmd('/nav stop') end
            if mq.TLO.Target.ID() == 0 then
                mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID())
                mq.cmd('/face fast')
                if mq.TLO.Pet.ID() ~= nil then
                    mq.cmd('/pet attack')
                end
            end
        end
    end
    if mq.TLO.Me.Class.ShortName() == 'ENC' and Alive() then
        UseGear()
        if EncEngage() then
            EncAggro()
        end
        
        --Ancestral Aid
        if mq.TLO.Me.AltAbilityReady('Ancestral Aid')() and enc_burn_variables.myhp <= 40 and enc_burn_variables.myhp >= 1 and not enc_burn_variables.hovering then
            print(easy, ' \ag ENC Burn\aw - \ag[\atAA\ag]\ao - Ancestral Aid')
            mq.cmd('/alt activate 447')
            mq.delay(490)
            if EncEngage() then
                EncAggro()
            end
        end
        if EncBurn() then
            --AA
            --Companion's Fortification
            if mq.TLO.Me.AltAbilityReady('Companion\'s Fortification')() and enc_burn_variables.mypethp >= 50 and enc_burn_variables.mypethp <= 100 and not enc_burn_variables.hovering then
                print(easy, ' \ag ENC Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Fortification')
                mq.cmd('/alt activate 3707')
                mq.delay(490)
                if EncEngage() then
                    EncAggro()
                end
            end
        end
    end
end

-------------------------------------------------
------------------ PAL Burn NOT DONE ---------------------
-------------------------------------------------

local PAL_BURN = function ()
    local pal_burn_variables = {
        targethp = mq.TLO.Target.PctHPs() or 0,
        targetdistance = mq.TLO.Target.Distance() or 0,
        myhp = mq.TLO.Me.PctHPs() or 0,
        maintank = mq.TLO.Group.MainTank.CleanName(),
        myendurance = mq.TLO.Me.PctEndurance(),
        xtarget = mq.TLO.Me.XTarget(),
        mymana = mq.TLO.Me.PctMana() or 0,
        maintankdistance = mq.TLO.Group.MainTank.Distance() or 0,
        targetlevel = mq.TLO.Target.Level() or 0,
        mepoisoned = mq.TLO.Me.CountersPoison() or 0,
        mypethp = mq.TLO.Me.Pet.PctHPs() or 0,
        mypetdistance = mq.TLO.Me.Pet.Distance() or 0,
        mypet = mq.TLO.Me.Pet.CleanName(),
        spell_rank = '',
        spell_ready = '',
        combat_true = mq.TLO.Me.Combat(),
        aggressive = mq.TLO.Target.Aggressive(),
        xtargetdistance = mq.TLO.Me.XTarget(1).Distance() or 0,
        hovering = mq.TLO.Me.Hovering()
        }
    local function PalBurn()
        return not mq.TLO.Me.Hovering()
        and not mq.TLO.Me.Invulnerable()
        and not mq.TLO.Me.Silenced()
        and not mq.TLO.Me.Mezzed()
        and not mq.TLO.Me.Charmed()
        and not mq.TLO.Me.Feigning()
        and mq.TLO.Target.Aggressive()
        and mq.TLO.Me.XTarget() >= 1
        and pal_burn_variables.targetdistance <= 100
        and pal_burn_variables.targetdistance >= 1
        and pal_burn_variables.targethp >= defaults.STOP_BURN
        and pal_burn_variables.targethp <= defaults.START_BURN
        and mq.TLO.Target.ID() ~= 0
        and not mq.TLO.Me.Moving()
        and mq.TLO.Me.Buff('Resurrection Sickness')() == nil
    end
    local function PalEngage()
        if Alive() and mq.TLO.Me.XTarget() ~= 0 then
            return mq.TLO.Me.XTarget(1).ID() >= 1
            and pal_burn_variables.xtargetdistance <= 50
            and pal_burn_variables.xtargetdistance >= 25
            and not mq.TLO.Navigation.Active()
        end
    end
    local function PalAggro()
        if Alive() then
            if mq.TLO.Navigation.Active() then mq.cmd('/nav stop') end
            if mq.TLO.Target.ID() == 0 then
                mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID())
                mq.cmd('/face fast')
                if mq.TLO.Pet.ID() ~= nil then
                    mq.cmd('/pet attack')
                end
            end
        end
    end
    if mq.TLO.Me.Class.ShortName() == 'PAL' and Alive() then
        UseGear()
        if PalEngage() then
            PalAggro()
        end
        
        --Breather
        local breather = mq.TLO.Spell('Breather').RankName()
        if mq.TLO.Me.CombatAbilityReady('Breather')() and pal_burn_variables.myendurance <= 20 and mq.TLO.Me.Song('Breather')() == nil and pal_burn_variables.xtarget == 0 and not pal_burn_variables.combat_true and not pal_burn_variables.hovering then
            print(easy, ' \ag PAL Burn\aw - \ag[\atCombat Ability\ag]\ao - '..breather..'')
            mq.cmdf('/disc %s', breather)
            mq.delay(490)
            if PalEngage() then
                PalAggro()
            end
        end
        --Purification
        if mq.TLO.Me.AltAbilityReady('Purification')() and pal_burn_variables.myhp >= 1 and pal_burn_variables.myhp <= 99 and pal_burn_variables.mepoisoned >= 1 and not pal_burn_variables.hovering and not mq.TLO.Me.Moving() then
            mq.cmd('/target %s',mq.TLO.Me.CleanName())
            mq.delay(100)
            print(easy, ' \ag PAL Burn\aw - \ag[\atAA\ag]\ao - Purification')
            mq.cmd('/alt activate 286')
            mq.delay(490)
            if PalEngage() then
                PalAggro()
            end
        end
        --Blessing of Purification
        if mq.TLO.Me.AltAbilityReady('Blessing of Purification')() and pal_burn_variables.myhp >= 1 and pal_burn_variables.myhp <= 99 and pal_burn_variables.mepoisoned >= 1 and not pal_burn_variables.hovering and not mq.TLO.Me.Moving() then
            mq.cmd('/target %s',mq.TLO.Me.CleanName())
            mq.delay(100)
            print(easy, ' \ag PAL Burn\aw - \ag[\atAA\ag]\ao - Blessing of Purification')
            mq.cmd('/alt activate 9101')
            mq.delay(490)
            if PalEngage() then
                PalAggro()
            end
        end
        --Radiant Cure
        if mq.TLO.Me.AltAbilityReady('Radiant Cure')() and pal_burn_variables.mepoisoned >= 1 and not pal_burn_variables.hovering then
            print(easy, ' \ag PAL Burn\aw - \ag[\atAA\ag]\ao - Radiant Cure')
            mq.cmd('/alt activate 285')
            mq.delay(490)
            if PalEngage() then
                PalAggro()
            end
        end
        if PalBurn() then
            --Combat Abilities
            --Unending Affirmation
            local unendingaffirmation = mq.TLO.Spell('Unending Affirmation').RankName()
            if mq.TLO.Me.CombatAbilityReady('Unending Affirmation')() and pal_burn_variables.maintank == mq.TLO.Me.CleanName() then
                print(easy, ' \ag PAL Burn\aw - \ag[\atCombat Ability\ag]\ao - '..unendingaffirmation..'')
                mq.cmdf('/disc %s', unendingaffirmation)
                mq.delay(490)
                if PalEngage() then
                    PalAggro()
                end
            end
            --Mantle of the Sapphire
            local mantleofthesapphire = mq.TLO.Spell('Mantle of the Sapphire').RankName()
            if mq.TLO.Me.CombatAbilityReady('Mantle of the Sapphire')() and pal_burn_variables.myhp <= 40 and pal_burn_variables.myhp >= 1 then
                print(easy, ' \ag PAL Burn\aw - \ag[\atCombat Ability\ag]\ao - '..mantleofthesapphire..'')
                mq.cmdf('/disc %s', mantleofthesapphire)
                mq.delay(490)
                if PalEngage() then
                    PalAggro()
                end
            end
            --Thwart
            local thwart = mq.TLO.Spell('Thwart').RankName()
            if mq.TLO.Me.CombatAbilityReady('Thwart')() and pal_burn_variables.myhp <= 40 and pal_burn_variables.myhp >= 1 then
                print(easy, ' \ag PAL Burn\aw - \ag[\atCombat Ability\ag]\ao - '..thwart..'')
                mq.cmdf('/disc %s', thwart)
                mq.delay(490)
                if PalEngage() then
                    PalAggro()
                end
            end
            --Armor of Sincerity
            local armorofsincerity = mq.TLO.Spell('Armor of Sincerity').RankName()
            if mq.TLO.Me.CombatAbilityReady('Armor of Sincerity')() and pal_burn_variables.myhp <= 40 and pal_burn_variables.myhp >= 1 then
                print(easy, ' \ag PAL Burn\aw - \ag[\atCombat Ability\ag]\ao - '..armorofsincerity..'')
                mq.cmdf('/disc %s', armorofsincerity)
                mq.delay(490)
                if PalEngage() then
                    PalAggro()
                end
            end
            --Righteous Antipathy
            local righteousantipathy = mq.TLO.Spell('Righteous Antipathy').RankName()
            if mq.TLO.Me.CombatAbilityReady('Righteous Antipathy')() and pal_burn_variables.targethp >= 70 and pal_burn_variables.myhp <= 99 then
                print(easy, ' \ag PAL Burn\aw - \ag[\atCombat Ability\ag]\ao - '..righteousantipathy..'')
                mq.cmdf('/disc %s', righteousantipathy)
                mq.delay(490)
                if PalEngage() then
                    PalAggro()
                end
            end
            --AA
            --Ageless Enmity
            if mq.TLO.Me.AltAbilityReady('Ageless Enmity')() and pal_burn_variables.maintank == mq.TLO.Me.CleanName() then
                print(easy, ' \ag PAL Burn\aw - \ag[\atAA\ag]\ao - Ageless Enmity')
                mq.cmd('/alt activate 10392')
                mq.delay(490)
                if PalEngage() then
                    PalAggro()
                end
            end
            --Divine Call
            if mq.TLO.Me.AltAbilityReady('Divine Call')() and pal_burn_variables.maintank == mq.TLO.Me.CleanName() then
                print(easy, ' \ag PAL Burn\aw - \ag[\atAA\ag]\ao - Divine Call')
                mq.cmd('/alt activate 660')
                mq.delay(490)
                if PalEngage() then
                    PalAggro()
                end
            end
            --Forceful Rejuvenation
            if mq.TLO.Me.AltAbilityReady('Forceful Rejuvenation')() then
                print(easy, ' \ag PAL Burn\aw - \ag[\atAA\ag]\ao - Foreceful Rejuvenation')
                mq.cmd('/alt activate 7003')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if PalEngage() then
                   PalAggro()
                end
            end
            --Speed of the Savior
            if mq.TLO.Me.AltAbilityReady('Speed of the Savior')() then
                print(easy, ' \ag PAL Burn\aw - \ag[\atAA\ag]\ao - Speed of the Savior')
                mq.cmd('/alt activate 659')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if PalEngage() then
                   PalAggro()
                end
            end
            --Projection of Piety
            if mq.TLO.Me.AltAbilityReady('Projection of Piety')() and pal_burn_variables.targethp >= 80 and pal_burn_variables.targethp <= 99 then
                print(easy, ' \ag PAL Burn\aw - \ag[\atAA\ag]\ao - Projection of Piety')
                mq.cmd('/alt activate 3216')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if PalEngage() then
                   PalAggro()
                end
            end
            --Spire of Chivalry
            if mq.TLO.Me.AltAbilityReady('Spire of Chivalry')() and pal_burn_variables.targethp >= 80 and pal_burn_variables.targethp <= 99 then
                print(easy, ' \ag PAL Burn\aw - \ag[\atAA\ag]\ao - Spire of Chivalry')
                mq.cmd('/alt activate 1440')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if PalEngage() then
                   PalAggro()
                end
            end
            --Thunder of Karana
            if mq.TLO.Me.AltAbilityReady('Thunder of Karana')() and pal_burn_variables.targethp >= 80 and pal_burn_variables.targethp <= 99 then
                print(easy, ' \ag PAL Burn\aw - \ag[\atAA\ag]\ao - Thunder of Karana')
                mq.cmd('/alt activate 1017')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if PalEngage() then
                   PalAggro()
                end
            end
            --Valorous Rage
            if mq.TLO.Me.AltAbilityReady('Valorous Rage')() and pal_burn_variables.targethp >= 80 and pal_burn_variables.targethp <= 99 then
                print(easy, ' \ag PAL Burn\aw - \ag[\atAA\ag]\ao - Valorous Rage')
                mq.cmd('/alt activate 920')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if PalEngage() then
                   PalAggro()
                end
            end
            --Shield Flash
            if mq.TLO.Me.AltAbilityReady('Shield Flash')() and pal_burn_variables.myhp <= 50 and pal_burn_variables.myhp >= 1 then
                print(easy, ' \ag PAL Burn\aw - \ag[\atAA\ag]\ao - Shield Flash')
                mq.cmd('/alt activate 1112')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if PalEngage() then
                   PalAggro()
                end
            end
            --Gift of Life
            if mq.TLO.Me.AltAbilityReady('Gift of Life')() and pal_burn_variables.myhp <= 50 and pal_burn_variables.myhp >= 1 then
                print(easy, ' \ag PAL Burn\aw - \ag[\atAA\ag]\ao - Gift of Life')
                mq.cmd('/alt activate 3676')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if PalEngage() then
                   PalAggro()
                end
            end
            --Armor of the Inquisitor
            if mq.TLO.Me.AltAbilityReady('Armor of the Inquisitor')() and pal_burn_variables.myhp <= 90 and pal_burn_variables.myhp >= 1 then
                print(easy, ' \ag PAL Burn\aw - \ag[\atAA\ag]\ao - Armor of the Inquisitor')
                mq.cmd('/alt activate 701')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if PalEngage() then
                   PalAggro()
                end
            end
            --Group Armor of the Inquisitor
            if mq.TLO.Me.AltAbilityReady('Group Armor of the Inquisitor')() and pal_burn_variables.myhp <= 50 and pal_burn_variables.myhp >= 1 then
                print(easy, ' \ag PAL Burn\aw - \ag[\atAA\ag]\ao - Group Armor of the Inquisitor')
                mq.cmd('/alt activate 2019')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if PalEngage() then
                   PalAggro()
                end
            end
            --Hand of Piety
            if mq.TLO.Me.AltAbilityReady('Hand of Piety')() and pal_burn_variables.myhp <= 65 and pal_burn_variables.myhp >= 1 then
                print(easy, ' \ag PAL Burn\aw - \ag[\atAA\ag]\ao - Hand of Piety')
                mq.cmd('/alt activate 180')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if PalEngage() then
                   PalAggro()
                end
            end
            --Inquisitor's Judgement
            if mq.TLO.Me.AltAbilityReady('Inquisitor\'s Judgement')() and pal_burn_variables.targethp >= 80 and pal_burn_variables.targethp <= 99 then
                print(easy, ' \ag PAL Burn\aw - \ag[\atAA\ag]\ao - Inquisitor\'s Judgement')
                mq.cmd('/alt activate 6492')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if PalEngage() then
                   PalAggro()
                end
            end
            --Lay on Hands
            if mq.TLO.Me.AltAbilityReady('Lay on Hands')() and pal_burn_variables.myhp <= 10 and not pal_burn_variables.hovering then
                mq.cmdf('/target %s',mq.TLO.Me.CleanName())
                print(easy, ' \ag PAL Burn\aw - \ag[\atAA\ag]\ao - Lay on Hands')
                mq.cmd('/alt activate 6001')
                mq.delay(490)
                if PalEngage() then
                    PalAggro()
                end
            end
            --Marr's Gift
            if mq.TLO.Me.AltAbilityReady('Marr\'s Gift')() and pal_burn_variables.myhp <= 50 and not pal_burn_variables.hovering then
                mq.cmdf('/target %s',mq.TLO.Me.CleanName())
                print(easy, ' \ag PAL Burn\aw - \ag[\atAA\ag]\ao - Marr\'s Gift')
                mq.cmd('/alt activate 1282')
                mq.delay(490)
                if PalEngage() then
                    PalAggro()
                end
            end
            --Marr's Salvation
            if mq.TLO.Me.AltAbilityReady('Marr\'s Salvation')() and pal_burn_variables.targethp <= 90 and not pal_burn_variables.hovering then
                print(easy, ' \ag PAL Burn\aw - \ag[\atAA\ag]\ao - Marr\'s Salvation')
                mq.cmd('/alt activate 769')
                mq.delay(490)
                if PalEngage() then
                    PalAggro()
                end
            end
        end
    end
end

-------------------------------------------------
------------------ WIZ Burn ---------------------
-------------------------------------------------

local WIZ_BURN = function ()
    local wiz_burn_variables = {
        targethp = mq.TLO.Target.PctHPs() or 0,
        targetdistance = mq.TLO.Target.Distance() or 0,
        myhp = mq.TLO.Me.PctHPs() or 0,
        maintank = mq.TLO.Group.MainTank.CleanName(),
        myendurance = mq.TLO.Me.PctEndurance(),
        xtarget = mq.TLO.Me.XTarget(),
        mymana = mq.TLO.Me.PctMana() or 0,
        maintankdistance = mq.TLO.Group.MainTank.Distance() or 0,
        targetlevel = mq.TLO.Target.Level() or 0,
        mepoisoned = mq.TLO.Me.CountersPoison() or 0,
        mypethp = mq.TLO.Me.Pet.PctHPs() or 0,
        mypetdistance = mq.TLO.Me.Pet.Distance() or 0,
        mypet = mq.TLO.Me.Pet.CleanName(),
        spell_rank = '',
        spell_ready = '',
        combat_true = mq.TLO.Me.Combat(),
        aggressive = mq.TLO.Target.Aggressive(),
        xtargetdistance = mq.TLO.Me.XTarget(1).Distance() or 0,
        hovering = mq.TLO.Me.Hovering()
        }
    local function WizBurn()
        return not mq.TLO.Me.Hovering()
        and not mq.TLO.Me.Invulnerable()
        and not mq.TLO.Me.Silenced()
        and not mq.TLO.Me.Mezzed()
        and not mq.TLO.Me.Charmed()
        and not mq.TLO.Me.Feigning()
        and mq.TLO.Target.Aggressive()
        and mq.TLO.Me.XTarget() >= 1
        and wiz_burn_variables.targetdistance <= 100
        and wiz_burn_variables.targetdistance >= 1
        and wiz_burn_variables.targethp >= defaults.STOP_BURN
        and wiz_burn_variables.targethp <= defaults.START_BURN
        and mq.TLO.Target.ID() ~= 0
        and not mq.TLO.Me.Moving()
        and mq.TLO.Me.Buff('Resurrection Sickness')() == nil
    end
    local function WizEngage()
        if Alive() and mq.TLO.Me.XTarget() ~= 0 then
            return mq.TLO.Me.XTarget(1).ID() >= 1
            and wiz_burn_variables.xtargetdistance <= 50
            and wiz_burn_variables.xtargetdistance >= 25
            and not mq.TLO.Navigation.Active()
        end
    end
    local function WizAggro()
        if Alive() then
            if mq.TLO.Navigation.Active() then mq.cmd('/nav stop') end
            if mq.TLO.Target.ID() == 0 then
                mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID())
                mq.cmd('/face fast')
                if mq.TLO.Pet.ID() ~= nil then
                    mq.cmd('/pet attack')
                end
            end
        end
    end
    if mq.TLO.Me.Class.ShortName() == 'WIZ' and Alive() then
        UseGear()
        if WizEngage() then
            WizAggro()
        end
        --Improved Familiar
        if mq.TLO.Me.AltAbilityReady('Improved Familiar')() and mq.TLO.Me.Buff('Improved Familiar')() == nil and not wiz_burn_variables.hovering then
            print(easy, ' \agWIZ Using:\aw - \ag[\atAA\ag]\ao - Improved Familiar')
            mq.cmd('/alt activate 52')
            mq.delay(500)
            if WizEngage() then
                WizAggro()
            end
        end
        --Harvest of Druzzil
        if mq.TLO.Me.AltAbilityReady('Harvest of Druzzil')() and wiz_burn_variables.mymana <= 80 and wiz_burn_variables.mymana >= 1 and not wiz_burn_variables.hovering then
            print(easy, ' \agWIZ Using:\aw - \ag[\atAA\ag]\ao - Harvest of Druzzil')
            mq.cmd('/alt activate 172')
            mq.delay(500)
            while mq.TLO.Me.Casting() do mq.delay(250) end
            if WizEngage() then
               WizAggro()
            end
        end
        --Etherealist's Unity
        if mq.TLO.Me.AltAbilityReady('Etherealist\'s Unity')() and mq.TLO.Me.Buff('Shield of the Crystalwing')() == nil and not wiz_burn_variables.hovering then
            print(easy, ' \agWIZ Using:\aw - \ag[\atAA\ag]\ao - Etherealist\'s Unity')
            mq.cmd('/alt activate 1168')
            mq.delay(490)
            if WizEngage() then
                WizAggro()
            end
        end
        if WizBurn() then
            --AA
            --Armor of Experience
            if WizBurn() and mq.TLO.Me.AltAbilityReady('Armor of Experience')() and wiz_burn_variables.myhp <= 20 and wiz_burn_variables.myhp >= 1 then
                print(easy, ' \ag WIZ Burn\aw - \ag[\atAA\ag]\ao - Armor of Experience')
                mq.cmd('/alt activate 2000')
                mq.delay(490)
                if WizEngage() then
                    WizAggro()
                end
            end
            --A Hole In Space
            if mq.TLO.Me.AltAbilityReady('A Hole In Space')() and wiz_burn_variables.myhp <= 5 and wiz_burn_variables.myhp >= 1 and not mq.TLO.Me.Feigning() and WizBurn() then
                print(easy, ' \ag WIZ Burn\aw - \ag[\atAA\ag]\ao - A Hole In Space')
                mq.cmd('/alt activate 365')
                mq.delay(490)
                if WizEngage() then
                    WizAggro()
                end
            end
            --Arcane Whisper
            if mq.TLO.Me.AltAbilityReady('Arcane Whisper')() and wiz_burn_variables.myhp <= 50 and wiz_burn_variables.myhp >= 1 and mq.TLO.Me.PctAggro() >= 90 and not mq.TLO.Me.Feigning() and WizBurn() then
                print(easy, ' \ag WIZ Burn\aw - \ag[\atAA\ag]\ao - Arcane Whisper')
                mq.cmd('/alt activate 636')
                mq.delay(490)
                if WizEngage() then
                    WizAggro()
                end
            end
            --Dimensional Shield
            if mq.TLO.Me.AltAbilityReady('Dimensional Shield')() and wiz_burn_variables.myhp <= 50 and wiz_burn_variables.myhp >= 1 and mq.TLO.Me.PctAggro() >= 90 and not mq.TLO.Me.Feigning() and WizBurn() then
                print(easy, ' \ag WIZ Burn\aw - \ag[\atAA\ag]\ao - Dimensional Shield')
                mq.cmd('/alt activate 639')
                mq.delay(490)
                if WizEngage() then
                    WizAggro()
                end
            end
            --Mind Crash
            if mq.TLO.Me.AltAbilityReady('Mind Crash')() and wiz_burn_variables.myhp <= 50 and wiz_burn_variables.myhp >= 1 and mq.TLO.Me.PctAggro() >= 90 and not mq.TLO.Me.Feigning() and WizBurn() then
                print(easy, ' \ag WIZ Burn\aw - \ag[\atAA\ag]\ao - Mind Crash')
                mq.cmd('/alt activate 451')
                mq.delay(490)
                if WizEngage() then
                    WizAggro()
                end
            end
            --Lower Element
            if mq.TLO.Me.AltAbilityReady('Lower Element')() and wiz_burn_variables.targethp >= 75 and wiz_burn_variables.targethp <= 99 and WizBurn() then
                print(easy, ' \ag WIZ Burn\aw - \ag[\atAA\ag]\ao - Lower Element')
                mq.cmd('/alt activate 1262')
                mq.delay(490)
                if WizEngage() then
                    WizAggro()
                end
            end
            --Spire of Arcanum
            if mq.TLO.Me.AltAbilityReady('Spire of Arcanum')() and wiz_burn_variables.targethp >= 75 and wiz_burn_variables.targethp <= 99 and mq.TLO.Me.PctAggro() >= 90 and WizBurn() then
                print(easy, ' \ag WIZ Burn\aw - \ag[\atAA\ag]\ao - Spire of Arcanum')
                mq.cmd('/alt activate 1350')
                mq.delay(490)
                if WizEngage() then
                    WizAggro()
                end
            end
            --Mana Burn
            if mq.TLO.Me.AltAbilityReady('Mana Burn')() and wiz_burn_variables.targethp >= 75 and wiz_burn_variables.targethp <= 99 and WizBurn() then
                print(easy, ' \ag WIZ Burn\aw - \ag[\atAA\ag]\ao - Mana Burn')
                mq.cmd('/alt activate 565')
                mq.delay(490)
                if WizEngage() then
                    WizAggro()
                end
            end
            --Ward of Destruction
            if mq.TLO.Me.AltAbilityReady('Ward of Destruction')() and wiz_burn_variables.targethp >= 75 and wiz_burn_variables.targethp <= 99 and WizBurn() then
                print(easy, ' \ag WIZ Burn\aw - \ag[\atAA\ag]\ao - Ward of Destruction')
                mq.cmd('/alt activate 307')
                mq.delay(490)
                if WizEngage() then
                    WizAggro()
                end
            end
            --Eradicate Magic
            if mq.TLO.Me.AltAbilityReady('Eradicate Magic')() and wiz_burn_variables.targethp >= 75 and wiz_burn_variables.targethp <= 99 and WizBurn() then
                print(easy, ' \ag WIZ Burn\aw - \ag[\atAA\ag]\ao - Eradicate Magic')
                mq.cmd('/alt activate 547')
                mq.delay(490)
                if WizEngage() then
                    WizAggro()
                end
            end
            --Focus of Arcanum
            if mq.TLO.Me.AltAbilityReady('Eradicate Magic')() and wiz_burn_variables.targethp >= 80 and wiz_burn_variables.targethp <= 99 and WizBurn() then
                print(easy, ' \ag WIZ Burn\aw - \ag[\atAA\ag]\ao - Focus of Arcanum')
                mq.cmd('/alt activate 1211')
                mq.delay(490)
                if WizEngage() then
                    WizAggro()
                end
            end
            --Forceful Rejuvenation
            if mq.TLO.Me.AltAbilityReady('Forceful Rejuvenation')() and WizBurn() then
                print(easy, ' \ag WIZ Burn\aw - \ag[\atAA\ag]\ao - Foreceful Rejuvenation')
                mq.cmd('/alt activate 7003')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if WizEngage() then
                   WizAggro()
                end
            end
            --Improved Twincast
            if mq.TLO.Me.AltAbilityReady('Improved Twincast')() and WizBurn() then
                print(easy, ' \ag WIZ Burn\aw - \ag[\atAA\ag]\ao - Improved Twincast')
                mq.cmd('/alt activate 515')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if WizEngage() then
                   WizAggro()
                end
            end
            --Silent Casting
            if mq.TLO.Me.AltAbilityReady('Silent Casting')() and wiz_burn_variables.targethp >= 80 and WizBurn() then
                print(easy, ' \ag WIZ Burn\aw - \ag[\atAA\ag]\ao - Silent Casting')
                mq.cmd('/alt activate 500')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if WizEngage() then
                   WizAggro()
                end
            end
            --Arcane Destruction
            if mq.TLO.Me.AltAbilityReady('Arcane Destruction')() and wiz_burn_variables.targethp >= 80 and WizBurn() then
                print(easy, ' \ag WIZ Burn\aw - \ag[\atAA\ag]\ao - Arcane Destruction')
                mq.cmd('/alt activate 1265')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if WizEngage() then
                   WizAggro()
                end
            end
            --Arcane Fury
            if mq.TLO.Me.AltAbilityReady('Arcane Fury')() and wiz_burn_variables.targethp >= 80 and WizBurn() then
                print(easy, ' \ag WIZ Burn\aw - \ag[\atAA\ag]\ao - Arcane Fury')
                mq.cmd('/alt activate 840')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if WizEngage() then
                   WizAggro()
                end
            end
            --Atol's Shackles
            if mq.TLO.Me.AltAbilityReady('Atol\'s Shackles')() and mq.TLO.Target.Buff('Atol\'s Shackles')() == nil and mq.TLO.Target.Buff('Encroaching Darkness')() == nil and mq.TLO.Target.Buff('Entombing Darkness')() == nil and wiz_burn_variables.targethp >= 50 and wiz_burn_variables.xtarget >= 3 and WizBurn() then
                print(easy, ' \ag WIZ Burn\aw - \ag[\atAA\ag]\ao - Atol\'s Shackles')
                mq.cmd('/alt activate 1155')
                mq.delay(490)
                if WizEngage() then
                    WizAggro()
                end
            end
            --Call of Xuzi
            if mq.TLO.Me.AltAbilityReady('Call of Xuzi')() and wiz_burn_variables.targethp >= 80 and WizBurn() then
                print(easy, ' \ag WIZ Burn\aw - \ag[\atAA\ag]\ao - Call of Xuzi')
                mq.cmd('/alt activate 208')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if WizEngage() then
                   WizAggro()
                end
            end
            --Concussion
            if mq.TLO.Me.AltAbilityReady('Concussion')() and wiz_burn_variables.targethp >= 80 and WizBurn() then
                print(easy, ' \ag WIZ Burn\aw - \ag[\atAA\ag]\ao - Concussion')
                mq.cmd('/alt activate 577')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if WizEngage() then
                   WizAggro()
                end
            end
            --Force of Flame
            if mq.TLO.Me.AltAbilityReady('Force of Flame')() and wiz_burn_variables.targethp >= 80 and wiz_burn_variables.mymana >= 50 and WizBurn() then
                print(easy, ' \ag WIZ Burn\aw - \ag[\atAA\ag]\ao - Force of Flame')
                mq.cmd('/alt activate 1266')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if WizEngage() then
                   WizAggro()
                end
            end
            --Force of Ice
            if mq.TLO.Me.AltAbilityReady('Force of Ice')() and wiz_burn_variables.targethp >= 80 and wiz_burn_variables.mymana >= 50 and WizBurn() then
                print(easy, ' \ag WIZ Burn\aw - \ag[\atAA\ag]\ao - Force of Ice')
                mq.cmd('/alt activate 1267')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if WizEngage() then
                   WizAggro()
                end
            end
            --Force of Will
            if mq.TLO.Me.AltAbilityReady('Force of Will')() and wiz_burn_variables.targethp >= 80 and wiz_burn_variables.mymana >= 50 and WizBurn() then
                print(easy, ' \ag WIZ Burn\aw - \ag[\atAA\ag]\ao - Force of Will')
                mq.cmd('/alt activate 1154')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if WizEngage() then
                   WizAggro()
                end
            end
            --Frenzied Devastation
            if mq.TLO.Me.AltAbilityReady('Frenzied Devastation')() and wiz_burn_variables.targethp >= 80 and WizBurn() then
                print(easy, ' \ag WIZ Burn\aw - \ag[\atAA\ag]\ao - Frenzied Devastation')
                mq.cmd('/alt activate 308')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if WizEngage() then
                   WizAggro()
                end
            end
            --Fury of Gods
            if mq.TLO.Me.AltAbilityReady('Fury of Gods')() and wiz_burn_variables.targethp >= 80 and WizBurn() then
                print(easy, ' \ag WIZ Burn\aw - \ag[\atAA\ag]\ao - Fury of Gods')
                mq.cmd('/alt activate 1150')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if WizEngage() then
                   WizAggro()
                end
            end
        end
    end
end

-------------------------------------------------
------------------ RNG Burn NOT DONE ---------------------
-------------------------------------------------

local RNG_BURN = function ()
    local rng_burn_variables = {
        targethp = mq.TLO.Target.PctHPs() or 0,
        targetdistance = mq.TLO.Target.Distance() or 0,
        myhp = mq.TLO.Me.PctHPs() or 0,
        maintank = mq.TLO.Group.MainTank.CleanName(),
        myendurance = mq.TLO.Me.PctEndurance(),
        xtarget = mq.TLO.Me.XTarget(),
        mymana = mq.TLO.Me.PctMana() or 0,
        maintankdistance = mq.TLO.Group.MainTank.Distance() or 0,
        targetlevel = mq.TLO.Target.Level() or 0,
        mepoisoned = mq.TLO.Me.CountersPoison() or 0,
        mypethp = mq.TLO.Me.Pet.PctHPs() or 0,
        mypetdistance = mq.TLO.Me.Pet.Distance() or 0,
        mypet = mq.TLO.Me.Pet.CleanName(),
        spell_rank = '',
        spell_ready = '',
        combat_true = mq.TLO.Me.Combat(),
        aggressive = mq.TLO.Target.Aggressive(),
        xtargetdistance = mq.TLO.Me.XTarget(1).Distance() or 0,
        hovering = mq.TLO.Me.Hovering()
        }
    local function RngBurn()
        return not mq.TLO.Me.Hovering()
        and not mq.TLO.Me.Invulnerable()
        and not mq.TLO.Me.Silenced()
        and not mq.TLO.Me.Mezzed()
        and not mq.TLO.Me.Charmed()
        and not mq.TLO.Me.Feigning()
        and mq.TLO.Target.Aggressive()
        and mq.TLO.Me.XTarget() >= 1
        and rng_burn_variables.targetdistance <= 100
        and rng_burn_variables.targetdistance >= 1
        and rng_burn_variables.targethp >= defaults.STOP_BURN
        and rng_burn_variables.targethp <= defaults.START_BURN
        and mq.TLO.Target.ID() ~= 0
        and not mq.TLO.Me.Moving()
        and mq.TLO.Me.Buff('Resurrection Sickness')() == nil
    end
    local function RngEngage()
        if Alive() and mq.TLO.Me.XTarget() ~= 0 then
            return mq.TLO.Me.XTarget(1).ID() >= 1
            and rng_burn_variables.xtargetdistance <= 50
            and rng_burn_variables.xtargetdistance >= 25
            and not mq.TLO.Navigation.Active()
        end
    end
    local function RngAggro()
        if Alive() then
            if mq.TLO.Navigation.Active() then mq.cmd('/nav stop') end
            if mq.TLO.Target.ID() == 0 then
                mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID())
                mq.cmd('/face fast')
                if mq.TLO.Pet.ID() ~= nil then
                    mq.cmd('/pet attack')
                end
            end
        end
    end
    if mq.TLO.Me.Class.ShortName() == 'RNG' and Alive() then
        UseGear()
        if RngEngage() then
            RngAggro()
        end
        --Breather
        local breather = mq.TLO.Spell('Breather').RankName()
        if mq.TLO.Me.CombatAbilityReady('Breather')() and rng_burn_variables.myendurance <= 20 and mq.TLO.Me.Song('Breather')() == nil and rng_burn_variables.xtarget == 0 and not rng_burn_variables.combat_true and not rng_burn_variables.hovering then
            print(easy, ' \ag RNG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..breather..'')
            mq.cmdf('/disc %s', breather)
            mq.delay(490)
            if RngEngage() then
                RngAggro()
            end
        end
        if RngBurn() then
            --AA
            --Convergence of Spirits
            if mq.TLO.Me.AltAbilityReady('Convergence of Spirits')() and rng_burn_variables.myhp >= 1 and rng_burn_variables.myhp <= 50 and not rng_burn_variables.hovering and not mq.TLO.Me.Moving() then
                mq.cmd('/target %s',mq.TLO.Me.CleanName())
                mq.delay(100)
                print(easy, ' \ag RNG Burn\aw - \ag[\atAA\ag]\ao - Convergence of Spirits')
                mq.cmd('/alt activate 455')
                mq.delay(490)
                if RngEngage() then
                    RngAggro()
                end
            end
            --Auspice of the Hunter
            if mq.TLO.Me.AltAbilityReady('Auspice of the Hunter')() and rng_burn_variables.targethp >= 50 and rng_burn_variables.targethp <= 100 and not rng_burn_variables.hovering then
                print(easy, ' \ag RNG Burn\aw - \ag[\atAA\ag]\ao - Auspice of the Hunter')
                mq.cmd('/alt activate 462')
                mq.delay(490)
                if RngEngage() then
                    RngAggro()
                end
            end
            --Pack Hunt
            if mq.TLO.Me.AltAbilityReady('Pack Hunt')() and rng_burn_variables.targethp >= 50 and rng_burn_variables.targethp <= 100 and not rng_burn_variables.hovering then
                print(easy, ' \ag RNG Burn\aw - \ag[\atAA\ag]\ao - Pack Hunt')
                mq.cmd('/alt activate 874')
                mq.delay(490)
                if RngEngage() then
                    RngAggro()
                end
            end
            --Outrider's Accuracy
            if mq.TLO.Me.AltAbilityReady('Outrider\'s Accuracy')() and rng_burn_variables.targethp >= 50 and rng_burn_variables.targethp <= 100 and not rng_burn_variables.hovering then
                print(easy, ' \ag RNG Burn\aw - \ag[\atAA\ag]\ao - Outrider\'s Accuracy')
                mq.cmd('/alt activate 3804')
                mq.delay(490)
                if RngEngage() then
                    RngAggro()
                end
            end
            --Imbued Ferocity
            if mq.TLO.Me.AltAbilityReady('Imbued Ferocity')() and rng_burn_variables.targethp >= 50 and rng_burn_variables.targethp <= 100 and not rng_burn_variables.hovering then
                print(easy, ' \ag RNG Burn\aw - \ag[\atAA\ag]\ao - Imbued Ferocity')
                mq.cmd('/alt activate 2235')
                mq.delay(490)
                if RngEngage() then
                    RngAggro()
                end
            end
            --Guardian of the Forest
            if mq.TLO.Me.AltAbilityReady('Guardian of the Forest')() and rng_burn_variables.targethp >= 50 and rng_burn_variables.targethp <= 100 and not rng_burn_variables.hovering then
                print(easy, ' \ag RNG Burn\aw - \ag[\atAA\ag]\ao - Guardian of the Forest')
                mq.cmd('/alt activate 184')
                mq.delay(490)
                if RngEngage() then
                    RngAggro()
                end
            end
            --Group Guardian of the Forest
            if mq.TLO.Me.AltAbilityReady('Group Guardian of the Forest')() and rng_burn_variables.targethp >= 50 and rng_burn_variables.targethp <= 100 and not rng_burn_variables.hovering then
                print(easy, ' \ag RNG Burn\aw - \ag[\atAA\ag]\ao - Group Guardian of the Forest')
                mq.cmd('/alt activate 873')
                mq.delay(490)
                if RngEngage() then
                    RngAggro()
                end
            end
            --Entropy of Nature
            if mq.TLO.Me.AltAbilityReady('Entropy of Nature')() and rng_burn_variables.targethp >= 50 and rng_burn_variables.targethp <= 100 and not rng_burn_variables.hovering then
                print(easy, ' \ag RNG Burn\aw - \ag[\atAA\ag]\ao - Entropy of Nature')
                mq.cmd('/alt activate 682')
                mq.delay(490)
                if RngEngage() then
                    RngAggro()
                end
            end
            --Empowered Blades
            if mq.TLO.Me.AltAbilityReady('Empowered Blades')() and rng_burn_variables.targethp >= 50 and rng_burn_variables.targethp <= 100 and not rng_burn_variables.hovering then
                print(easy, ' \ag RNG Burn\aw - \ag[\atAA\ag]\ao - Empowered Blades')
                mq.cmd('/alt activate 683')
                mq.delay(490)
                if RngEngage() then
                    RngAggro()
                end
            end
            --Elemental Arrow
            if mq.TLO.Me.AltAbilityReady('Elemental Arrow')() and rng_burn_variables.targethp >= 50 and rng_burn_variables.targethp <= 100 and not rng_burn_variables.hovering then
                print(easy, ' \ag RNG Burn\aw - \ag[\atAA\ag]\ao - Elemental Arrow')
                mq.cmd('/alt activate 838')
                mq.delay(490)
                if RngEngage() then
                    RngAggro()
                end
            end
        end
    end
end

-------------------------------------------------
------------------ CLR Burn NOT DONE ---------------------
-------------------------------------------------

local CLR_BURN = function ()
    local clr_burn_variables = {
        targethp = mq.TLO.Target.PctHPs() or 0,
        targetdistance = mq.TLO.Target.Distance() or 0,
        myhp = mq.TLO.Me.PctHPs() or 0,
        maintank = mq.TLO.Group.MainTank.CleanName(),
        myendurance = mq.TLO.Me.PctEndurance(),
        xtarget = mq.TLO.Me.XTarget(),
        mymana = mq.TLO.Me.PctMana() or 0,
        maintankdistance = mq.TLO.Group.MainTank.Distance() or 0,
        targetlevel = mq.TLO.Target.Level() or 0,
        mepoisoned = mq.TLO.Me.CountersPoison() or 0,
        mypethp = mq.TLO.Me.Pet.PctHPs() or 0,
        mypetdistance = mq.TLO.Me.Pet.Distance() or 0,
        mypet = mq.TLO.Me.Pet.CleanName(),
        spell_rank = '',
        spell_ready = '',
        combat_true = mq.TLO.Me.Combat(),
        aggressive = mq.TLO.Target.Aggressive(),
        xtargetdistance = mq.TLO.Me.XTarget(1).Distance() or 0,
        hovering = mq.TLO.Me.Hovering()
        }
    local function ClrBurn()
        return not mq.TLO.Me.Hovering()
        and not mq.TLO.Me.Invulnerable()
        and not mq.TLO.Me.Silenced()
        and not mq.TLO.Me.Mezzed()
        and not mq.TLO.Me.Charmed()
        and not mq.TLO.Me.Feigning()
        and mq.TLO.Target.Aggressive()
        and mq.TLO.Me.XTarget() >= 1
        and clr_burn_variables.targetdistance <= 100
        and clr_burn_variables.targetdistance >= 1
        and clr_burn_variables.targethp >= defaults.STOP_BURN
        and clr_burn_variables.targethp <= defaults.START_BURN
        and mq.TLO.Target.ID() ~= 0
        and not mq.TLO.Me.Moving()
        and mq.TLO.Me.Buff('Resurrection Sickness')() == nil
    end
    local function ClrEngage()
        if Alive() and mq.TLO.Me.XTarget() ~= 0 then
            return mq.TLO.Me.XTarget(1).ID() >= 1
            and clr_burn_variables.xtargetdistance <= 50
            and clr_burn_variables.xtargetdistance >= 25
            and not mq.TLO.Navigation.Active()
        end
    end
    local function ClrAggro()
        if Alive() then
            if mq.TLO.Navigation.Active() then mq.cmd('/nav stop') end
            if mq.TLO.Target.ID() == 0 then
                mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID())
                mq.cmd('/face fast')
                if mq.TLO.Pet.ID() ~= nil then
                    mq.cmd('/pet attack')
                end
            end
        end
    end
    if mq.TLO.Me.Class.ShortName() == 'CLR' and Alive() then
        UseGear()
        if ClrEngage() then
            ClrAggro()
        end
        --Ward of Purity
        if mq.TLO.Me.AltAbilityReady('Ward of Purity')() and clr_burn_variables.myhp >= 1 and clr_burn_variables.myhp <= 99 and clr_burn_variables.mepoisoned >= 1 and not clr_burn_variables.hovering and not mq.TLO.Me.Moving() then
            mq.cmd('/target %s',mq.TLO.Me.CleanName())
            mq.delay(100)
            print(easy, ' \ag CLR Burn\aw - \ag[\atAA\ag]\ao - Ward of Purity')
            mq.cmd('/alt activate 506')
            mq.delay(490)
            if ClrEngage() then
                ClrAggro()
            end
        end
        --Radiant Cure
        if mq.TLO.Me.AltAbilityReady('Radiant Cure')() and clr_burn_variables.mepoisoned >= 1 and not clr_burn_variables.hovering then
            print(easy, ' \ag CLR Burn\aw - \ag[\atAA\ag]\ao - Radiant Cure')
            mq.cmd('/alt activate 153')
            mq.delay(490)
            if ClrEngage() then
                ClrAggro()
            end
        end
        --Purified Spirits
        if mq.TLO.Me.AltAbilityReady('Purified Spirits')() and clr_burn_variables.mepoisoned >= 1 and not clr_burn_variables.hovering then
            mq.cmdf('/target %s',mq.TLO.Me.CleanName())
            print(easy, ' \ag CLR Burn\aw - \ag[\atAA\ag]\ao - Purified Spirits')
            mq.cmd('/alt activate 626')
            mq.delay(490)
            if ClrEngage() then
                ClrAggro()
            end
        end
        if ClrBurn() then
            --AA
            --Spire of the Vicar
            if ClrBurn() and mq.TLO.Me.AltAbilityReady('Spire of the Vicar')() and mq.TLO.Me.Buff('Spire of the Vicar')() == nil then
                print(easy, ' \ag CLR Burn\aw - \ag[\atAA\ag]\ao - Spire of the Vicar')
                mq.cmd('/alt activate 1470')
                mq.delay(490)
                if ClrEngage() then
                    ClrAggro()
                end
            end
            --Silent Casting
            if mq.TLO.Me.AltAbilityReady('Silent Casting')() and clr_burn_variables.targethp >= 80 and ClrBurn() then
                print(easy, ' \ag CLR Burn\aw - \ag[\atAA\ag]\ao - Silent Casting')
                mq.cmd('/alt activate 500')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if ClrEngage() then
                   ClrAggro()
                end
            end
            --Veturika's Perserverance
            if mq.TLO.Me.AltAbilityReady('Veturika\'s Perserverance')() and clr_burn_variables.mymana <= 80 and ClrBurn() then
                print(easy, ' \ag CLR Burn\aw - \ag[\atAA\ag]\ao - Veturika\'s Perserverance')
                mq.cmd('/alt activate 798')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if ClrEngage() then
                   ClrAggro()
                end
            end
            --Celestial Hammer
            if mq.TLO.Me.AltAbilityReady('Celestial Hammer')() and clr_burn_variables.targethp >= 80 and ClrBurn() then
                print(easy, ' \ag CLR Burn\aw - \ag[\atAA\ag]\ao - Celestial Hammer')
                mq.cmd('/alt activate 391')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if ClrEngage() then
                   ClrAggro()
                end
            end
            --Celestial Rapidity
            if mq.TLO.Me.AltAbilityReady('Celestial Rapidity')() and ClrBurn() then
                print(easy, ' \ag CLR Burn\aw - \ag[\atAA\ag]\ao - Celestial Rapidity')
                mq.cmd('/alt activate 997')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if ClrEngage() then
                   ClrAggro()
                end
            end
            --Improved Twincast
            if mq.TLO.Me.AltAbilityReady('Improved Twincast')() and ClrBurn() then
                print(easy, ' \ag CLR Burn\aw - \ag[\atAA\ag]\ao - Improved Twincast')
                mq.cmd('/alt activate 515')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if ClrEngage() then
                   ClrAggro()
                end
            end
            --Flurry of Life
            if mq.TLO.Me.AltAbilityReady('Flurry of Life')() and ClrBurn() then
                print(easy, ' \ag CLR Burn\aw - \ag[\atAA\ag]\ao - Flurry of Life')
                mq.cmd('/alt activate 6488')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if ClrEngage() then
                   ClrAggro()
                end
            end
            --Beacon of Life
            if mq.TLO.Me.AltAbilityReady('Beacon of Life')() and clr_burn_variables.myhp <= 50 and ClrBurn() then
                print(easy, ' \ag CLR Burn\aw - \ag[\atAA\ag]\ao - Beacon of Life')
                mq.cmd('/alt activate 137')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if ClrEngage() then
                   ClrAggro()
                end
            end
            --Celestial Regeneration
            if mq.TLO.Me.AltAbilityReady('Celestial Regeneration')() and clr_burn_variables.myhp <= 75 and ClrBurn() then
                print(easy, ' \ag CLR Burn\aw - \ag[\atAA\ag]\ao - Celestial Regeneration')
                mq.cmd('/alt activate 38')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if ClrEngage() then
                   ClrAggro()
                end
            end
            --Battle Frenzy
            if mq.TLO.Me.AltAbilityReady('Battle Frenzy')() and clr_burn_variables.targethp >= 80 and ClrBurn() then
                print(easy, ' \ag CLR Burn\aw - \ag[\atAA\ag]\ao - Battle Frenzy')
                mq.cmd('/alt activate 735')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if ClrEngage() then
                   ClrAggro()
                end
            end
        end
    end
end

-------------------------------------------------
------------------ DRU Burn NOT DONE ---------------------
-------------------------------------------------

local DRU_BURN = function ()
    local dru_burn_variables = {
        targethp = mq.TLO.Target.PctHPs() or 0,
        targetdistance = mq.TLO.Target.Distance() or 0,
        myhp = mq.TLO.Me.PctHPs() or 0,
        maintank = mq.TLO.Group.MainTank.CleanName(),
        myendurance = mq.TLO.Me.PctEndurance(),
        xtarget = mq.TLO.Me.XTarget(),
        mymana = mq.TLO.Me.PctMana() or 0,
        maintankdistance = mq.TLO.Group.MainTank.Distance() or 0,
        targetlevel = mq.TLO.Target.Level() or 0,
        mepoisoned = mq.TLO.Me.CountersPoison() or 0,
        mypethp = mq.TLO.Me.Pet.PctHPs() or 0,
        mypetdistance = mq.TLO.Me.Pet.Distance() or 0,
        mypet = mq.TLO.Me.Pet.CleanName(),
        spell_rank = '',
        spell_ready = '',
        combat_true = mq.TLO.Me.Combat(),
        aggressive = mq.TLO.Target.Aggressive(),
        xtargetdistance = mq.TLO.Me.XTarget(1).Distance() or 0,
        hovering = mq.TLO.Me.Hovering()
        }
    local function DruBurn()
        return not mq.TLO.Me.Hovering()
        and not mq.TLO.Me.Invulnerable()
        and not mq.TLO.Me.Silenced()
        and not mq.TLO.Me.Mezzed()
        and not mq.TLO.Me.Charmed()
        and not mq.TLO.Me.Feigning()
        and mq.TLO.Target.Aggressive()
        and mq.TLO.Me.XTarget() >= 1
        and dru_burn_variables.targetdistance <= 100
        and dru_burn_variables.targetdistance >= 1
        and dru_burn_variables.targethp >= defaults.STOP_BURN
        and dru_burn_variables.targethp <= defaults.START_BURN
        and mq.TLO.Target.ID() ~= 0
        and not mq.TLO.Me.Moving()
        and mq.TLO.Me.Buff('Resurrection Sickness')() == nil
    end
    local function DruEngage()
        if Alive() and mq.TLO.Me.XTarget() ~= 0 then
            return mq.TLO.Me.XTarget(1).ID() >= 1
            and dru_burn_variables.xtargetdistance <= 50
            and dru_burn_variables.xtargetdistance >= 25
            and not mq.TLO.Navigation.Active()
        end
    end
    local function DruAggro()
        if Alive() then
            if mq.TLO.Navigation.Active() then mq.cmd('/nav stop') end
            if mq.TLO.Target.ID() == 0 then
                mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID())
                mq.cmd('/face fast')
                if mq.TLO.Pet.ID() ~= nil then
                    mq.cmd('/pet attack')
                end
            end
        end
    end
    if mq.TLO.Me.Class.ShortName() == 'DRU' and Alive() then
        UseGear()
        if DruEngage() then
            DruAggro()
        end
        --Breather
        local breather = mq.TLO.Spell('Breather').RankName()
        if mq.TLO.Me.CombatAbilityReady('Breather')() and dru_burn_variables.myendurance <= 20 and mq.TLO.Me.Song('Breather')() == nil and dru_burn_variables.xtarget == 0 and not dru_burn_variables.combat_true and not dru_burn_variables.hovering then
            print(easy, ' \agDRU Burn\aw - \ag[\atCombat Ability\ag]\ao - '..breather..'')
            mq.cmdf('/disc %s', breather)
            mq.delay(490)
            if DruEngage() then
                DruAggro()
            end
        end
        --Ancestral Aid
        if mq.TLO.Me.AltAbilityReady('Ancestral Aid')() and dru_burn_variables.myhp <= 40 and dru_burn_variables.myhp >= 1 and not dru_burn_variables.hovering then
            print(easy, ' \agDRU Burn\aw - \ag[\atAA\ag]\ao - Ancestral Aid')
            mq.cmd('/alt activate 447')
            mq.delay(490)
            if DruEngage() then
                DruAggro()
            end
        end
        if DruBurn() then
            --AA
            --Companion's Fortification
            if mq.TLO.Me.AltAbilityReady('Companion\'s Fortification')() and dru_burn_variables.mypethp >= 50 and dru_burn_variables.mypethp <= 100 and not dru_burn_variables.hovering then
                print(easy, ' \agDRU Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Fortification')
                mq.cmd('/alt activate 3707')
                mq.delay(490)
                if DruEngage() then
                    DruAggro()
                end
            end
        end
    end
end

-------------------------------------------------
---------------- War Burn -----------------------
-------------------------------------------------
local WAR_BURN = function ()
    local war_burn_variables = {
        targethp = mq.TLO.Target.PctHPs() or 0,
        targetdistance = mq.TLO.Target.Distance() or 0,
        myhp = mq.TLO.Me.PctHPs() or 0,
        maintank = mq.TLO.Group.MainTank.CleanName(),
        myendurance = mq.TLO.Me.PctEndurance(),
        xtarget = mq.TLO.Me.XTarget(),
        mymana = mq.TLO.Me.PctMana() or 0,
        maintankdistance = mq.TLO.Group.MainTank.Distance() or 0,
        targetlevel = mq.TLO.Target.Level() or 0,
        mepoisoned = mq.TLO.Me.CountersPoison() or 0,
        mypethp = mq.TLO.Me.Pet.PctHPs() or 0,
        mypetdistance = mq.TLO.Me.Pet.Distance() or 0,
        mypet = mq.TLO.Me.Pet.CleanName(),
        spell_rank = '',
        spell_ready = '',
        combat_true = mq.TLO.Me.Combat(),
        aggressive = mq.TLO.Target.Aggressive(),
        xtargetdistance = mq.TLO.Me.XTarget(1).Distance() or 0,
        hovering = mq.TLO.Me.Hovering()
        }
        local function WarBurn()
            return not mq.TLO.Me.Hovering()
            and not mq.TLO.Me.Invulnerable()
            and not mq.TLO.Me.Silenced()
            and not mq.TLO.Me.Mezzed()
            and not mq.TLO.Me.Charmed()
            and not mq.TLO.Me.Feigning()
            and mq.TLO.Target.Aggressive()
            and mq.TLO.Me.Combat()
            and mq.TLO.Me.XTarget() >= 1
            and war_burn_variables.targetdistance <= 30
            and war_burn_variables.targetdistance >= 1
            and war_burn_variables.targethp >= defaults.STOP_BURN
            and war_burn_variables.targethp <= defaults.START_BURN
            and war_burn_variables.myendurance >= 10
            and mq.TLO.Target.ID() ~= 0
            and not mq.TLO.Me.Moving()
            and mq.TLO.Me.Buff('Resurrection Sickness')() == nil
        end
        local function WarEngage()
            if Alive() and mq.TLO.Me.XTarget() ~= 0 then
                return mq.TLO.Me.XTarget(1).ID() >= 1
                and war_burn_variables.xtargetdistance <= 50
                and war_burn_variables.xtargetdistance >= 25
                and not mq.TLO.Navigation.Active()
            end
        end
        local function WarAggro()
            if Alive() then
            if mq.TLO.Navigation.Active() then mq.cmd('/nav stop') end
                if mq.TLO.Target.ID() == 0 then
                    mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID())
                    mq.cmd('/face fast')
                    mq.delay(500)
                    mq.cmd('/stick')
                    mq.cmd('/attack on')
                end
            end
        end
        if mq.TLO.Me.Class.ShortName() == 'WAR' and Alive() then
            UseGear()
            if WarEngage() then
                WarAggro()
            end
            --Autofire
            if Alive() and mq.TLO.Target.ID() ~= 0 and mq.TLO.Target.LineOfSight() ~= nil and mq.TLO.Target.Distance() ~= nil and mq.TLO.Target.Distance() >= 100 and not mq.TLO.Me.Moving() and mq.TLO.Me.XTarget() >= 1 then
                mq.cmd('/face fast')
                mq.cmd('/autofire on')
                while mq.TLO.Target.ID() ~= 0 and mq.TLO.Target.Distance() >= 100 do
                    mq.delay(10)
                end
            end
            if mq.TLO.FindItem('Huntsman\'s Ethereal Quiver')() and mq.TLO.FindItemCount('121336')() < 100 and mq.TLO.FindItem('=Huntsman\'s Ethereal Quiver').TimerReady() == 0 and mq.TLO.Me.FreeInventory() >= 3 and not mq.TLO.Me.Combat() and not mq.TLO.Me.Invis() and not mq.TLO.Me.Sitting() and Checked() and not mq.TLO.Me.Moving() and (mq.TLO.Zone.ID() ~= 344 and mq.TLO.Zone.ID() ~= 202 or saved_settings.edibles_pok_gl) then
                if mq.TLO.Me.FreeInventory() <= 7 then
                    print(easy, ' \agHuntsman\'s Ethereal Quiver: \arYou are just about out of room to summon arrows')
                end
                if mq.TLO.Cursor.ID() ~= nil then
                    print(easy, ' \agCursor Keep: \ap '..mq.TLO.Cursor.Name())
                    mq.cmd('/autoinv')
                end
                mq.cmdf("/useitem %s", 'Huntsman\'s Ethereal Quiver')
                mq.delay('1s')
                if mq.TLO.Cursor.ID() ~= nil then
                    print(easy, ' \agHuntsman\'s Ethereal Quiver Keep: \ap '..mq.TLO.Cursor.Name())
                    mq.cmd('/autoinv')
                    if mq.TLO.Cursor.ID() ~= nil then
                        print(easy, ' \agCursor Keep: \ap '..mq.TLO.Cursor.Name())
                        mq.cmd('/autoinv')
                    end
                end
            end
            if (mq.TLO.Target.ID() == 0 and mq.TLO.Me.Combat()) or (mq.TLO.Target.ID() ~= 0 and mq.TLO.Me.XTarget() == 0 and mq.TLO.Me.Combat()) then
                print('\ar[\apEasy\ar]\ay Not a valid target. Turning Attack OFF')
                mq.cmd('/attack off')
            end
            --Field Bulwark
            local field_bulwark = mq.TLO.Spell('Field Bulwark').RankName()
            if WarBurn() and mq.TLO.Me.CombatAbilityReady('Field Bulwark')() and mq.TLO.Me.Song("Field Bulwark")() == nil and mq.TLO.Me.Song("Vigorous Defense")() == nil and not war_burn_variables.hovering and war_burn_variables.myendurance >= 10 and not mq.TLO.Me.Moving() and mq.TLO.Me.Standing() then
                print(easy, ' \ag WAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..field_bulwark..'')
                mq.cmdf('/disc %s', field_bulwark)
                mq.delay(490)
            end
            --Vigorous Defense
            local vigorous_defense = mq.TLO.Spell('Vigorous Defense').RankName()
            if WarBurn() and mq.TLO.Me.CombatAbilityReady('Vigorous Defense')() and mq.TLO.Me.Song("Vigorous Defense")() == nil and not war_burn_variables.hovering and war_burn_variables.myendurance >= 10 and not mq.TLO.Me.Moving() and mq.TLO.Me.Standing() then
                print(easy, ' \ag WAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..vigorous_defense..'')
                mq.cmdf('/disc %s', vigorous_defense)
                mq.delay(490)
            end
            --Primal Defense
            local primal_defense = mq.TLO.Spell('Primal Defense').RankName()
            if WarBurn() and mq.TLO.Me.CombatAbilityReady('Primal Defense')() and not mq.TLO.Me.CombatAbilityReady('Vigorous Defense')() and mq.TLO.Me.Song("Primal Defense")() == nil and mq.TLO.Me.Song("Vigorous Defense")() == nil and not war_burn_variables.hovering and war_burn_variables.myendurance >= 10 and not mq.TLO.Me.Moving() and mq.TLO.Me.Standing() then
                print(easy, ' \ag WAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..primal_defense..'')
                mq.cmdf('/disc %s', primal_defense)
                mq.delay(490)
            end
            --Full Moon's Champion
            local full_moons_champion = mq.TLO.Spell('Full Moon\'s Champion').RankName()
            if WarBurn() and mq.TLO.Me.CombatAbilityReady('Full Moon\'s Champion')() and mq.TLO.Me.Song("Full Moon\'s Champion")() == nil and mq.TLO.Me.Song("Field Bulwark")() == nil and not war_burn_variables.hovering and war_burn_variables.myendurance >= 10 and not mq.TLO.Me.Moving() and mq.TLO.Me.Standing() then
                print(easy, ' \ag WAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..full_moons_champion..'')
                mq.cmdf('/disc %s', full_moons_champion)
                mq.delay(490)
            end
            --Champion's Aura
            local champions_aura = mq.TLO.Spell('Champion\'s Aura').RankName()
            if WarBurn() and mq.TLO.Me.CombatAbilityReady('Champion\'s Aura')() and mq.TLO.Me.Aura('Champion\'s Aura')() == nil and war_burn_variables.myendurance >= 10 and not war_burn_variables.hovering and not mq.TLO.Me.Moving() and mq.TLO.Me.Standing() then
                print(easy, ' \ag WAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..champions_aura..'')
                mq.cmdf('/disc %s', champions_aura)
                mq.delay(490)
            end
            --Breather
            local breather = mq.TLO.Spell('Breather').RankName()
            if mq.TLO.Me.CombatAbilityReady('Breather')() and war_burn_variables.myendurance <= 20 and not mq.TLO.Me.Combat() and mq.TLO.Me.Song('Breather')() == nil and war_burn_variables.xtarget == 0 and not war_burn_variables.hovering then
                print(easy, ' \ag WAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..breather..'')
                mq.cmdf('/disc %s', breather)
                mq.delay(5000)
            end
            if WarBurn() then
                --Commanding Voice
                local commanding_voice = mq.TLO.Spell('Commanding Voice').RankName()
            if mq.TLO.Me.CombatAbilityReady('Commanding Voice')() and mq.TLO.Me.Song("Commanding Voice")() == nil and not war_burn_variables.hovering and war_burn_variables.myendurance >= 10 then
                print(easy, ' \ag WAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..commanding_voice..'')
                mq.cmdf('/disc %s', commanding_voice)
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
                --Taunt
            if WarBurn() and mq.TLO.Me.AbilityReady('Taunt')() and war_burn_variables.maintank == mq.TLO.Me.CleanName() then
                print(easy, ' \ag WAR Burn\aw - \ag[\atAbility\ag]\ao - Taunt')
                mq.cmd('/doability Taunt')
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Kick
            if WarBurn() and mq.TLO.Me.AbilityReady('Kick')() and mq.TLO.Me.Inventory('14').Type() ~= 'Shield' then
                print(easy, ' \ag WAR Burn\aw - \ag[\atAbility\ag]\ao - Kick')
                mq.cmd('/doability Kick')
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Disarm
            if WarBurn() and mq.TLO.Me.AbilityReady('Disarm')() then
                print(easy, ' \ag WAR Burn\aw - \ag[\atAbility\ag]\ao - Disarm')
                mq.cmd('/doability Disarm')
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Bash
            if WarBurn() and mq.TLO.Me.AbilityReady('Bash')() and mq.TLO.Me.Inventory('14').Type() == 'Shield' then
                print(easy, ' \ag WAR Burn\aw - \ag[\atAbility\ag]\ao - Bash')
                mq.cmd('/doability Bash')
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Throat Jab
            local throat_jab = mq.TLO.Spell('Throat Jab').RankName()
            if WarBurn() and mq.TLO.Me.CombatAbilityReady('Throat Jab')() and mq.TLO.Target.Buff('Throat Jab')() == nil then
                print(easy, ' \ag WAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..throat_jab..'')
                mq.cmdf('/disc %s',throat_jab)
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Bracing Stance
            local shield_rupture = mq.TLO.Spell('Shield Rupture').RankName()
            if WarBurn() and mq.TLO.Me.CombatAbilityReady('Shield Rupture')() then
                print(easy, ' \ag WAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..shield_rupture..'')
                mq.cmdf('/disc %s',shield_rupture)
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Mortimus' Roar
            local mortimus_roar = mq.TLO.Spell('Mortimus\' Roar').RankName()
            if WarBurn() and mq.TLO.Me.CombatAbilityReady('Mortimus\' Roar')() and mq.TLO.Target.Buff('Mortimus\' Roar')() == nil then
                print(easy, ' \ag WAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..mortimus_roar..'')
                mq.cmdf('/disc %s',mortimus_roar)
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Namdrows' Roar
            local namdrows_roar = mq.TLO.Spell('Namdrows\' Roar').RankName()
            if WarBurn() and mq.TLO.Me.CombatAbilityReady('Namdrows\' Roar')() and mq.TLO.Target.Buff('Namdrows\' Roar')() == nil then
                print(easy, ' \ag WAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..namdrows_roar..'')
                mq.cmdf('/disc %s',namdrows_roar)
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Bristle Recourse
            local bristle = mq.TLO.Spell('Bristle').RankName()
            if WarBurn() and mq.TLO.Me.CombatAbilityReady('Bristle')() and mq.TLO.Me.Song('Bristle Recourse')() == nil then
                print(easy, ' \ag WAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..bristle..'')
                mq.cmdf('/disc %s',bristle)
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Phantom Aggressor
            local phantom_aggressor = mq.TLO.Spell('Phantom Aggressor').RankName()
            if WarBurn() and mq.TLO.Me.CombatAbilityReady('Phantom Aggressor')() then
                print(easy, ' \ag WAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..phantom_aggressor..'')
                mq.cmdf('/disc %s',phantom_aggressor)
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Roar of Challenge
            local roar_of_challenge = mq.TLO.Spell('Roar of Challenge').RankName()
            if WarBurn() and mq.TLO.Me.CombatAbilityReady('Roar of Challenge')() and war_burn_variables.xtarget >= 3 then
                print(easy, ' \ag WAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..roar_of_challenge..'')
                mq.cmdf('/disc %s',roar_of_challenge)
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Ecliptic Shield
            local ecliptic_shield = mq.TLO.Spell('Ecliptic Shield').RankName()
            if WarBurn() and mq.TLO.Me.CombatAbilityReady('Ecliptic Shield')() and mq.TLO.Me.Buff('Ecliptic Shielding')() == nil then
                print(easy, ' \ag WAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..ecliptic_shield..'')
                mq.cmdf('/disc %s',65000)
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Wade into Conflict Effect
            local wade_into_conflict = mq.TLO.Spell('Wade into Conflict').RankName()
            if WarBurn() and mq.TLO.Me.CombatAbilityReady('Wade into Conflict')() and mq.TLO.Me.Buff('Wade into Conflict Effect')() == nil then
                print(easy, ' \ag WAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..wade_into_conflict..'')
                mq.cmdf('/disc %s',wade_into_conflict)
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Levincrash Defense Discipline
            local levincrash_defense_discipline = mq.TLO.Spell('Levincrash Defense Discipline').RankName()
            if WarBurn() and mq.TLO.Me.CombatAbilityReady('Levincrash Defense Discipline')() and war_burn_variables.myhp <= 75 and war_burn_variables.myhp >= 1 then
                print(easy, ' \ag WAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..levincrash_defense_discipline..'')
                mq.cmdf('/disc %s', levincrash_defense_discipline)
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Unconditional Attention
            local unconditional_attention = mq.TLO.Spell('Unconditional Attention').RankName()
            if WarBurn() and mq.TLO.Me.CombatAbilityReady('Unconditional Attention')() then
                print(easy, ' \ag WAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..unconditional_attention..'')
                mq.cmdf('/disc %s', unconditional_attention)
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Perforate
            local perforate = mq.TLO.Spell('Perforate').RankName()
            if WarBurn() and mq.TLO.Me.CombatAbilityReady('Perforate')() then
                print(easy, ' \ag WAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..perforate..'')
                mq.cmdf('/disc %s', perforate)
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Penumbral Precision Effect
            local penumbral_precision = mq.TLO.Spell('Penumbral Precision').RankName()
            if WarBurn() and mq.TLO.Me.CombatAbilityReady('Penumbral Precision')() and war_burn_variables.targethp >= 50 and war_burn_variables.targethp <= 75 and mq.TLO.Me.Buff('Penumbral Expanse Effect')() == nil then
                print(easy, ' \ag WAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..penumbral_precision..'')
                mq.cmdf('/disc %s',penumbral_precision)
                mq.delay(490)
                if WarEngage() then
                if mq.TLO.Navigation.Active() then mq.cmd('/nav stop') end
                if mq.TLO.Target.ID() == 0 then
                    mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID())
                    mq.cmd('/face fast')
                    mq.delay(500)
                    mq.cmd('/stick')
                    mq.cmd('/attack on')
                end
            end
            end
            --Knuckle Break
            local knuckle_break = mq.TLO.Spell('Knuckle Break').RankName()
            if WarBurn() and mq.TLO.Me.CombatAbilityReady('Knuckle Break')() then
                print(easy, ' \ag WAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..knuckle_break..'')
                mq.cmdf('/disc %s',knuckle_break)
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Warrior's Resolve
            local warriors_resolve = mq.TLO.Spell('Warrior\'s Resolve').RankName()
            if WarBurn() and mq.TLO.Me.CombatAbilityReady('Warrior\'s Resolve')() and mq.TLO.Me.Buff('Warrior\'s Resolve')() == nil then
                print(easy, ' \ag WAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..warriors_resolve..'')
                mq.cmdf('/disc %s',warriors_resolve)
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Warrior's Aegis
            local warriors_aegis = mq.TLO.Spell('Warrior\'s Aegis').RankName()
            if WarBurn() and mq.TLO.Me.CombatAbilityReady('Warrior\'s Aegis')() and mq.TLO.Me.Buff('Warrior\'s Aegis')() == nil and mq.TLO.Me.Buff('Warrior\'s Resolve')() == nil then
                print(easy, ' \ag WAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..warriors_aegis..'')
                mq.cmdf('/disc %s',warriors_aegis)
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Distressing Shout
            local distressing_shout = mq.TLO.Spell('Distressing Shout').RankName()
            if WarBurn() and mq.TLO.Me.CombatAbilityReady('Distressing Shout')() and mq.TLO.Target.Buff('Distressing Shout Effect')() == nil then
                print(easy, ' \ag WAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..distressing_shout..'')
                mq.cmdf('/disc %s',distressing_shout)
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Twilight Shout
            local twilight_shout = mq.TLO.Spell('Twilight Shout').RankName()
            if WarBurn() and mq.TLO.Me.CombatAbilityReady('Twilight Shout')() and mq.TLO.Target.Buff('Twilight Shout Effect')() == nil and mq.TLO.Target.Buff('Distressing Shout Effect')() == nil then
                print(easy, ' \ag WAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..twilight_shout..'')
                mq.cmdf('/disc %s',twilight_shout)
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --End of the Line
            local end_of_the_line = mq.TLO.Spell('End of the Line').RankName()
            if WarBurn() and mq.TLO.Me.CombatAbilityReady('End of the Line')() and mq.TLO.Me.Song('End of the Line')() == nil then
                print(easy, ' \ag WAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..end_of_the_line..'')
                mq.cmdf('/disc %s',end_of_the_line)
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Finish the Fight
            local finish_the_fight = mq.TLO.Spell('Finish the Fight').RankName()
            if WarBurn() and mq.TLO.Me.CombatAbilityReady('Finish the Fight')() and mq.TLO.Me.Song('Finish the Fight')() == nil and mq.TLO.Me.Song('End of the Line')() == nil then
                print(easy, ' \ag WAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..finish_the_fight..'')
                mq.cmdf('/disc %s',finish_the_fight)
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Grappling Strike
            if WarBurn() and mq.TLO.Me.AltAbilityReady('Grappling Strike')() then
                print(easy, ' \ag WAR Burn\aw - \ag[\atAA\ag]\ao - Grappling Strike')
                mq.cmd('/alt activate 601')
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Projection of Fury
            if WarBurn() and mq.TLO.Me.AltAbilityReady('Projection of Fury')() then
                print(easy, ' \ag WAR Burn\aw - \ag[\atAA\ag]\ao - Projection of Fury')
                mq.cmd('/alt activate 3213')
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Rage of Rallos Zek
            if WarBurn() and mq.TLO.Me.AltAbilityReady('Rage of Rallos Zek')() and mq.TLO.Me.Song('Rage of Rallos Zek')() == nil then
                print(easy, ' \ag WAR Burn\aw - \ag[\atAA\ag]\ao - Rage of Rallos Zek')
                mq.cmd('/alt activate 131')
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Ageless Enmity
            if WarBurn() and mq.TLO.Me.AltAbilityReady('Ageless Enmity')() then
                print(easy, ' \ag WAR Burn\aw - \ag[\atAA\ag]\ao - Ageless Enmity')
                mq.cmd('/alt activate 10367')
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Blade Guardian
            if WarBurn() and mq.TLO.Me.AltAbilityReady('Blade Guardian')() and war_burn_variables.myhp <= 40 and war_burn_variables.myhp >= 1 then
                print(easy, ' \ag WAR Burn\aw - \ag[\atAA\ag]\ao - Blade Guardian')
                mq.cmd('/alt activate 967')
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Blast of Anger
            if WarBurn() and mq.TLO.Me.AltAbilityReady('Blast of Anger')() then
                print(easy, ' \ag WAR Burn\aw - \ag[\atAA\ag]\ao - Blast of Anger')
                mq.cmd('/alt activate 3646')
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Areat Taunt
            if WarBurn() and mq.TLO.Me.AltAbilityReady('Area Taunt')() and not mq.TLO.Me.Moving() and war_burn_variables.xtarget >= 2 then
                print(easy, ' \ag WAR Burn\aw - \ag[\atAA\ag]\ao - Area Taunt')
                mq.cmd('/alt activate 110')
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Brace for Impact
            if WarBurn() and mq.TLO.Me.AltAbilityReady('Brace for Impact')() and war_burn_variables.myhp <= 30 and war_burn_variables.myhp >= 1 then
                print(easy, ' \ag WAR Burn\aw - \ag[\atAA\ag]\ao - Brace for Impact')
                mq.cmd('/alt activate 1686')
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Call of Challenge
            if WarBurn() and mq.TLO.Me.AltAbilityReady('Call of Challenge')() and war_burn_variables.targethp >= 2 and war_burn_variables.targethp <= 10 and mq.TLO.Target.Buff('Call of Challenge')() == nil then
                print(easy, ' \ag WAR Burn\aw - \ag[\atAA\ag]\ao - Call of Challenge')
                mq.cmd('/alt activate 552')
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Gut Punch
            if WarBurn() and mq.TLO.Me.AltAbilityReady('Gut Punch')() and mq.TLO.Target.Buff('Gut Punch')() == nil then
                print(easy, ' \ag WAR Burn\aw - \ag[\atAA\ag]\ao - Gut Punch')
                mq.cmd('/alt activate 3732')
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Imperator's Command
            if WarBurn() and mq.TLO.Me.AltAbilityReady('Imperator\'s Command')() then
                print(easy, ' \ag WAR Burn\aw - \ag[\atAA\ag]\ao - Imperator\'s Command')
                mq.cmd('/alt activate 2011')
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Knee Strike
            if WarBurn() and mq.TLO.Me.AltAbilityReady('Knee Strike')() and mq.TLO.Target.Buff('Knee Strike')() == nil then
                print(easy, ' \ag WAR Burn\aw - \ag[\atAA\ag]\ao - Knee Strike')
                mq.cmd('/alt activate 801')
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Mark of the Mage Hunter
            if WarBurn() and mq.TLO.Me.AltAbilityReady('Mark of the Mage Hunter')() and war_burn_variables.myhp <= 50 and war_burn_variables.myhp >= 1 then
                print(easy, ' \ag WAR Burn\aw - \ag[\atAA\ag]\ao - Mark of the Mage Hunter')
                mq.cmd('/alt activate 606')
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Vehement Rage
            if WarBurn() and mq.TLO.Me.AltAbilityReady('Vehement Rage')() then
                print(easy, ' \ag WAR Burn\aw - \ag[\atAA\ag]\ao - Vehement Rage')
                mq.cmd('/alt activate 800')
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Press the Attack
            if WarBurn() and mq.TLO.Me.AltAbilityReady('Press the Attack')() then
                print(easy, ' \ag WAR Burn\aw - \ag[\atAA\ag]\ao - Press the Attack')
                mq.cmd('/alt activate 467')
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Respendent Glory
            if WarBurn() and mq.TLO.Me.AltAbilityReady('Resplendent Glory')() and war_burn_variables.myhp <= 50 and war_burn_variables.myhp >= 1 then
                print(easy, ' \ag WAR Burn\aw - \ag[\atAA\ag]\ao - Resplendent Glory')
                mq.cmd('/alt activate 130')
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Spire of the Warlord
            if WarBurn() and mq.TLO.Me.AltAbilityReady('Spire of the Warlord')() and mq.TLO.Me.Buff('Spire of the Warlord')() == nil then
                print(easy, ' \ag WAR Burn\aw - \ag[\atAA\ag]\ao - Spire of the Warlord')
                mq.cmd('/alt activate 1400')
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --War Cry
            if WarBurn() and mq.TLO.Me.AltAbilityReady('War Cry')() then
                print(easy, ' \ag WAR Burn\aw - \ag[\atAA\ag]\ao - War Cry')
                mq.cmd('/alt activate 111')
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Warlord's Bravery
            if WarBurn() and mq.TLO.Me.AltAbilityReady('Warlord\'s Bravery')() and war_burn_variables.myhp <= 40 and war_burn_variables.myhp >= 1 then
                print(easy, ' \ag WAR Burn\aw - \ag[\atAA\ag]\ao - Warlord\'s Bravery')
                mq.cmd('/alt activate 804')
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Warlord's Fury
            if WarBurn() and mq.TLO.Me.AltAbilityReady('Warlord\'s Fury')() and mq.TLO.Target.Buff('Warlord\'s Fury')() == nil then
                print(easy, ' \ag WAR Burn\aw - \ag[\atAA\ag]\ao - Warlord\'s Fury')
                mq.cmd('/alt activate 688')
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Warlord's Grasp
            if WarBurn() and mq.TLO.Me.AltAbilityReady('Warlord\'s Grasp')() and mq.TLO.Target.Buff('Warlord\'s Grasp')() == nil then
                print(easy, ' \ag WAR Burn\aw - \ag[\atAA\ag]\ao - Warlord\'s Grasp')
                mq.cmd('/alt activate 2002')
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Warlord's Resurgence
            if WarBurn() and mq.TLO.Me.AltAbilityReady('Warlord\'s Resurgence')() and war_burn_variables.myhp <= 30 and war_burn_variables.myhp >= 1 then
                print(easy, ' \ag WAR Burn\aw - \ag[\atAA\ag]\ao - Warlord\'s Resurgence')
                mq.cmd('/alt activate 911')
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Warlord's Tenacity
            if WarBurn() and mq.TLO.Me.AltAbilityReady('Warlord\'s Tenacity')() and war_burn_variables.myhp <= 25 and war_burn_variables.myhp >= 1 then
                print(easy, ' \ag WAR Burn\aw - \ag[\atAA\ag]\ao - Warlord\'s Tenacity')
                mq.cmd('/alt activate 300')
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
            --Wars Sheol's Heroic Blade
            if WarBurn() and mq.TLO.Me.AltAbilityReady('Wars Sheol\'s Heroic Blade')() then
                print(easy, ' \ag WAR Burn\aw - \ag[\atAA\ag]\ao - Wars Sheol\'s Heroic Blade')
                mq.cmd('/alt activate 2007')
                mq.delay(490)
                if WarEngage() then
                    WarAggro()
                end
            end
        end
    end
end
-------------------------------------------------
---------------- BRD Burn -----------------------
-------------------------------------------------
local BRD_BURN = function ()
    local brd_burn_variables = {
        targethp = mq.TLO.Target.PctHPs() or 0,
        targetdistance = mq.TLO.Target.Distance() or 0,
        myhp = mq.TLO.Me.PctHPs() or 0,
        maintank = mq.TLO.Group.MainTank.CleanName(),
        myendurance = mq.TLO.Me.PctEndurance(),
        xtarget = mq.TLO.Me.XTarget(),
        mymana = mq.TLO.Me.PctMana() or 0,
        maintankdistance = mq.TLO.Group.MainTank.Distance() or 0,
        targetlevel = mq.TLO.Target.Level() or 0,
        mepoisoned = mq.TLO.Me.CountersPoison() or 0,
        mypethp = mq.TLO.Me.Pet.PctHPs() or 0,
        mypetdistance = mq.TLO.Me.Pet.Distance() or 0,
        mypet = mq.TLO.Me.Pet.CleanName(),
        spell_rank = '',
        spell_ready = '',
        combat_true = mq.TLO.Me.Combat(),
        aggressive = mq.TLO.Target.Aggressive(),
        xtargetdistance = mq.TLO.Me.XTarget(1).Distance() or 0,
        hovering = mq.TLO.Me.Hovering()
        }
        local function BrdBurn()
            return not mq.TLO.Me.Hovering()
            and not mq.TLO.Me.Invulnerable()
            and not mq.TLO.Me.Silenced()
            and not mq.TLO.Me.Mezzed()
            and not mq.TLO.Me.Charmed()
            and not mq.TLO.Me.Feigning()
            and mq.TLO.Target.Aggressive()
            and mq.TLO.Me.Combat()
            and mq.TLO.Me.XTarget() >= 1
            and brd_burn_variables.targetdistance <= 30
            and brd_burn_variables.targetdistance >= 1
            and brd_burn_variables.targethp >= defaults.STOP_BURN
            and brd_burn_variables.targethp <= defaults.START_BURN
            and mq.TLO.Target.ID() ~= 0
            and mq.TLO.Me.Buff('Resurrection Sickness')() == nil
        end
        local function BrdEngage()
            if Alive() and mq.TLO.Me.XTarget() ~= 0 then
                return mq.TLO.Me.XTarget(1).ID() >= 1
                and brd_burn_variables.xtargetdistance <= 50
                and brd_burn_variables.xtargetdistance >= 25
                and not mq.TLO.Navigation.Active()
            end
        end
        local function BrdAggro()
            if Alive() then
                if mq.TLO.Navigation.Active() then mq.cmd('/nav stop') end
                if mq.TLO.Target.ID() == 0 then
                    mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID())
                    mq.cmd('/face fast')
                    mq.delay(500)
                    mq.cmd('/stick')
                    mq.cmd('/attack on')
                end
            end
        end
        if mq.TLO.Me.Class.ShortName() == 'BRD' and Alive() then
            UseGear()
            if BrdEngage() then
                BrdAggro()
            end
            if (mq.TLO.Target.ID() == 0 and mq.TLO.Me.Combat()) or (mq.TLO.Target.ID() ~= 0 and mq.TLO.Me.XTarget() == 0 and mq.TLO.Me.Combat()) then
                print('\ar[\apEasy\ar]\ay Not a valid target. Turning Attack OFF')
                mq.cmd('/attack off')
            end
            if BrdBurn() then
            --Intimidation
            if mq.TLO.Me.AbilityReady('Intimidation')() and BrdBurn() then
                print(easy, ' \ag BRD Burn\aw - \ag[\atAbility\ag]\ao - Intimidation')
                mq.cmd('/doability Intimidation')
                mq.delay(490)
                if BrdEngage() then
                    BrdAggro()
                end
            end
            --Kick
            if BrdBurn() and mq.TLO.Me.AbilityReady('Kick')() then
                print(easy, ' \ag BRD Burn\aw - \ag[\atAbility\ag]\ao - Kick')
                mq.cmd('/doability Kick')
                mq.delay(490)
                if BrdEngage() then
                    BrdAggro()
                end
            end
            --Combat Abilities
            --Reflexive Rebuttal
            local reflexive_rebuttal = mq.TLO.Spell('Reflexive Rebuttal').RankName()
            if BrdBurn() and mq.TLO.Me.CombatAbilityReady('Reflexive Rebuttal')()and mq.TLO.Me.ActiveDisc() == nil then
                print(easy, ' \ag BRD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..reflexive_rebuttal..'')
                mq.cmdf('/disc %s', reflexive_rebuttal)
                mq.delay(490)
                if BrdEngage() then
                    BrdAggro()
                end
            end
            --Thousand Blades
            local thousand_blades = mq.TLO.Spell('Thousand Blades').RankName()
            if BrdBurn() and mq.TLO.Me.CombatAbilityReady('Thousand Blades')() then
                mq.cmd('/stopdisc')
                mq.delay(100)
                print(easy, ' \ag BRD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..thousand_blades..'')
                mq.cmdf('/disc %s', thousand_blades)
                mq.delay(490)
                if BrdEngage() then
                    BrdAggro()
                end
            end
            --Deftdance Discipline
            local deftdance_discipline = mq.TLO.Spell('Deftdance Discipline').RankName()
            if BrdBurn() and mq.TLO.Me.CombatAbilityReady('Deftdance Discipline')() and brd_burn_variables.myhp <= 75 and brd_burn_variables.myhp >= 1 then
                mq.cmd('/stopdisc')
                mq.delay(100)
                print(easy, ' \ag BRD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..deftdance_discipline..'')
                mq.cmdf('/disc %s', deftdance_discipline)
                mq.delay(490)
                if BrdEngage() then
                    BrdAggro()
                end
            end
            --Resistant Discipline
            local resistant_discipline = mq.TLO.Spell('Resistant Discipline').RankName()
            if BrdBurn() and mq.TLO.Me.CombatAbilityReady('Resistant Discipline')() and mq.TLO.Me.ActiveDisc() == nil then
                print(easy, ' \ag BRD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..resistant_discipline..'')
                mq.cmdf('/disc %s', resistant_discipline)
                mq.delay(490)
                if BrdEngage() then
                    BrdAggro()
                end
            end
            --Puretone Discipline
            local puretone_discipline = mq.TLO.Spell('Puretone Discipline').RankName()
            if BrdBurn() and mq.TLO.Me.CombatAbilityReady('Puretone Discipline')() and mq.TLO.Me.ActiveDisc() == nil then
                print(easy, ' \ag BRD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..puretone_discipline..'')
                mq.cmdf('/disc %s', puretone_discipline)
                mq.delay(490)
                if BrdEngage() then
                    BrdAggro()
                end
            end
            --AA
            --Bladed Song
            if BrdBurn() and mq.TLO.Me.AltAbilityReady('Bladed Song')() and mq.TLO.Target.Buff('Bladed Song')() == nil then
                print(easy, ' \ag BRD Burn\aw - \ag[\atAA\ag]\ao - Bladed Song')
                mq.cmd('/alt activate 669')
                mq.delay(490)
                if BrdEngage() then
                    BrdAggro()
                end
            end
            --Boastful Bellow
            if BrdBurn() and mq.TLO.Me.AltAbilityReady('Boastful Bellow')() and mq.TLO.Target.Buff('Boastful Bellow')() == nil and brd_burn_variables.myhp <= 20 and brd_burn_variables.myhp >= 1 then
                print(easy, ' \ag BRD Burn\aw - \ag[\atAA\ag]\ao - Boastful Bellow')
                mq.cmd('/alt activate 199')
                mq.delay(490)
                if BrdEngage() then
                    BrdAggro()
                end
            end
            --Cacophony
            if BrdBurn() and mq.TLO.Me.AltAbilityReady('Cacophony')() and mq.TLO.Target.Buff('Cacophony')() == nil then
                print(easy, ' \ag BRD Burn\aw - \ag[\atAA\ag]\ao - Cacophony')
                mq.cmd('/alt activate 553')
                mq.delay(490)
                if BrdEngage() then
                    BrdAggro()
                end
            end
            --Dance of Blades
            if BrdBurn() and mq.TLO.Me.AltAbilityReady('Dance of Blades')() and mq.TLO.Me.Song('Dance of Blades')() == nil then
                print(easy, ' \ag BRD Burn\aw - \ag[\atAA\ag]\ao - Dance of Blades')
                mq.cmd('/alt activate 359')
                mq.delay(490)
                if BrdEngage() then
                    BrdAggro()
                end
            end
            --Fierce Eye
            if BrdBurn() and mq.TLO.Me.AltAbilityReady('Fierce Eye')() and mq.TLO.Me.Song('Fierce Eye')() == nil and mq.TLO.Me.GroupSize() > 2 then
                print(easy, ' \ag BRD Burn\aw - \ag[\atAA\ag]\ao - Fierce Eye')
                mq.cmd('/alt activate 3506')
                mq.delay(490)
                if BrdEngage() then
                    BrdAggro()
                end
            end
            --Flurry of Notes
            if BrdBurn() and mq.TLO.Me.AltAbilityReady('Flurry of Notes')() and mq.TLO.Me.Buff('Flurry of Notes')() == nil then
                print(easy, ' \ag BRD Burn\aw - \ag[\atAA\ag]\ao - Flurry of Notes')
                mq.cmd('/alt activate 899')
                mq.delay(490)
                if BrdEngage() then
                    BrdAggro()
                end
            end
            --Frenzied Kicks
            if BrdBurn() and mq.TLO.Me.AltAbilityReady('Frenzied Kicks')() and mq.TLO.Me.Song('Frenzied Kicks')() == nil then
                print(easy, ' \ag BRD Burn\aw - \ag[\atAA\ag]\ao - Frenzied Kicks')
                mq.cmd('/alt activate 910')
                mq.delay(490)
                if BrdEngage() then
                    BrdAggro()
                end
            end
            --Funeral Dirge
            if BrdBurn() and mq.TLO.Me.AltAbilityReady('Funeral Dirge')() and mq.TLO.Target.Buff('Funeral Dirge')() == nil then
                print(easy, ' \ag BRD Burn\aw - \ag[\atAA\ag]\ao - Funeral Dirge')
                mq.cmd('/alt activate 777')
                mq.delay(490)
                if BrdEngage() then
                    BrdAggro()
                end
            end
            --Hymn of the Last Stand
            if BrdBurn() and mq.TLO.Me.AltAbilityReady('Hymn of the Last Stand')() and mq.TLO.Me.Buff('Hymn of the Last Stand')() == nil then
                print(easy, ' \ag BRD Burn\aw - \ag[\atAA\ag]\ao - Hymn of the Last Stand')
                mq.cmd('/alt activate 668')
                mq.delay(490)
                if BrdEngage() then
                    BrdAggro()
                end
            end
            --Lyrical Prankster
            if BrdBurn() and mq.TLO.Me.AltAbilityReady('Lyrical Prankster')() and brd_burn_variables.targethp >= 80 and brd_burn_variables.targethp <= 99 then
                print(easy, ' \ag BRD Burn\aw - \ag[\atAA\ag]\ao - Lyrical Prankster')
                mq.cmd('/alt activate 8204')
                mq.delay(490)
                if BrdEngage() then
                    BrdAggro()
                end
            end
            --Quick Time
            if BrdBurn() and mq.TLO.Me.AltAbilityReady('Quick Time')() and mq.TLO.Me.Song('Quick Time')() == nil then
                print(easy, ' \ag BRD Burn\aw - \ag[\atAA\ag]\ao - Quick Time')
                mq.cmd('/alt activate 3702')
                mq.delay(490)
                if BrdEngage() then
                    BrdAggro()
                end
            end
            --Rallying Solo
            if BrdBurn() and mq.TLO.Me.AltAbilityReady('Rallying Solo')() and (brd_burn_variables.myendurance <= 30 or brd_burn_variables.mymana <= 30) then
                print(easy, ' \ag BRD Burn\aw - \ag[\atAA\ag]\ao - Rallying Solo')
                mq.cmd('/alt activate 1136')
                mq.delay(490)
                if BrdEngage() then
                    BrdAggro()
                end
            end
            --Shield of Notes
            if BrdBurn() and mq.TLO.Me.AltAbilityReady('Shield of Notes')() and mq.TLO.Me.Song('Shield of Notes')() == nil and brd_burn_variables.myhp <= 50 and brd_burn_variables.myhp >= 1 then
                print(easy, ' \ag BRD Burn\aw - \ag[\atAA\ag]\ao - Shield of Notes')
                mq.cmd('/alt activate 361')
                mq.delay(490)
                if BrdEngage() then
                    BrdAggro()
                end
            end
            --Silent Displacement
            if BrdBurn() and mq.TLO.Me.AltAbilityReady('Silent Displacement')() and brd_burn_variables.myhp <= 20 and brd_burn_variables.myhp >= 1 then
                print(easy, ' \ag BRD Burn\aw - \ag[\atAA\ag]\ao - Silent Displacement')
                mq.cmd('/alt activate 1178')
                mq.delay(490)
                if BrdEngage() then
                    BrdAggro()
                end
            end
            --Song of Stone
            if BrdBurn() and mq.TLO.Me.AltAbilityReady('Song of Stone')() and brd_burn_variables.targethp >= 80 and brd_burn_variables.targethp <= 99 then
                print(easy, ' \ag BRD Burn\aw - \ag[\atAA\ag]\ao - Song of Stone')
                mq.cmd('/alt activate 544')
                mq.delay(490)
                if BrdEngage() then
                    BrdAggro()
                end
            end
            --Spire of the Minstrels
            if BrdBurn() and mq.TLO.Me.AltAbilityReady('Spire of the Minstrels')() and mq.TLO.Me.Song('Spire of the Minstrels')() == nil then
                print(easy, ' \ag BRD Burn\aw - \ag[\atAA\ag]\ao - Spire of the Minstrels')
                mq.cmd('/alt activate 1420')
                mq.delay(490)
                if BrdEngage() then
                    BrdAggro()
                end
            end
            --Armor of Experience
            if BrdBurn() and mq.TLO.Me.AltAbilityReady('Armor of Experience')() and brd_burn_variables.myhp <= 20 and brd_burn_variables.myhp >= 1 then
                print(easy, ' \ag BRD Burn\aw - \ag[\atAA\ag]\ao - Armor of Experience')
                mq.cmd('/alt activate 2000')
                mq.delay(490)
                if BrdEngage() then
                    BrdAggro()
                end
            end
            --Fading Memories
            if BrdBurn() and mq.TLO.Me.AltAbilityReady('Fading Memories')() and brd_burn_variables.myhp <= 10 and brd_burn_variables.myhp >= 1 and mq.TLO.Target.Level() <= 123 then
                print(easy, ' \ag BRD Burn\aw - \ag[\atAA\ag]\ao - Fading Memories')
                mq.cmd('/alt activate 212')
                print(easy, ' \ag BRD Burn\aw - \ag[\atAA\ag]\ao - Dirge of the Sleepwalker')
                mq.cmd('/alt activate 3701')
                mq.delay(490)
                if BrdEngage() then
                    BrdAggro()
                end
            end
        end
    end
end

-------------------------------------------------
---------------- SHD Burn -----------------------
-------------------------------------------------
local SHD_BURN = function ()
    local shd_burn_variables = {
        targethp = mq.TLO.Target.PctHPs() or 0,
        targetdistance = mq.TLO.Target.Distance() or 0,
        myhp = mq.TLO.Me.PctHPs() or 0,
        maintank = mq.TLO.Group.MainTank.CleanName(),
        myendurance = mq.TLO.Me.PctEndurance(),
        xtarget = mq.TLO.Me.XTarget(),
        mymana = mq.TLO.Me.PctMana() or 0,
        maintankdistance = mq.TLO.Group.MainTank.Distance() or 0,
        targetlevel = mq.TLO.Target.Level() or 0,
        mepoisoned = mq.TLO.Me.CountersPoison() or 0,
        mypethp = mq.TLO.Me.Pet.PctHPs() or 0,
        mypetdistance = mq.TLO.Me.Pet.Distance() or 0,
        mypet = mq.TLO.Me.Pet.CleanName(),
        spell_rank = '',
        spell_ready = '',
        combat_true = mq.TLO.Me.Combat(),
        aggressive = mq.TLO.Target.Aggressive(),
        xtargetdistance = mq.TLO.Me.XTarget(1).Distance() or 0,
        hovering = mq.TLO.Me.Hovering()
        }
    local function ShdBurn()
        return not mq.TLO.Me.Hovering()
        and not mq.TLO.Me.Invulnerable()
        and not mq.TLO.Me.Silenced()
        and not mq.TLO.Me.Mezzed()
        and not mq.TLO.Me.Charmed()
        and not mq.TLO.Me.Feigning()
        and mq.TLO.Target.Aggressive()
        and mq.TLO.Me.Combat()
        and mq.TLO.Me.XTarget() >= 1
        and shd_burn_variables.targetdistance <= 30
        and shd_burn_variables.targetdistance >= 1
        and shd_burn_variables.targethp >= defaults.STOP_BURN
        and shd_burn_variables.targethp <= defaults.START_BURN
        and mq.TLO.Target.ID() ~= 0
        and not mq.TLO.Me.Moving()
        and mq.TLO.Me.Buff('Resurrection Sickness')() == nil
    end
    local function ShdEngage()
        if Alive() and mq.TLO.Me.XTarget() ~= 0 then
            return mq.TLO.Me.XTarget(1).ID() >= 1
            and shd_burn_variables.xtargetdistance <= 50
            and shd_burn_variables.xtargetdistance >= 25
            and not mq.TLO.Navigation.Active()
        end
    end
    local function ShdAggro()
        if Alive() then
        if mq.TLO.Navigation.Active() then mq.cmd('/nav stop') end
        if mq.TLO.Target.ID() == 0 then
            mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID())
            mq.cmd('/face fast')
            mq.delay(500)
            mq.cmd('/stick')
            mq.cmd('/attack on')
        end
        end
    end
    if mq.TLO.Me.Class.ShortName() == 'SHD' and Alive() then
        UseGear()
        if ShdEngage() then
            ShdAggro()
        end
        if (mq.TLO.Target.ID() == 0 and mq.TLO.Me.Combat()) or (mq.TLO.Target.ID() ~= 0 and mq.TLO.Me.XTarget() == 0 and mq.TLO.Me.Combat()) then
            print('\ar[\apEasy\ar]\ay Not a valid target. Turning Attack OFF')
            mq.cmd('/attack off')
        end
        
        --Breather
        local breather = mq.TLO.Spell('Breather').RankName()
        if mq.TLO.Me.CombatAbilityReady('Breather')() and shd_burn_variables.myendurance <= 20 and not mq.TLO.Me.Combat() and mq.TLO.Me.Song('Breather')() == nil and shd_burn_variables.xtarget == 0 and not shd_burn_variables.hovering then
            print(easy, ' \ag SHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..breather..'')
            mq.cmdf('/disc %s', breather)
            mq.delay(490)
        end
        --Dark Lord's Unity (Beza)
        if mq.TLO.Me.AltAbilityReady('Dark Lord\'s Unity (Beza)')() and shd_burn_variables.myendurance >= 20 and mq.TLO.Me.Buff('Drape of the Akheva')() == nil and not shd_burn_variables.hovering and not mq.TLO.Me.Moving() then
            print(easy, ' \ag SHD Burn\aw - \ag[\atAA\ag]\ao - Dark Lord\'s Unity (Beza)')
            mq.cmd('/alt activate 1164')
            mq.delay(490)
            if ShdEngage() then
                ShdAggro()
            end
        end
        --Voice of Thule (MainTank)
        if mq.TLO.Me.AltAbilityReady('Voice of Thule')() and mq.TLO.Group.MainTank.Buff('Voice of Thule')() == nil and shd_burn_variables.maintankdistance <= 100 and shd_burn_variables.maintankdistance >= 1 and shd_burn_variables.maintank ~= nil and shd_burn_variables.xtarget == 0 and not shd_burn_variables.hovering and not mq.TLO.Me.Moving() then
            mq.cmdf('/target id %s', mq.TLO.Group.MainTank.ID())
            if mq.TLO.Group.MainTank.Buff('Voice of Thule')() then mq.delay('1s') return end
            mq.cmdf('/target id %s', mq.TLO.Group.MainTank.ID())
            mq.delay(50)
            printf(easy, ' \ag SHD Burn\aw - \ag[\atAA\ag]\ao - Voice of Thule on', shd_burn_variables.maintank)
            mq.cmd('/alt activate 7000')
            mq.delay(490)
            if ShdEngage() then
                ShdAggro()
            end
        end
        --Voice of Thule
        if mq.TLO.Me.AltAbilityReady('Voice of Thule')() and mq.TLO.Me.Buff('Voice of Thule')() == nil and shd_burn_variables.maintank == mq.TLO.Me.CleanName() and shd_burn_variables.xtarget == 0 and not shd_burn_variables.hovering and not mq.TLO.Me.Moving() then
            mq.cmdf('/target id %s', mq.TLO.Me.ID())
            mq.delay(50)
            print(easy, ' \ag SHD Burn\aw - \ag[\atAA\ag]\ao - Voice of Thule')
            mq.cmd('/alt activate 7000')
            mq.delay(490)
            if ShdEngage() then
                ShdAggro()
            end
        end
        --Abilities
        if ShdBurn() then
            --Taunt
            if mq.TLO.Me.AbilityReady('Taunt')() and shd_burn_variables.maintank == mq.TLO.Me.CleanName() and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atAbility\ag]\ao - Taunt')
                mq.cmd('/doability Taunt')
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Disarm
            if mq.TLO.Me.AbilityReady('Disarm')() and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atAbility\ag]\ao - Disarm')
                mq.cmd('/doability Disarm')
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Bash
            if mq.TLO.Me.AbilityReady('Bash')() and mq.TLO.Me.Inventory('14').Type() == 'Shield' and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atAbility\ag]\ao - Bash')
                mq.cmd('/doability Bash')
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Combat Abilities
            --Reflexive Resentment
            local reflexive_resentment = mq.TLO.Spell('Reflexive Resentment').RankName()
            if mq.TLO.Me.CombatAbilityReady('Reflexive Resentment')() and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..reflexive_resentment..'')
                mq.cmdf('/disc %s', reflexive_resentment)
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Corrupted Guardian
            local corrupted_guardian = mq.TLO.Spell('Corrupted Guardian').RankName()
            if mq.TLO.Me.CombatAbilityReady('Corrupted Guardian')() and mq.TLO.Me.Song('Corrupted Guardian Effect')() == nil and shd_burn_variables.myhp <= 40 and shd_burn_variables.myhp >= 1 and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..corrupted_guardian..'')
                mq.cmdf('/disc %s', corrupted_guardian)
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Repudiate
            local repudiate = mq.TLO.Spell('Repudiate').RankName()
            if mq.TLO.Me.CombatAbilityReady('Repudiate')() and mq.TLO.Me.Buff('Repudiate')() == nil and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..repudiate..'')
                mq.cmdf('/disc %s', repudiate)
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Spite of Mirenilla
            local spite_of_mirenilla = mq.TLO.Spell('Spite of Mirenilla').RankName()
            if mq.TLO.Me.CombatAbilityReady('Spite of Mirenilla')() and mq.TLO.Me.Song('Spite of Mirenilla Recourse')() == nil and mq.TLO.Me.ActiveDisc.ID() == nil and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..spite_of_mirenilla..'')
                mq.cmdf('/disc %s', spite_of_mirenilla)
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Xetheg's Carapace
            local xethegs_carapace = mq.TLO.Spell('Xetheg\'s Carapace').RankName()
            if mq.TLO.Me.CombatAbilityReady('Xetheg\'s Carapace')() and mq.TLO.Me.ActiveDisc.ID() == nil and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..xethegs_carapace..'')
                mq.cmdf('/disc %s', xethegs_carapace)
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Sanguine Blade
            local sanguine_blade = mq.TLO.Spell('Sanguine Blade').RankName()
            if mq.TLO.Me.CombatAbilityReady('Sanguine Blade')() and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..sanguine_blade..'')
                mq.cmdf('/disc %s', sanguine_blade)
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Grisly Blade
            local grisly_blade = mq.TLO.Spell('Grisly Blade').RankName()
            if mq.TLO.Me.CombatAbilityReady('Grisly Blade')() and shd_burn_variables.myendurance >= 20 and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..grisly_blade..'')
                mq.cmdf('/disc %s', grisly_blade)
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Wounding Blade
            local wounding_blade = mq.TLO.Spell('Wounding Blade').RankName()
            if mq.TLO.Me.CombatAbilityReady('Wounding Blade')() and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..wounding_blade..'')
                mq.cmdf('/disc %s', wounding_blade)
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Terminal Breath
            local terminal_breath = mq.TLO.Spell('Terminal Breath').RankName()
            if mq.TLO.Me.CombatAbilityReady('Terminal Breath')() and shd_burn_variables.myhp <= 10 and shd_burn_variables.myhp >= 1 and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..terminal_breath..'')
                mq.cmdf('/disc %s', terminal_breath)
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Unrelenting Acrimony
            local unrelenting_acrimony = mq.TLO.Spell('Unrelenting Acrimony').RankName()
            if mq.TLO.Me.CombatAbilityReady('Unrelenting Acrimony')() and shd_burn_variables.maintank == mq.TLO.Me.CleanName() and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..unrelenting_acrimony..'')
                mq.cmdf('/disc %s', unrelenting_acrimony)
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Fyrthek Mantle
            local fyrthek_mantle = mq.TLO.Spell('Fyrthek Mantle').RankName()
            if mq.TLO.Me.CombatAbilityReady('Fyrthek Mantle')() and shd_burn_variables.myhp <= 50 and shd_burn_variables.myhp >= 1 and ShdBurn() then
                mq.cmd('/stopdisc')
                mq.delay(50)
                print(easy, ' \ag SHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..fyrthek_mantle..'')
                mq.cmdf('/disc %s', fyrthek_mantle)
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Deflection Discipline
            local deflection_discipline = mq.TLO.Spell('Deflection Discipline').RankName()
            if mq.TLO.Me.CombatAbilityReady('Deflection Discipline')() and shd_burn_variables.myhp <= 30 and shd_burn_variables.myhp >= 1 and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..deflection_discipline..'')
                mq.cmdf('/disc %s', deflection_discipline)
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Leechcurse Discipline
            local leechcurse_discipline = mq.TLO.Spell('Leechcurse Discipline').RankName()
            if mq.TLO.Me.CombatAbilityReady('Leechcurse Discipline')() and shd_burn_variables.myhp <= 10 and shd_burn_variables.myhp >= 1 and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..leechcurse_discipline..'')
                mq.cmdf('/disc %s', leechcurse_discipline)
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Unholy Aura Discipline
            local unholy_aura_discipline = mq.TLO.Spell('Unholy Aura Discipline').RankName()
            if mq.TLO.Me.CombatAbilityReady('Unholy Aura Discipline')() and mq.TLO.Me.ActiveDisc.ID() == nil and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..unholy_aura_discipline..'')
                mq.cmdf('/disc %s', unholy_aura_discipline)
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Rigor Mortis
            local rigor_mortis = mq.TLO.Spell('Rigor Mortis').RankName()
            if mq.TLO.Me.CombatAbilityReady('Rigor Mortis')() and shd_burn_variables.myhp <= 5 and shd_burn_variables.myhp >= 1 and not mq.TLO.Me.Feigning() and shd_burn_variables.aggressive == true and shd_burn_variables.combat_true
                or mq.TLO.Me.CombatAbilityReady('Rigor Mortis')() and shd_burn_variables.maintank ~= mq.TLO.Me.CleanName() and mq.TLO.Me.PctAggro() >= 90 and not mq.TLO.Me.Feigning() and ShdBurn() then
                    print(easy, ' \ag SHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..rigor_mortis..'')
                    mq.cmdf('/disc %s', rigor_mortis)
                    mq.delay('1s')
                if shd_burn_variables.myhp >= 20 and shd_burn_variables.myhp <= 100 and shd_burn_variables.maintank ~= mq.TLO.Me.CleanName() and ShdBurn() then
                    if mq.TLO.Navigation.Active() then mq.cmd('/nav stop') end
                    mq.cmd('/stand')
                    print(easy, ' \ag SHD Burn\aw - Standing Up')
                    mq.delay(50)
                    mq.cmd('/attack on')
                    print(easy, ' \ag SHD Burn\aw - Resume Attack')
                end
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --AA
            --Ageless Enmity
            if mq.TLO.Me.AltAbilityReady('Ageless Enmity')() and shd_burn_variables.maintank == mq.TLO.Me.CleanName() and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atAA\ag]\ao - Agless Enmity')
                mq.cmd('/alt activate 10392')
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Death Peace
            if mq.TLO.Me.AltAbilityReady('Death Peace')() and shd_burn_variables.maintank ~= mq.TLO.Me.CleanName() and shd_burn_variables.myhp <= 5 and shd_burn_variables.myhp >= 1 and not mq.TLO.Me.Feigning() and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atAA\ag]\ao - Death Peace')
                mq.cmd('/alt activate 428')
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Death's Effigy
            if mq.TLO.Me.AltAbilityReady('Death\'s Effigy')() and shd_burn_variables.maintank ~= mq.TLO.Me.CleanName() and shd_burn_variables.myhp <= 3 and shd_burn_variables.myhp >= 1 and not mq.TLO.Me.Feigning() and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atAA\ag]\ao - Death\'s Effigy')
                mq.cmd('/alt activate 7756')
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Encroaching Darkness
            if mq.TLO.Me.AltAbilityReady('Encroaching Darkness')() and mq.TLO.Target.Buff('Encroaching Darkness')() == nil and mq.TLO.Target.Buff('Entombing Darkness')() == nil and shd_burn_variables.targethp >= 50 and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atAA\ag]\ao - Encroaching Darkness')
                mq.cmd('/alt activate 826')
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Projection of Doom
            if mq.TLO.Me.AltAbilityReady('Projection of Doom')() and shd_burn_variables.targethp >= 90 and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atAA\ag]\ao - Projection of Doom')
                mq.cmd('/alt activate 3215')
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Shield Flash
            if mq.TLO.Me.AltAbilityReady('Shield Flash')() and shd_burn_variables.myhp <= 50 and shd_burn_variables.myhp >= 1 and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atAA\ag]\ao - Shield Flash')
                mq.cmd('/alt activate 1112')
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Chattering Bones
            if mq.TLO.Me.AltAbilityReady('Chattering Bones')() and shd_burn_variables.targethp >= 90 and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atAA\ag]\ao - Chattering Bones')
                mq.cmd('/alt activate 3822')
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Explosion of Hatred
            if mq.TLO.Me.AltAbilityReady('Explosion of Hatred')() and shd_burn_variables.maintank == mq.TLO.Me.CleanName() and shd_burn_variables.xtarget >= 2 and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atAA\ag]\ao - Explosion of Hatred')
                mq.cmd('/alt activate 822')
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Explosion of Spite
            if mq.TLO.Me.AltAbilityReady('Explosion of Spite')() and shd_burn_variables.maintank == mq.TLO.Me.CleanName() and shd_burn_variables.xtarget >= 2 and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atAA\ag]\ao - Explosion of Spite')
                mq.cmd('/alt activate 749')
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Gift of the Quick Spear
            if mq.TLO.Me.AltAbilityReady('Gift of the Quick Spear')() and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atAA\ag]\ao - Gift of the Quick Spear')
                mq.cmd('/alt activate 2034')
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Harm Touch
            if mq.TLO.Me.AltAbilityReady('Harm Touch')() and shd_burn_variables.xtarget >= 3 and shd_burn_variables.targethp >= 50 and shd_burn_variables.maintank == mq.TLO.Me.CleanName() and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atAA\ag]\ao - Harm Touch')
                mq.cmd('/alt activate 6000')
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Hate's Attracktion
            if mq.TLO.Me.AltAbilityReady('Hate\'s Attraction')() and shd_burn_variables.targethp >= 80 and shd_burn_variables.maintank == mq.TLO.Me.CleanName() and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atAA\ag]\ao - Hate\'s Attraction')
                mq.cmd('/alt activate 9400')
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Stream of Hatred
            if mq.TLO.Me.AltAbilityReady('Stream of Hatred')() and shd_burn_variables.targethp >= 80 and shd_burn_variables.maintank == mq.TLO.Me.CleanName() and shd_burn_variables.xtarget >= 2 and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atAA\ag]\ao - Stream of Hatred')
                mq.cmd('/alt activate 731')
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Leech Touch
            if mq.TLO.Me.AltAbilityReady('Leech Touch')() and shd_burn_variables.targethp >= 80 and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atAA\ag]\ao - Leech Touch')
                mq.cmd('/alt activate 87')
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Reaver's Bargain
            if mq.TLO.Me.AltAbilityReady('Reaver\'s Bargain')() and shd_burn_variables.myhp <= 30 and shd_burn_variables.myhp >= 1 and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atAA\ag]\ao - Reaver\'s Bargain')
                mq.cmd('/alt activate 1116')
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Scourge Skin
            if mq.TLO.Me.AltAbilityReady('Scourge Skin')() and shd_burn_variables.maintank == mq.TLO.Me.CleanName() and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atAA\ag]\ao - Scourge Skin')
                mq.cmd('/alt activate 7755')
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Spire of the Reaver
            if mq.TLO.Me.AltAbilityReady('Spire of the Reaver')() and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atAA\ag]\ao - Spire of the Reaver')
                mq.cmd('/alt activate 1450')
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --T`Vyl's Resolve
            if mq.TLO.Me.AltAbilityReady('T`Vyl\'s Resolve')() and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atAA\ag]\ao - T`Vyl\'s Resolve')
                mq.cmd('/alt activate 742')
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Thought Leech
            if mq.TLO.Me.AltAbilityReady('Thought Leech')() and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atAA\ag]\ao - Thought Leech')
                mq.cmd('/alt activate 651')
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Veil of Darkness
            if mq.TLO.Me.AltAbilityReady('Veil of Darkness')() and shd_burn_variables.maintank == mq.TLO.Me.CleanName() and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atAA\ag]\ao - Veil of Darkness')
                mq.cmd('/alt activate 854')
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Vicious Bite of Chaos
            if mq.TLO.Me.AltAbilityReady('Vicious Bite of Chaos')() and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atAA\ag]\ao - Vicious Bite of Chaos')
                mq.cmd('/alt activate 825')
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
            --Visage of Death
            if mq.TLO.Me.AltAbilityReady('Visage of Death')() and ShdBurn() then
                print(easy, ' \ag SHD Burn\aw - \ag[\atAA\ag]\ao - Visage of Death')
                mq.cmd('/alt activate 9403')
                mq.delay(490)
                if ShdEngage() then
                    ShdAggro()
                end
            end
        end
    end
end

-------------------------------------------------
---------------- BER Burn -----------------------
-------------------------------------------------
local BER_BURN = function ()
    local ber_burn_variables = {
        targethp = mq.TLO.Target.PctHPs() or 0,
        targetdistance = mq.TLO.Target.Distance() or 0,
        myhp = mq.TLO.Me.PctHPs() or 0,
        maintank = mq.TLO.Group.MainTank.CleanName(),
        myendurance = mq.TLO.Me.PctEndurance(),
        xtarget = mq.TLO.Me.XTarget(),
        mymana = mq.TLO.Me.PctMana() or 0,
        maintankdistance = mq.TLO.Group.MainTank.Distance() or 0,
        targetlevel = mq.TLO.Target.Level() or 0,
        mepoisoned = mq.TLO.Me.CountersPoison() or 0,
        mypethp = mq.TLO.Me.Pet.PctHPs() or 0,
        mypetdistance = mq.TLO.Me.Pet.Distance() or 0,
        mypet = mq.TLO.Me.Pet.CleanName(),
        spell_rank = '',
        spell_ready = '',
        combat_true = mq.TLO.Me.Combat(),
        aggressive = mq.TLO.Target.Aggressive(),
        xtargetdistance = mq.TLO.Me.XTarget(1).Distance() or 0,
        hovering = mq.TLO.Me.Hovering()
        }
    local function BerBurn()
        return not mq.TLO.Me.Hovering()
        and not mq.TLO.Me.Invulnerable()
        and not mq.TLO.Me.Silenced()
        and not mq.TLO.Me.Mezzed()
        and not mq.TLO.Me.Charmed()
        and not mq.TLO.Me.Feigning()
        and mq.TLO.Target.Aggressive()
        and mq.TLO.Me.Combat()
        and mq.TLO.Me.XTarget() >= 1
        and ber_burn_variables.targetdistance <= 30
        and ber_burn_variables.targetdistance >= 1
        and ber_burn_variables.targethp >= defaults.STOP_BURN
        and ber_burn_variables.targethp <= defaults.START_BURN
        and mq.TLO.Target.ID() ~= 0
        and not mq.TLO.Me.Moving()
        and mq.TLO.Me.Buff('Resurrection Sickness')() == nil
    end
    local function BerEngage()
        if Alive() and mq.TLO.Me.XTarget() ~= 0 then
            return mq.TLO.Me.XTarget(1).ID() >= 1
            and ber_burn_variables.xtargetdistance <= 50
            and ber_burn_variables.xtargetdistance >= 25
            and not mq.TLO.Navigation.Active()
        end
    end
    local function BerAggro()
        if Alive() then
        if mq.TLO.Navigation.Active() then mq.cmd('/nav stop') end
            if mq.TLO.Target.ID() == 0 then
                    mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID())
                    mq.cmd('/face fast')
                    mq.delay(500)
                    mq.cmd('/stick')
                    local swift_punch = mq.TLO.Spell('Swift Punch').RankName()
                    if not mq.TLO.Me.Combat() and mq.TLO.Me.CombatAbilityReady('Swift Punch')() then
                        mq.cmdf('/disc %s',swift_punch)
                    end
                    mq.cmd('/attack on')
                end
            end
        end
    if mq.TLO.Me.Class.ShortName() == 'BER' and Alive() and mq.TLO.Target.ID() ~= 0 then
        UseGear()
        if BerEngage() then
            BerAggro()
        end
        if (mq.TLO.Target.ID() == 0 and mq.TLO.Me.Combat()) or (mq.TLO.Target.ID() ~= 0 and mq.TLO.Me.XTarget() == 0 and mq.TLO.Me.Combat()) then
            print('\ar[\apEasy\ar]\ay Not a valid target. Turning Attack OFF')
            mq.cmd('/attack off')
        end
   
    --Breather
    local breather = mq.TLO.Spell('Breather').RankName()
    if mq.TLO.Me.CombatAbilityReady('Breather')() and ber_burn_variables.myendurance <= 20 and not mq.TLO.Me.Combat() and mq.TLO.Me.Song('Breather')() == nil and ber_burn_variables.xtarget == 0 and not ber_burn_variables.hovering then
        print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..breather..'')
        mq.cmdf('/disc %s',breather)
        mq.delay(490)
        if BerEngage() then
            BerAggro()
        end
    end
    if mq.TLO.Me.XTarget() >= 1 then
        --Communion of Blood
        if mq.TLO.Me.AltAbilityReady('Communion of Blood')() and not mq.TLO.Me.Combat() and ber_burn_variables.myendurance <= 25 and ber_burn_variables.myendurance >= 0 and mq.TLO.Me.Song('Communion of Blood')() == nil and not ber_burn_variables.hovering and not mq.TLO.Me.Moving() then
            print(easy, ' \ag BER Burn\aw - \ag[\atAA\ag]\ao - Communion of Blood')
            mq.cmd('/alt activate 1253')
            mq.delay(30000)
        end
        --Agony of Absolution
        if mq.TLO.Me.AltAbilityReady('Agony of Absolution')() and not mq.TLO.Me.Combat() and ber_burn_variables.mepoisoned > 0 and not ber_burn_variables.hovering and not mq.TLO.Me.Moving() then
            print(easy, ' \ag BER Burn\aw - \ag[\atAA\ag]\ao - Agony of Absolution')
            mq.cmd('/alt activate 643')
        end
        --Axe of the Eviscerator
        local axe_of_the_eviscerator = mq.TLO.Spell('Axe of the Eviscerator').RankName()
            if mq.TLO.FindItemCount('=Honed Axe Components')() <= 3 then
                mq.cmd('/popup You are out of Honed Axe Components')
            end
            if mq.TLO.Me.CombatAbilityReady('Axe of the Eviscerator')() and mq.TLO.FindItemCount('=Axe of the Eviscerator')() <= 100 and mq.TLO.FindItemCount('=Honed Axe Components')() >= 4 and not ber_burn_variables.hovering and not mq.TLO.Me.Moving() then
                print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..axe_of_the_eviscerator..'')
                mq.cmdf('/disc %s',axe_of_the_eviscerator)
                mq.delay(3000)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Cursor.ID() ~= nil then
                    print(easy, ' \ag BER Burn \agKeep: \ap '..mq.TLO.Cursor.Name())
                    mq.cmd('/autoinv')
                end
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
        --Axe of the Conqueror
        local axe_of_the_conqueror = mq.TLO.Spell('Axe of the Conqueror').RankName()
            if mq.TLO.FindItemCount('=Honed Axe Components')() <= 3 then
                mq.cmd('/popup You are out of Honed Axe Components')
            end
            if mq.TLO.Me.CombatAbilityReady('Axe of the Conqueror')() and mq.TLO.FindItemCount('=Axe of the Conqueror')() <= 100 and mq.TLO.FindItemCount('=Honed Axe Components')() >= 4 and not ber_burn_variables.hovering and not mq.TLO.Me.Moving() then
                print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..axe_of_the_conqueror..'')
                mq.cmdf('/disc %s',axe_of_the_conqueror)
                mq.delay(3000)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Cursor.ID() ~= nil then
                    print(easy, ' \ag BER Burn \agKeep: \ap '..mq.TLO.Cursor.Name())
                    mq.cmd('/autoinv')
                end
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
        --Axe of the Vindicator
        local axe_of_the_vindicator = mq.TLO.Spell('Axe of the Vindicator').RankName()
        if mq.TLO.FindItemCount('=Fine Axe Components')() <= 3 then
            mq.cmd('/popup You are out of Fine Axe Components')
        end
        if mq.TLO.Me.CombatAbilityReady('Axe of the Vindicator')() and mq.TLO.FindItemCount('=Axe of the Vindicator')() <= 100 and mq.TLO.FindItemCount('=Fine Axe Components')() >= 4 and not ber_burn_variables.hovering and not mq.TLO.Me.Moving() then
            print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..axe_of_the_vindicator..'')
            mq.cmdf('/disc %s',axe_of_the_vindicator)
            mq.delay(3000)
            while mq.TLO.Me.Casting() do mq.delay(250) end
            if mq.TLO.Cursor.ID() ~= nil then
                print(easy, ' \ag BER Burn \agKeep: \ap '..mq.TLO.Cursor.Name())
                mq.cmd('/autoinv')
            end
            mq.delay(490)
            if BerEngage() then
                BerAggro()
            end
        end
        --Axe of the Mangler
        local axe_of_the_mangler = mq.TLO.Spell('Axe of the Mangler').RankName()
        if mq.TLO.FindItemCount('=Fine Axe Components')() <= 3 then
            mq.cmd('/popup You are out of Fine Axe Components')
        end
        if mq.TLO.Me.CombatAbilityReady('Axe of the Mangler')() and mq.TLO.FindItemCount('=Axe of the Mangler')() <= 100 and mq.TLO.FindItemCount('=Fine Axe Components')() >= 4 and not ber_burn_variables.hovering and not mq.TLO.Me.Moving() then
            print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..axe_of_the_mangler..'')
            mq.cmdf('/disc %s',axe_of_the_mangler)
            mq.delay(3000)
            while mq.TLO.Me.Casting() do mq.delay(250) end
            if mq.TLO.Cursor.ID() ~= nil then
                print(easy, ' \ag BER Burn \agKeep: \ap '..mq.TLO.Cursor.Name())
                mq.cmd('/autoinv')
            end
            mq.delay(490)
            if BerEngage() then
                BerAggro()
            end
        end
        --Axe of the Demolisher
        local axe_of_the_demolisher = mq.TLO.Spell('Axe of the Demolisher').RankName()
        if mq.TLO.FindItemCount('=Fine Axe Components')() <= 3 then
            mq.cmd('/popup You are out of Fine Axe Components')
        end
        if mq.TLO.Me.CombatAbilityReady('Axe of the Demolisher')() and mq.TLO.FindItemCount('=Axe of the Demolisher')() <= 100 and mq.TLO.FindItemCount('=Fine Axe Components')() >= 4 and not ber_burn_variables.hovering and not mq.TLO.Me.Moving() then
            print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..axe_of_the_demolisher..'')
            mq.cmdf('/disc %s',axe_of_the_demolisher)
            mq.delay(4000)
            while mq.TLO.Me.Casting() do mq.delay(250) end
            if mq.TLO.Cursor.ID() ~= nil then
                print(easy, ' \ag BER Burn \agKeep: \ap '..mq.TLO.Cursor.Name())
                mq.cmd('/autoinv')
            end
            mq.delay(490)
            if BerEngage() then
                BerAggro()
            end
        end
        --Abilities
        if BerBurn() then
            --Frenzy
            if mq.TLO.Me.AbilityReady('Frenzy')() and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atAbility\ag]\ao - Frenzy')
                mq.cmd('/doability Frenzy')
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Intimidation
            if mq.TLO.Me.AbilityReady('Intimidation')() and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atAbility\ag]\ao - Intimidation')
                mq.cmd('/doability Intimidation')
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Disarm
            if mq.TLO.Me.AbilityReady('Disarm')() and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atAbility\ag]\ao - Disarm')
                mq.cmd('/doability Disarm')
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Combat Abilities
            --Ecliptic Rage
            local ecliptic_rage = mq.TLO.Spell('Ecliptic Rage').RankName()
            if mq.TLO.Me.CombatAbilityReady('Ecliptic Rage')() and mq.TLO.FindItemCount('=Axe of the Mangler')() >= 1 and ber_burn_variables.myendurance >= 10 and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..ecliptic_rage..'')
                mq.cmd('/disc 65593')
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Mangling Discipline
            local mangling_discipline = mq.TLO.Spell('Mangling Discipline').RankName()
            if mq.TLO.Me.CombatAbilityReady('Mangling Discipline')() and ber_burn_variables.targethp >= 80 and ber_burn_variables.targethp <= 99 and mq.TLO.Me.ActiveDisc.ID() == nil and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..mangling_discipline..'')
                mq.cmdf('/disc %s', mangling_discipline)
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Sapping Strikes
            local sapping_strikes = mq.TLO.Spell('Sapping Strikes').RankName()
            if mq.TLO.Me.CombatAbilityReady('Sapping Strikes')() and ber_burn_variables.targethp >= 80 and ber_burn_variables.targethp <= 99 and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..sapping_strikes..'')
                mq.cmdf('/disc %s', sapping_strikes)
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Disconcerting Discipline
            local disconcerting_discipline = mq.TLO.Spell('Disconcerting Discipline').RankName()
            if mq.TLO.Me.CombatAbilityReady('Disconcerting Discipline')() and ber_burn_variables.targethp >= 80 and ber_burn_variables.targethp <= 99 and mq.TLO.Me.ActiveDisc.ID() == nil and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..disconcerting_discipline..'')
                mq.cmdf('/disc %s', disconcerting_discipline)
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Vindicator's Coalition
            local vindicators_coalition = mq.TLO.Spell('Vindicator\'s Coalition').RankName()
            if mq.TLO.Me.CombatAbilityReady('Vindicator\'s Coalition')() and mq.TLO.Me.Buff('Vindicator\'s Coalition Effect')() == nil and ber_burn_variables.myendurance >= 10 and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..vindicators_coalition..'')
                mq.cmdf('/disc %s', vindicators_coalition)
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Phantom Assailant
            local phantom_assailant = mq.TLO.Spell('Phantom Assailant').RankName()
            if mq.TLO.Me.CombatAbilityReady('Phantom Assailant')() and ber_burn_variables.targethp >= 80 and ber_burn_variables.targethp <= 99 and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..phantom_assailant..'')
                mq.cmdf('/disc %s', phantom_assailant)
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Instinctive Retaliation
            local instinctive_retaliation = mq.TLO.Spell('Instinctive Retaliation').RankName()
            if mq.TLO.Me.CombatAbilityReady('Instinctive Retaliation')() and ber_burn_variables.myhp <=50 and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..instinctive_retaliation..'')
                mq.cmdf('/disc %s', instinctive_retaliation)
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Axe of Orrak
            local axe_of_orrak = mq.TLO.Spell('Axe of Orrak').RankName()
            if mq.TLO.Me.CombatAbilityReady('Axe of Orrak')() and mq.TLO.FindItemCount('=Axe of the Eviscerator')() >= 1 and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..axe_of_orrak..'')
                mq.cmdf('/disc %s', axe_of_orrak)
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Axe of Xin Diabo
            local axe_of_xin_diabo = mq.TLO.Spell('Axe of Xin Diabo').RankName()
            if mq.TLO.Me.CombatAbilityReady('Axe of Xin Diabo')() and mq.TLO.FindItemCount('=Axe of the Conqueror')() >= 1 and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..axe_of_xin_diabo..'')
                mq.cmdf('/disc %s', axe_of_xin_diabo)
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Axe of Derakor
            local axe_of_derakor = mq.TLO.Spell('Axe of Derakor').RankName()
            if mq.TLO.Me.CombatAbilityReady('Axe of Derakor')() and mq.TLO.FindItemCount('=Axe of the Vindicator')() >= 1 and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..axe_of_derakor..'')
                mq.cmdf('/disc %s', axe_of_derakor)
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Prime Retaliation
            local prime_retaliation = mq.TLO.Spell('Prime Retaliation').RankName()
            if mq.TLO.Me.CombatAbilityReady('Prime Retaliation')() and ber_burn_variables.myhp <= 89 and ber_burn_variables.myhp >=10 and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..prime_retaliation..'')
                mq.cmdf('/disc %s', prime_retaliation)
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Shared Violence
            local shared_violence = mq.TLO.Spell('Shared Violence').RankName()
            if mq.TLO.Me.CombatAbilityReady('Shared Violence')() and ber_burn_variables.targethp <= 99 and ber_burn_variables.targethp >= 50 and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..shared_violence..'')
                mq.cmdf('/disc %s', shared_violence)
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Oppressing Frenzy
            local oppressing_frenzy = mq.TLO.Spell('Oppressing Frenzy').RankName()
            if mq.TLO.Me.CombatAbilityReady('Oppressing Frenzy')() and ber_burn_variables.targethp >= 40 and ber_burn_variables.targethp <= 99 and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..oppressing_frenzy..'')
                mq.cmdf('/disc %s', oppressing_frenzy)
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Blinding Frenzy
            local blinding_frenzy = mq.TLO.Spell('Blinding Frenzy').RankName()
            if mq.TLO.Me.CombatAbilityReady('Blinding Frenzy')() and ber_burn_variables.myhp <= 89 and ber_burn_variables.myhp >= 25 and BerBurn() then
                mq.cmd('/stopdisc')
                mq.delay(50)
                print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..blinding_frenzy..'')
                mq.cmdf('/disc %s', blinding_frenzy)
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Maiming Axe Throw
            local maiming_axe_throw = mq.TLO.Spell('Maiming Axe Throw').RankName()
            if mq.TLO.Me.CombatAbilityReady('Maiming Axe Throw')() and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..maiming_axe_throw..'')
                mq.cmdf('/disc %s', maiming_axe_throw)
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Bloodthirst
            local bloodthirst = mq.TLO.Spell('Bloodthirst').RankName()
            if mq.TLO.Me.CombatAbilityReady('Bloodthirst')() and ber_burn_variables.targethp >= 50 and ber_burn_variables.targethp <= 99 and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..bloodthirst..'')
                mq.cmdf('/disc %s', bloodthirst)
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Buttressed Frenzy
            local buttressed_frenzy = mq.TLO.Spell('Buttressed Frenzy').RankName()
            if mq.TLO.Me.CombatAbilityReady('Buttressed Frenzy')() and ber_burn_variables.myhp >= 50 and ber_burn_variables.myhp <= 89 and mq.TLO.Me.Buff('Buttressed Frenzy')() == nil and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..buttressed_frenzy..'')
                mq.cmdf('/disc %s', buttressed_frenzy)
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Shriveling Strikes
            local shriveling_strikes = mq.TLO.Spell('Shriveling Strikes').RankName()
            if mq.TLO.Me.CombatAbilityReady('Shriveling Strikes')() and ber_burn_variables.targethp >= 60 and ber_burn_variables.targethp <= 99 and mq.TLO.Me.Song('Shriveling Strikes')() == nil and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..shriveling_strikes..'')
                mq.cmdf('/disc %s', shriveling_strikes)
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Frothing Rage
            local frothing_rage = mq.TLO.Spell('Frothing Rage').RankName()
            if mq.TLO.Me.CombatAbilityReady('Frothing Rage')() and ber_burn_variables.targethp >= 60 and ber_burn_variables.targethp <= 99 and mq.TLO.Me.Song('Frothing Rage')() == nil and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..frothing_rage..'')
                mq.cmdf('/disc %s', frothing_rage)
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Avenging Flurry Discipline
            local avenging_flurry_discipline = mq.TLO.Spell('Avenging Flurry Discipline').RankName()
            if mq.TLO.Me.CombatAbilityReady('Avenging Flurry Discipline')() and ber_burn_variables.targethp >= 60 and ber_burn_variables.targethp <= 99 and mq.TLO.Me.ActiveDisc.ID() == nil and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..avenging_flurry_discipline..'')
                mq.cmdf('/disc %s', avenging_flurry_discipline)
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Brutal Discipline
            local brutal_discipline = mq.TLO.Spell('Brutal Discipline').RankName()
            if mq.TLO.Me.CombatAbilityReady('Brutal Discipline')() and ber_burn_variables.targethp >= 60 and ber_burn_variables.targethp <= 99 and mq.TLO.Me.ActiveDisc.ID() == nil and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..brutal_discipline..'')
                mq.cmdf('/disc %s', brutal_discipline)
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Cleaving Acrimony Discipline
            local cleaving_acrimony_discipline = mq.TLO.Spell('Cleaving Acrimony Discipline').RankName()
            if mq.TLO.Me.CombatAbilityReady('Cleaving Acrimony Discipline')() and ber_burn_variables.targethp >= 60 and ber_burn_variables.targethp <= 99 and mq.TLO.Me.ActiveDisc.ID() == nil and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..cleaving_acrimony_discipline..'')
                mq.cmdf('/disc %s', cleaving_acrimony_discipline)
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Eviscerating Volley
            local eviscerating_volley = mq.TLO.Spell('Eviscerating Volley').RankName()
            if mq.TLO.Me.CombatAbilityReady('Eviscerating Volley')() and ber_burn_variables.targethp >= 60 and ber_burn_variables.targethp <= 99 and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..eviscerating_volley..'')
                mq.cmdf('/disc %s', eviscerating_volley)
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Pulverizing Volley
            local pulverizing_volley = mq.TLO.Spell('Pulverizing Volley').RankName()
            if mq.TLO.Me.CombatAbilityReady('Pulverizing Volley')() and ber_burn_variables.targethp >= 60 and ber_burn_variables.targethp <= 99 and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..pulverizing_volley..'')
                mq.cmdf('/disc %s', pulverizing_volley)
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Cry Carnage
            local cry_carnage = mq.TLO.Spell('Cry Carnage').RankName()
            if mq.TLO.Me.CombatAbilityReady('Cry Carnage')() and ber_burn_variables.targethp >= 60 and ber_burn_variables.targethp <= 99 and mq.TLO.Me.Song('Cry Carnage')() == nil and mq.TLO.Me.ActiveDisc.ID() == nil and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..cry_carnage..'')
                mq.cmdf('/disc %s', cry_carnage)
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --AA
            --Focused Furious Rampage
            if mq.TLO.Me.AltAbilityReady('Focused Furious Rampage')() and ber_burn_variables.targethp >= 50 and ber_burn_variables.targethp <= 99 and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atAA\ag]\ao - Focused Furious Rampage')
                mq.cmd('/alt activate 379')
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Vehement Rage
            if mq.TLO.Me.AltAbilityReady('Vehement Rage')() and ber_burn_variables.targethp >= 50 and ber_burn_variables.targethp <= 99 and mq.TLO.Me.Song('Vehement Rage')() == nil and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atAA\ag]\ao - Vehement Rage')
                mq.cmd('/alt activate 800')
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Binding Axe
            if mq.TLO.Me.AltAbilityReady('Binding Axe')() and ber_burn_variables.targethp >= 50 and ber_burn_variables.targethp <= 99 and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atAA\ag]\ao - Binding Axe')
                mq.cmd('/alt activate 642')
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Blinding Fury
            if mq.TLO.Me.AltAbilityReady('Blinding Fury')() and ber_burn_variables.targethp >= 50 and ber_burn_variables.targethp <= 99 and mq.TLO.Me.Buff('Blinding Fury')() == nil and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atAA\ag]\ao - Blinding Fury')
                mq.cmd('/alt activate 610')
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Blood Pact
            if mq.TLO.Me.AltAbilityReady('Blood Pact')() and ber_burn_variables.targethp >= 50 and ber_burn_variables.targethp <= 99 and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atAA\ag]\ao - Blood Pact')
                mq.cmd('/alt activate 387')
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Blood Sustenance
            if mq.TLO.Me.AltAbilityReady('Blood Sustenance')() and ber_burn_variables.targethp >= 1 and ber_burn_variables.targethp <= 30 and mq.TLO.Me.Song('Blood Sustenance')() == nil and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atAA\ag]\ao - Blood Sustenance')
                mq.cmd('/alt activate 1141')
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Blood Fury
            if mq.TLO.Me.AltAbilityReady('Blood Fury')() and ber_burn_variables.myhp >= 96 and ber_burn_variables.myhp <= 100 and mq.TLO.Me.Song('Blood Fury')() == nil and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atAA\ag]\ao - Blood Fury')
                mq.cmd('/alt activate 752')
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Desperation
            if mq.TLO.Me.AltAbilityReady('Desperation')() and ber_burn_variables.targethp >= 50 and ber_burn_variables.targethp <= 99 and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atAA\ag]\ao - Desperation')
                mq.cmd('/alt activate 373')
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Juggernaut Surge
            if mq.TLO.Me.AltAbilityReady('Juggernaut Surge')() and ber_burn_variables.targethp >= 50 and ber_burn_variables.targethp <= 99 and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atAA\ag]\ao - Juggernaut Surge')
                mq.cmd('/alt activate 961')
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Juggernaut's Resolve
            if mq.TLO.Me.AltAbilityReady('Juggernaut\'s Resolve')() and ber_burn_variables.myhp <= 50 and ber_burn_variables.myhp >= 1 and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atAA\ag]\ao - Juggernaut\'s Resolve')
                mq.cmd('/alt activate 836')
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Reckless Abandon
            if mq.TLO.Me.AltAbilityReady('Reckless Abandon')() and ber_burn_variables.myhp <= 100 and ber_burn_variables.myhp >= 90 and mq.TLO.Me.Song('Reckless Abandon')() == nil and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atAA\ag]\ao - Reckless Abandon')
                mq.cmd('/alt activate 3710')
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Savage Spirit
            if mq.TLO.Me.AltAbilityReady('Savage Spirit')() and ber_burn_variables.myhp <= 100 and ber_burn_variables.myhp >= 90 and mq.TLO.Me.Buff('Savage Spirit')() == nil and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atAA\ag]\ao - Savage Spirit')
                mq.cmd('/alt activate 465')
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Spire of the Juggernaut
            if mq.TLO.Me.AltAbilityReady('Spire of the Juggernaut')() and mq.TLO.Me.Buff('Spire of the Juggernaut')() == nil and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atAA\ag]\ao - Spire of the Juggernaut')
                mq.cmd('/alt activate 1500')
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Uncanny Resilience
            if mq.TLO.Me.AltAbilityReady('Uncanny Resilience')() and ber_burn_variables.myhp <= 30 and ber_burn_variables.myhp >= 0 and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atAA\ag]\ao - Uncanny Resilience')
                mq.cmd('/alt activate 609')
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Untamed Rage
            if mq.TLO.Me.AltAbilityReady('Untamed Rage')() and ber_burn_variables.myhp >= 80 and ber_burn_variables.myhp <= 99 and mq.TLO.Me.Buff('Untamed Rage')() == nil and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atAA\ag]\ao - Untamed Rage')
                mq.cmd('/alt activate 374')
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
            --Braxi's Howl
            if mq.TLO.Me.AltAbilityReady('Braxi\'s Howl')() and ber_burn_variables.targethp >= 80 and ber_burn_variables.targethp <= 99 and BerBurn() then
                print(easy, ' \ag BER Burn\aw - \ag[\atAA\ag]\ao - Braxi\'s Howl')
                mq.cmd('/alt activate 1013')
                mq.delay(490)
                if BerEngage() then
                    BerAggro()
                end
            end
        end
    end
    end
end

-------------------------------------------------
------------------ ROG Burn ---------------------
-------------------------------------------------
local ROG_BURN = function ()
    local rog_burn_variables = {
        targethp = mq.TLO.Target.PctHPs() or 0,
        targetdistance = mq.TLO.Target.Distance() or 0,
        myhp = mq.TLO.Me.PctHPs() or 0,
        maintank = mq.TLO.Group.MainTank.CleanName(),
        myendurance = mq.TLO.Me.PctEndurance(),
        xtarget = mq.TLO.Me.XTarget(),
        mymana = mq.TLO.Me.PctMana() or 0,
        maintankdistance = mq.TLO.Group.MainTank.Distance() or 0,
        targetlevel = mq.TLO.Target.Level() or 0,
        mepoisoned = mq.TLO.Me.CountersPoison() or 0,
        mypethp = mq.TLO.Me.Pet.PctHPs() or 0,
        mypetdistance = mq.TLO.Me.Pet.Distance() or 0,
        mypet = mq.TLO.Me.Pet.CleanName(),
        spell_rank = '',
        spell_ready = '',
        combat_true = mq.TLO.Me.Combat(),
        aggressive = mq.TLO.Target.Aggressive(),
        xtargetdistance = mq.TLO.Me.XTarget(1).Distance() or 0,
        hovering = mq.TLO.Me.Hovering()
        }
    local function RogBurn()
        return not mq.TLO.Me.Hovering()
        and not mq.TLO.Me.Invulnerable()
        and not mq.TLO.Me.Silenced()
        and not mq.TLO.Me.Mezzed()
        and not mq.TLO.Me.Charmed()
        and not mq.TLO.Me.Feigning()
        and mq.TLO.Target.Aggressive()
        and mq.TLO.Me.Combat()
        and mq.TLO.Me.XTarget() >= 1
        and rog_burn_variables.targetdistance <= 30
        and rog_burn_variables.targetdistance >= 1
        and rog_burn_variables.targethp >= defaults.STOP_BURN
        and rog_burn_variables.targethp <= defaults.START_BURN
        and mq.TLO.Target.ID() ~= 0
        and mq.TLO.Me.Buff('Resurrection Sickness')() == nil
    end
    local function RogEngage()
        if Alive() and mq.TLO.Me.XTarget() ~= 0 then
            return mq.TLO.Me.XTarget(1).ID() >= 1
            and rog_burn_variables.xtargetdistance <= 50
            and rog_burn_variables.xtargetdistance >= 25
            and not mq.TLO.Navigation.Active()
        end
    end
    local function RogAggro()
        if Alive() then
        if mq.TLO.Navigation.Active() then mq.cmd('/nav stop') end
        if mq.TLO.Target.ID() == 0 then
            mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID())
            mq.cmd('/face fast')
            mq.delay(500)
            mq.cmd('/stick')
            mq.cmd('/attack on')
        end
        end
    end
    if mq.TLO.Me.Class.ShortName() == 'ROG' and Alive() then
        UseGear()
        if (mq.TLO.Target.ID() == 0 and mq.TLO.Me.Combat()) or (mq.TLO.Target.ID() ~= 0 and mq.TLO.Me.XTarget() == 0 and mq.TLO.Me.Combat()) then
            print('\ar[\apEasy\ar]\ay Not a valid target. Turning Attack OFF')
            mq.cmd('/attack off')
        end
        if Alive() and mq.TLO.Me.Invis('SOS')() == false then
            if mq.TLO.Me.AbilityReady('Sneak')() and mq.TLO.Me.State() ~= 'MOUNT' and not rog_burn_variables.hovering and not mq.TLO.Me.Combat() then
                mq.cmd('/doability sneak')
                mq.delay(500)
            end
            if mq.TLO.Me.AbilityReady('Hide')() and mq.TLO.Me.Sneaking() then
                mq.cmd('/doability hide')
            end
        end
        if RogEngage() then
            RogAggro()
        end
        --Consigned Bite of the Shissar XXI
        if mq.TLO.Me.Level() >= 116 and mq.TLO.Me.Level() <= 120 and mq.TLO.FindItemCount('=Consigned Bite of the Shissar XXI')() >=1 and mq.TLO.FindItem("=Consigned Bite of the Shissar XXI").TimerReady() == 0 and mq.TLO.Me.Buff('=Bite of the Shissar Poison XII')() == nil and not rog_burn_variables.hovering and not mq.TLO.Me.Moving() then
            print(easy, ' \ag ROG Burn\aw - \ag[\atClicky\ag]\ao - Consigned Bite of the Shissar XXI')
            mq.cmd('/useitem "Consigned Bite of the Shissar XXI"')
        end
        if mq.TLO.Me.Level() >= 121 and mq.TLO.Me.Level() <= 125 and mq.TLO.FindItemCount('=Consigned Bite of the Shissar XXII')() >=1 and mq.TLO.FindItem("=Consigned Bite of the Shissar XXII").TimerReady() == 0 and mq.TLO.Me.Buff('=Bite of the Shissar Poison XIII')() == nil and not rog_burn_variables.hovering and not mq.TLO.Me.Moving() then
            print(easy, ' \ag ROG Burn\aw - \ag[\atClicky\ag]\ao - Consigned Bite of the Shissar XXII')
            mq.cmd('/useitem "Consigned Bite of the Shissar XXII"')
        end
        --Breather
        local breather = mq.TLO.Spell('Breather').RankName()
        if mq.TLO.Me.CombatAbilityReady('Breather')() and rog_burn_variables.myendurance <= 20 and not mq.TLO.Me.Combat() and mq.TLO.Me.Song('Breather')() == nil and rog_burn_variables.xtarget == 0 and not rog_burn_variables.hovering then
            print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..breather..'')
            mq.cmdf('/disc %s', breather)
            mq.delay(500)
        end
        --Purge Poison
        if mq.TLO.Me.AltAbilityReady('Purge Poison')() and rog_burn_variables.myhp >= 1 and rog_burn_variables.myhp <= 99 and rog_burn_variables.mepoisoned >= 1 and not rog_burn_variables.hovering and not mq.TLO.Me.Moving() then
            mq.cmd('/target %s',mq.TLO.Me.CleanName())
            mq.delay(100)
            print(easy, ' \ag ROG Burn\aw - \ag[\atAA\ag]\ao - Purge Poison')
            mq.cmd('/alt activate 107')
            mq.delay(490)
            if RogEngage() then
                RogAggro()
            end
        end
        --Abilities
        if rog_burn_variables.targethp >= defaults.STOP_BURN and rog_burn_variables.targethp <= defaults.START_BURN and rog_burn_variables.targetdistance <= 30 and rog_burn_variables.targetdistance >= 0 and RogBurn() then
            --Backstab
            if mq.TLO.Me.AbilityReady('Backstab')() and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atAbility\ag]\ao - Backstab')
                mq.cmd('/doability Backstab')
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Intimidation
            if mq.TLO.Me.AbilityReady('Intimidation')() and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atAbility\ag]\ao - Intimidation')
                mq.cmd('/doability Intimidation')
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Disarm
            if mq.TLO.Me.AbilityReady('Disarm')() and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atAbility\ag]\ao - Disarm')
                mq.cmd('/doability Disarm')
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Combat Abilities
            --Ecliptic Weapons
            local ecliptic_weapons = mq.TLO.Spell('Ecliptic Weapons').RankName()
            if RogBurn() and mq.TLO.Me.CombatAbilityReady('Ecliptic Weapons')() and mq.TLO.Me.Buff('Ecliptic Weapons')() == nil then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..ecliptic_weapons..'')
                mq.cmdf('/disc %s', ecliptic_weapons)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Composite Weapons
            local composite_weapons = mq.TLO.Spell('Ecliptic Rage').RankName()
            if mq.TLO.Me.CombatAbilityReady('Ecliptic Rage')() and rog_burn_variables.targethp <= 99 and rog_burn_variables.targethp >= 50 and rog_burn_variables.myendurance >= 10 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..composite_weapons..'')
                mq.cmdf('/disc %s', composite_weapons)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Poisonous Coalition
            local poisonous_coalition = mq.TLO.Spell('Poisonous Coalition').RankName()
            if mq.TLO.Me.CombatAbilityReady('Poisonous Coalition')() and rog_burn_variables.targethp >= 50 and rog_burn_variables.targethp <= 99 and rog_burn_variables.myendurance >= 20 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..poisonous_coalition..'')
                mq.cmdf('/disc %s', poisonous_coalition)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Veiled Blade
            local veiled_blade = mq.TLO.Spell('Veiled Blade').RankName()
            if mq.TLO.Me.CombatAbilityReady('Veiled Blade')() and mq.TLO.Me.Song('Veiled Blade')() == nil and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..veiled_blade..'')
                mq.cmdf('/disc %s', veiled_blade)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Obfuscated Blade
            local obfuscated_blade = mq.TLO.Spell('Obfuscated Blade').RankName()
            if mq.TLO.Me.CombatAbilityReady('Obfuscated Blade')() and not mq.TLO.Me.CombatAbilityReady('Veiled Blade')() and mq.TLO.Me.Song('Obfuscated Blade')() == nil and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..obfuscated_blade..'')
                mq.cmdf('/disc %s', obfuscated_blade)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Phantom Assassin
            local phantom_assassin = mq.TLO.Spell('Phantom Assassin').RankName()
            if mq.TLO.Me.CombatAbilityReady('Phantom Assassin')() and rog_burn_variables.targethp >= 50 and rog_burn_variables.targethp <= 99 and mq.TLO.Me.Buff('Assassin\'s Premonition')() == nil and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..phantom_assassin..'')
                mq.cmdf('/disc %s', phantom_assassin)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Jugular Rend
            local jugular_rend = mq.TLO.Spell('Jugular Rend').RankName()
            if mq.TLO.Me.CombatAbilityReady('Jugular Rend')() and rog_burn_variables.targethp >=50 and rog_burn_variables.targethp <= 99 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..jugular_rend..'')
                mq.cmdf('/disc %s', jugular_rend)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Weapon Covenant
            local weapon_covenant = mq.TLO.Spell('Weapon Covenant').RankName()
            if mq.TLO.Me.CombatAbilityReady('Weapon Covenant')() and mq.TLO.Me.ActiveDisc() == nil and rog_burn_variables.targethp >=50 and rog_burn_variables.targethp <= 99 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..weapon_covenant..'')
                mq.cmdf('/disc %s', weapon_covenant)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Knifeplay Discipline
            local knifeplay = mq.TLO.Spell('Knifeplay Discipline').RankName()
            if mq.TLO.Me.CombatAbilityReady('Knifeplay Discipline')() and rog_burn_variables.targethp >=50 and rog_burn_variables.targethp <= 99 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..knifeplay..'')
                mq.cmdf('/disc %s', knifeplay)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Foolish Mark
            local foolish_mark = mq.TLO.Spell('Foolish Mark').RankName()
            if mq.TLO.Me.CombatAbilityReady('Foolish Mark')() and rog_burn_variables.targetlevel <= 120 and rog_burn_variables.targetlevel >= 100 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..foolish_mark..'')
                mq.cmdf('/disc %s', foolish_mark)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Baleful Aim Discipline
            local baleful_aim_discipline = mq.TLO.Spell('Baleful Aim Discipline').RankName()
            if mq.TLO.Me.CombatAbilityReady('Baleful Aim Discipline')() and mq.TLO.Me.ActiveDisc.ID() == nil and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..baleful_aim_discipline..'')
                mq.cmdf('/disc %s', baleful_aim_discipline)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Crinotoxin Discipline
            local crinotoxin_discipline = mq.TLO.Spell('Crinotoxin Discipline').RankName()
            if mq.TLO.Me.CombatAbilityReady('Crinotoxin Discipline')() and rog_burn_variables.targethp <= 99 and rog_burn_variables.targethp >= 50 and mq.TLO.Me.ActiveDisc.ID() == nil and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..crinotoxin_discipline..'')
                mq.cmdf('/disc %s', crinotoxin_discipline)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Exotoxin Discipline
            local exotoxin_discipline = mq.TLO.Spell('Exotoxin Discipline').RankName()
            if mq.TLO.Me.CombatAbilityReady('Exotoxin Discipline')() and not mq.TLO.Me.CombatAbilityReady('Crinotoxin Discipline')() and rog_burn_variables.targethp <= 99 and rog_burn_variables.targethp >= 50 and mq.TLO.Me.ActiveDisc.ID() == nil and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..exotoxin_discipline..'')
                mq.cmdf('/disc %s', exotoxin_discipline)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Ragged Edge Discipline
            local ragged_edge_discipline = mq.TLO.Spell('Ragged Edge Discipline').RankName()
            if mq.TLO.Me.CombatAbilityReady('Ragged Edge Discipline')() and rog_burn_variables.targethp >= 40 and rog_burn_variables.targethp <= 99 and mq.TLO.Me.ActiveDisc.ID() == nil and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..ragged_edge_discipline..'')
                mq.cmdf('/disc %s', ragged_edge_discipline)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Agitating Smoke
            local agitating_smoke = mq.TLO.Spell('Agitating Smoke').RankName()
            if mq.TLO.Me.CombatAbilityReady('Agitating Smoke')() and rog_burn_variables.myhp <= 50 and rog_burn_variables.myhp >= 1 and rog_burn_variables.xtarget >= 2 and rog_burn_variables.myendurance >= 5 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..agitating_smoke..'')
                mq.cmdf('/disc %s', agitating_smoke)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Trickery
            local trickery = mq.TLO.Spell('Trickery').RankName()
            if mq.TLO.Me.CombatAbilityReady('Trickery')() and rog_burn_variables.myendurance >= 5 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..trickery..'')
                mq.cmdf('/disc %s', trickery)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Beguile
            local beguile = mq.TLO.Spell('Beguile').RankName()
            if mq.TLO.Me.CombatAbilityReady('Beguile')() and rog_burn_variables.myendurance >= 5 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..beguile..'')
                mq.cmdf('/disc %s', beguile)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Disorienting Puncture
            local disorienting_puncture = mq.TLO.Spell('Disorienting Puncture').RankName()
            if mq.TLO.Me.CombatAbilityReady('Disorienting Puncture')() and rog_burn_variables.myendurance >= 5 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..disorienting_puncture..'')
                mq.cmdf('/disc %s', disorienting_puncture)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Pinpoint Fault
            local pinpoint_fault = mq.TLO.Spell('Pinpoint Fault').RankName()
            if mq.TLO.Me.CombatAbilityReady('Pinpoint Fault')() and rog_burn_variables.targethp >= 50 and rog_burn_variables.targethp <= 99 and rog_burn_variables.myendurance >= 10 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..pinpoint_fault..'')
                mq.cmdf('/disc %s', pinpoint_fault)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Pinpoint Defects
            local pinpoint_defects = mq.TLO.Spell('Pinpoint Defects').RankName()
            if mq.TLO.Me.CombatAbilityReady('Pinpoint Defects')() and not mq.TLO.Me.CombatAbilityReady('Pinpoint Fault')() and rog_burn_variables.targethp >= 50 and rog_burn_variables.targethp <= 99 and rog_burn_variables.myendurance >= 10 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..pinpoint_defects..'')
                mq.cmdf('/disc %s', pinpoint_defects)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Mayhem
            local mayhem = mq.TLO.Spell('Mayhem').RankName()
            if mq.TLO.Me.CombatAbilityReady('Mayhem')() and rog_burn_variables.targethp >= 60 and rog_burn_variables.targethp <= 99 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..mayhem..'')
                mq.cmdf('/disc %s', mayhem)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Shadowstrike
            local shadowstrike = mq.TLO.Spell('Shadowstrike').RankName()
            if mq.TLO.Me.CombatAbilityReady('Shadowstrike')() and not mq.TLO.Me.CombatAbilityReady('Mayhem')() and rog_burn_variables.targethp >= 60 and rog_burn_variables.targethp <= 99 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..shadowstrike..'')
                mq.cmdf('/disc %s', shadowstrike)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Venomous Blade
            local venomous_blade = mq.TLO.Spell('Venomous Blade').RankName()
            if mq.TLO.Me.CombatAbilityReady('Venomous Blade')() and rog_burn_variables.targethp >= 60 and rog_burn_variables.targethp <= 99 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..venomous_blade..'')
                mq.cmdf('/disc %s', venomous_blade)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Netherbian Blade
            local netherbian_blade = mq.TLO.Spell('Netherbian Blade').RankName()
            if mq.TLO.Me.CombatAbilityReady('Netherbian Blade')() and rog_burn_variables.targethp >= 60 and rog_burn_variables.targethp <= 99 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..netherbian_blade..'')
                mq.cmdf('/disc %s', netherbian_blade)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Ambuscade
            local ambuscade = mq.TLO.Spell('Ambuscade').RankName()
            if mq.TLO.Me.CombatAbilityReady('Ambuscade')() and rog_burn_variables.targethp >= 60 and rog_burn_variables.targethp <= 99 and rog_burn_variables.targetlevel <= 120 and rog_burn_variables.myendurance >= 10 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..ambuscade..'')
                mq.cmdf('/disc %s', ambuscade)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Frenzied Stabbing Discipline
            local frenzied_stabbing_discipline = mq.TLO.Spell('Frenzied Stabbing Discipline').RankName()
            if mq.TLO.Me.CombatAbilityReady('Frenzied Stabbing Discipline')() and rog_burn_variables.targethp >= 60 and rog_burn_variables.targethp <= 99 and mq.TLO.Me.ActiveDisc.ID() == nil and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..frenzied_stabbing_discipline..'')
                mq.cmdf('/disc %s', frenzied_stabbing_discipline)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Unseeable Discipline
            local unseeable_discipline = mq.TLO.Spell('Unseeable Discipline').RankName()
            if mq.TLO.Me.CombatAbilityReady('Unseeable Discipline')() and rog_burn_variables.targethp >= 60 and rog_burn_variables.targethp <= 99 and mq.TLO.Me.ActiveDisc.ID() == nil and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..unseeable_discipline..'')
                mq.cmdf('/disc %s', unseeable_discipline)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Twisted Chance Discipline
            local twisted_chance_discipline = mq.TLO.Spell('Twisted Chance Discipline').RankName()
            if mq.TLO.Me.CombatAbilityReady('Twisted Chance Discipline')() and rog_burn_variables.targethp >= 60 and rog_burn_variables.targethp <= 99 and mq.TLO.Me.ActiveDisc.ID() == nil and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..twisted_chance_discipline..'')
                mq.cmdf('/disc %s', twisted_chance_discipline)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Executioner Discipline
            local executioner_discipline = mq.TLO.Spell('Executioner Discipline').RankName()
            if mq.TLO.Me.CombatAbilityReady('Executioner Discipline')() and rog_burn_variables.targethp >= 60 and rog_burn_variables.targethp <= 99 and mq.TLO.Me.ActiveDisc.ID() == nil and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..executioner_discipline..'')
                mq.cmdf('/disc %s', executioner_discipline)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Counterattack Discipline
            local counterattack_discipline = mq.TLO.Spell('Counterattack Discipline').RankName()
            if mq.TLO.Me.CombatAbilityReady('Counterattack Discipline')() and rog_burn_variables.myhp <= 60 and rog_burn_variables.targethp >= 1 and mq.TLO.Me.ActiveDisc.ID() == nil and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..counterattack_discipline..'')
                mq.cmdf('/disc %s', counterattack_discipline)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Storied Escape
            local storied_escape = mq.TLO.Spell('Storied Escape').RankName()
            if mq.TLO.Me.CombatAbilityReady('Storied Escape')() and rog_burn_variables.myhp <= 10 and rog_burn_variables.targethp >= 1 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..storied_escape..'')
                mq.cmdf('/disc %s', storied_escape)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Gutsy Escape
            local gutsy_escape = mq.TLO.Spell('Gutsy Escape').RankName()
            if mq.TLO.Me.CombatAbilityReady('Gutsy Escape')() and not mq.TLO.Me.CombatAbilityReady('Storied Escape')() and rog_burn_variables.myhp <= 10 and rog_burn_variables.targethp >= 1 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..gutsy_escape..'')
                mq.cmdf('/disc %s', gutsy_escape)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Lance
            local lance = mq.TLO.Spell('Lance').RankName()
            if mq.TLO.Me.CombatAbilityReady('Lance')() and rog_burn_variables.targethp <= 99 and rog_burn_variables.targethp >= 75 and rog_burn_variables.myhp >= 80 and rog_burn_variables.myhp <= 100 and rog_burn_variables.myendurance >= 5 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..lance..'')
                mq.cmdf('/disc %s', lance)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Blinding Candascence
            local blinding_candascence = mq.TLO.Spell('Blinding Candascence').RankName()
            if mq.TLO.Me.CombatAbilityReady('Blinding Candascence')() and rog_burn_variables.targethp <= 99 and rog_burn_variables.targethp >= 75 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..blinding_candascence..'')
                mq.cmdf('/disc %s', blinding_candascence)
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --AA
            --Escape
            if mq.TLO.Me.AltAbilityReady('Escape')() and rog_burn_variables.myhp >= 1 and rog_burn_variables.myhp <= 20 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atAA\ag]\ao - Escape')
                mq.cmd('/alt activate 102')
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Focused Rake's Rampage
            if mq.TLO.Me.AltAbilityReady('Focused Rake\'s Rampage')() and rog_burn_variables.targethp >= 50 and rog_burn_variables.targethp <= 99 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atAA\ag]\ao - Focused Rake\'s Rampage')
                mq.cmd('/alt activate 378')
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Assassin's Premonition
            if mq.TLO.Me.AltAbilityReady('Assassin\'s Premonition')() and rog_burn_variables.targethp >= 50 and rog_burn_variables.targethp <= 60 and rog_burn_variables.myendurance >= 10 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atAA\ag]\ao - Assassin\'s Premonition')
                mq.cmd('/alt activate 1134')
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Ligament Slice
            if mq.TLO.Me.AltAbilityReady('Ligament Slice')() and rog_burn_variables.targethp >= 50 and rog_burn_variables.targethp <= 99 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atAA\ag]\ao - Ligament Slice')
                mq.cmd('/alt activate 672')
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Rogue's Fury
            if mq.TLO.Me.AltAbilityReady('Rogue\'s Fury')() and rog_burn_variables.targethp >= 50 and rog_burn_variables.targethp <= 99 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atAA\ag]\ao - Rogue\'s Fury')
                mq.cmd('/alt activate 3514')
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Shadow's Flanking
            if mq.TLO.Me.AltAbilityReady('Shadow\'s Flanking')() and rog_burn_variables.targethp >= 50 and rog_burn_variables.targethp <= 99 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atAA\ag]\ao - Shadow\'s Flanking')
                mq.cmd('/alt activate 1506')
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Spire of the Rake
            if mq.TLO.Me.AltAbilityReady('Spire of the Rake')() and rog_burn_variables.targethp >= 75 and rog_burn_variables.targethp <= 99 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atAA\ag]\ao - Spire of the Rake')
                mq.cmd('/alt activate 1410')
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Tumble
            if mq.TLO.Me.AltAbilityReady('Tumble')() and rog_burn_variables.myhp >= 1 and rog_burn_variables.myhp <= 50 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atAA\ag]\ao - Tumble')
                mq.cmd('/alt activate 673')
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
            --Twisted Shank
            if mq.TLO.Me.AltAbilityReady('Twisted Shank')() and rog_burn_variables.targethp >= 50 and rog_burn_variables.targethp <= 99 and RogBurn() then
                print(easy, ' \ag ROG Burn\aw - \ag[\atAA\ag]\ao - Twisted Shank')
                mq.cmd('/alt activate 670')
                mq.delay(490)
                if RogEngage() then
                    RogAggro()
                end
            end
        end
    end
end

-------------------------------------------------
------------------ MNK Burn ---------------------
-------------------------------------------------
local MNK_BURN = function ()
    local mnk_burn_variables = {
        targethp = mq.TLO.Target.PctHPs() or 0,
        targetdistance = mq.TLO.Target.Distance() or 0,
        myhp = mq.TLO.Me.PctHPs() or 0,
        maintank = mq.TLO.Group.MainTank.CleanName(),
        myendurance = mq.TLO.Me.PctEndurance(),
        xtarget = mq.TLO.Me.XTarget(),
        mymana = mq.TLO.Me.PctMana() or 0,
        maintankdistance = mq.TLO.Group.MainTank.Distance() or 0,
        targetlevel = mq.TLO.Target.Level() or 0,
        mepoisoned = mq.TLO.Me.CountersPoison() or 0,
        mypethp = mq.TLO.Me.Pet.PctHPs() or 0,
        mypetdistance = mq.TLO.Me.Pet.Distance() or 0,
        mypet = mq.TLO.Me.Pet.CleanName(),
        spell_rank = '',
        spell_ready = '',
        combat_true = mq.TLO.Me.Combat(),
        aggressive = mq.TLO.Target.Aggressive(),
        xtargetdistance = mq.TLO.Me.XTarget(1).Distance() or 0,
        hovering = mq.TLO.Me.Hovering()
        }
    local function MnkBurn()
        return not mq.TLO.Me.Hovering()
        and not mq.TLO.Me.Invulnerable()
        and not mq.TLO.Me.Silenced()
        and not mq.TLO.Me.Mezzed()
        and not mq.TLO.Me.Charmed()
        and not mq.TLO.Me.Feigning()
        and mq.TLO.Target.Aggressive()
        and mq.TLO.Me.Combat()
        and mq.TLO.Me.XTarget() >= 1
        and mnk_burn_variables.targetdistance <= 30
        and mnk_burn_variables.targetdistance >= 1
        and mnk_burn_variables.targethp >= defaults.STOP_BURN
        and mnk_burn_variables.targethp <= defaults.START_BURN  
        and mq.TLO.Target.ID() ~= 0
        and not mq.TLO.Me.Moving()
        and mq.TLO.Me.Buff('Resurrection Sickness')() == nil
    end
    local function MnkEngage()
        if Alive() and mq.TLO.Me.XTarget() ~= 0 then
            return mq.TLO.Me.XTarget(1).ID() >= 1
            and mnk_burn_variables.xtargetdistance <= 50
            and mnk_burn_variables.xtargetdistance >= 25
            and not mq.TLO.Navigation.Active()
        end
    end
    local function MnkAggro()
        if Alive() then
        if mq.TLO.Navigation.Active() then mq.cmd('/nav stop') end
        if mq.TLO.Target.ID() == 0 then
            mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID())
            mq.cmd('/face fast')
            mq.delay(500)
            mq.cmd('/stick')
            mq.cmd('/attack on')
        end
        end
    end
    if mq.TLO.Me.Class.ShortName() == 'MNK' and Alive() then
        UseGear()
        if MnkEngage() then
            MnkAggro()
        end
        if (mq.TLO.Target.ID() == 0 and mq.TLO.Me.Combat()) or (mq.TLO.Target.ID() ~= 0 and mq.TLO.Me.XTarget() == 0 and mq.TLO.Me.Combat()) then
            print('\ar[\apEasy\ar]\ay Not a valid target. Turning Attack OFF')
            mq.cmd('/attack off')
        end
        --Breather
        local breather = mq.TLO.Spell('Breather').RankName()
        if mq.TLO.Me.CombatAbilityReady('Breather')() and mnk_burn_variables.myendurance <= 20 and not mq.TLO.Me.Combat() and mq.TLO.Me.Song('Breather')() == nil and mnk_burn_variables.xtarget == 0 and not mnk_burn_variables.hovering then
            print(easy, ' \ag MNK Burn\aw - \ag[\atCombat Ability\ag]\ao - '..breather..'')
            mq.cmdf('/disc %s', breather)
            mq.delay(490)
            if MnkEngage() then
                MnkAggro()
            end
        end
        --Abilities
        if MnkBurn() then
            --Eagle Strike
            if mq.TLO.Me.AbilityReady('Eagle Strike')() and MnkBurn() then
                print(easy, ' \ag MNK Burn\aw - \ag[\atAbility\ag]\ao - Eagle Strike')
                mq.cmd('/doability "Eagle Strike"')
                mq.delay(490)
                if MnkEngage() then
                    MnkAggro()
                end
            end
            --Round Kick
            if mq.TLO.Me.AbilityReady('Round Kick')() and MnkBurn() then
                print(easy, ' \ag MNK Burn\aw - \ag[\atAbility\ag]\ao - Round Kick')
                mq.cmd('/doability "Round Kick"')
                mq.delay(490)
                if MnkEngage() then
                    MnkAggro()
                end
            end
            --Tail Rake
            if mq.TLO.Me.AbilityReady('Tail Rake')() and MnkBurn() then
                print(easy, ' \ag MNK Burn\aw - \ag[\atAbility\ag]\ao - Tail Rake')
                mq.cmd('/doability "Tail Rake"')
                mq.delay(490)
                if MnkEngage() then
                    MnkAggro()
                end
            end
            --Combat Abilities
            --Buffeting of Fists
            local buffeting_of_fists = mq.TLO.Spell('Buffeting of Fists').RankName()
            if mq.TLO.Me.CombatAbilityReady('Buffeting of Fists')() and mnk_burn_variables.targethp <= 99 and mnk_burn_variables.targethp >= 50 and MnkBurn() then
                print(easy, ' \ag MNK Burn\aw - \ag[\atCombat Ability\ag]\ao - '..buffeting_of_fists..'')
                mq.cmdf('/disc %s', buffeting_of_fists)
                mq.delay(490)
                if MnkEngage() then
                    MnkAggro()
                end
            end
            --AA
            --Destructive Force
            if mq.TLO.Me.AltAbilityReady('Destructive Force')() and mnk_burn_variables.targethp <= 99 and mnk_burn_variables.targethp >= 50 and MnkBurn() then
                print(easy, ' \ag MNK Burn\aw - \ag[\atAA\ag]\ao - Destructive Force')
                mq.cmd('/alt activate 276')
                mq.delay(490)
                if MnkEngage() then
                    MnkAggro()
                end
            end
            --Silent Strikes
            if mq.TLO.Me.AltAbilityReady('Silent Strikes')() and mnk_burn_variables.targethp <= 99 and mnk_burn_variables.targethp >= 50 and MnkBurn() then
                print(easy, ' \ag MNK Burn\aw - \ag[\atAA\ag]\ao - Silent Strikes')
                mq.cmd('/alt activate 1109')
                mq.delay(490)
                if MnkEngage() then
                    MnkAggro()
                end
            end
            --Vehement Rage
            if MnkBurn() and mq.TLO.Me.AltAbilityReady('Vehement Rage')() and mnk_burn_variables.targethp <= 99 and mnk_burn_variables.targethp >= 50 and MnkBurn() then
                print(easy, ' \ag MNK Burn\aw - \ag[\atAA\ag]\ao - Vehement Rage')
                mq.cmd('/alt activate 800')
                mq.delay(490)
                if MnkEngage() then
                    MnkAggro()
                end
            end
            --Five Point Palm
            if MnkBurn() and mq.TLO.Me.AltAbilityReady('Five Point Palm')() and mnk_burn_variables.targethp <= 99 and mnk_burn_variables.targethp >= 50 and MnkBurn() then
                print(easy, ' \ag MNK Burn\aw - \ag[\atAA\ag]\ao - Five Point Palm')
                mq.cmd('/alt activate 1012')
                mq.delay(490)
                if MnkEngage() then
                    MnkAggro()
                end
            end
            --Infusion of Thunder
            if MnkBurn() and mq.TLO.Me.AltAbilityReady('Infusion of Thunder')() and mnk_burn_variables.targethp <= 99 and mnk_burn_variables.targethp >= 50 and MnkBurn() then
                print(easy, ' \ag MNK Burn\aw - \ag[\atAA\ag]\ao - Infusion of Thunder')
                mq.cmd('/alt activate 945')
                mq.delay(490)
                if MnkEngage() then
                    MnkAggro()
                end
            end
            --Purified Body
            if mq.TLO.Me.AltAbilityReady('Purified Body')() and mnk_burn_variables.mepoisoned >= 1 and not mnk_burn_variables.hovering then
                mq.cmdf('/target %s',mq.TLO.Me.CleanName())
                print(easy, ' \ag MNK Burn\aw - \ag[\atAA\ag]\ao - Purified Body')
                mq.cmd('/alt activate 98')
                mq.delay(490)
                if MnkEngage() then
                    MnkAggro()
                end
            end
            --Spire of the Sensei
            if mq.TLO.Me.AltAbilityReady('Spire of the Sensei')() and mnk_burn_variables.targethp <= 99 and mnk_burn_variables.targethp >= 50 and MnkBurn() then
                print(easy, ' \ag MNK Burn\aw - \ag[\atAA\ag]\ao - Spire of the Sensei')
                mq.cmd('/alt activate 1360')
                mq.delay(490)
                if MnkEngage() then
                    MnkAggro()
                end
            end
            --Swift Tails' Chant
            if mq.TLO.Me.AltAbilityReady('Swift Tails\' Chant')() and mnk_burn_variables.targethp <= 99 and mnk_burn_variables.targethp >= 50 and MnkBurn() and not mnk_burn_variables.hovering and mnk_burn_variables.myendurance <= 50 and not mq.TLO.Me.Moving() and mq.TLO.Me.Standing() then
                print(easy, ' \ag MNK Burn\aw - \ag[\atAA\ag]\ao - Swift Tails\' Chant')
                mq.cmd('/alt activate 1014')
                mq.delay(490)
                if MnkEngage() then
                    MnkAggro()
                end
            end
            --Ton Po's Stance
            if mq.TLO.Me.AltAbilityReady('Ton Po\'s Stance')() and mnk_burn_variables.targethp <= 99 and mnk_burn_variables.targethp >= 50 and MnkBurn() then
                print(easy, ' \ag MNK Burn\aw - \ag[\atAA\ag]\ao - Ton Po\'s Stance')
                mq.cmd('/alt activate 1016')
                mq.delay(490)
                if MnkEngage() then
                    MnkAggro()
                end
            end
            --Two-Finger Wasp Touch
            if mq.TLO.Me.AltAbilityReady('Two-Finger Wasp Touch')() and mnk_burn_variables.targethp <= 99 and mnk_burn_variables.targethp >= 50 and MnkBurn() then
                print(easy, ' \ag MNK Burn\aw - \ag[\atAA\ag]\ao - Two-Finger Wasp Touch')
                mq.cmd('/alt activate 1235')
                mq.delay(490)
                if MnkEngage() then
                    MnkAggro()
                end
            end
            --Zan Fi's Whistle
            if mq.TLO.Me.AltAbilityReady('Zan Fi\'s Whistle')() and mnk_burn_variables.targethp <= 99 and mnk_burn_variables.targethp >= 50 and MnkBurn() then
                print(easy, ' \ag MNK Burn\aw - \ag[\atAA\ag]\ao - Zan Fi\'s Whistle')
                mq.cmd('/alt activate 7001')
                mq.delay(490)
                if MnkEngage() then
                    MnkAggro()
                end
            end
        end
    end
end

-------------------------------------------------
------------------ BST Burn ---------------------
-------------------------------------------------
local BST_BURN = function ()
    local bst_burn_variables = {
        targethp = mq.TLO.Target.PctHPs() or 0,
        targetdistance = mq.TLO.Target.Distance() or 0,
        myhp = mq.TLO.Me.PctHPs() or 0,
        maintank = mq.TLO.Group.MainTank.CleanName(),
        myendurance = mq.TLO.Me.PctEndurance(),
        xtarget = mq.TLO.Me.XTarget(),
        mymana = mq.TLO.Me.PctMana() or 0,
        maintankdistance = mq.TLO.Group.MainTank.Distance() or 0,
        targetlevel = mq.TLO.Target.Level() or 0,
        mepoisoned = mq.TLO.Me.CountersPoison() or 0,
        mypethp = mq.TLO.Me.Pet.PctHPs() or 0,
        mypetdistance = mq.TLO.Me.Pet.Distance() or 0,
        mypet = mq.TLO.Me.Pet.CleanName(),
        spell_rank = '',
        spell_ready = '',
        combat_true = mq.TLO.Me.Combat(),
        aggressive = mq.TLO.Target.Aggressive(),
        xtargetdistance = mq.TLO.Me.XTarget(1).Distance() or 0,
        hovering = mq.TLO.Me.Hovering()
        }
    local function BstBurn()
        return not mq.TLO.Me.Hovering()
        and not mq.TLO.Me.Invulnerable()
        and not mq.TLO.Me.Silenced()
        and not mq.TLO.Me.Mezzed()
        and not mq.TLO.Me.Charmed()
        and not mq.TLO.Me.Feigning()
        and mq.TLO.Target.Aggressive()
        and mq.TLO.Me.Combat()
        and mq.TLO.Me.XTarget() >= 1
        and bst_burn_variables.targetdistance <= 30
        and bst_burn_variables.targetdistance >= 1
        and bst_burn_variables.targethp >= defaults.STOP_BURN
        and bst_burn_variables.targethp <= defaults.START_BURN  
        and mq.TLO.Target.ID() ~= 0
        and not mq.TLO.Me.Moving()
        and mq.TLO.Me.Buff('Resurrection Sickness')() == nil
    end
    local function BstEngage()
        if Alive() and mq.TLO.Me.XTarget() ~= 0 then
            return mq.TLO.Me.XTarget(1).ID() >= 1
            and bst_burn_variables.xtargetdistance <= 50
            and bst_burn_variables.xtargetdistance >= 25
            and not mq.TLO.Navigation.Active()
        end
    end
    local function BstAggro()
        if Alive() then
        if mq.TLO.Navigation.Active() then mq.cmd('/nav stop') end
        if mq.TLO.Target.ID() == 0 then
            mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID())
            mq.cmd('/face fast')
            mq.delay(500)
            mq.cmd('/stick')
            mq.cmd('/attack on')
        end
        end
    end
    if mq.TLO.Me.Class.ShortName() == 'BST' and Alive() then
        UseGear()
        if BstEngage() then
            BstAggro()
        end
        if (mq.TLO.Target.ID() == 0 and mq.TLO.Me.Combat()) or (mq.TLO.Target.ID() ~= 0 and mq.TLO.Me.XTarget() == 0 and mq.TLO.Me.Combat()) then
            print('\ar[\apEasy\ar]\ay Not a valid target. Turning Attack OFF')
            mq.cmd('/attack off')
        end
        
        --Breather
        local breather = mq.TLO.Spell('Breather').RankName()
        if mq.TLO.Me.CombatAbilityReady('Breather')() and bst_burn_variables.myendurance <= 20 and not mq.TLO.Me.Combat() and mq.TLO.Me.Song('Breather')() == nil and bst_burn_variables.xtarget == 0 and not bst_burn_variables.hovering then
            print(easy, ' \ag BST Burn\aw - \ag[\atCombat Ability\ag]\ao - '..breather..'')
            mq.cmdf('/disc %s', breather)
            mq.delay(490)
            if BstEngage() then
                BstAggro()
            end
        end
        --Paragon of Spirit
        if mq.TLO.Me.AltAbilityReady('Paragon of Spirit')() and bst_burn_variables.mymana <= 80 and bst_burn_variables.mymana >= 1 and mq.TLO.Me.Song('Paragon of Spirit')() == nil and mq.TLO.Me.Buff('Focused Paragon of Spirit')() == nil and not bst_burn_variables.hovering and not mq.TLO.Me.Moving() then
            print(easy, ' \ag BST Burn\aw - \ag[\atAA\ag]\ao - Paragon of Spirit')
            mq.cmd('/alt activate 128')
            mq.delay(490)
            if BstEngage() then
                BstAggro()
            end
        end
        --Summoned: Sahdi's Emblem of the Enchanced Minion
        if mq.TLO.FindItemCount('Summoned: Sahdi\'s Emblem of the Enhanced Minion')() >=1 and mq.TLO.Me.Pet.Buff('Enhanced Minion')() == nil and mq.TLO.Me.Pet.CleanName() ~= nil and not bst_burn_variables.hovering  then
            print(easy, ' \ag BST Burn\aw - \ag[\atClicky\ag]\ao - Summoned: Sahdi\'s Emblem of the Enhanced Minion')
            mq.cmdf('/target %s', mq.TLO.Me.Pet.CleanName())
            mq.cmd('/useitem "Summoned: Sahdi\'s Emblem of the Enhanced Minion"')
            mq.delay(500)
            while mq.TLO.Me.Casting() do mq.delay(250) end
            if BstEngage() then
               BstAggro()
            end
        end
        --Focused Paragon of Spirits
        if mq.TLO.Me.AltAbilityReady('Focused Paragon of Spirits')() and bst_burn_variables.mymana <= 80 and bst_burn_variables.mymana >= 1 and mq.TLO.Me.Song('Paragon of Spirit')() == nil and mq.TLO.Me.Buff('Focused Paragon of Spirit')() == nil and not bst_burn_variables.hovering and not mq.TLO.Me.Moving() then
            mq.cmdf('/target id %s', mq.TLO.Me.ID())
            mq.delay(50)
            print(easy, ' \ag BST Burn\aw - \ag[\atAA\ag]\ao - Focused Paragon of Spirits')
            mq.cmd('/alt activate 3817')
            mq.delay(490)
            if BstEngage() then
                BstAggro()
            end
        end
        --Abilities
        if BstBurn() then
            --Eagle Strike
            if mq.TLO.Me.AbilityReady('Eagle Strike')() and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atAbility\ag]\ao - Eagle Strike')
                mq.cmd('/doability "Eagle Strike"')
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Round Kick
            if mq.TLO.Me.AbilityReady('Round Kick')() and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atAbility\ag]\ao - Round Kick')
                mq.cmd('/doability "Round Kick"')
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Combat Abilities
            --Kejaan's Vindication
            local kejaans_vindication = mq.TLO.Spell('Kejaan\'s Vindication').RankName()
            if mq.TLO.Me.CombatAbilityReady('Kejaan\'s Vindication')() and bst_burn_variables.targethp <= 99 and bst_burn_variables.targethp >= 50 and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atCombat Ability\ag]\ao - '..kejaans_vindication..'')
                mq.cmdf('/disc %s', kejaans_vindication)
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Reflexive Riving
            local reflexive_riving = mq.TLO.Spell('Reflexive Riving').RankName()
            if mq.TLO.Me.CombatAbilityReady('Reflexive Riving')() and bst_burn_variables.targethp >= 80 and bst_burn_variables.targethp <= 99 and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atCombat Ability\ag]\ao - '..reflexive_riving..'')
                mq.cmdf('/disc %s', reflexive_riving)
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Monkey's Spirit Discipline
            local monkeys_spirit_discipline = mq.TLO.Spell('Monkey\'s Spirit Discipline').RankName()
            if mq.TLO.Me.CombatAbilityReady('Monkey\'s Spirit Discipline')() and bst_burn_variables.myhp <= 60 and bst_burn_variables.myhp >= 1 and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atCombat Ability\ag]\ao - '..monkeys_spirit_discipline..'')
                mq.cmdf('/disc %s', monkeys_spirit_discipline)
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Clobber
            local clobber = mq.TLO.Spell('Clobber').RankName()
            if mq.TLO.Me.CombatAbilityReady('Clobber')() and bst_burn_variables.targethp >= 60 and bst_burn_variables.targethp <= 99 and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atCombat Ability\ag]\ao - '..clobber..'')
                mq.cmdf('/disc %s', clobber)
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Bestial Fierceness
            local bestial_fierceness = mq.TLO.Spell('Bestial Fierceness').RankName()
            if mq.TLO.Me.CombatAbilityReady('Bestial Fierceness')() and bst_burn_variables.targethp >=50 and bst_burn_variables.targethp <= 99 and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atCombat Ability\ag]\ao - '..bestial_fierceness..'')
                mq.cmdf('/disc %s', bestial_fierceness)
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Eruption of Claws
            local eruption_of_claws = mq.TLO.Spell('Eruption of Claws').RankName()
            if mq.TLO.Me.CombatAbilityReady('Eruption of Claws')() and bst_burn_variables.targethp <= 99 and bst_burn_variables.targethp >= 55 and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atCombat Ability\ag]\ao - '..eruption_of_claws..'')
                mq.cmdf('/disc %s', eruption_of_claws)
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Resistant Discipline
            local resistant_discipline = mq.TLO.Spell('Resistant Discipline').RankName()
            if mq.TLO.Me.CombatAbilityReady('Resistant Discipline')() and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atCombat Ability\ag]\ao - '..resistant_discipline..'')
                mq.cmdf('/disc %s', resistant_discipline)
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Ruaabri's Fury
            local ruaabris_fury = mq.TLO.Spell('Ruaabri\'s Fury').RankName()
            if mq.TLO.Me.CombatAbilityReady('Ruaabri\'s Fury')() and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atCombat Ability\ag]\ao - '..ruaabris_fury..'')
                mq.cmdf('/disc %s', ruaabris_fury)
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Savage Rancor
            local savage_rancor = mq.TLO.Spell('Savage Rancor').RankName()
            if mq.TLO.Me.CombatAbilityReady('Savage Rancor')() and bst_burn_variables.targethp <= 99 and bst_burn_variables.targethp >= 50 and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atCombat Ability\ag]\ao - '..savage_rancor..'')
                mq.cmdf('/disc %s', savage_rancor)
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Protective Spirit Discipline
            local protective_spirit_discipline = mq.TLO.Spell('Protective Spirit Discipline').RankName()
            if mq.TLO.Me.CombatAbilityReady('Protective Spirit Discipline')() and bst_burn_variables.myhp <= 60 and bst_burn_variables.myhp >= 1 and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atCombat Ability\ag]\ao - '..protective_spirit_discipline..'')
                mq.cmdf('/disc %s', protective_spirit_discipline)
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --AA
            --Falsified Death
            if mq.TLO.Me.AltAbilityReady('Falsified Death')() and bst_burn_variables.myhp >= 1 and bst_burn_variables.myhp <= 10 and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atAA\ag]\ao - Falsified Death')
                mq.cmd('/alt activate 421')
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Companion's Aegis
            if mq.TLO.Me.AltAbilityReady('Companion\'s Aegis')() and bst_burn_variables.mypethp >= 1 and bst_burn_variables.mypethp <= 50 and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Aegis')
                mq.cmd('/alt activate 441')
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Companion's Fortification
            if mq.TLO.Me.AltAbilityReady('Companion\'s Fortification')() and bst_burn_variables.mypethp >= 50 and bst_burn_variables.mypethp <= 100 and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Fortification')
                mq.cmd('/alt activate 3707')
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Companion's Fury
            if mq.TLO.Me.AltAbilityReady('Companion\'s Fury')() and bst_burn_variables.targethp >= 50 and bst_burn_variables.targethp <= 99 and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Fury')
                mq.cmd('/alt activate 443')
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Mend Companion
            if mq.TLO.Me.AltAbilityReady('Mend Companion')() and bst_burn_variables.mypethp <= 50 and bst_burn_variables.mypethp >= 1 and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atAA\ag]\ao - Mend Companion')
                mq.cmd('/alt activate 58')
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Companion's Intervening Divine Aura
            if mq.TLO.Me.AltAbilityReady('Companion\'s Intervening Divine Aura')() and bst_burn_variables.mypethp <= 20 and bst_burn_variables.mypethp >= 1 and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Intervening Divine Aura')
                mq.cmd('/alt activate 1580')
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Frenzied Swipes
            if mq.TLO.Me.AltAbilityReady('Frenzied Swipes')() and bst_burn_variables.targethp >= 75 and bst_burn_variables.targethp <= 99 and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atAA\ag]\ao - Frenzied Swipes')
                mq.cmd('/alt activate 1240')
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Bloodlust
            if mq.TLO.Me.AltAbilityReady('Bloodlust')() and bst_burn_variables.targethp >= 75 and bst_burn_variables.targethp <= 99 and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atAA\ag]\ao - Bloodlust')
                mq.cmd('/alt activate 241')
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Hobble of Spirits
            if mq.TLO.Me.AltAbilityReady('Hobble of Spirits')() and mq.TLO.Me.Pet.Buff('Hobble of Spirits')() == nil and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atAA\ag]\ao - Hobble of Spirits')
                mq.cmd('/alt activate 126')
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Sha's Reprisal
            if mq.TLO.Me.AltAbilityReady('Sha\'s Reprisal')() and mq.TLO.Target.Buff('Turgur\'s Insects')() == nil and mq.TLO.Target.Buff('Sha\'s Reprisal')() == nil and bst_burn_variables.targethp >= 1 and bst_burn_variables.targethp <= 98 and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atAA\ag]\ao - Sha\'s Reprisal')
                mq.cmd('/alt activate 1269')
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Spire of the Savage Lord
            if mq.TLO.Me.AltAbilityReady('Spire of the Savage Lord')() and bst_burn_variables.targethp <= 99 and bst_burn_variables.targethp >= 70 and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atAA\ag]\ao - Spire of the Savage Lord')
                mq.cmd('/alt activate 1430')
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Nature's Salve
            if mq.TLO.Me.AltAbilityReady('Nature\'s Salve')() and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atAA\ag]\ao - Nature\'s Salve')
                mq.cmd('/alt activate 8303')
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Chameleon Strike
            if mq.TLO.Me.AltAbilityReady('Chamelion Strike')() and bst_burn_variables.targethp <= 99 and bst_burn_variables.targethp >= 10 and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atAA\ag]\ao - Chameleon Strike')
                mq.cmd('/alt activate 11080')
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Roar of Thunder
            if mq.TLO.Me.AltAbilityReady('Roar of Thunder')() and bst_burn_variables.targethp >= 50 and bst_burn_variables.targethp <= 99 and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atAA\ag]\ao - Roar of Thunder')
                mq.cmd('/alt activate 362')
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Roaring Strike
            if mq.TLO.Me.AltAbilityReady('Roaring Strike')() and bst_burn_variables.targethp >= 25 and bst_burn_variables.targethp <= 99 and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atAA\ag]\ao - Roaring Strike')
                mq.cmd('/alt activate 972')
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Pact of the Wurine
            if mq.TLO.Me.AltAbilityReady('Pact of the Wurine')() and mq.TLO.Me.Buff('Pact of the Wurine')() == nil and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atAA\ag]\ao - Pact of the Wurine')
                mq.cmd('/alt activate 3709')
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Protection of the Warder
            if mq.TLO.Me.AltAbilityReady('Protection of the Warder')() and bst_burn_variables.myhp <= 20 and bst_burn_variables.myhp >= 1 and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atAA\ag]\ao - Protection of the Warder')
                mq.cmd('/alt activate 8302')
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Ferociousness
            if mq.TLO.Me.AltAbilityReady('Ferociousness')() and bst_burn_variables.targethp <= 99 and bst_burn_variables.targethp >= 50 and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atAA\ag]\ao - Ferociousness')
                mq.cmd('/alt activate 966')
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Frenzy of Spirit
            if mq.TLO.Me.AltAbilityReady('Frenzy of Spirit')() and bst_burn_variables.targethp >= 55 and bst_burn_variables.targethp <= 99 and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atAA\ag]\ao - Frenzy of Spirit')
                mq.cmd('/alt activate 127')
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Group Bestial Alignment
            if mq.TLO.Me.AltAbilityReady('Group Bestial Alignment')() and bst_burn_variables.targethp >= 75 and bst_burn_variables.targethp <= 99 and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atAA\ag]\ao - Group Bestial Alignment')
                mq.cmd('/alt activate 985')
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Companion's Shielding
            if mq.TLO.Me.AltAbilityReady('Companion\'s Shielding')() and bst_burn_variables.mypethp <= 20 and bst_burn_variables.mypethp >= 1 and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Shielding')
                mq.cmd('/alt activate 444')
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Attack of the Warders
            if mq.TLO.Me.AltAbilityReady('Attack of the Warders')() and bst_burn_variables.targethp >= 55 and bst_burn_variables.targethp <= 99 and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atAA\ag]\ao - Attack of the Warders')
                mq.cmd('/alt activate 981')
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Consumption of Spirit
            if mq.TLO.Me.AltAbilityReady('Consumption of Spirit')() and bst_burn_variables.mymana <= 60 and bst_burn_variables.mymana >= 1 and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atAA\ag]\ao - Consumption of Spirit')
                mq.cmd('/alt activate 1239')
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
            --Enduring Frenzy
            if mq.TLO.Me.AltAbilityReady('Enduring Frenzy')() and bst_burn_variables.targethp <= 99 and bst_burn_variables.targethp >= 75 and BstBurn() then
                print(easy, ' \ag BST Burn\aw - \ag[\atAA\ag]\ao - Enduring Frenzy')
                mq.cmd('/alt activate 2068')
                mq.delay(490)
                if BstEngage() then
                    BstAggro()
                end
            end
        end
    end
end

-------------------------------------------------
------------------ NEC Burn ---------------------
-------------------------------------------------
local NEC_BURN = function ()
    local nec_burn_variables = {
        targethp = mq.TLO.Target.PctHPs() or 0,
        targetdistance = mq.TLO.Target.Distance() or 0,
        myhp = mq.TLO.Me.PctHPs() or 0,
        maintank = mq.TLO.Group.MainTank.CleanName(),
        myendurance = mq.TLO.Me.PctEndurance(),
        xtarget = mq.TLO.Me.XTarget(),
        mymana = mq.TLO.Me.PctMana() or 0,
        maintankdistance = mq.TLO.Group.MainTank.Distance() or 0,
        targetlevel = mq.TLO.Target.Level() or 0,
        mepoisoned = mq.TLO.Me.CountersPoison() or 0,
        mypethp = mq.TLO.Me.Pet.PctHPs() or 0,
        mypetdistance = mq.TLO.Me.Pet.Distance() or 0,
        mypet = mq.TLO.Me.Pet.CleanName(),
        spell_rank = '',
        spell_ready = '',
        aggressive = mq.TLO.Target.Aggressive(),
        xtargetdistance = mq.TLO.Me.XTarget(1).Distance() or 0,
        hovering = mq.TLO.Me.Hovering()
        }
    local function NecBurn()
        return not mq.TLO.Me.Hovering()
        and not mq.TLO.Me.Invulnerable()
        and not mq.TLO.Me.Silenced()
        and not mq.TLO.Me.Mezzed()
        and not mq.TLO.Me.Charmed()
        and not mq.TLO.Me.Feigning()
        and mq.TLO.Target.Aggressive()
        and mq.TLO.Me.XTarget() >= 1
        and nec_burn_variables.targetdistance <= 100
        and nec_burn_variables.targetdistance >= 1
        and nec_burn_variables.targethp >= defaults.STOP_BURN
        and nec_burn_variables.targethp <= defaults.START_BURN
        and mq.TLO.Target.ID() ~= 0
        and not mq.TLO.Me.Moving()
        and mq.TLO.Me.Buff('Resurrection Sickness')() == nil
    end
    local function NecEngage()
        if Alive() and mq.TLO.Me.XTarget() ~= 0 then
            return mq.TLO.Me.XTarget(1).ID() >= 1
            and nec_burn_variables.xtargetdistance <= 50
            and nec_burn_variables.xtargetdistance >= 25
            and not mq.TLO.Navigation.Active()
        end
    end
    local function NecAggro()
        if Alive() then
        if mq.TLO.Navigation.Active() then mq.cmd('/nav stop') end
            if mq.TLO.Target.ID() == 0 then
                mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID())
                mq.cmd('/face fast')
                if mq.TLO.Pet.ID() ~= nil then
                    mq.cmd('/pet attack')
                end
            end
        end
    end
    if mq.TLO.Me.Class.ShortName() == 'NEC' and Alive() then
        UseGear()
            --Summoned: Kotahl's Tonic of Healing
            if mq.TLO.FindItemCount('Summoned: Kotahl\'s Tonic of Healing')() > 0 and mq.TLO.FindItem("Summoned: Kotahl's Tonic of Healing").TimerReady() == 0 and nec_burn_variables.myhp <= 90 and nec_burn_variables.myhp >= 1 and mq.TLO.Me.Song('Renewal')() == nil and not nec_burn_variables.hovering then
                print(easy, ' \agNEC Using:\ap Summoned: Kotahl\'s Tonic of Healing.')
                mq.cmdf("/useitem %s", 'Summoned: Kotahl\'s Tonic of Healing')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            
            --Summoned: Kotahl's Tonic of Refreshment
            if mq.TLO.FindItemCount('Summoned: Kotahl\'s Tonic of Refreshment')() > 0 and mq.TLO.FindItem("Summoned: Kotahl's Tonic of Refreshment").TimerReady() == 0 and nec_burn_variables.myendurance <= 90 and nec_burn_variables.myendurance >= 1 and not nec_burn_variables.hovering then
                print(easy, ' \agNEC Using:\ap Summoned: Kotahl\'s Tonic of Refreshment.')
                mq.cmdf("/useitem %s", 'Summoned: Kotahl\'s Tonic of Refreshment')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            --Summoned: Kotahl's Tonic of Clarity
            if mq.TLO.FindItemCount('Summoned: Kotahl\'s Tonic of Clarity')() > 0 and mq.TLO.FindItem("Summoned: Kotahl's Tonic of Clarity").TimerReady() == 0 and nec_burn_variables.mymana <= 90 and nec_burn_variables.mymana >= 1 and not nec_burn_variables.hovering and mq.TLO.Me.Song('Paragon of Spirit')() == nil then
                print(easy, ' \agNEC Using:\ap Summoned: Kotahl\'s Tonic of Clarity.')
                mq.cmdf("/useitem %s", 'Summoned: Kotahl\'s Tonic of Clarity')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            --Exalted Tonic of Healing
            if mq.TLO.FindItemCount('Exalted Tonic of Healing')() > 0 and mq.TLO.FindItem("Exalted Tonic of Healing").TimerReady() == 0 and nec_burn_variables.myhp <= 90 and nec_burn_variables.myhp >= 1 and mq.TLO.Me.Song('Renewal')() == nil and not nec_burn_variables.hovering then
                print(easy, ' \agNEC Using:\ap Exalted Tonic of Healing.')
                mq.cmdf("/useitem %s", 'Exalted Tonic of Healing')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            --Delete Ether-Fused Shard
            if mq.TLO.FindItemCount('Ether-Fused Shard')() > 0 and mq.TLO.FindItem('Ether-Fused Shard').Charges() < 1 and not nec_burn_variables.hovering then
                mq.cmd('/ctrl /itemnotify "Ether-Fused Shard" leftmouseup')
                mq.delay('1s')
                if mq.TLO.Cursor.ID() == 85487 then
                    mq.cmd('/destroy')
                    print(easy, ' \arNec Destroyed:\ay (Empty) \apEther-Fused Shard.')
                end
                mq.delay(500)
                if NecEngage() then
                   NecAggro()
                end
            end
            --Summoned: Sahdi's Emblem of the Enchanced Minion
            if mq.TLO.FindItemCount('Summoned: Sahdi\'s Emblem of the Enhanced Minion')() >=1 and mq.TLO.Me.Pet.Buff('Enhanced Minion')() == nil and mq.TLO.Me.Pet.CleanName() ~= nil and not nec_burn_variables.hovering  then
                print(easy, ' \ag NEC Burn\aw - \ag[\atClicky\ag]\ao - Summoned: Sahdi\'s Emblem of the Enhanced Minion')
                mq.cmdf('/target %s', mq.TLO.Me.Pet.CleanName())
                mq.cmd('/useitem "Summoned: Sahdi\'s Emblem of the Enhanced Minion"')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            --Imprint of the Enhanced Minion
            if mq.TLO.FindItemCount('Imprint of the Enhanced Minion')() >=1 and mq.TLO.Me.Pet.Buff('Enhanced Minion')() == nil and mq.TLO.Me.Pet.CleanName() ~= nil and not nec_burn_variables.hovering then
                print(easy, ' \ag NEC Burn\aw - \ag[\atClicky\ag]\ao - Imprint of the Enhanced Minion')
                mq.cmdf('/target %s', mq.TLO.Me.Pet.CleanName())
                mq.cmd('/useitem "Imprint of the Enhanced Minion"')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
        if NecBurn() then
            --BURNING
            --AA
            --Companion's Aegis
            if mq.TLO.Me.AltAbilityReady('Companion\'s Aegis')() and nec_burn_variables.mypethp <= 50 and nec_burn_variables.mypethp >= 1 and NecBurn() then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Aegis')
                mq.cmd('/alt activate 441')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            --Companion's Fortification
            if mq.TLO.Me.AltAbilityReady('Companion\'s Fortification')() and nec_burn_variables.mypethp >= 50 and nec_burn_variables.mypethp <= 100 and NecBurn() then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Fortification')
                mq.cmd('/alt activate 3707')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            --Companion's Fury
            if mq.TLO.Me.AltAbilityReady('Companion\'s Fury')() and nec_burn_variables.targethp >= 50 and nec_burn_variables.targethp <= 99 and NecBurn() then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Fury')
                mq.cmd('/alt activate 766')
                mq.delay(490)
                if NecEngage() then
                    NecAggro()
                end
            end
            --Companion's Intervening Divine Aura
            if mq.TLO.Me.AltAbilityReady('Companion\'s Intervening Divine Aura')() and nec_burn_variables.mypethp <= 30 and nec_burn_variables.mypethp >= 1 and NecBurn() then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Intervening Divine Aura')
                mq.cmd('/alt activate 1580')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            --Death Peace
            if mq.TLO.Me.AltAbilityReady('Death Peace')() and nec_burn_variables.myhp <= 20 and NecBurn() then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Death Peace')
                mq.cmd('/alt activate 428')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                while mq.TLO.Me.XTarget() >= 1 do mq.delay(100) end
                mq.cmd('/stand')
            end
            --Death's Effigy
            if mq.TLO.Me.AltAbilityReady('Death\'s Effigy')() and nec_burn_variables.myhp <= 20 and NecBurn() then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Death\'s Effigy')
                mq.cmd('/alt activate 773')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                while mq.TLO.Me.XTarget() >= 1 do mq.delay(100) end
                mq.cmd('/stand')
            end
            --Harmshield
            if mq.TLO.Me.AltAbilityReady('Harmshield')() and nec_burn_variables.myhp <= 50 and NecBurn() then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Harmshield')
                mq.cmd('/alt activate 821')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                mq.delay('17s')
                if NecEngage() then
                    NecAggro()
                 end
            end
            --Eradicate Magic
            if mq.TLO.Me.AltAbilityReady('Eradicate Magic')() and nec_burn_variables.mepoisoned >= 1 and NecBurn() then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Eradicate Magic')
                mq.cmd('/target %s',mq.TLO.Me.CleanName())
                mq.delay(100)
                mq.cmd('/alt activate 547')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            --Focus of Arcanum
            if mq.TLO.Me.AltAbilityReady('Focus of Arcanum')() and NecBurn() then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Focus of Arcanum')
                mq.cmd('/alt activate 1211')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            --Forceful Rejuvenation
            if mq.TLO.Me.AltAbilityReady('Forceful Rejuvenation')() and NecBurn() then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Foreceful Rejuvenation')
                mq.cmd('/alt activate 7003')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            --Encroaching Darkness
            if mq.TLO.Me.AltAbilityReady('Encroaching Darkness')() and mq.TLO.Target.Buff('Encroaching Darkness')() == nil and mq.TLO.Target.Buff('Entombing Darkness')() == nil and nec_burn_variables.targethp >= 50 and NecBurn() then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Encroaching Darkness')
                mq.cmd('/alt activate 826')
                mq.delay(490)
                if NecEngage() then
                    NecAggro()
                end
            end
            --Mend Companion
            if mq.TLO.Me.AltAbilityReady('Mend Companion')() and nec_burn_variables.mypethp <= 40 and nec_burn_variables.mypethp >= 1 and not nec_burn_variables.hovering then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Mend Companion')
                mq.cmd('/alt activate 58')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            --Silent Casting
            if mq.TLO.Me.AltAbilityReady('Silent Casting')() and nec_burn_variables.targethp >= 80 and NecBurn() then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Silent Casting')
                mq.cmd('/alt activate 500')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            --Pestilent Paralysis
            if mq.TLO.Me.AltAbilityReady('Pestilent Paralysis')() and nec_burn_variables.targethp >= 50 and nec_burn_variables.targethp <= 99 and mq.TLO.Me.XTarget() >= 3 and NecBurn() then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Pestilent Paralysis')
                mq.cmd('/alt activate 431')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            --Summon Companion
            if mq.TLO.Me.AltAbilityReady('Summon Companion')() and nec_burn_variables.mypetdistance >= 200 or mq.TLO.Me.AltAbilityReady('Summon Companion')() and nec_burn_variables.mypetdistance >= 100 and nec_burn_variables.mypethp <= 40 and nec_burn_variables.mypethp >= 1 and not nec_burn_variables.hovering then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Summon Companion')
                mq.cmd('/alt activate 1215')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            --Blood Magic
            if mq.TLO.Me.AltAbilityReady('Blood Magic')() and nec_burn_variables.myhp >= 50 and nec_burn_variables.myhp <= 100 and nec_burn_variables.mymana <= 30 and NecBurn() then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Blood Magic')
                mq.cmd('/alt activate 524')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            --Death Bloom
            if mq.TLO.Me.AltAbilityReady('Death Bloom')() and nec_burn_variables.myhp >= 50 and nec_burn_variables.myhp <= 100 and nec_burn_variables.mymana <= 20 and NecBurn() then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Death Bloom')
                mq.cmd('/alt activate 7703')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            --Dying Grasp
            if mq.TLO.Me.AltAbilityReady('Dying Grasp')() and nec_burn_variables.targethp >= 40 and nec_burn_variables.targethp <= 98 and NecBurn() then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Dying Grasp')
                mq.cmd('/alt activate 351')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            --Embalmer's Carapace
            if mq.TLO.Me.AltAbilityReady('Embalmer\'s Carapace')() and nec_burn_variables.myhp <= 35 and nec_burn_variables.myhp >= 30 and mq.TLO.Me.XTarget() >= 3 and NecBurn() then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Embalmer\'s Carapace')
                mq.cmd('/alt activate 433')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            --Embrace the Decay
            if mq.TLO.Me.AltAbilityReady('Embrace the Decay')() and nec_burn_variables.mepoisoned >= 1 and NecBurn() then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Embrace the Decay')
                mq.cmd('/target %s',mq.TLO.Me.CleanName())
                mq.delay(100)
                mq.cmd('/alt activate 764')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            --Hand of Death
            if mq.TLO.Me.AltAbilityReady('Hand of Death')() and nec_burn_variables.targethp <= 99 and nec_burn_variables.targethp >= 60 and NecBurn() then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Hand of Death')
                mq.cmd('/alt activate 1257')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            --Fear Storm
            if mq.TLO.Me.AltAbilityReady('Fear Storm')() and nec_burn_variables.targethp <= 99 and nec_burn_variables.targethp >= 60 and mq.TLO.Me.XTarget() >= 3 and NecBurn() then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Fear Storm')
                mq.cmd('/alt activate 70')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            --Heretic's Twincast
            if mq.TLO.Me.AltAbilityReady('Heretic\'s Twincast')() and NecBurn() then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Heretic\'s Twincast')
                mq.cmd('/alt activate 677')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            --Mercurial Torment
            if mq.TLO.Me.AltAbilityReady('Mercurial Torment')() and NecBurn() then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Mercurial Torment')
                mq.cmd('/alt activate 430')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            --Life Burn
            if mq.TLO.Me.AltAbilityReady('Life Burn')() and nec_burn_variables.targethp <= 99 and nec_burn_variables.targethp >= 60 and NecBurn() then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Life Burn')
                mq.cmd('/alt activate 68')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            --Rise of Bones
            if mq.TLO.Me.AltAbilityReady('Rise of Bones')() and nec_burn_variables.targethp <= 99 and nec_burn_variables.targethp >= 60 and NecBurn() then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Rise of Bones')
                mq.cmd('/alt activate 900')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            --Swarm of Decay
            if mq.TLO.Me.AltAbilityReady('Swarm of Decay')() and nec_burn_variables.targethp <= 99 and nec_burn_variables.targethp >= 60 and NecBurn() then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Swarm of Decay')
                mq.cmd('/alt activate 320')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            --Wake the Dead
            if mq.TLO.Me.AltAbilityReady('Wake the Dead')() and nec_burn_variables.targethp <= 99 and nec_burn_variables.targethp >= 60 and mq.TLO.SpawnCount('npccorpse radius 100')() >= 1 and NecBurn() then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Wake the Dead')
                mq.cmd('/alt activate 175')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            --Mortifier's Unity
            if mq.TLO.Me.AltAbilityReady('Mortifier\'s Unity')() and mq.TLO.Me.Buff('Contraside')() == nil and NecBurn() then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Mortifier\'s Unity')
                mq.cmd('/alt activate 1167')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            --Spire of Necromancy
            if mq.TLO.Me.AltAbilityReady('Spire of Necromancy')() and NecBurn() then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Spire of Necromancy')
                mq.cmd('/alt activate 1390')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
            --Undead Stuff not used
            if mq.TLO.Me.AltAbilityReady('Turned Summoned')() and mq.TLO.Target.Race() ~= nil and mq.TLO.Target.Race() == 'Undead' and NecBurn() then
                print(easy, ' \ag NEC Burn\aw - \ag[\atAA\ag]\ao - Turned Summoned')
                mq.cmd('/alt activate 559')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if NecEngage() then
                   NecAggro()
                end
            end
        end
    end
end

-------------------------------------------------
------------------ MAG Burn ---------------------
-------------------------------------------------
local MAG_BURN = function ()
    local mag_burn_variables = {
        targethp = mq.TLO.Target.PctHPs() or 0,
        targetdistance = mq.TLO.Target.Distance() or 0,
        myhp = mq.TLO.Me.PctHPs() or 0,
        maintank = mq.TLO.Group.MainTank.CleanName(),
        myendurance = mq.TLO.Me.PctEndurance(),
        xtarget = mq.TLO.Me.XTarget(),
        mymana = mq.TLO.Me.PctMana() or 0,
        maintankdistance = mq.TLO.Group.MainTank.Distance() or 0,
        targetlevel = mq.TLO.Target.Level() or 0,
        mepoisoned = mq.TLO.Me.CountersPoison() or 0,
        mypethp = mq.TLO.Me.Pet.PctHPs() or 0,
        mypetdistance = mq.TLO.Me.Pet.Distance() or 0,
        mypet = mq.TLO.Me.Pet.CleanName(),
        spell_rank = '',
        spell_ready = '',
        aggressive = mq.TLO.Target.Aggressive(),
        xtargetdistance = mq.TLO.Me.XTarget(1).Distance() or 0,
        hovering = mq.TLO.Me.Hovering()
        }
    local function MagBurn()
        return not mq.TLO.Me.Hovering()
        and not mq.TLO.Me.Invulnerable()
        and not mq.TLO.Me.Silenced()
        and not mq.TLO.Me.Mezzed()
        and not mq.TLO.Me.Charmed()
        and not mq.TLO.Me.Feigning()
        and mq.TLO.Target.Aggressive()
        and mq.TLO.Me.XTarget() >= 1
        and mag_burn_variables.targetdistance <= 100
        and mag_burn_variables.targetdistance >= 1
        and mag_burn_variables.targethp >= defaults.STOP_BURN
        and mag_burn_variables.targethp <= defaults.START_BURN
        and mq.TLO.Target.ID() ~= 0
        and not mq.TLO.Me.Moving()
        and mq.TLO.Me.Buff('Resurrection Sickness')() == nil
    end
    local function MagEngage()
        if Alive() and mq.TLO.Me.XTarget() ~= 0 then
            return mq.TLO.Me.XTarget(1).ID() >= 1
            and mag_burn_variables.xtargetdistance <= 50
            and mag_burn_variables.xtargetdistance >= 25
            and not mq.TLO.Navigation.Active()
        end
    end
    local function MagAggro()
        if Alive() then
            if mq.TLO.Navigation.Active() then mq.cmd('/nav stop') end
            if mq.TLO.Target.ID() == 0 then
                mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID())
                mq.cmd('/face fast')
                if mq.TLO.Pet.ID() ~= nil then
                    mq.cmd('/pet attack')
                end
            end
        end
    end
    if mq.TLO.Me.Class.ShortName() == 'MAG' and Alive() then
        UseGear()
            --Elemental Conversion
            if mq.TLO.Me.AltAbilityReady('Elemental Conversion')() and mag_burn_variables.mymana <= 50 and mag_burn_variables.mymana >= 1 and mag_burn_variables.mypethp >= 50 and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Elemental Conversion')
                mq.cmd('/alt activate 2065')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                MagAggro()
                end
            end
            --Summoned: Kotahl's Tonic of Healing
            if mq.TLO.FindItemCount('Summoned: Kotahl\'s Tonic of Healing')() > 0 and mq.TLO.FindItem("Summoned: Kotahl's Tonic of Healing").TimerReady() == 0 and mag_burn_variables.myhp <= 90 and mag_burn_variables.myhp >= 1 and mq.TLO.Me.Song('Renewal')() == nil and not mag_burn_variables.hovering then
                print(easy, ' \agMAG Using:\ap Summoned: Kotahl\'s Tonic of Healing.')
                mq.cmdf("/useitem %s", 'Summoned: Kotahl\'s Tonic of Healing')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            
            --Summoned: Kotahl's Tonic of Refreshment
            if mq.TLO.FindItemCount('Summoned: Kotahl\'s Tonic of Refreshment')() > 0 and mq.TLO.FindItem("Summoned: Kotahl's Tonic of Refreshment").TimerReady() == 0 and mag_burn_variables.myendurance <= 90 and mag_burn_variables.myendurance >= 1 and not mag_burn_variables.hovering then
                print(easy, ' \agMAG Using:\ap Summoned: Kotahl\'s Tonic of Refreshment.')
                mq.cmdf("/useitem %s", 'Summoned: Kotahl\'s Tonic of Refreshment')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Summoned: Kotahl's Tonic of Clarity
            if mq.TLO.FindItemCount('Summoned: Kotahl\'s Tonic of Clarity')() > 0 and mq.TLO.FindItem("Summoned: Kotahl's Tonic of Clarity").TimerReady() == 0 and mag_burn_variables.mymana <= 90 and mag_burn_variables.mymana >= 1 and not mag_burn_variables.hovering and mq.TLO.Me.Song('Paragon of Spirit')() == nil then
                print(easy, ' \agMAG Using:\ap Summoned: Kotahl\'s Tonic of Clarity.')
                mq.cmdf("/useitem %s", 'Summoned: Kotahl\'s Tonic of Clarity')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Exalted Tonic of Healing
            if mq.TLO.FindItemCount('Exalted Tonic of Healing')() > 0 and mq.TLO.FindItem("Exalted Tonic of Healing").TimerReady() == 0 and mag_burn_variables.myhp <= 90 and mag_burn_variables.myhp >= 1 and mq.TLO.Me.Song('Renewal')() == nil and not mag_burn_variables.hovering then
                print(easy, ' \agMAG Using:\ap Exalted Tonic of Healing.')
                mq.cmdf("/useitem %s", 'Exalted Tonic of Healing')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Delete Ether-Fused Shard
            if mq.TLO.FindItemCount('Ether-Fused Shard')() > 0 and mq.TLO.FindItem('Ether-Fused Shard').Charges() < 1 and not mag_burn_variables.hovering then
                mq.cmd('/ctrl /itemnotify "Ether-Fused Shard" leftmouseup')
                mq.delay('1s')
                if mq.TLO.Cursor.ID() == 85487 then
                    mq.cmd('/destroy')
                    print(easy, ' \arMag Destroyed:\ay (Empty) \apEther-Fused Shard.')
                end
                mq.delay(500)
                if MagEngage() then
                   MagAggro()
                end
            end
            --Delete Summoned: Darkshine Staff
            if mq.TLO.FindItemCount('Summoned: Darkshine Staff')() > 0 and mq.TLO.FindItem('Summoned: Darkshine Staff').Charges() < 1 and not mag_burn_variables.hovering then
                mq.cmd('/ctrl /itemnotify "Summoned: Darkshine Staff" leftmouseup')
                mq.delay('1s')
                if mq.TLO.Cursor.ID() == 109889 then
                    mq.cmd('/destroy')
                    print(easy, ' \arMag Destroyed:\ay (Empty) \apSummoned: Darkshine Staff.')
                end
                mq.delay(500)
                if MagEngage() then
                   MagAggro()
                end
            end
            --Summoned: Sahdi's Emblem of the Enchanced Minion
            if mq.TLO.FindItemCount('Summoned: Sahdi\'s Emblem of the Enhanced Minion')() >=1 and mq.TLO.Me.Pet.Buff('Enhanced Minion')() == nil and mq.TLO.Me.Pet.CleanName() ~= nil and not mag_burn_variables.hovering  then
                print(easy, ' \ag MAG Burn\aw - \ag[\atClicky\ag]\ao - Summoned: Sahdi\'s Emblem of the Enhanced Minion')
                mq.cmdf('/target %s', mq.TLO.Me.Pet.CleanName())
                mq.cmd('/useitem "Summoned: Sahdi\'s Emblem of the Enhanced Minion"')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Imprint of the Enhanced Minion
            if mq.TLO.FindItemCount('Imprint of the Enhanced Minion')() >=1 and mq.TLO.Me.Pet.Buff('Enhanced Minion')() == nil and mq.TLO.Me.Pet.CleanName() ~= nil and not mag_burn_variables.hovering then
                print(easy, ' \ag MAG Burn\aw - \ag[\atClicky\ag]\ao - Imprint of the Enhanced Minion')
                mq.cmdf('/target %s', mq.TLO.Me.Pet.CleanName())
                mq.cmd('/useitem "Imprint of the Enhanced Minion"')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Summon Modulation Shard
            if mq.TLO.Me.AltAbilityReady('Summon Modulation Shard')() and mq.TLO.FindItemCount('Dazzling Modulation Shard')() == 0 and mq.TLO.FindItemCount('Summoned: Modulation Shard VIII')() == 0 and not mag_burn_variables.hovering then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Summon Modulation Shard')
                mq.cmd('/alt activate 596')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
                if mq.TLO.Cursor.ID() then
                    mq.cmd('/autoinv')
                end
            end
        if MagBurn() then
            --BURNING
            --Molten Komatiite Orb
            if mq.TLO.FindItemCount('Molten Komatiite Orb')() > 0 and mq.TLO.FindItem("Molten Komatiite Orb").TimerReady() == 0 and MagBurn() then
                mq.cmdf("/useitem %s", 'Molten Komatiite Orb')
                print(easy, ' \ag MAG Burn\aw - \ag[\atItem\ag]\ao - Molten Komatiite Orb')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Summoned: Exigent Servant XXIV II
            if mq.TLO.FindItemCount('Summoned: Exigent Servant XXIV II')() > 0 and mq.TLO.FindItem("Summoned: Exigent Servant XXIV II").TimerReady() == 0 and MagBurn() then
                mq.cmdf("/useitem %s", 'Summoned: Exigent Servant XXIV II')
                print(easy, ' \ag MAG Burn\aw - \ag[\atItem\ag]\ao - Summoned: Exigent Servant XXIV II')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Summoned: Exigent Minion XXIV II
            if mq.TLO.FindItemCount('Summoned: Exigent Minion XXIV II')() > 0 and mq.TLO.FindItem("Summoned: Exigent Minion XXIV II").TimerReady() == 0 and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atItem\ag]\ao - Summoned: Exigent Minion XXIV II')
                mq.cmdf("/useitem %s", 'Summoned: Exigent Minion XXIV II')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Ether-Fused shard
            if mq.TLO.FindItemCount('Ether-Fused Shard')() > 0 and mq.TLO.FindItem("Ether-Fused Shard").TimerReady() == 0 and mag_burn_variables.targethp <= 98 and mag_burn_variables.targethp >= 1 and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atItem\ag]\ao - Ether-Fused Shard')
                mq.cmdf("/useitem %s", 'Ether-Fused Shard')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Summoned: Darkshine Staff
            if mq.TLO.FindItemCount('Summoned: Darkshine Staff')() > 0 and mq.TLO.FindItem("Summoned: Darkshine Staff").TimerReady() == 0 and mag_burn_variables.targethp <= 98 and mag_burn_variables.targethp >= 1 and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atItem\ag]\ao - Summoned: Darkshine Staff.')
                mq.cmdf("/useitem %s", 'Summoned: Darkshine Staff')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Summoned: Voidfrost Paradox
            if mq.TLO.FindItemCount('Summoned: Voidfrost Paradox')() > 0 and mq.TLO.FindItem("Summoned: Voidfrost Paradox").TimerReady() == 0 and mag_burn_variables.targethp <= 98 and mag_burn_variables.targethp >= 1 and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atItem\ag]\ao - Summoned: Voidfrost Paradox.')
                mq.cmdf("/useitem %s", 'Summoned: Voidfrost Paradox')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --AA
            --Arcane Whisper
            if mq.TLO.Me.AltAbilityReady('Arcane Whisper')() and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Arcane Whisper')
                mq.cmdf('/target %s',mq.TLO.Me.CleanName())
                mq.delay(100)
                mq.cmd('/alt activate 636')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Companion's Aegis
            if mq.TLO.Me.AltAbilityReady('Companion\'s Aegis')() and mag_burn_variables.mypethp <= 50 and mag_burn_variables.mypethp >= 1 and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Aegis')
                mq.cmd('/alt activate 441')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Companion's Fortification
            if mq.TLO.Me.AltAbilityReady('Companion\'s Fortification')() and mag_burn_variables.mypethp >= 50 and mag_burn_variables.mypethp <= 100 and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Fortification')
                mq.cmd('/alt activate 3707')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Companion\'s Fury'
            if mq.TLO.Me.AltAbilityReady('Companion\'s Fury')() and mag_burn_variables.mypethp >= 50 and mag_burn_variables.mypethp <= 100 and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Fury')
                mq.cmd('/alt activate 60')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Companion's Intervening Divine Aura
            if mq.TLO.Me.AltAbilityReady('Companion\'s Intervening Divine Aura')() and mag_burn_variables.mypethp <= 30 and mag_burn_variables.mypethp >= 1 and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Intervening Divine Aura')
                mq.cmd('/alt activate 1580')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Dimensional Shield
            if mq.TLO.Me.AltAbilityReady('Dimensional Shield')() and mag_burn_variables.myhp <= 50 and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Dimensional Shield')
                mq.cmd('/alt activate 639')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Drape of Shadows
            if mq.TLO.Me.AltAbilityReady('Drape of Shadows')() and mag_burn_variables.myhp <= 20 and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Drape of Shadows')
                mq.cmd('/alt activate 8341')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Eradicate Magic
            if mq.TLO.Me.AltAbilityReady('Eradicate Magic')() and mag_burn_variables.mepoisoned >= 1 and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Eradicate Magic')
                mq.cmd('/target %s',mq.TLO.Me.CleanName())
                mq.delay(100)
                mq.cmd('/alt activate 547')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Focus of Arcanum
            if mq.TLO.Me.AltAbilityReady('Focus of Arcanum')() and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Focus of Arcanum')
                mq.cmd('/alt activate 1211')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Forceful Rejuvenation
            if mq.TLO.Me.AltAbilityReady('Forceful Rejuvenation')() and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Foreceful Rejuvenation')
                mq.cmd('/alt activate 7003')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Improved Twincast
            if mq.TLO.Me.AltAbilityReady('Improved Twincast')() and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Improved Twincast')
                mq.cmd('/alt activate 515')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Malaise
            if mq.TLO.Me.AltAbilityReady('Malaise')() and mag_burn_variables.targethp >= 50 and mag_burn_variables.targethp <= 99 and mq.TLO.Me.XTarget(1).ID() ~= 0 and mq.TLO.Target.Buff('Malosinetra')() == nil and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Malaise')
                mq.cmd('/alt activate 1041')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Mend Companion
            if mq.TLO.Me.AltAbilityReady('Mend Companion')() and mag_burn_variables.mypethp <= 40 and mag_burn_variables.mypethp >= 1 and not mag_burn_variables.hovering then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Mend Companion')
                mq.cmd('/alt activate 58')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Silent Casting
            if mq.TLO.Me.AltAbilityReady('Silent Casting')() and mag_burn_variables.targethp >= 80 and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Silent Casting')
                mq.cmd('/alt activate 500')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Summon Companion
            if mq.TLO.Me.AltAbilityReady('Summon Companion')() and mag_burn_variables.mypetdistance >= 200 or mq.TLO.Me.AltAbilityReady('Summon Companion')() and mag_burn_variables.mypetdistance >= 100 and mag_burn_variables.mypethp <= 40 and mag_burn_variables.mypethp >= 1 and not mag_burn_variables.hovering then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Summon Companion')
                mq.cmd('/alt activate 1215')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Companion of Necessity
            if mq.TLO.Me.AltAbilityReady('Companion of Necessity')() and mag_burn_variables.targethp <= 99 and mag_burn_variables.targethp >= 50 and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Companion of Necessity')
                mq.cmd('/alt activate 3516')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Companion's Shielding
            if mq.TLO.Me.AltAbilityReady('Companion\'s Shielding')() and mag_burn_variables.mypethp <= 50 and mag_burn_variables.mypethp >= 1 and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Shielding')
                mq.cmd('/alt activate 265')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Force of Elements
            if mq.TLO.Me.AltAbilityReady('Force of Elements')() and mag_burn_variables.mymana >= 30 and mag_burn_variables.targethp <= 75 and mag_burn_variables.targethp >= 25 and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Force of Elements')
                mq.cmd('/alt activate 8800')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Heart of Frostone
            if mq.TLO.Me.AltAbilityReady('Heart of Frostone')() and mag_burn_variables.myhp <= 50 and mag_burn_variables.myhp >= 1 and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Heart of Frostone')
                mq.cmd('/alt activate 786')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Heart of Skyfire
            if mq.TLO.Me.AltAbilityReady('Heart of Skyfire')() and mag_burn_variables.targethp >= 40 and mag_burn_variables.targethp <= 98 and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Heart of Skyfire')
                mq.cmd('/alt activate 785')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Host in the Shell
            if mq.TLO.Me.AltAbilityReady('Host in the Shell')() and mag_burn_variables.mypethp <= 35 and mag_burn_variables.mypethp >= 1 and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Host in the Shell')
                mq.cmd('/alt activate 8342')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Host of the Elements
            if mq.TLO.Me.AltAbilityReady('Host of the Elements')() and mag_burn_variables.targethp <= 99 and mag_burn_variables.targethp >= 60 and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Host of the Elements')
                mq.cmd('/alt activate 207')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Second Wind Ward
            if mq.TLO.Me.AltAbilityReady('Second Wind Ward')() and mag_burn_variables.mypethp <= 60 and mag_burn_variables.targethp >= 1 and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Second Wind Ward')
                mq.cmd('/alt activate 2066')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Servant of Ro
            if mq.TLO.Me.AltAbilityReady('Servant of Ro')() and mag_burn_variables.targethp <= 99 and mag_burn_variables.targethp >= 60 and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Servant of Ro')
                mq.cmd('/alt activate 174')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Shield of the Elements
            if mq.TLO.Me.AltAbilityReady('Shield of the Elements')() and mag_burn_variables.myhp <= 50 and mag_burn_variables.myhp >= 1 and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Shield of the Elements')
                mq.cmd('/alt activate 603')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Spire of the Elements
            if mq.TLO.Me.AltAbilityReady('Spire of the Elements')() and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Spire of the Elements')
                mq.cmd('/alt activate 1370')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Thaumaturge's Focus
            if mq.TLO.Me.AltAbilityReady('Thaumaturge\'s Focus')() and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Thaumaturge\'s Focus')
                mq.cmd('/alt activate 390')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Thaumaturge's Unity
            if mq.TLO.Me.AltAbilityReady('Thaumaturge\'s Unity')() and mq.TLO.Me.Buff('Ophiolite Bodyguard')() == nil and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Thaumaturge\'s Unity')
                mq.cmd('/alt activate 1169')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
            --Turn Summoned
            if mq.TLO.Me.AltAbilityReady('Turned Summoned')() and mq.TLO.Target.Race() ~= nil and mq.TLO.Target.Race() == 'Elemental' and MagBurn() then
                print(easy, ' \ag MAG Burn\aw - \ag[\atAA\ag]\ao - Turned Summoned')
                mq.cmd('/alt activate 559')
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if MagEngage() then
                   MagAggro()
                end
            end
        end
    end
end

-------------------------------------------------
------------------ SHM Burn ---------------------
-------------------------------------------------

local SHM_BURN = function ()
    local shm_burn_variables = {
        targethp = mq.TLO.Target.PctHPs() or 0,
        targetdistance = mq.TLO.Target.Distance() or 0,
        myhp = mq.TLO.Me.PctHPs() or 0,
        maintank = mq.TLO.Group.MainTank.CleanName(),
        myendurance = mq.TLO.Me.PctEndurance(),
        xtarget = mq.TLO.Me.XTarget(),
        mymana = mq.TLO.Me.PctMana() or 0,
        maintankdistance = mq.TLO.Group.MainTank.Distance() or 0,
        targetlevel = mq.TLO.Target.Level() or 0,
        mepoisoned = mq.TLO.Me.CountersPoison() or 0,
        mypethp = mq.TLO.Me.Pet.PctHPs() or 0,
        mypetdistance = mq.TLO.Me.Pet.Distance() or 0,
        mypet = mq.TLO.Me.Pet.CleanName(),
        spell_rank = '',
        spell_ready = '',
        combat_true = mq.TLO.Me.Combat(),
        aggressive = mq.TLO.Target.Aggressive(),
        xtargetdistance = mq.TLO.Me.XTarget(1).Distance() or 0,
        hovering = mq.TLO.Me.Hovering()
        }
    local function ShmBurn()
        return not mq.TLO.Me.Hovering()
        and not mq.TLO.Me.Invulnerable()
        and not mq.TLO.Me.Silenced()
        and not mq.TLO.Me.Mezzed()
        and not mq.TLO.Me.Charmed()
        and not mq.TLO.Me.Feigning()
        and mq.TLO.Target.Aggressive()
        and mq.TLO.Me.XTarget() >= 1
        and shm_burn_variables.targetdistance <= 100
        and shm_burn_variables.targetdistance >= 1
        and shm_burn_variables.targethp >= defaults.STOP_BURN
        and shm_burn_variables.targethp <= defaults.START_BURN
        and mq.TLO.Target.ID() ~= 0
        and not mq.TLO.Me.Moving()
        and mq.TLO.Me.Buff('Resurrection Sickness')() == nil
    end
    local function ShmEngage()
        if Alive() and mq.TLO.Me.XTarget() ~= 0 then
            return mq.TLO.Me.XTarget(1).ID() >= 1
            and shm_burn_variables.xtargetdistance <= 50
            and shm_burn_variables.xtargetdistance >= 25
            and not mq.TLO.Navigation.Active()
        end
    end
    local function ShmAggro()
        if Alive() then
            if mq.TLO.Navigation.Active() then mq.cmd('/nav stop') end
            if mq.TLO.Target.ID() == 0 then
                mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID())
                mq.cmd('/face fast')
                if mq.TLO.Pet.ID() ~= nil then
                    mq.cmd('/pet attack')
                end
            end
        end
    end
    if mq.TLO.Me.Class.ShortName() == 'SHM' and Alive() then
        UseGear()
        if ShmEngage() then
            ShmAggro()
        end

        --Breather
        local breather = mq.TLO.Spell('Breather').RankName()
        if mq.TLO.Me.CombatAbilityReady('Breather')() and shm_burn_variables.myendurance <= 20 and mq.TLO.Me.Song('Breather')() == nil and shm_burn_variables.xtarget == 0 and not shm_burn_variables.combat_true and not shm_burn_variables.hovering then
            print(easy, ' \ag SHM Burn\aw - \ag[\atCombat Ability\ag]\ao - '..breather..'')
            mq.cmdf('/disc %s', breather)
            mq.delay(490)
            if ShmEngage() then
                ShmAggro()
            end
        end
        --Ancestral Aid
        if mq.TLO.Me.AltAbilityReady('Ancestral Aid')() and shm_burn_variables.myhp <= 40 and shm_burn_variables.myhp >= 1 and not shm_burn_variables.hovering then
            print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Ancestral Aid')
            mq.cmd('/alt activate 447')
            mq.delay(490)
            if ShmEngage() then
                ShmAggro()
            end
        end
        --Cannibalization
        if mq.TLO.Me.AltAbilityReady('Cannibalization')() and shm_burn_variables.myhp >= 80 and shm_burn_variables.mymana <= 80 and not shm_burn_variables.hovering then
            mq.cmd('/alt activate 47')
            print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Cannibalization')
            mq.delay(490)
            if ShmEngage() then
                ShmAggro()
            end
        end
        --Pact of the Wolf
        if mq.TLO.Me.AltAbilityReady('Pact of the Wolf')() and mq.TLO.Me.Song('Pact of the Wolf')() == nil and not shm_burn_variables.hovering then
            print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Pact of the Wolf')
            mq.cmd('/alt activate 707')
            mq.delay(490)
            if ShmEngage() then
                ShmAggro()
            end
        end
        if ShmBurn() then
            --AA
            --Companion's Fortification
            if mq.TLO.Me.AltAbilityReady('Companion\'s Fortification')() and shm_burn_variables.mypethp >= 50 and shm_burn_variables.mypethp <= 100 and not shm_burn_variables.hovering then
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Fortification')
                mq.cmd('/alt activate 3707')
                mq.delay(490)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Companion's Aegis
            if mq.TLO.Me.AltAbilityReady('Companion\'s Aegis')() and shm_burn_variables.mypethp >= 1 and shm_burn_variables.mypethp <= 50 and not shm_burn_variables.hovering then
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Aegis')
                mq.cmd('/alt activate 441')
                mq.delay(490)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Companion's Intervening Divine Aura
            if mq.TLO.Me.AltAbilityReady('Companion\'s Intervening Divine Aura')() and shm_burn_variables.mypethp <= 20 and shm_burn_variables.mypethp >= 1 and ShmBurn() then
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Intervening Divine Aura')
                mq.cmd('/alt activate 1580')
                mq.delay(490)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Focus of Arcanum
            if mq.TLO.Me.AltAbilityReady('Focus of Arcanum')() and ShmBurn() then
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Focus of Arcanum')
                mq.cmd('/alt activate 1211')
                mq.delay(750)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Forceful Rejuvenation
            if mq.TLO.Me.AltAbilityReady('Forceful Rejuvenation')() and ShmBurn() then
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Foreceful Rejuvenation')
                mq.cmd('/alt activate 7003')
                mq.delay(750)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Inconspicuous Totem
            if mq.TLO.Me.AltAbilityReady('Inconspicuous Totem')() and shm_burn_variables.myhp <= 50 and shm_burn_variables.myhp >= 1 and shm_burn_variables.xtarget >= 3 and ShmBurn() then
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Inconspicuous Totem')
                mq.cmd('/alt activate 9504')
                mq.delay(490)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Spirit of Tala'Tak
            if mq.TLO.Me.AltAbilityReady('Spirit of Tala\'Tak')() and mq.TLO.Me.Buff('Spirit of Tala\'Tak')() == nil and ShmBurn() then
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Spirit of Tala\'Tak')
                mq.cmd('/alt activate 859')
                mq.delay(490)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Malaise
            if mq.TLO.Me.AltAbilityReady('Malaise')() and shm_burn_variables.targethp >= 50 and shm_burn_variables.targethp <= 99 and mq.TLO.Target.Buff('Malosinetra')() == nil and ShmBurn() then
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Malaise')
                mq.cmd('/alt activate 1041')
                mq.delay(750)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Preincarnation
            if mq.TLO.Me.AltAbilityReady('Preincarnation')() and mq.TLO.Me.Buff('Preincarnation')() == nil and ShmBurn() then
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Preincarnation')
                mq.cmd('/alt activate 149')
                mq.delay(490)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Purified Spirits
            if mq.TLO.Me.AltAbilityReady('Purified Spirits')() and shm_burn_variables.mepoisoned >= 1 and not shm_burn_variables.hovering then
                mq.cmdf('/target %s',mq.TLO.Me.CleanName())
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Purified Spirits')
                mq.cmd('/alt activate 626')
                mq.delay(490)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Radiant Cure
            if mq.TLO.Me.AltAbilityReady('Radiant Cure')() and shm_burn_variables.mepoisoned >= 1 and not shm_burn_variables.hovering then
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Radiant Cure')
                mq.cmd('/alt activate 153')
                mq.delay(490)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Silent Casting
            if mq.TLO.Me.AltAbilityReady('Silent Casting')() and shm_burn_variables.targethp >= 80 and ShmBurn() then
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Silent Casting')
                mq.cmd('/alt activate 494')
                mq.delay(750)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Spritual Rebuke
            if mq.TLO.Me.AltAbilityReady('Spiritual Rebuke')() and shm_burn_variables.targethp >= 1 and shm_burn_variables.targethp <= 98  and shm_burn_variables.xtarget >= 4 and ShmBurn() then
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Spiritual Rebuke')
                mq.cmd('/alt activate 147')
                mq.delay(490)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Summon Companion
            if mq.TLO.Me.AltAbilityReady('Summon Companion')() and shm_burn_variables.mypetdistance >= 200 or mq.TLO.Me.AltAbilityReady('Summon Companion')() and shm_burn_variables.mypetdistance >= 100 and shm_burn_variables.mypethp <= 40 and shm_burn_variables.mypethp >= 1 and not shm_burn_variables.hovering then
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Summon Companion')
                mq.cmd('/alt activate 1215')
                mq.delay(750)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Virulent Paralysis
            if mq.TLO.Me.AltAbilityReady('Virulent Paralysis')() and shm_burn_variables.myhp <= 50 and shm_burn_variables.myhp >= 1 and shm_burn_variables.targetdistance <= 50 and shm_burn_variables.targetdistance >= 0 and ShmBurn() then
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Virulent Paralysis')
                mq.cmd('/alt activate 992')
                mq.delay(490)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Wind of Malaise
            if mq.TLO.Me.AltAbilityReady('Wind of Malaise')() and shm_burn_variables.targethp <= 99 and shm_burn_variables.targethp >= 10 and shm_burn_variables.xtarget >= 4 and ShmBurn() then
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Wind of Malaise')
                mq.cmd('/alt activate 952')
                mq.delay(490)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Ancestral Guard
            if mq.TLO.Me.AltAbilityReady('Ancestral Guard')() and shm_burn_variables.myhp >= 1 and shm_burn_variables.myhp <= 30 and ShmBurn() then
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Ancestral Guard')
                mq.cmd('/alt activate 528')
                mq.delay(490)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Call of the Ancients
            if mq.TLO.Me.AltAbilityReady('Call of the Ancients')() and shm_burn_variables.myhp >= 1 and shm_burn_variables.myhp <= 80 and ShmBurn() then
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Call of the Ancients')
                mq.cmd('/alt activate 321')
                mq.delay(490)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Dampen Resistance
            if mq.TLO.Me.AltAbilityReady('Dampen Resistance')() and ShmBurn() then
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Dampen Resistance')
                mq.cmd('/alt activate 857')
                mq.delay(490)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Fleeting Spirit
            if mq.TLO.Me.AltAbilityReady('Feeting Spirit')() and shm_burn_variables.targethp <= 99 and shm_burn_variables.targethp >= 75 and ShmBurn() then
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Fleeting Spirit')
                mq.cmd('/alt activate 1138')
                mq.delay(490)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Rabid Bear
            if mq.TLO.Me.AltAbilityReady('Rabid Bear')() and shm_burn_variables.targethp >= 55 and shm_burn_variables.targethp <= 99 and ShmBurn() then
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Rabid Bear')
                mq.cmd('/alt activate 50')
                mq.delay(490)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Soothsayer's Intervention
            if mq.TLO.Me.AltAbilityReady('Soothsayer\'s Intervention')() and shm_burn_variables.myhp <= 40 and shm_burn_variables.myhp >= 1 and ShmBurn() then
                mq.cmdf('/target %s',mq.TLO.Me.CleanName())
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Soothsayer\'s Intervention')
                mq.cmd('/alt activate 619')
                mq.delay(490)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Spire of the Ancestors
            if mq.TLO.Me.AltAbilityReady('Spire of the Ancestors')() and ShmBurn() then
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Spire of the Ancestors')
                mq.cmd('/alt activate 1490')
                mq.delay(490)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Spirit Call
            if mq.TLO.Me.AltAbilityReady('Spirit Call')() and shm_burn_variables.targethp >= 55 and shm_burn_variables.targethp <= 99 and ShmBurn() then
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Spirit Call')
                mq.cmd('/alt activate 177')
                mq.delay(490)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Spirit Guardian
            if mq.TLO.Me.AltAbilityReady('Spirit Guardian')() and shm_burn_variables.myhp <= 30 and shm_burn_variables.myhp >= 1 and not shm_burn_variables.hovering then
                mq.cmdf('/target %s',mq.TLO.Me.CleanName())
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Spirit Guardian')
                mq.cmd('/alt activate 614')
                mq.delay(490)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Spirit of Urgency
            if mq.TLO.Me.AltAbilityReady('Spirit of Urgency')() and shm_burn_variables.targethp <= 99 and shm_burn_variables.targethp >= 10 and shm_burn_variables.myhp <= 25 and shm_burn_variables.myhp >= 1 and ShmBurn() then
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Spirit of Urgency')
                mq.cmd('/alt activate 948')
                mq.delay(490)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Spiritual Blessing
            if mq.TLO.Me.AltAbilityReady('Spiritual Blessing')() and shm_burn_variables.myhp <= 20 and shm_burn_variables.myhp >= 1 and not shm_burn_variables.hovering then
                mq.cmdf('/target %s',mq.TLO.Me.CleanName())
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Spiritual Blessing')
                mq.cmd('/alt activate 151')
                mq.delay(490)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Spiritual Channeling
            if mq.TLO.Me.AltAbilityReady('Spiritual Channeling')() and shm_burn_variables.mymana <= 5 and shm_burn_variables.myhp >= 25 and not shm_burn_variables.hovering then
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Spiritual Channeling')
                mq.cmd('/alt activate 446')
                mq.delay(490)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Turgur's Swarm
            if mq.TLO.Me.AltAbilityReady('Turgur\'s Swarm')() and shm_burn_variables.targethp <= 98 and shm_burn_variables.targethp >= 50 and mq.TLO.Target.Buff('Turgur\'s Insects')() == nil and ShmBurn() then
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Turgur\'s Swarm')
                mq.cmd('/alt activate 3729')
                mq.delay(490)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Union of Spirits
            if mq.TLO.Me.AltAbilityReady('Union of Spirits')() and shm_burn_variables.myhp <= 25 and shm_burn_variables.myhp >= 1 and not shm_burn_variables.hovering then
                mq.cmdf('/target %s',mq.TLO.Me.CleanName())
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Union of Spirits')
                mq.cmd('/alt activate 662')
                mq.delay(490)
                if ShmEngage() then
                    ShmAggro()
                end
            end
            --Pack of Lunar Wolves
            if mq.TLO.Me.AltAbilityReady('Pack of Lunar Wolves')() and mq.TLO.Me.Buff('Pack of Lunar Wolves')() == nil and ShmBurn() then
                print(easy, ' \ag SHM Burn\aw - \ag[\atAA\ag]\ao - Pack of Lunar Wolves')
                mq.cmd('/alt activate 1166')
                mq.delay(490)
                if ShmEngage() then
                    ShmAggro()
                end
            end
        end
    end
end

-------------------------------------------------
---------------------- Scripts ------------------
-------------------------------------------------
local options = {
    {
        name = 'Clear Rods',
        helper = 'Clear Mod Rod from cursor',
        selected = saved_settings.clear_rods,
        action = ClearModRods
    }, {
        name = 'Clear Cursor',
        helper = 'Inventory any item on the cursor',
        selected = saved_settings.clear_cursor,
        action = ClearCursor
    }, {
        name = 'Destroy Rods',
        helper = 'Destroys Mod Rods on your cursor',
        selected = saved_settings.destroy_rods,
        action = DestroyModRod
    }, {
        name = 'Force Feed',
        helper = 'Eat Specified Food when Hungry',
        selected = saved_settings.force_feed,
        action = ForceFeed
    }, {
        name = 'Force Drink',
        helper = 'Drink Specified Drinks when Thirsty',
        selected = saved_settings.force_drink,
        action = ForceDrink
    }, {
        name = 'Get Drunk',
        helper = 'If you have Alcohol, You will get Drunk',
        selected = saved_settings.get_drunk,
        action = GetDrunk
    }, {
        name = 'Destroy Bulwark',
        helper = 'Destroys Empty Bulwark of Many Portals',
        selected = saved_settings.destroy_bulwark,
        action = OldBulwark
    }, {
        name = 'Close PopUp',
        helper = 'Closes F2P PopUp',
        selected = saved_settings.close_popup,
        action = ClosePopUp
    }, {
        name = 'Check Parcel',
        helper = 'Attempts to Retrieve Items from parcel when notified (Set for zone 737)',
        selected = saved_settings.check_parcel,
        action = CheckParcel
    }, {
        name = 'Relay Tells',
        helper = 'Will Relay Tells to DanNet',
        selected = saved_settings.relay_tells,
        action = RelayTells
    }, {
        name = 'Start Overseer',
        helper = 'Will Start Up Overseer.lua when not running',
        selected = saved_settings.start_overseer,
        action = StartOverseer
    }, {
        name = 'Teach',
        helper = 'Teach Languages to Your Group',
        selected = saved_settings.teach_languages,
        action = Language
    }, {
        name = 'Begging',
        helper = 'Will beg when standing with a target',
        selected = saved_settings.begging,
        action = Begging
    }, {
        name = 'Pick Pockets',
        helper = 'Will Pickpocket when standing with a target',
        selected = saved_settings.pickpocket,
        action = Pickpocket
    }, {
        name = 'Bind Wound',
        helper = 'Will bind wound if you have bandages and under 90 pct hp',
        selected = saved_settings.bind_wound,
        action = BindWound
    }, {
        name = 'Forage',
        helper = 'Will only forage when standing',
        selected = saved_settings.forage,
        action = Forage
    }, {
        name = 'Grab Globes',
        helper = 'Pick up any Globes in Range',
        selected = saved_settings.grab_globes,
        action = GrabGlobes
    }, {
        name = 'Remove Levitation',
        helper = 'Removes Levitation',
        selected = saved_settings.remove_levitation,
        action = RemoveLev
    }
}
local mercoptions = {
    {
        name = 'Pop Merc',
        helper = 'Will UnSuspend Your Mercenary when Suspended',
        selected = saved_settings.pop_merc,
        action = PopMerc
    }, {
        name = 'Revive Merc',
        helper = 'Will Revive a Dead Mercenary',
        selected = saved_settings.revive_merc,
        action = ReviveMerc
    }, {
        name = 'Revive Suspended',
        helper = 'Will Attempt to Revive a Suspended Mercenary due to Zone Limit or Accidental Suspended Merc',
        selected = saved_settings.revive_merc_suspended,
        action = ReviveMercSuspended
    }, {
        name = 'Lazy Merc',
        helper = 'Will place your Mercenary in Passive mode while in Safe Zones',
        selected = saved_settings.lazy_merc,
        action = LazyMerc
    }, {
        name = 'Working Merc',
        helper = 'Will place your Mercenary in Balanced mode when leaving Safe Zones',
        selected = saved_settings.working_merc,
        action = WorkingMerc
    }
}
local itemoptions = {
    {
        name = 'Summon Cookies',
        helper = 'Uses Fresh Cookie Dispenser',
        selected = saved_settings.summon_cookies,
        action = CookieDispenser
    }, {
        name = 'Summon Tea',
        helper = 'Uses Spiced Iced Tea Dispenser',
        selected = saved_settings.summon_tea,
        action = TeaDispenser
    }, {
        name = 'Summon Bread',
        helper = 'Uses Wee\'er Harvester',
        selected = saved_settings.summon_bread,
        action = WeeHarvester
    }, {
        name = 'Summon Water',
        helper = 'Uses Bigger Belt of the River',
        selected = saved_settings.summon_water,
        action = BiggerBelt
    }, {
        name = 'Summon Milk',
        helper = 'Uses Warm Milk Dispenser',
        selected = saved_settings.summon_milk,
        action = MilkDispenser
    }, {
        name = 'Summon Picnic',
        helper = 'Uses Packed Picnic Basket',
        selected = saved_settings.summon_picnic,
        action = PicnicDispenser
    }, {
        name = 'Summon Brew',
        helper = 'Uses Brell\'s Brew Dispenser',
        selected = saved_settings.summon_brew,
        action = BrewDispenser
    }, {
        name = 'Endless Turkey',
        helper = 'Uses Endless Turkeys',
        selected = saved_settings.endless_turkey,
        action = TurkeyDispenser
    }, {
        name = 'Summon Ale',
        helper = 'Uses Brell\'s Fishin\' Pole',
        selected = saved_settings.summon_brew,
        action = BrellsFishingPole
    }
}
local classoptions = {
    {
        name = 'ROG Poison',
        helper = 'Summons Poison Using Leg Slot (Rogue Only)',
        selected = saved_settings.rog_poison,
        action = RoguePoison
    }, {
        name = 'Corpse Recovery',
        helper = 'Recover Corpse (Rogue & Bard Only (DanNet Required for DanNet Corpse))',
        selected = saved_settings.corpse_recovery,
        action = CorpseRecovery,
    }, {
        name = 'MAG Cauldron',
        helper = 'Summon Items Using Cauldron (Mage Only)',
        selected = saved_settings.mag_cauldron,
        action = CheckCauldron,
    }, {
        name = 'AA Rez',
        helper = 'Rez DanNet Peers within 100 ft (DRU, SHM, PAL, CLR, NEC Only)(Necromancer Requires Essence Emerald)(DanNet Required)',
        selected = saved_settings.aa_rez,
        action = RezCheck
    }, {
        name = 'Group Shrink',
        helper = 'Shrink Group (Beastlord & Shaman Only)',
        selected = saved_settings.group_shrink,
        action = Shrink
    }, {
        name = 'BER Burn',
        helper = 'Berserker Unleash Damage (Berserker Only)',
        selected = saved_settings.ber_burn,
        action = BER_BURN
    }, {
        name = 'BRD Burn',
        helper = 'Bard Unleash Damage (Bard Only)',
        selected = saved_settings.brd_burn,
        action = BRD_BURN
    }, {
        name = 'BST Burn',
        helper = 'Beast Unleash Damage (Beastlord Only)',
        selected = saved_settings.bst_burn,
        action = BST_BURN
    }, {
        name = 'CLR Burn',
        helper = 'Cleric Unleash Damage (Cleric Only)',
        selected = saved_settings.clr_burn,
        action = CLR_BURN
    }, {
        name = 'DRU Burn',
        helper = 'Druid Unleash Damage (Druid Only)',
        selected = saved_settings.dru_burn,
        action = DRU_BURN
    }, {
        name = 'ENC Burn',
        helper = 'Enchanter Unleash Damage (Enchanter Only)',
        selected = saved_settings.enc_burn,
        action = ENC_BURN
    }, {
        name = 'MAG Burn',
        helper = 'Magician Unleash Damage (Magician Only)',
        selected = saved_settings.mag_burn,
        action = MAG_BURN
    }, {
        name = 'MNK Burn',
        helper = 'Monk Unleash Damage (Monk Only)',
        selected = saved_settings.mnk_burn,
        action = MNK_BURN
    }, {
        name = 'NEC Burn',
        helper = 'Necromancer Unleash Damage (Necromancer Only)',
        selected = saved_settings.nec_burn,
        action = NEC_BURN
    }, {
        name = 'PAL Burn',
        helper = 'Paladin Unleash Damage (Paladin Only)',
        selected = saved_settings.pal_burn,
        action = PAL_BURN
    }, {
        name = 'RNG Burn',
        helper = 'Ranger Unleash Damage (Ranger Only)',
        selected = saved_settings.rng_burn,
        action = RNG_BURN
    }, {
        name = 'ROG Burn',
        helper = 'Rogue Unleash Damage (Rogue Only)',
        selected = saved_settings.rog_burn,
        action = ROG_BURN
    }, {
        name = 'SHD Burn',
        helper = 'SK Unleash Damage (Shadow Knight Only)',
        selected = saved_settings.shd_burn,
        action = SHD_BURN
    }, {
        name = 'SHM Burn',
        helper = 'Shaman Unleash Damage (Shaman Only)',
        selected = saved_settings.shm_burn,
        action = SHM_BURN
    }, {
        name = 'WAR Burn',
        helper = 'Warrior Unleash Damage (Warrior Only)',
        selected = saved_settings.war_burn,
        action = WAR_BURN
    }, {
        name = 'WIZ Burn',
        helper = 'Wizard Unleash Damage (Wizard Only)',
        selected = saved_settings.wiz_burn,
        action = WIZ_BURN
    }
}
local campoptions = {
    {
        name = 'Campfire',
        helper = 'Will drop a Campfire if all requirements are met for a Campfire',
        selected = saved_settings.campfire,
        action = Campfire
    }, {
        name = 'Fellowship',
        helper = 'Will teleport back to your Campfire in Another Zone if one is Placed',
        selected = saved_settings.fellowship,
        action = Fellowship
    }, {
        name = 'Scoot Camp',
        helper = 'Get out of camp if PC is near',
        selected = saved_settings.scoot_camp,
        action = CheckDistance
    }, {
        name = 'PC Alert',
        helper = 'Alert As PC gets Close',
        selected = saved_settings.pc_alert,
        action = CheckDistance2
    }, {
        name = 'GM Alert',
        helper = 'GM Alert and Pause Script',
        selected = saved_settings.gm_alert,
        action = GMCHECK
    }, {
        name = 'Auto Loot',
        helper = 'Auto Loot items checked in Advanced Loot, Only use on Master Looter',
        selected = saved_settings.auto_loot,
        action = LootCheck
    }, {
        name = 'Toon Assist',
        helper = 'All Connected DanNet Melee will Toon Assist the Main Tank(DanNet Required)',
        selected = saved_settings.toon_assist,
        action = ToonAssist
    }, {
        name = 'Lesson',
        helper = 'Use Lesson of the Devoted when Ready',
        selected = saved_settings.lesson,
        action = Lesson
    }, {
        name = 'Power Source',
        helper = 'Will replace spent Power Source and Destroy Old Power Source',
        selected = saved_settings.power_source,
        action = PowerSource
    }, {
        name = 'Respawn Bind',
        helper = 'Respawn to Bind Immediately After Death',
        selected = saved_settings.respawn_bind,
        action = RespawnBind
    }, {
        name = 'Close Book',
        helper = 'Closes Spell Book when open more than 10 Seconds',
        selected = saved_settings.close_book,
        action = CloseBook
    }, {
        name = 'Use Mount',
        helper = 'Uses mount in Ammo slot to stay mounted',
        selected = saved_settings.use_mount,
        action = UseMount
    }
}

local function UpdateTime()
    timeDisplayNorrath = string.format("%02d:%02d", mq.TLO.GameTime.Hour(), mq.TLO.GameTime.Minute())
    timeDisplayEarth = os.date("%H:%M:%S")
end

local function TrackPlat()
    current_plat = mq.TLO.Me.Platinum()
end

local function Cannonballdex()
    for _, value in ipairs(campoptions) do
        if value.selected then
            value.action()
        end
    end
    for _, value in ipairs(options) do
        if value.selected then
            value.action()
        end
    end
    for _, value in ipairs(mercoptions) do
        if value.selected then
            value.action()
        end
    end
    for _, value in ipairs(itemoptions) do
        if value.selected then
            value.action()
        end
    end
    for _, value in ipairs(classoptions) do
        if value.selected then
            value.action()
        end
    end
    if mq.TLO.Me.Fellowship.CampfireZone() ~= nil then
        while mq.TLO.Me.Fellowship.CampfireZone() ~= nil and mq.TLO.Me.Fellowship.CampfireDuration.TotalSeconds() >= 1 do
            CampFireZone = mq.TLO.Me.Fellowship.CampfireZone()
            break
        end
        while mq.TLO.Me.Fellowship.CampfireDuration.TotalSeconds() ~= nil and mq.TLO.Me.Fellowship.Campfire() ~= nil do
            CampfireDuration = mq.TLO.Me.Fellowship.CampfireDuration.TotalSeconds()
            break
        end
    end
    while mq.TLO.Me.Invis('UNDEAD')() do
        Invis_IVU_Status = "YES"
        break
    end
    while mq.TLO.Me.Rooted() do
        Root_Status = "YES"
        break
    end
    while mq.TLO.Me.Snared() do
        Snare_Status = "YES"
        break
    end
    while mq.TLO.Me.Levitating() do
        Levitate_Status = "YES"
        break
    end
    while pause_switch do
        mq.delay(100)
    end
    while mq.TLO.Macro() do
        Macro = mq.TLO.Macro()
        if mq.TLO.Macro() == nil then
            Macro = 'Loading ...'
        end
        break    
    end
end

local function textEnabledPC(member)
    ImGui.PushStyleColor(ImGuiCol.Text, 0.690, 0.553, 0.259, 1)
    ImGui.PushStyleColor(ImGuiCol.HeaderHovered, 0.33, 0.33, 0.33, 0.5)
    ImGui.PushStyleColor(ImGuiCol.HeaderActive, 0.0, 0.66, 0.33, 0.5)
    local tarPC = ImGui.Selectable(member, false, ImGuiSelectableFlags.AllowDoubleClick)
    ImGui.PopStyleColor(3)
    if tarPC and ImGui.IsMouseDoubleClicked(0) then
        mq.cmdf('/tar %s',member)
        printf('\ayTarget \ag%s',member)
    end
end

local function navEnabledPC(loc)
    ImGui.PushStyleColor(ImGuiCol.Text, 0.690, 0.553, 0.259, 1)
    ImGui.PushStyleColor(ImGuiCol.HeaderHovered, 0.33, 0.33, 0.33, 0.5)
    ImGui.PushStyleColor(ImGuiCol.HeaderActive, 0.0, 0.66, 0.33, 0.5)
    local navPC = ImGui.Selectable(loc, false, ImGuiSelectableFlags.AllowDoubleClick)
    ImGui.PopStyleColor(3)
    if navPC and ImGui.IsMouseDoubleClicked(0) then
        mq.cmdf('/nav locYXZ %s',loc)
        printf('\ayNavigating to \ag%s',loc)
    end
end

local function CannonballdexGUI()
    if mq.TLO.Me.Invis('UNDEAD')() == false then
        Invis_IVU_Status = "NO"
    end
    if mq.TLO.Me.Rooted() == nil then
        Root_Status = "NO"
    end
    if mq.TLO.Me.Snared() == nil then
        Snare_Status = "NO"
    end
    if mq.TLO.Me.Levitating() == false then
        Levitate_Status = "NO"
    end
    if mq.TLO.Me.Fellowship.CampfireZone() == nil then
        CampFireZone = "NONE"
        CampfireDuration = 0
    end
    if mq.TLO.Me.HaveExpansion(31)() then
        expansion_owned = "The Outer Brood"
    end
    if mq.TLO.Me.HaveExpansion(30)() and not mq.TLO.Me.HaveExpansion(31)() then
        expansion_owned = "Laurion's Song"
    end
    if mq.TLO.Me.HaveExpansion(29)() and not mq.TLO.Me.HaveExpansion(30)() and not mq.TLO.Me.HaveExpansion(31)() then
        expansion_owned = "Night of Shadows"
    end
    if mq.TLO.Me.HaveExpansion(28)() and not mq.TLO.Me.HaveExpansion(29)() and not mq.TLO.Me.HaveExpansion(30)() and not mq.TLO.Me.HaveExpansion(31)() then
        expansion_owned = "Terror of Luclin"
    end

    if Open then
        Open, ShowUI = ImGui.Begin('Easy.lua by Cannonballdex', Open)
        ImGui.SetWindowSize(500, 250, ImGuiCond.Once)
        ImGui.SetWindowFontScale(saved_settings.font_size or 1)
        if ShowUI then
            if pause_switch then
                if ImGui.Button(ICONS.FA_PLAY_CIRCLE) then
                    pause_switch = false
                    gm_switch = false
                end
                ImGui.SameLine()
                HelpMarker("Start will resume all actions of the script")
                ImGui.SameLine()
                if ImGui.Button(ICONS.MD_STOP) then
                    mq.cmd('/lua stop easy')
                end
                ImGui.SameLine()
                HelpMarker("End My Script")
                if mq.TLO.Plugin('mq2dannet')() ~= nil and saved_settings.dannet_load then
                ImGui.SameLine()
                    if ImGui.Button(ICONS.FA_STOP) then
                        mq.cmd('/dge /lua stop easy')
                    end
                ImGui.SameLine()
                HelpMarker("End Script on All Toons connected to DanNet")
                end
                ImGui.SameLine()
                ImGui.Text("Status: ")
                ImGui.SameLine()
                ImGui.TextColored(1,1,0,1,"[ PAUSED ]")
            end
            if not pause_switch then
                if ImGui.Button(ICONS.MD_PAUSE_CIRCLE_FILLED) then
                    pause_switch = true
                end
                ImGui.SameLine()
                HelpMarker("Pause all actions of the script")
                ImGui.SameLine()
                if ImGui.Button(ICONS.MD_STOP) then
                    mq.cmd('/lua stop easy')
                end
                HelpMarker("End Script")
                ImGui.SameLine()
                ImGui.Text("Status: ")
                ImGui.SameLine()
                ImGui.TextColored(0,1,0,1,"[ RUNNING ]")
                if mq.TLO.Plugin('mq2dannet')() ~= nil and saved_settings.dannet_load then
                    ImGui.SameLine()
                    if pause_switch_all then
                        if ImGui.Button(ICONS.MD_PLAYLIST_PLAY) then
                            mq.cmd('/dgex /lua pause easy')
                            pause_switch_all = false
                        end
                        HelpMarker("Start will resume all actions of the script on toons connected to DanNet")
                        ImGui.SameLine()
                        ImGui.Text("Status: ")
                        ImGui.SameLine()
                        ImGui.TextColored(1,1,0,1,"[ PEERS PAUSED ]")
                        ImGui.Separator()
                    end
                    ImGui.SameLine()
                    if not pause_switch_all then
                        ImGui.SameLine()
                        if ImGui.Button(ICONS.FA_PAUSE_CIRCLE_O) then
                            mq.cmd('/dgex /lua pause easy')
                            pause_switch_all = true
                        end
                        HelpMarker("Pause all actions of the script on all toons connected to DanNet")                       
                        ImGui.SameLine()
                        if ImGui.Button(ICONS.FA_STOP) then
                            mq.cmd('/dgex /lua stop easy')
                        end
                        ImGui.SameLine()
                        HelpMarker("End Script on All Toons connected to DanNet")
                        ImGui.SameLine()
                        ImGui.Text("Status: ")
                        ImGui.SameLine()
                        ImGui.TextColored(0,1,0,1,"[ PEERS RUNNING ]")
                    end
                end
            end
            ImGui.Separator()
            ImGui.Text("Sub:")
            ImGui.SameLine()
            if mq.TLO.Me.Subscription() == "GOLD" then
                ImGui.TextColored(0,1,0,1,"[ " .. mq.TLO.Me.Subscription() .. " ]")
            elseif mq.TLO.Me.Subscription() == "SILVER" then
                ImGui.TextColored(0.6, 0.6, 0, 1,"[ " .. mq.TLO.Me.Subscription() .. " ]")
            elseif mq.TLO.Me.Subscription() == "FREE" then
                ImGui.TextColored(0.95, 0.05, 0.05, 0.95,"[ " .. mq.TLO.Me.Subscription() .. " ]")
            end
            ImGui.SameLine()
            ImGui.Text("Days Left:")
            ImGui.SameLine()
            if mq.TLO.Me.SubscriptionDays() ~= nil then
                if mq.TLO.Me.SubscriptionDays() > 7 then
                    ImGui.TextColored(0,1,0,1,"[ " .. mq.TLO.Me.SubscriptionDays() .. " ]")
                elseif mq.TLO.Me.SubscriptionDays() < 8 and mq.TLO.Me.SubscriptionDays() > 3 then
                    ImGui.TextColored(0.6, 0.6, 0, 1,"[ " .. mq.TLO.Me.SubscriptionDays() .. " ]")
                elseif mq.TLO.Me.SubscriptionDays() < 4 then
                    ImGui.TextColored(0.95, 0.05, 0.05, 1,"[ " .. mq.TLO.Me.SubscriptionDays() .. " ]")
                end
            end
            ImGui.SameLine()
            ImGui.Text("Krono:")
            ImGui.SameLine()
            local me_krono = mq.TLO.Me.Krono() or 0
                if me_krono >= 5 then
                    ImGui.TextColored(0,1,0,1,"[ " ..  me_krono .. " ]")
                elseif me_krono <= 4 and  me_krono >= 2 then
                    ImGui.TextColored(0.6, 0.6, 0, 1,"[ " ..  me_krono .. " ]")
                elseif me_krono <= 1 then
                    ImGui.TextColored(0.95, 0.05, 0.05, 1,"[ " ..  me_krono .. " ]")
                end
            ImGui.SameLine()
            ImGui.Text("Own:")
            ImGui.SameLine()
            ImGui.TextColored(1, 1, .5, 1,"[ " .. expansion_owned .. " ]")
            ImGui.Separator()
            ImGui.TextColored(0, 1, 1, 1, ICONS.FA_EYE)
            HelpMarker('Invisible to Undead')
            ImGui.SameLine()
            ImGui.Text("IVU:")
            ImGui.SameLine()
            if mq.TLO.Me.Invis('UNDEAD')() then
                ImGui.TextColored(0,1,0,1,"[ " .. Invis_IVU_Status .. " ]")
            elseif not mq.TLO.Me.Invis('UNDEAD')() then
                ImGui.TextColored(0.95, 0.05, 0.05, 1,"[ " .. Invis_IVU_Status .. " ]")
            end
            ImGui.SameLine() ImGui.Text('|')
            ImGui.SameLine()
            ImGui.TextColored(0, 1, 1, 1, ICONS.FA_STREET_VIEW)
            HelpMarker('Rooted')
            ImGui.SameLine()
            ImGui.Text("Root:")
            ImGui.SameLine()
            if mq.TLO.Me.Rooted() then
                ImGui.TextColored(0.95, 0.05, 0.05, 1,"[ " .. Root_Status .. " ]")
            elseif not mq.TLO.Me.Rooted() then
                ImGui.TextColored(0, 1, 0, 1,"[ " .. Root_Status .. " ]")
            end
            ImGui.SameLine() ImGui.Text('|')
            ImGui.SameLine()
            ImGui.TextColored(0, 1, 1, 1, ICONS.MD_DIRECTIONS_WALK)
            HelpMarker('Snared')
            ImGui.SameLine()
            ImGui.Text("Snare:")
            ImGui.SameLine()
            if mq.TLO.Me.Snared() then
                ImGui.TextColored(0.95, 0.05, 0.05, 1,"[ " .. Snare_Status .. " ]")
            elseif not mq.TLO.Me.Snared() then
                ImGui.TextColored(0, 1, 0, 1,"[ " .. Snare_Status .. " ]")
            end
            ImGui.SameLine() ImGui.Text('|')
            ImGui.SameLine()
            ImGui.TextColored(0, 1, 1, 1, ICONS.MD_CLOUD)
            HelpMarker('Levitating')
            ImGui.SameLine()
            ImGui.Text("Levi:")
            ImGui.SameLine()
            if mq.TLO.Me.Levitating() then
                ImGui.TextColored(0, 1, 0, 1,"[ " .. Levitate_Status .. " ]")
            elseif not mq.TLO.Me.Levitating() then
                ImGui.TextColored(0.95, 0.05, 0.05, 1,"[ " .. Levitate_Status .. " ]")
            end
            ImGui.Separator()
            ImGui.TextColored(0, 1, 1, 1, ICONS.MD_PERSON)
            ImGui.SameLine()
            local pcs = mq.TLO.SpawnCount('pc')() - mq.TLO.SpawnCount('guild pc')()
            HelpMarker('Other Players | Guild Members in Zone.')
            ImGui.SameLine()
            if pcs > 50 then
                ImGui.TextColored(0.95, 0.05, 0.05, 1, '[ '..tostring(pcs)..' ]')
            elseif pcs > 24 then
                ImGui.TextColored(0.6, 0.6, 0, 1, '[ '..tostring(pcs)..' ]')
            elseif pcs > 0 then
                ImGui.TextColored(0.05, 0.95, 0.05, 1, '[ '..tostring(pcs)..' ]')
            elseif pcs == 0 then
                ImGui.TextColored(0.05, 0.95, 0.05, 1, '[ '..tostring(pcs)..' ]')
            else
                ImGui.TextDisabled(tostring(pcs))
            end
            HelpMarker('Other Players in Zone.')
            ImGui.SameLine()
            ImGui.Text('|')
            ImGui.SameLine()
            ImGui.TextColored(0.05, 0.95, 0.05, 1, '[ '..mq.TLO.SpawnCount('guild pc')()..' ]')
            HelpMarker('Guild Members in Zone.')
            ImGui.SameLine() ImGui.Text('|')
            ImGui.SameLine()
            ImGui.TextColored(0, 1, 1, 1, ICONS.MD_PERSON_OUTLINE)
            HelpMarker('Total Peers and Peers in Zone.')
            if mq.TLO.Plugin('mq2dannet')() == nil then
            ImGui.SameLine()
                ImGui.TextColored(0, 1, 1, 1, ICONS.MD_ERROR)
                    HelpMarker('DanNet Disabled. You must load the plugin DanNet for this function to work')
                end
                if mq.TLO.Plugin('mq2dannet')() ~= nil and saved_settings.dannet_load == nil then
                    ImGui.SameLine()
                    ImGui.TextColored(0, 1, 1, 1, ICONS.MD_ERROR)
                    HelpMarker('You have DanNet running, but not dannet_load=true in your Easy.ini file')
                end
                if mq.TLO.Plugin('mq2dannet')() ~= nil and saved_settings.dannet_load == false then
                    ImGui.SameLine()
                    ImGui.TextColored(0, 1, 1, 1, ICONS.MD_ERROR)
                    HelpMarker('DanNet = false (This must be set to TRUE when using DanNet')
                end
                ImGui.SameLine()
                if mq.TLO.Plugin('mq2dannet')() ~= nil and saved_settings.dannet_load then
            while peerCountDanNet > 0 and mq.TLO.DanNet.PeerCount() ~= peerCountDanNet do
                peerCountDanNet = mq.TLO.DanNet.PeerCount()
                break
            end
            zonePeerCount = (string.format('zone_%s_%s', mq.TLO.EverQuest.Server(), mq.TLO.Zone.ShortName()))
            while peerCountDanNet > 0 and mq.TLO.DanNet.PeerCount(''..zonePeerCount..'')() ~= zonePeerCount do
                if INSTANCE_ZONE[mq.TLO.Zone.ShortName()] then
                    zonePeerCount = (string.format('zone_%s', mq.TLO.Zone.ShortName()))
                end
                if not INSTANCE_ZONE[mq.TLO.Zone.ShortName()] then
                    zonePeerCount = (string.format('zone_%s_%s', mq.TLO.EverQuest.Server(), mq.TLO.Zone.ShortName()))
                end
                break
            end
            if peerCountDanNet > 0 then
                ImGui.TextColored(0,1,0,1,"[ " .. peerCountDanNet .. " ]")
                HelpMarker('Total Peers.')
                ImGui.SameLine()
                ImGui.Text('|')
                ImGui.SameLine()
                ImGui.TextColored(0,1,0,1,"[ " .. mq.TLO.DanNet.PeerCount(''..zonePeerCount..'')() .. " ]")
                HelpMarker('Total Peers in Zone.')
            end
            end
            ImGui.SameLine() ImGui.Text('|')
            ImGui.SameLine()
            ImGui.TextColored(0, 1, 1, 1, ICONS.MD_REMOVE_RED_EYE)
            HelpMarker('Group Member Invis Status - F1 is You')
            ImGui.SameLine() ImGui.TextDisabled('|')
            if mq.TLO.Group() ~= nil then
                for i = 0, mq.TLO.Group.Members() do
                    local member = mq.TLO.Group.Member(i)
                    if member.Present() and not member.Mercenary() then
                        ImGui.SameLine()
                        if not member.Invis() then
                            ImGui.TextColored(0.95, 0.05, 0.05, 1, 'F'..i+1)
                        elseif member.Invis('NORMAL')() then
                            ImGui.TextColored(0.05, 0.95, 0.05, 1, 'F'..i+1)
                        end
                        ImGui.SameLine() ImGui.TextDisabled('|')
                    end
                end
            end
            if mq.TLO.Group() == nil and mq.TLO.Me.Invis() then
                ImGui.SameLine()
                ImGui.TextColored(0.05, 0.95, 0.05, 1, 'F1')
                ImGui.SameLine() ImGui.TextDisabled('|')
            end
            if mq.TLO.Group() == nil and not mq.TLO.Me.Invis() then
                ImGui.SameLine()
                ImGui.TextColored(0.95, 0.05, 0.05, 1, 'F1')
                ImGui.SameLine() ImGui.TextDisabled('|')
            end
            if mq.TLO.Me.Thirst() ~= nil then
                ImGui.Separator()
                ImGui.TextColored(0, 1, 1, 1, ICONS.MD_LOCAL_DRINK)
                ImGui.SameLine()
                ImGui.Text("Thirst:")
                ImGui.SameLine()
                if mq.TLO.Me.Thirst() < 500 then
                    ImGui.TextColored(0.95, 0.05, 0.05, 1,"[ " .. mq.TLO.Me.Thirst() .. " ]")
                else
                    ImGui.TextColored(0, 0.8, 1, 1,"[ " .. mq.TLO.Me.Thirst() .. " ]")
                end
            end
            if mq.TLO.Me.Hunger() ~= nil then
                ImGui.SameLine() ImGui.Text('|')
                ImGui.SameLine()
                ImGui.TextColored(0, 1, 1, 1, ICONS.MD_LOCAL_DINING)
                ImGui.SameLine()
                ImGui.Text("Hunger:")
                ImGui.SameLine()
                if mq.TLO.Me.Hunger() < 500 then
                    ImGui.TextColored(0.95, 0.05, 0.05, 1,"[ " .. mq.TLO.Me.Hunger() .. " ]")
                else
                    ImGui.TextColored(0, 0.8, 1, 1,"[ " .. mq.TLO.Me.Hunger() .. " ]")
                end
            end
                if mq.TLO.Me.Drunk() ~= nil then
                    ImGui.SameLine() ImGui.Text('|')
                    ImGui.SameLine()
                    ImGui.TextColored(0, 1, 1, 1, ICONS.FA_GLASS)
                    ImGui.SameLine()
                    ImGui.Text("Drunk:")
                    ImGui.SameLine()
                    if mq.TLO.Me.Drunk() > 0 then
                        ImGui.TextColored(0.95, 0.05, 0.05, 1,"[ " .. mq.TLO.Me.Drunk() .. " ]")
                    else
                        ImGui.TextColored(0, 0.8, 1, 1,"[ " .. mq.TLO.Me.Drunk() .. " ]")
                    end
                end
                if mq.TLO.Me.Fellowship.Campfire() ~= nil then
                    ImGui.Separator()
                    ImGui.TextColored(0, 1, 1, 1, ICONS.FA_FREE_CODE_CAMP)
                    HelpMarker('Campfire Location')
                    ImGui.SameLine()
                    if mq.TLO.Me.Fellowship.CampfireZone() ~= nil then
                        CampFireZone = mq.TLO.Me.Fellowship.CampfireZone() or 'NONE'
                        ImGui.TextColored(1, 1, .5, 1,"[ " .. CampFireZone .. " ]")
                    else
                        ImGui.TextColored(0, 0.8, 1, 1,"[ " .. CampFireZone .. " ]")
                    end
                    ImGui.SameLine() ImGui.Text('|')
                    ImGui.SameLine()
                    ImGui.TextColored(0, 1, 1, 1, ICONS.MD_AV_TIMER)
                    HelpMarker('Time Remaining on Campfire')
                    ImGui.SameLine()
                    if mq.TLO.Me.Fellowship.CampfireDuration() ~= nil then
                        CampFireDuration = mq.TLO.Me.Fellowship.CampfireDuration() or '0'
                        ImGui.TextColored(1, 1, .5, 1,"[ " .. CampfireDuration/60 .. " ]")
                    else
                        ImGui.TextColored(0, 0.8, 1, 1,"[ " .. CampfireDuration .. " ]")
                    end
                end
                if mq.TLO.GameTime.Hour() ~= nil then
                    ImGui.SameLine() ImGui.Text('||')
                    local hour = mq.TLO.GameTime.Hour()
                    if hour >= 19 or hour < 6 then
                        ImGui.SameLine()
                        ImGui.TextColored(0, 1, 1, 1, ICONS.FA_MOON_O)
                    else
                        ImGui.SameLine()
                        ImGui.TextColored(1, 0.85, 0, 1, ICONS.MD_WB_SUNNY)
                    end
                    HelpMarker('Norrath Time')
                    ImGui.SameLine()
                    ImGui.TextColored(0, 0.8, 1, 1,"[ " .. timeDisplayNorrath .. " ]")
                    ImGui.SameLine() ImGui.Text('|')
                    ImGui.SameLine()
                    ImGui.TextColored(0, 1, 1, 1, ICONS.FA_GLOBE)
                    HelpMarker('Earth Time')
                    ImGui.SameLine()
                    ImGui.TextColored(0, 0.8, 1, 1,"[ " .. timeDisplayEarth .. " ]")
                end
                ImGui.Separator()
                ImGui.TextColored(0, 1, 1, 1, ICONS.MD_BATTERY_CHARGING_FULL)
                HelpMarker('Power Source')
                ImGui.SameLine()
                if mq.TLO.Me.Inventory('21')() ~= nil then
                    if MySource == nil then
                        MySource = 'NONE'
                    end
                    ImGui.TextColored(1, 1, .5, 1,"[ " .. MySource .. " ]")
                else
                    if MySource == nil then
                        MySource = 'NONE'
                    end
                    ImGui.TextColored(0, 0.8, 1, 1,"[ " .. MySource .. " ]")
                end
                ImGui.SameLine() ImGui.Text('|')
                ImGui.SameLine()
                ImGui.TextColored(0, 1, 1, 1, ICONS.FA_INFO_CIRCLE)
                HelpMarker('Power Source Count In Inventory')
                ImGui.SameLine()
                ImGui.TextColored(0, 0.8, 1, 1,"[ " ..MySourceCount .. " ]")
                ImGui.SameLine() ImGui.Text('|')
                ImGui.SameLine()
                if MySourcePower == nil then
                    MySourcePower = 1000*0
                end
                if MySourcePower == 0 then
                    ImGui.TextColored(0, 1, 1, 1, ICONS.FA_BATTERY_EMPTY)
                end
                if MySourcePower ~= nil and MySourcePower > 0 and MySourcePower < 500 then
                    ImGui.TextColored(0, 1, 1, 1, ICONS.FA_BATTERY_QUARTER)
                end
                if MySourcePower ~= nil and MySourcePower > 499 and MySourcePower < 1000 then
                    ImGui.TextColored(0, 1, 1, 1, ICONS.FA_BATTERY_HALF)
                end
                if MySourcePower ~= nil and MySourcePower > 999 and MySourcePower < 1500 then
                    ImGui.TextColored(0, 1, 1, 1, ICONS.FA_BATTERY_THREE_QUARTERS)
                end
                if MySourcePower ~= nil and MySourcePower > 1500 then
                    ImGui.TextColored(0, 1, 1, 1, ICONS.FA_BATTERY_FULL)
                end
                HelpMarker('Power Remaining')
                ImGui.SameLine()
                
                ImGui.TextColored(0, 0.8, 1, 1,"[ " .. MySourcePower/1000 .. " ]")
                ImGui.SameLine() ImGui.Text('|')
                ImGui.SameLine()
                ImGui.TextColored(0, 1, 1, 1, ICONS.MD_POWER)
                HelpMarker('Total Power Remaining On All Power Sources In Inventory')
                ImGui.SameLine()
                ImGui.TextColored(0, 0.8, 1, 1,"[ " .. MySourcePower*MySourceCount/1000 .. " ]")
                if nil ~= mq.TLO.Macro() then
                    ImGui.Separator()
                    ImGui.Text("Running Macro:")
                    ImGui.SameLine()
                    ImGui.TextColored(0,1,0,1,"[ " .. Macro .. " ]")
                    ImGui.SameLine()
                    if not mq.TLO.Macro.Paused() then
                        if ImGui.Button('Pause') then
                            mq.cmd('/mqp')
                            HelpMarker("Pause Macro")
                        end
                    end
                    if mq.TLO.Macro.Paused() then
                        if ImGui.Button('Resume') then
                            mq.cmd('/mqp')
                            HelpMarker("Resume Macro")
                        end
                    end
                    ImGui.SameLine()
                    if ImGui.Button('End') then
                        mq.cmd('/end')
                        HelpMarker("End Macro")
                    end
                end
                local uihelpers = {}
                uihelpers.DrawInfoBar = function(ratio, text, width, height, barColor)
                    height = height or 20
                    width = width or -1
                    if nil ~= barColor then
                        ImGui.PushStyleColor(ImGuiCol.PlotHistogram, barColor[1] or 0, barColor[2] or 0, barColor[3] or 0, barColor[4] or 1)
                    else
                        ImGui.PushStyleColor(ImGuiCol.PlotHistogram, 1 - ratio, ratio, 0, 0.5)
                    end
                    ImGui.PushStyleColor(ImGuiCol.Text, 0, 0, 0, 1)
                    ImGui.ProgressBar(ratio, width, height, text)
                    ImGui.PopStyleColor(2)
                end
                if pause_switch == false and gm_switch == true then
                    if mq.TLO.SpawnCount("GM")() > 0 then
                        uihelpers.DrawInfoBar(100, "> > GM > > "..ICONS.MD_WARNING.." > > GM > >"..ICONS.MD_ERROR.." WARNING ALERT "..ICONS.MD_ERROR.."< < GM < < "..ICONS.MD_WARNING.." < < GM < <")
                        if mq.TLO.SpawnCount("GM")() > 0 then
                            mq.cmd('/beep')
                            if mq.TLO.Plugin('mq2dannet')() ~= nil and saved_settings.dannet_load then
                            mq.cmd('/noparse /dgza /docommand /${Me.Class.ShortName} mode 0')
                                print(easy, ' GM Alert: \aySetting all toons using CWTN to Manual Mode')
                            end
                                mq.cmd('/say AFK BRB')
                            pause_switch = true
                            gm_switch = true
                        end
                    end
                end
                if gm_switch == true then
                    uihelpers.DrawInfoBar(100, "> > GM > > "..ICONS.MD_WARNING.." > > GM > >"..ICONS.MD_ERROR.." WARNING ALERT "..ICONS.MD_ERROR.."< < GM < < "..ICONS.MD_WARNING.." < < GM < <")
                end

----------------------------------------------------------------------------------------------------------------
------ MEAT AND POTATOES OF THE GUI ----------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------

            ImGui.Separator()
            if ImGui.BeginTabBar('Options', ImGuiTabBarFlags.Reorderable) then
            if ImGui.BeginTabItem('Basic Options') then
                ImGui.BeginTable("Basic Options",2)
                for _, value in ipairs(options) do
                    ImGui.TableNextColumn()
                    value.selected = ImGui.Checkbox(value.name, value.selected) ImGui.SameLine() HelpMarker(value.helper)
                end
                ImGui.EndTable()
                ImGui.EndTabItem()
            end
            if ImGui.BeginTabItem('Camp Options') then
                ImGui.BeginTable("Camp Options",2)
                for _, value in ipairs(campoptions) do
                    ImGui.TableNextColumn()
                    value.selected = ImGui.Checkbox(value.name, value.selected) ImGui.SameLine() HelpMarker(value.helper)
                end
                ImGui.EndTable()
                if ImGui.CollapsingHeader('Custom Distance Settings') then
                    HelpMarker('Distance to Scoot, Alert or Assist when Selected')
                    ImGui.BeginTable("Notify Distance Settings",1)
                    ImGui.TableNextColumn()
                    ImGui.Text('Scoot Camp Trigger Distance:')
                    ImGui.SameLine()
                    ImGui.PushItemWidth(100)
                    defaults.SCOOT_DISTANCE, _ = ImGui.SliderInt('##SliderInt_Scoot', defaults.SCOOT_DISTANCE, 1, 1000, "%d")
                    ImGui.SameLine()
                    ImGui.PushItemWidth(1)
                    defaults.SCOOT_DISTANCE, _ = ImGui.InputInt('##inputint###inputstandard_Scoot', defaults.SCOOT_DISTANCE, 1, 1000, ImGuiInputTextFlags.None)
                    if defaults.SCOOT_DISTANCE < 1 then defaults.SCOOT_DISTANCE = 1 end
                    if defaults.SCOOT_DISTANCE > 1000 then defaults.SCOOT_DISTANCE = 1000 end
                    HelpMarker('Scoot Camp if PC within this Distance')
                    ImGui.Text('Alert PC Trigger Distance:')
                    ImGui.SameLine()
                    ImGui.PushItemWidth(100)
                    defaults.ALERT_DISTANCE, _ = ImGui.SliderInt('##SliderInt_Alert', defaults.ALERT_DISTANCE, 1, 1000, "%d")
                    ImGui.SameLine()
                    ImGui.PushItemWidth(1)
                    defaults.ALERT_DISTANCE, _ = ImGui.InputInt('##inputint###inputstandard_Alert', defaults.ALERT_DISTANCE, 1, 1000, ImGuiInputTextFlags.None)
                    if defaults.ALERT_DISTANCE < 1 then defaults.ALERT_DISTANCE = 1 end
                    if defaults.ALERT_DISTANCE > 1000 then defaults.ALERT_DISTANCE = 1000 end
                    HelpMarker('Alert if PC within this Distance')
                    ImGui.Text('Call for Toon Assist:')
                    ImGui.SameLine()
                    ImGui.PushItemWidth(100)
                    defaults.TOON_ASSIST_PCT_ON, _ = ImGui.SliderInt('##SliderInt_On', defaults.TOON_ASSIST_PCT_ON, 1, 100, "%d")
                    ImGui.SameLine()
                    ImGui.PushItemWidth(1)
                    defaults.TOON_ASSIST_PCT_ON, _ = ImGui.InputInt('##inputint###inputstandard_AssistOn', defaults.TOON_ASSIST_PCT_ON, 1, 100, ImGuiInputTextFlags.None)
                    if defaults.TOON_ASSIST_PCT_ON < 1 then defaults.TOON_ASSIST_PCT_ON = 1 end
                    if defaults.TOON_ASSIST_PCT_ON > 100 then defaults.TOON_ASSIST_PCT_ON = 100 end
                    HelpMarker('Mob % HP to call toon assist')
                    ImGui.Text('Stop Call for Toon Assist:')
                    ImGui.SameLine()
                    ImGui.PushItemWidth(100)
                    defaults.TOON_ASSIST_PCT_OFF, _ = ImGui.SliderInt('##SliderInt_Off', defaults.TOON_ASSIST_PCT_OFF, 1, 100, "%d")
                    ImGui.SameLine()
                    ImGui.PushItemWidth(1)
                    defaults.TOON_ASSIST_PCT_OFF, _ = ImGui.InputInt('##inputint###inputstandard_AssistOff', defaults.TOON_ASSIST_PCT_OFF, 1, 100, ImGuiInputTextFlags.None)
                    if defaults.TOON_ASSIST_PCT_OFF < 1 then defaults.TOON_ASSIST_PCT_OFF = 1 end
                    if defaults.TOON_ASSIST_PCT_OFF > 100 then defaults.TOON_ASSIST_PCT_OFF = 100 end
                    HelpMarker('Mob % HP to stop calling toon assist')
                    ImGui.PopItemWidth()
                    ImGui.EndTable()
                end
                ImGui.EndTabItem()
            end
            
            if ImGui.BeginTabItem('Merc Options') then
                ImGui.BeginTable("Merc Options",2)
                for _, value in ipairs(mercoptions) do
                    ImGui.TableNextColumn()
                    value.selected = ImGui.Checkbox(value.name, value.selected) ImGui.SameLine() HelpMarker(value.helper)
                end
                ImGui.EndTable()
                ImGui.EndTabItem()
            end
            if ImGui.BeginTabItem('Clicky Options') then
                ImGui.BeginTable("Clicky Options",2)
                for _, value in ipairs(itemoptions) do
                    ImGui.TableNextColumn()
                    value.selected = ImGui.Checkbox(value.name, value.selected) ImGui.SameLine() HelpMarker(value.helper)
                end
                ImGui.EndTable()
                if ImGui.CollapsingHeader('Custom Clicky Settings') then
                    HelpMarker('Quantity to Summon')
                    ImGui.BeginTable("Custom Clicky Settings",1)
                    HelpMarker('Requires Clickies')
                    ImGui.TableNextColumn()
                    ------ Cookies
                    ImGui.Text('Cookies:')
                    ImGui.SameLine()
                    ImGui.PushItemWidth(100)
                    defaults.COOKIES_TO_SUMMON, _ = ImGui.SliderInt('##SliderInt_Cookies', defaults.COOKIES_TO_SUMMON, 1, 100, "%d")
                    ImGui.SameLine()
                    ImGui.PushItemWidth(1)
                    defaults.COOKIES_TO_SUMMON, _ = ImGui.InputInt('##inputint###inputstandard_Cookies', defaults.COOKIES_TO_SUMMON, 1, 100, ImGuiInputTextFlags.None)
                    if defaults.COOKIES_TO_SUMMON < 1 then defaults.COOKIES_TO_SUMMON = 0 end
                    if defaults.COOKIES_TO_SUMMON > 100 then defaults.COOKIES_TO_SUMMON = 100 end
                    HelpMarker('Quantity of Cookies to Summon')
                    ImGui.SameLine()
                    local cookie_count = mq.TLO.FindItemCount('71980')()
                    ImGui.Text(string.format('You have (%s) Fresh Cookies', cookie_count))
                    ------ Tea
                    ImGui.Text('Tea:')
                    ImGui.SameLine()
                    ImGui.PushItemWidth(100)
                    defaults.SPICED_TEA_TO_SUMMON, _ = ImGui.SliderInt('##SliderInt_Tea', defaults.SPICED_TEA_TO_SUMMON, 1, 100, "%d")
                    ImGui.SameLine()
                    ImGui.PushItemWidth(1)
                    defaults.SPICED_TEA_TO_SUMMON, _ = ImGui.InputInt('##inputint###inputstandard_Tea', defaults.SPICED_TEA_TO_SUMMON, 1, 100, ImGuiInputTextFlags.None)
                    if defaults.SPICED_TEA_TO_SUMMON < 1 then defaults.SPICED_TEA_TO_SUMMON = 0 end
                    if defaults.SPICED_TEA_TO_SUMMON > 100 then defaults.SPICED_TEA_TO_SUMMON = 100 end
                    HelpMarker('Quantity of Spiced Tea to Summon')
                    ImGui.SameLine()
                    local tea_count = mq.TLO.FindItemCount('107807')()
                    ImGui.Text(string.format('You have (%s) Spiced Tea', tea_count))
                    ------ Milk
                    ImGui.Text('Warm Milk:')
                    ImGui.SameLine()
                    ImGui.PushItemWidth(100)
                    defaults.WARM_MILK_TO_SUMMON, _ = ImGui.SliderInt('##SliderInt_Milk', defaults.WARM_MILK_TO_SUMMON, 1, 100, "%d")
                    ImGui.SameLine()
                    ImGui.PushItemWidth(1)
                    defaults.WARM_MILK_TO_SUMMON, _ = ImGui.InputInt('##inputint###inputstandard_Milk', defaults.WARM_MILK_TO_SUMMON, 1, 100, ImGuiInputTextFlags.None)
                    if defaults.WARM_MILK_TO_SUMMON < 1 then defaults.WARM_MILK_TO_SUMMON = 0 end
                    if defaults.WARM_MILK_TO_SUMMON > 100 then defaults.WARM_MILK_TO_SUMMON = 100 end
                    HelpMarker('Quantity of Warm Milk to Summon')
                    ImGui.SameLine()
                    local milk_count = mq.TLO.FindItemCount('52199')()
                    ImGui.Text(string.format('You have (%s) Warm Milk', milk_count))
                    ------ Turkey
                    ImGui.Text('Turkey:')
                    ImGui.SameLine()
                    ImGui.PushItemWidth(100)
                    defaults.COOKED_TURKEY_TO_SUMMON, _ = ImGui.SliderInt('##SliderInt_Turkey', defaults.COOKED_TURKEY_TO_SUMMON, 1, 100, "%d")
                    ImGui.SameLine()
                    ImGui.PushItemWidth(1)
                    defaults.COOKED_TURKEY_TO_SUMMON, _ = ImGui.InputInt('##inputint###inputstandard_Turkey', defaults.COOKED_TURKEY_TO_SUMMON, 1, 100, ImGuiInputTextFlags.None)
                    if defaults.COOKED_TURKEY_TO_SUMMON < 1 then defaults.COOKED_TURKEY_TO_SUMMON = 0 end
                    if defaults.COOKED_TURKEY_TO_SUMMON > 100 then defaults.COOKED_TURKEY_TO_SUMMON = 100 end
                    HelpMarker('Quantity of Cooked Turkey to Summon')
                    ImGui.SameLine()
                    local turkey_count = mq.TLO.FindItemCount('56064')()
                    ImGui.Text(string.format('You have (%s) Cooked Turkey', turkey_count))
                    ------ Brells Brew
                    ImGui.Text('Brew:')
                    ImGui.SameLine()
                    ImGui.PushItemWidth(100)
                    defaults.BRELL_ALE_TO_SUMMON, _ = ImGui.SliderInt('##SliderInt_Brells', defaults.BRELL_ALE_TO_SUMMON, 1, 100, "%d")
                    ImGui.SameLine()
                    ImGui.PushItemWidth(1)
                    defaults.BRELL_ALE_TO_SUMMON, _ = ImGui.InputInt('##inputint###inputstandard_Brells', defaults.BRELL_ALE_TO_SUMMON, 1, 100, ImGuiInputTextFlags.None)
                    if defaults.BRELL_ALE_TO_SUMMON < 1 then defaults.BRELL_ALE_TO_SUMMON = 0 end
                    if defaults.BRELL_ALE_TO_SUMMON > 100 then defaults.BRELL_ALE_TO_SUMMON = 100 end
                    HelpMarker('Quantity of Brell Day Ale to Summon')
                    ImGui.SameLine()
                    local brew_count = mq.TLO.FindItemCount('48994')()
                    ImGui.Text(string.format('You have (%s) Brell Day Ale', brew_count))
                    ------ Ale
                    ImGui.Text('Ale:')
                    ImGui.SameLine()
                    ImGui.PushItemWidth(100)
                    defaults.ALE_TO_SUMMON, _ = ImGui.SliderInt('##SliderInt_Ale', defaults.ALE_TO_SUMMON, 1, 100, "%d")
                    ImGui.SameLine()
                    ImGui.PushItemWidth(1)
                    defaults.ALE_TO_SUMMON, _ = ImGui.InputInt('##inputint###inputstandard_Ale', defaults.ALE_TO_SUMMON, 1, 100, ImGuiInputTextFlags.None)
                    if defaults.ALE_TO_SUMMON < 1 then defaults.ALE_TO_SUMMON = 0 end
                    if defaults.ALE_TO_SUMMON > 100 then defaults.ALE_TO_SUMMON = 100 end
                    HelpMarker('Quantity of Ale to Summon')
                    ImGui.SameLine()
                    local ale_count = mq.TLO.FindItemCount('8991')()
                    ImGui.Text(string.format('You have (%s) Ale', ale_count))
                    ------ Bread
                    ImGui.Text('Bread:')
                    ImGui.SameLine()
                    ImGui.PushItemWidth(100)
                    defaults.BURNED_BREAD_TO_SUMMON, _ = ImGui.SliderInt('##SliderInt_Bread', defaults.BURNED_BREAD_TO_SUMMON, 1, 100, "%d")
                    ImGui.SameLine()
                    ImGui.PushItemWidth(1)
                    defaults.BURNED_BREAD_TO_SUMMON, _ = ImGui.InputInt('##inputint###inputstandard_Bread', defaults.BURNED_BREAD_TO_SUMMON, 1, 100, ImGuiInputTextFlags.None)
                    if defaults.BURNED_BREAD_TO_SUMMON < 1 then defaults.BURNED_BREAD_TO_SUMMON = 0 end
                    if defaults.BURNED_BREAD_TO_SUMMON > 100 then defaults.BURNED_BREAD_TO_SUMMON = 100 end
                    HelpMarker('Quantity of Bread to Summon')
                    ImGui.SameLine()
                    local bread_count = mq.TLO.FindItemCount('85830')()
                    ImGui.Text(string.format('You have (%s) Burned Bread', bread_count))
                    ------ Water
                    ImGui.Text('Water:')
                    ImGui.SameLine()
                    ImGui.PushItemWidth(100)
                    defaults.MURKY_GLOBE_TO_SUMMON, _ = ImGui.SliderInt('##SliderInt_Water', defaults.MURKY_GLOBE_TO_SUMMON, 1, 100, "%d")
                    ImGui.SameLine()
                    ImGui.PushItemWidth(1)
                    defaults.MURKY_GLOBE_TO_SUMMON, _ = ImGui.InputInt('##inputint###inputstandard_Water', defaults.MURKY_GLOBE_TO_SUMMON, 1, 100, ImGuiInputTextFlags.None)
                    if defaults.MURKY_GLOBE_TO_SUMMON < 1 then defaults.MURKY_GLOBE_TO_SUMMON = 0 end
                    if defaults.MURKY_GLOBE_TO_SUMMON > 100 then defaults.MURKY_GLOBE_TO_SUMMON = 100 end
                    HelpMarker('Quantity of Murky Globes to Summon')
                    ImGui.SameLine()
                    local globe_count = mq.TLO.FindItemCount('85829')()
                    ImGui.Text(string.format('You have (%s) Murky Globes', globe_count))
                    ImGui.Separator()
                    ImGui.Text('Packed Picnic Basket Settings')
                    ImGui.SameLine()
                    ImGui.Text('(?)')
                    HelpMarker('Can result in obtaining other items until the amount of items requested is reached.')
                    ImGui.Separator()
                    ------ Elven Wine (Packed Picnic Basket)
                    ImGui.Text('Elven Wine:')
                    ImGui.SameLine()
                    ImGui.PushItemWidth(100)
                    defaults.ELVEN_WINE_TO_SUMMON, _ = ImGui.SliderInt('##SliderInt_ElvenWine', defaults.ELVEN_WINE_TO_SUMMON, 1, 100, "%d")
                    ImGui.SameLine()
                    ImGui.PushItemWidth(1)
                    defaults.ELVEN_WINE_TO_SUMMON, _ = ImGui.InputInt('##inputint###inputstandard_ElvenWine', defaults.ELVEN_WINE_TO_SUMMON, 1, 100, ImGuiInputTextFlags.None)
                    if defaults.ELVEN_WINE_TO_SUMMON < 1 then defaults.ELVEN_WINE_TO_SUMMON = 0 end
                    if defaults.ELVEN_WINE_TO_SUMMON > 100 then defaults.ELVEN_WINE_TO_SUMMON = 100 end
                    HelpMarker('Quantity of Exquisite Elven Wine to Summon')
                    ImGui.SameLine()
                    local picnic_count = mq.TLO.FindItemCount('61994')()
                    ImGui.Text(string.format('You have (%s) Exquisite Elven Wine', picnic_count))
                    ------ Afternoon Tea (Packed Picnic Basket)
                    ImGui.Text('Afternoon Tea:')
                    ImGui.SameLine()
                    ImGui.PushItemWidth(100)
                    defaults.AFTERNOON_TEA_TO_SUMMON, _ = ImGui.SliderInt('##SliderInt_AfternoonTea', defaults.AFTERNOON_TEA_TO_SUMMON, 1, 100, "%d")
                    ImGui.SameLine()
                    ImGui.PushItemWidth(1)
                    defaults.AFTERNOON_TEA_TO_SUMMON, _ = ImGui.InputInt('##inputint###inputstandard_AfternoonTea', defaults.AFTERNOON_TEA_TO_SUMMON, 1, 100, ImGuiInputTextFlags.None)
                    if defaults.AFTERNOON_TEA_TO_SUMMON < 1 then defaults.AFTERNOON_TEA_TO_SUMMON = 0 end
                    if defaults.AFTERNOON_TEA_TO_SUMMON > 100 then defaults.AFTERNOON_TEA_TO_SUMMON = 100 end
                    HelpMarker('Quantity of Honeyed Qeynos Afternoon Tea to Summon')
                    ImGui.SameLine()
                    local afternoon_tea_count = mq.TLO.FindItemCount('61993')()
                    ImGui.Text(string.format('You have (%s) Honeyed Qeynos Afternoon Tea', afternoon_tea_count))
                    ------ Refreshing Milk (Packed Picnic Basket)
                    ImGui.Text('Refreshing Milk:')
                    ImGui.SameLine()
                    ImGui.PushItemWidth(100)
                    defaults.REFRESHING_MILK_TO_SUMMON, _ = ImGui.SliderInt('##SliderInt_RefreshingMilk', defaults.REFRESHING_MILK_TO_SUMMON, 1, 100, "%d")
                    ImGui.SameLine()
                    ImGui.PushItemWidth(1)
                    defaults.REFRESHING_MILK_TO_SUMMON, _ = ImGui.InputInt('##inputint###inputstandard_RefreshingMilk', defaults.REFRESHING_MILK_TO_SUMMON, 1, 100, ImGuiInputTextFlags.None)
                    if defaults.REFRESHING_MILK_TO_SUMMON < 1 then defaults.REFRESHING_MILK_TO_SUMMON = 0 end
                    if defaults.REFRESHING_MILK_TO_SUMMON > 100 then defaults.REFRESHING_MILK_TO_SUMMON = 100 end
                    HelpMarker('Quantity of Refreshing Milk to Summon')
                    ImGui.SameLine()
                    local refreshing_milk_count = mq.TLO.FindItemCount('61992')()
                    ImGui.Text(string.format('You have (%s) Refreshing Milk', refreshing_milk_count))
                    ------ Decadent Jumjum Cake (Packed Picnic Basket)
                    ImGui.Text('Jumjum Cake:')
                    ImGui.SameLine()
                    ImGui.PushItemWidth(100)
                    defaults.JUMJUM_CAKE_TO_SUMMON, _ = ImGui.SliderInt('##SliderInt_JumjumCake', defaults.JUMJUM_CAKE_TO_SUMMON, 1, 100, "%d")
                    ImGui.SameLine()
                    ImGui.PushItemWidth(1)
                    defaults.JUMJUM_CAKE_TO_SUMMON, _ = ImGui.InputInt('##inputint###inputstandard_JumjumCake', defaults.JUMJUM_CAKE_TO_SUMMON, 1, 100, ImGuiInputTextFlags.None)
                    if defaults.JUMJUM_CAKE_TO_SUMMON < 1 then defaults.JUMJUM_CAKE_TO_SUMMON = 0 end
                    if defaults.JUMJUM_CAKE_TO_SUMMON > 100 then defaults.JUMJUM_CAKE_TO_SUMMON = 100 end
                    HelpMarker('Quantity of Decadent Jumjum Cake to Summon')
                    ImGui.SameLine()
                    local jumjum_cake_count = mq.TLO.FindItemCount('61997')()
                    ImGui.Text(string.format('You have (%s) Decadent Jumjum Cake', jumjum_cake_count))
                    ------ Plump Sylvan Berries (Packed Picnic Basket)
                    ImGui.Text('Sylvan Berries:')
                    ImGui.SameLine()
                    ImGui.PushItemWidth(100)
                    defaults.PLUMP_SYLVAN_BERRIES_TO_SUMMON, _ = ImGui.SliderInt('##SliderInt_SylvanBerries', defaults.PLUMP_SYLVAN_BERRIES_TO_SUMMON, 1, 100, "%d")
                    ImGui.SameLine()
                    ImGui.PushItemWidth(1)
                    defaults.PLUMP_SYLVAN_BERRIES_TO_SUMMON, _ = ImGui.InputInt('##inputint###inputstandard_SylvanBerries', defaults.PLUMP_SYLVAN_BERRIES_TO_SUMMON, 1, 100, ImGuiInputTextFlags.None)
                    if defaults.PLUMP_SYLVAN_BERRIES_TO_SUMMON < 1 then defaults.PLUMP_SYLVAN_BERRIES_TO_SUMMON = 0 end
                    if defaults.PLUMP_SYLVAN_BERRIES_TO_SUMMON > 100 then defaults.PLUMP_SYLVAN_BERRIES_TO_SUMMON = 100 end
                    HelpMarker('Quantity of Plump Sylvan Berries to Summon')
                    ImGui.SameLine()
                    local sylvan_berries_count = mq.TLO.FindItemCount('61996')()
                    ImGui.Text(string.format('You have (%s) Plump Sylvan Berries', sylvan_berries_count))
                    ------ Spicy Wolf Sandwich (Packed Picnic Basket)
                    ImGui.Text('Wolf Sandwich:')
                    ImGui.SameLine()
                    ImGui.PushItemWidth(100)
                    defaults.SPICY_WOLF_SANDWICH_TO_SUMMON, _ = ImGui.SliderInt('##SliderInt_WolfSandwich', defaults.SPICY_WOLF_SANDWICH_TO_SUMMON, 1, 100, "%d")
                    ImGui.SameLine()
                    ImGui.PushItemWidth(1)
                    defaults.SPICY_WOLF_SANDWICH_TO_SUMMON, _ = ImGui.InputInt('##inputint###inputstandard_WolfSandwich', defaults.SPICY_WOLF_SANDWICH_TO_SUMMON, 1, 100, ImGuiInputTextFlags.None)
                    if defaults.SPICY_WOLF_SANDWICH_TO_SUMMON < 1 then defaults.SPICY_WOLF_SANDWICH_TO_SUMMON = 0 end
                    if defaults.SPICY_WOLF_SANDWICH_TO_SUMMON > 100 then defaults.SPICY_WOLF_SANDWICH_TO_SUMMON = 100 end
                    HelpMarker('Quantity of Spicy Wolf Sandwich to Summon')
                    ImGui.SameLine()
                    local wolf_sandwich_count = mq.TLO.FindItemCount('61995')()
                    ImGui.Text(string.format('You have (%s) Spicy Wolf Sandwich', wolf_sandwich_count))
                    ImGui.PopItemWidth()
                    ImGui.EndTable()
                end
                ImGui.EndTabItem()
            end
            if ImGui.BeginTabItem('Class Options') then
                ImGui.BeginTable("Class Options",2)
                for _, value in ipairs(classoptions) do
                    ImGui.TableNextColumn()
                    value.selected = ImGui.Checkbox(value.name, value.selected) ImGui.SameLine() HelpMarker(value.helper)
                end
                ImGui.EndTable()
                if ImGui.CollapsingHeader('Custom Burn Settings') then
                    HelpMarker('Mob PCT to Start and Stop Burn')
                    ImGui.BeginTable("Start Burn",1)
                    ImGui.TableNextColumn()
                    ImGui.Text('Mob HP PCT to Start Burn:')
                    ImGui.SameLine()
                    ImGui.PushItemWidth(100)
                    defaults.START_BURN, _ = ImGui.SliderInt('##SliderInt_BurnOn', defaults.START_BURN, 1, 100, "%d")
                    ImGui.SameLine()
                    ImGui.PushItemWidth(1)
                    defaults.START_BURN, _ = ImGui.InputInt('##inputint###inputstandard_StartBurn', defaults.START_BURN, 1, 100, ImGuiInputTextFlags.None)
                    if defaults.START_BURN < 1 then defaults.START_BURN = 1 end
                    if defaults.START_BURN > 100 then defaults.START_BURN = 100 end
                    HelpMarker('Start Burn When Mobs Hits This PCT HP')
                    ImGui.Text('Mob HP PCT to Stop Burn:')
                    ImGui.SameLine()
                    ImGui.PushItemWidth(100)
                    defaults.STOP_BURN, _ = ImGui.SliderInt('##SliderInt_BurnOff', defaults.STOP_BURN, 1, 100, "%d")
                    ImGui.SameLine()
                    ImGui.PushItemWidth(1)
                    defaults.STOP_BURN, _ = ImGui.InputInt('##inputint###inputstandard_StopBurn', defaults.STOP_BURN, 1, 100, ImGuiInputTextFlags.None)
                    if defaults.STOP_BURN < 1 then defaults.STOP_BURN = 1 end
                    if defaults.STOP_BURN > 100 then defaults.STOP_BURN = 100 end
                    HelpMarker('Stop Burn When Mob Hits This PCT HP')
                    ImGui.PopItemWidth()
                    ImGui.EndTable()
                end
                ImGui.EndTabItem()
            end
            ImGui.EndTabBar()
        end
        
            ImGui.Separator()
            --- Account
            if ImGui.CollapsingHeader('Account') then
                if Alive() then
                        HelpMarker('Display Account Details.')
                        local lastTell = mq.TLO.MacroQuest.LastTell()
                        if lastTell ~= nil then
                            ImGui.Text(ICONS.MD_MESSAGE.." Last message from: "..lastTell)
                            if state.settings.showLineSeparators then ImGui.Separator() end
                        end
                        ImGui.Text("Sub:")
                        ImGui.SameLine()
                        if mq.TLO.Me.Subscription() == "GOLD" then
                            ImGui.TextColored(0,1,0,1,"[ " .. mq.TLO.Me.Subscription() .. " ]")
                        elseif mq.TLO.Me.Subscription() == "SILVER" then
                            ImGui.TextColored(0.6, 0.6, 0, 1,"[ " .. mq.TLO.Me.Subscription() .. " ]")
                        elseif mq.TLO.Me.Subscription() == "FREE" then
                            ImGui.TextColored(0.95, 0.05, 0.05, 0.95,"[ " .. mq.TLO.Me.Subscription() .. " ]")
                        end
                        ImGui.SameLine()
                        ImGui.Text("Days Left:")
                        ImGui.SameLine()
                        if mq.TLO.Me.SubscriptionDays() ~= nil then
                            if mq.TLO.Me.SubscriptionDays() > 7 then
                                ImGui.TextColored(0,1,0,1,"[ " .. mq.TLO.Me.SubscriptionDays() .. " ]")
                            elseif mq.TLO.Me.SubscriptionDays() < 8 and mq.TLO.Me.SubscriptionDays() > 3 then
                                ImGui.TextColored(0.6, 0.6, 0, 1,"[ " .. mq.TLO.Me.SubscriptionDays() .. " ]")
                            elseif mq.TLO.Me.SubscriptionDays() < 4 then
                                ImGui.TextColored(0.95, 0.05, 0.05, 1,"[ " .. mq.TLO.Me.SubscriptionDays() .. " ]")
                            end
                        end
                        ImGui.SameLine()
                        ImGui.Text("Krono:")
                        ImGui.SameLine()
                        local me_krono = mq.TLO.Me.Krono() or 0
                            if me_krono >= 5 then
                                ImGui.TextColored(0,1,0,1,"[ " ..  me_krono .. " ]")
                            elseif me_krono <= 4 and  me_krono >= 2 then
                                ImGui.TextColored(0.6, 0.6, 0, 1,"[ " ..  me_krono .. " ]")
                            elseif me_krono <= 1 then
                                ImGui.TextColored(0.95, 0.05, 0.05, 1,"[ " ..  me_krono .. " ]")
                            end
                        ImGui.SameLine()
                        ImGui.Text("Own:")
                        ImGui.SameLine()
                        ImGui.TextColored(1, 1, .5, 1,"[ " .. expansion_owned .. " ]")
                        ImGui.Separator()
                        ImGui.Text("Name:")
                        ImGui.SameLine()
                        ImGui.TextColored(1, 1, .5, 1,"[ " .. mq.TLO.Me.CleanName() .. " ]")
                        ImGui.SameLine()
                        ImGui.Text("Level:")
                        ImGui.SameLine()
                        ImGui.TextColored(1, 1, .5, 1,"[ " .. mq.TLO.Me.Level() .. " ]")
                        ImGui.SameLine()
                        ImGui.Text("Class:")
                        ImGui.SameLine()
                        ImGui.TextColored(1, 1, .5, 1,"[ " .. mq.TLO.Me.Class() .. " ]")
                        ImGui.SameLine()
                        ImGui.Text("Race:")
                        ImGui.SameLine()
                        ImGui.TextColored(1, 1, .5, 1,"[ " .. mq.TLO.Me.Race() .. " ]")                                                            
                        ImGui.Separator()
                        ImGui.Text("Deity:")
                        ImGui.SameLine()
                        ImGui.TextColored(1, 1, .5, 1,"[ " .. mq.TLO.Me.Deity() .. " ]")
                        ImGui.SameLine()
                        ImGui.Text("Bind:")
                        ImGui.SameLine()
                        ImGui.TextColored(1, 1, .5, 1,"[ " .. mq.TLO.Me.ZoneBound() .. " ]")
                        ImGui.SameLine()
                        ImGui.Text("Origin:")
                        ImGui.SameLine()
                        if mq.TLO.Me.Origin() ~= nil then
                        ImGui.TextColored(1, 1, .5, 1,"[ " .. mq.TLO.Me.Origin() .. " ]")
                        end
                        if mq.TLO.Me.Origin() == nil then
                        ImGui.TextColored(1, 1, .5, 1,"[ Crescent Reach ]")
                        end
                        ImGui.Separator()
                        ImGui.Text("EQ Login:")
                        ImGui.SameLine()
                        ImGui.TextColored(1, 1, .5, 1,"[ " .. mq.TLO.EverQuest.LoginName() .. " ]")
                        ImGui.SameLine()
                        ImGui.Text("Server:")
                        ImGui.SameLine()
                        ImGui.TextColored(1, 1, .5, 1,"[ " .. mq.TLO.EverQuest.Server() .. " ]")
                        ImGui.SameLine()
                        ImGui.Text("Priority:")
                        ImGui.SameLine()
                        ImGui.TextColored(1, 1, .5, 1,"[ " .. mq.TLO.EverQuest.PPriority() .. " ]")
                        ImGui.Separator()
                        ImGui.Text("AA Unspent:")
                        ImGui.SameLine()
                        ImGui.TextColored(1, 1, .5, 1,"[ " .. mq.TLO.Me.AAPoints() .. " ]")
                        ImGui.SameLine()
                        ImGui.Text("AA Spent:")
                        ImGui.SameLine()
                        ImGui.TextColored(1, 1, .5, 1,"[ " .. mq.TLO.Me.AAPointsSpent() .. " ]")
                        ImGui.SameLine()
                        ImGui.Text("AA Total:")
                        ImGui.SameLine()
                        ImGui.TextColored(1, 1, .5, 1,"[ " .. mq.TLO.Me.AAPointsTotal() .. " ]")
                        ImGui.Text("AA Assigned:")
                        ImGui.SameLine()
                        ImGui.TextColored(1, 1, .5, 1,"[ " .. mq.TLO.Me.AAPointsAssigned() .. " ]")
                        ImGui.SameLine()
                        ImGui.Text("Merc AA Unspent:")
                        ImGui.SameLine()
                        ImGui.TextColored(1, 1, .5, 1,"[ " .. mq.TLO.Me.MercAAPoints() .. " ]")
                        ImGui.SameLine()
                        ImGui.Text("Merc AA Spent:")
                        ImGui.SameLine()
                        ImGui.TextColored(1, 1, .5, 1,"[ " .. mq.TLO.Me.MercAAPointsSpent() .. " ]")
                        ImGui.Separator()
                        ImGui.Text("Platinum:")
                        ImGui.SameLine()
                        ImGui.TextColored(1, 1, .5, 1,"[ " .. mq.TLO.Me.Platinum() .. " ]")
                        ImGui.SameLine()
                        ImGui.Text("Tracked Platinum:")
                        ImGui.SameLine()
                        ImGui.TextColored(1, 1, .5, 1,"[ " .. mq.TLO.Me.Platinum()-current_plat .." ]")
                        ImGui.SameLine()
                        if ImGui.Button('Reset Tracker') then
                            TrackPlat()
                            ImGui.SameLine() HelpMarker('Restart the plat counter for this session')
                        end
                end
            end
            --- Hunter                                                        
            if ImGui.CollapsingHeader('Hunter') then
                                HelpMarker('Hunter Achievements')
                                ImGui.BeginTable("Hide Hunter",2)
                                if not spawned_switch then
                                    ImGui.TableNextColumn() ImGui.Text('Show Me:')
                                    ImGui.SameLine() if ImGui.Button('Only Spawned') then
                                        mq.cmd('/easy showspawned')
                                        spawned_switch = true
                                    end
                                    ImGui.SameLine() HelpMarker('Show Only Spawned Hunter Mobs')
                                end
                                if spawned_switch then
                                    ImGui.TableNextColumn() ImGui.Text('Show Me:')
                                    ImGui.SameLine() if ImGui.Button('All Spawned') then
                                        mq.cmd('/easy showallhunter')
                                        spawned_switch = false
                                    end
                                    ImGui.SameLine() HelpMarker('Show All Spawned Hunter Mobs')
                                end
                                if not missing_switch then
                                    ImGui.TableNextColumn() ImGui.Text('Show Me:')
                                    ImGui.SameLine() if ImGui.Button('Only Missing') then
                                        mq.cmd('/easy showmissing')
                                        missing_switch = true
                                    end
                                    ImGui.SameLine() HelpMarker('Show Only Missing Hunter Mobs')                                    
                                end
                                if missing_switch then
                                    ImGui.TableNextColumn() ImGui.Text('Show Me:')
                                    ImGui.SameLine() if ImGui.Button('All Completed') then
                                        mq.cmd('/easy showcompleted')
                                        missing_switch = false
                                    end
                                    ImGui.SameLine() HelpMarker('Show All Completed Hunter Mobs')
                                end
                                ImGui.EndTable()
                                RenderTitle()
                                ImGui.Separator()
                                if curAch.ID then
                                    RenderHunter()
                                end
                            end

                            --- Zone Info
            if ImGui.CollapsingHeader('Zone Info') then
                HelpMarker('Display Zone Details.')
                    if mq.TLO.Zone() ~= nil then
                        ImGui.Text("Zone:")
                        ImGui.SameLine()
                        ImGui.TextColored(1, 1, .5, 1,"[ " .. mq.TLO.Zone() .. " ]")
                        ImGui.SameLine()
                        ImGui.Text("Short Name:")
                        ImGui.SameLine()
                        ImGui.TextColored(1, 1, .5, 1,"[ " .. mq.TLO.Zone.ShortName() .. " ]")
                        ImGui.SameLine()
                        ImGui.Text("ID:")
                        ImGui.SameLine()
                        ImGui.TextColored(1, 1, .5, 1,"[ " .. mq.TLO.Zone.ID() .. " ]")
                        ImGui.Separator()
                        ImGui.Text("Zone | Guild | Other:")
                        HelpMarker('Players, Guild and Others in Zone')
                        ImGui.SameLine()
                        ImGui.TextColored(0,1,0,1,"[ " .. mq.TLO.SpawnCount('pc')() .. " ]")
                        HelpMarker('Players in Zone')
                        ImGui.SameLine()
                        ImGui.TextColored(0,1,0,1,"[ " .. mq.TLO.SpawnCount('guild pc')() .. " ]")
                        HelpMarker('Guild Members in Zone')
                        ImGui.SameLine()
                        ImGui.TextColored(0,1,0,1,"[ " .. mq.TLO.SpawnCount('pc')() - mq.TLO.SpawnCount('guild pc')() .. " ]")
                        HelpMarker('Other Players in Zone')
                        ImGui.SameLine()
                        ImGui.Text("Peers | Zone")
                        HelpMarker('Total Peers and Peers in Zone')
                        ImGui.SameLine()
                        if mq.TLO.Plugin('mq2dannet')() == nil then
                            ImGui.TextColored(0.95, 0.05, 0.05, 1,"DanNet Disabled")
                        end
                        if mq.TLO.Plugin('mq2dannet')() ~= nil and saved_settings.dannet_load == false then
                            ImGui.TextColored(0.95, 0.05, 0.05, 1,"dannet_load = false")
                            HelpMarker('dannet_load = false (This must be set to TRUE when using DanNet')
                        end
                        if mq.TLO.Plugin('mq2dannet')() ~= nil and saved_settings.dannet_load == nil then
                            ImGui.TextColored(0.95, 0.05, 0.05, 1,"dannet_load Missing")
                            HelpMarker('dannet_load=true is missing from your Easy.ini file, add the setting and restart Easy.lua')
                        end
                        if mq.TLO.Plugin('mq2dannet')() ~= nil and saved_settings.dannet_load then
                        while peerCountDanNet > 0 and mq.TLO.DanNet.PeerCount() ~= peerCountDanNet do
                            peerCountDanNet = mq.TLO.DanNet.PeerCount()
                            break
                        end
                        zonePeerCount = (string.format('zone_%s_%s', mq.TLO.EverQuest.Server(), mq.TLO.Zone.ShortName()))
                        while peerCountDanNet > 0 and mq.TLO.DanNet.PeerCount(''..zonePeerCount..'')() ~= zonePeerCount do
                            if INSTANCE_ZONE[mq.TLO.Zone.ShortName()] then
                                zonePeerCount = (string.format('zone_%s', mq.TLO.Zone.ShortName()))
                            end
                            if not INSTANCE_ZONE[mq.TLO.Zone.ShortName()] then
                                zonePeerCount = (string.format('zone_%s_%s', mq.TLO.EverQuest.Server(), mq.TLO.Zone.ShortName()))
                            end
                            break
                        end
                        if peerCountDanNet > 0 then
                            ImGui.TextColored(0,1,0,1,"[ " .. peerCountDanNet .. " ]")
                            HelpMarker('Total Peers connected to DanNet')
                            ImGui.SameLine()
                            ImGui.TextColored(0,1,0,1,"[ " .. mq.TLO.DanNet.PeerCount(''..zonePeerCount..'')() .. " ]")
                            HelpMarker('Total Peers in Zone')
                        end
                    end
                        ImGui.Separator()
                        local ColumnID_Name = 0
                        local ColumnID_Level = 1
                        local ColumnID_Class = 2
                        local ColumnID_Race = 3
                        local ColumnID_Guild = 4
                        local ColumnID_Distance = 5
                        local ColumnID_LOS = 6
                        local ColumnID_HP = 7
                        local ColumnID_LOC = 8
                        if ImGui.BeginTable('##Players', 9, ImGuiTableFlags.Resizable, 0, ImGuiTableFlags.BordersH * 15, 0.0) then
                            ImGui.TableSetupColumn('Name', ImGuiTableColumnFlags.DefaultSort, 20.0, ColumnID_Name)
                            ImGui.TableSetupColumn('Level', ImGuiTableColumnFlags.DefaultSort, 0.0, ColumnID_Level)
                            ImGui.TableSetupColumn('Class', ImGuiTableColumnFlags.DefaultSort, 0.0, ColumnID_Class)
                            ImGui.TableSetupColumn('Race', ImGuiTableColumnFlags.DefaultSort, 0.0, ColumnID_Race)
                            ImGui.TableSetupColumn('Guild', ImGuiTableColumnFlags.DefaultSort, 0.0, ColumnID_Guild)
                            ImGui.TableSetupColumn('Distance', ImGuiTableColumnFlags.DefaultSort, 0.0, ColumnID_Distance)
                            ImGui.TableSetupColumn('LOS', ImGuiTableColumnFlags.DefaultSort, 0.0, ColumnID_LOS)
                            ImGui.TableSetupColumn('HP Pct', ImGuiTableColumnFlags.DefaultSort, 0.0, ColumnID_HP)
                            ImGui.TableSetupColumn('LOC', ImGuiTableColumnFlags.DefaultSort, 0.0, ColumnID_LOC)
                            ImGui.TableHeadersRow()
                            ImGui.TableNextRow()
                            if Alive() then
                            for k = 1, mq.TLO.SpawnCount('pc')() do
                                local player = mq.TLO.NearestSpawn(k,'pc')
                                        ImGui.TableNextRow()
                                        ImGui.TableNextColumn()
                                        if player.LineOfSight() then
                                        textEnabledPC(player.CleanName())
                                        else
                                        ImGui.Text(string.format('%s', player.CleanName()))
                                        end
                                        ImGui.TableNextColumn()
                                        ImGui.Text(string.format('%d', player.Level()))
                                        ImGui.TableNextColumn()
                                        ImGui.Text(string.format('%s', player.Class.ShortName()))
                                        ImGui.TableNextColumn()
                                        ImGui.Text(string.format('%s', player.Race()))
                                        ImGui.TableNextColumn()
                                        ImGui.Text(string.format('%s', player.Guild() or 'No Guild'))
                                        ImGui.TableNextColumn()
                                        ImGui.Text(string.format('%d', player.Distance()))
                                        ImGui.TableNextColumn()
                                        if player.LineOfSight() then
                                            ImGui.Text(string.format('%s', ICONS.FA_EYE))
                                        end
                                        ImGui.TableNextColumn()
                                        ImGui.Text(string.format('%d', player.PctHPs()))
                                        ImGui.TableNextColumn()
                                        navEnabledPC(player.LocYXZ())
                                        if not Alive() then
                                            break
                                        end
                                    end
                                end
                                ImGui.EndTable()
                            end
                        end
            end
                            -- Favorites
                            if ImGui.CollapsingHeader('Favs') then
                                HelpMarker('Can only run One Macro at a time')
                                ImGui.BeginTable("FavoriteMacros",3)
                                ImGui.TableNextColumn() if ImGui.Button('Block Spells') then block_spells() end ImGui.SameLine() HelpMarker('Adds Mod Rod and Summoned Food and Drink to Blocked Spell List.')
                                ImGui.TableNextColumn() if ImGui.Button('Lazy Lobby Rez') then mq.cmd('/mac lazylobbyrez') end ImGui.SameLine() HelpMarker('Summon Corpse in the Guild Lobby. (Requires LazyLobbyRez.mac')
                                ImGui.TableNextColumn() if ImGui.Button('Stop Macro') then mq.cmd('/end mac') end ImGui.SameLine() HelpMarker('Stops Macro from running')
                                ImGui.TableNextColumn() if ImGui.Button('Resupply') then mq.cmd('/lua run resupply') end ImGui.SameLine() HelpMarker('Resupply Regents and Supplies. (Requires resupply.lua)')
                                ImGui.TableNextColumn() if ImGui.Button('Dumpster Dive') then mq.cmd('/mac dumpsterdive') mq.cmd('/timed 100 /dive start') end ImGui.SameLine() HelpMarker('Dumpster Dive. (Requires dumpsterdive.mac)')
                                ImGui.TableNextColumn() if ImGui.Button('Parcel Stuff') then mq.cmd('/mac parcel') end ImGui.SameLine() HelpMarker('Parcel Items To Specified Toons. (Requires parcel.mac)')
                                ImGui.TableNextColumn() if ImGui.Button('ToonCollect') then mq.cmd('/lua run tooncollect') end ImGui.SameLine() HelpMarker('Claim Dispensers. (Requires tooncollect.lua)')
                                ImGui.TableNextColumn() if ImGui.Button('Big Bag') then mq.cmd('/lua run cbbag') end ImGui.SameLine() HelpMarker('Opens Big Bag (Requires cbbag.lua)')
                                ImGui.TableNextColumn() if ImGui.Button('Big Bank Bag') then mq.cmd('/lua run cbbankbag') end ImGui.SameLine() HelpMarker('Opens Big Bag (Requires cbbankbag.lua)')
                                ImGui.TableNextColumn() if ImGui.Button('Ignore Mob') then mq.cmdf('/addignore "%s"',mq.TLO.Target.CleanName()) mq.cmd('/keypress esc') end ImGui.SameLine() HelpMarker('Adds targeted mob to ignore list.)')
                                ImGui.TableNextColumn() if ImGui.Button('GearStatus') then mq.cmd('/lua run gearstatus') end ImGui.SameLine() HelpMarker('Inquire Toons Gear (Requires gearStatus.lua)')
                                ImGui.TableNextColumn() if ImGui.Button('BandoGear') then mq.cmd('/lua run bandogear') end ImGui.SameLine() HelpMarker('Gear Switcher (Requires bandogear.lua)')
                                ImGui.TableNextColumn() if ImGui.Button('Make Crew') then mq.cmd('/lua run makecrew') end ImGui.SameLine() HelpMarker('Make Groups (Requires makecrew.lua)')
                                ImGui.TableNextColumn() if ImGui.Button('Switcher') then mq.cmd('/lua run switcher') end ImGui.SameLine() HelpMarker('Switch Toons (Requires switcher.lua)')
                                ImGui.TableNextColumn() if ImGui.Button('GoToMyPlot') then mq.cmd('/lua run gotomyplot') end ImGui.SameLine() HelpMarker('Travel to Plot(Requires gotomyplot.lua)')
                                ImGui.TableNextColumn() if ImGui.Button('Collection Plot') then mq.cmd('/lua run cch') end ImGui.SameLine() HelpMarker('Collection Manager(Requires cch.lua)')
                                ImGui.TableNextColumn() if ImGui.Button('Housing Manager') then mq.cmd('/lua run housingmanager') end ImGui.SameLine() HelpMarker('House Manager(Requires housingmanager.lua)')
                                ImGui.TableNextColumn() if ImGui.Button('Collection Gather') then mq.cmd('/mac collections gather') end ImGui.SameLine() HelpMarker('Gather Needed Collections To File(Requires Collections.mac)')
                                ImGui.TableNextColumn() if ImGui.Button('Collection Bazaar') then mq.cmd('/mac collections bazaar') end ImGui.SameLine() HelpMarker('Buy Collections Bazaar(Requires Collections.mac)')
                                ImGui.TableNextColumn() if ImGui.Button('Claim House') then mq.cmd('/mac claimhouse') end ImGui.SameLine() HelpMarker('Claim House Collections(Requires ClaimHouse.mac)')
                                ImGui.EndTable()
                            end
                        end

        ImGui.End()
    end
end

local function help()
    print('\ag[\apEasy.lua\ag] \awby \agCannonballdex \at'..Version..'')
    print('\ar[\apEasy Help\ar]\ag /easy campfire \aw - Will drop a campfire if requirements are met')
    print('\ar[\apEasy Help\ar]\ag /easy brd \aw - One time activate BRD_Burn routine')
    print('\ar[\apEasy Help\ar]\ag /easy ber \aw - One time activate BER_Burn routine')
    print('\ar[\apEasy Help\ar]\ag /easy bst \aw - One time activate BST_Burn routine')
    print('\ar[\apEasy Help\ar]\ag /easy clr \aw - One time activate CLR_Burn routine')
    print('\ar[\apEasy Help\ar]\ag /easy dru \aw - One time activate DRU_Burn routine')
    print('\ar[\apEasy Help\ar]\ag /easy enc \aw - One time activate ENC_Burn routine')
    print('\ar[\apEasy Help\ar]\ag /easy mag \aw - One time activate MAG_Burn routine')
    print('\ar[\apEasy Help\ar]\ag /easy mnk \aw - One time activate MNK_Burn routine')
    print('\ar[\apEasy Help\ar]\ag /easy nec \aw - One time activate NEC_Burn routine')
    print('\ar[\apEasy Help\ar]\ag /easy pal \aw - One time activate PAL_Burn routine')
    print('\ar[\apEasy Help\ar]\ag /easy rng \aw - One time activate RNG_Burn routine')
    print('\ar[\apEasy Help\ar]\ag /easy rog \aw - One time activate ROG_Burn routine')
    print('\ar[\apEasy Help\ar]\ag /easy shd \aw - One time activate SHD_Burn routine')
    print('\ar[\apEasy Help\ar]\ag /easy shm \aw - One time activate SHM_Burn routine')
    print('\ar[\apEasy Help\ar]\ag /easy war \aw - One time activate WAR_Burn routine')
    print('\ar[\apEasy Help\ar]\ag /easy wiz \aw - One time activate WIZ_Burn routine')
    print('\ar[\apEasy Help\ar]\ag /easy showspawned \aw - Only show spawned hunter mobs')
    print('\ar[\apEasy Help\ar]\ag /easy showallhunter \aw - Show all hunter mobs even if not spawned')
    print('\ar[\apEasy Help\ar]\ag /easy showmissing \aw - Only show missing hunter mobs')
    print('\ar[\apEasy Help\ar]\ag /easy showcompleted \aw - Include already killed mobs')
    print('\ar[\apEasy Help\ar]\ag /easy checkparcel \aw - One time activate CheckParcel')
end
local function bind_easy(cmd)
    if cmd == nil then
        help()
        return
    end
    if cmd == 'campfire' then
        Campfire()
        return
    end
    if cmd == 'clr' then
        CLR_BURN()
        return
    end
    if cmd == 'war' then
        WAR_BURN()
        return
    end
    if cmd == 'dru' then
        DRU_BURN()
        return
    end
    if cmd == 'rog' then
        ROG_BURN()
        return
    end
    if cmd == 'brd' then
        BRD_BURN()
        return
    end
    if cmd == 'shd' then
        SHD_BURN()
        return
    end
    if cmd == 'ber' then
        BER_BURN()
        return
    end
    if cmd == 'bst' then
        BST_BURN()
        return
    end
    if cmd == 'mag' then
        MAG_BURN()
        return
    end
    if cmd == 'mnk' then
        MNK_BURN()
        return
    end
    if cmd == 'nec' then
        NEC_BURN()
        return
    end
    if cmd == 'shm' then
        SHM_BURN()
        return
    end
    if cmd == 'showmissing' then
        onlyShowMissing()
        return
    end
    if cmd == 'showcompleted' then
        ShowMissing()
        return
    end
    if cmd == 'showspawned' then
        onlyShowSpawned()
        return
    end
    if cmd == 'showallhunter' then
        ShowSpawned()
        return
    end
    if cmd == 'checkparcel' then
        CheckParcel()
        return
    end
end
local function Keep_DanNet_Loaded()
    if mq.TLO.Plugin('mq2dannet')() == nil and saved_settings.dannet_load then
        print('\ayLoading Plugin DanNet')
       mq.cmd('/plugin dannet')
       print('\arYou NEED \atDanNet to run Easy.lua')
       print('\atTo stop using DanNet, Change your Easy.ini file to dannet_load=false')
    end
end
local function Check_Gamestate()
    if mq.TLO.MacroQuest.GameState() ~= 'INGAME' then
        mq.cmd('/lua stop easy')
    end
end
mq.imgui.init('CannonballdexGUI', CannonballdexGUI)
mq.bind('/easy', bind_easy)
while Open do
    Keep_DanNet_Loaded()
    Cannonballdex()
    mq.delay(500)
    UpdateTime()
    if settings_hud.oldZone ~= settings_hud.myZone() then
        updateTables()
        settings_hud.oldZone = settings_hud.myZone()
    end
    Check_Gamestate()
end
