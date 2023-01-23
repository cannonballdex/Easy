--  Easy.lua - Cannonballdex - 2022-AUG-28
--  Credits to Ladon, Kaen01, loki, coldblooded, dragonslayer

---@type Mq
local mq = require('mq')
require 'ImGui'
local LIP = require('EasyLua/lib/LIP')
local ICONS = require('EasyLua.lib.ICONS')
local SETTINGS_FILE = ''
local SETTINGS_PATH = ''
local MAG_SETTINGS_FILE = ''
local MAG_SETTINGS_PATH = ''
local LOOT_FILE = ''
local LOOT_CONFIG_CHECK = ''
local Version = 'BETA v4.4'
local Debug = true
local function save_settings()
    LIP.save(SETTINGS_PATH, SETTINGS)
end
local function save_mag_settings()
    LIP.save(MAG_SETTINGS_PATH, MAG_SETTINGS)
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
    local DefaultSets = {
        aa_rez=false,
        auto_loot=true,
        ber_burn=false,
        brd_burn=false,
        bst_burn=false,
        campfire=false,
        check_parcel=true,
        claim_frags=true,
        clear_cursor=false,
        clear_rods=false,
        close_book=false,
        close_popup=true,
        dannet_load=true,
        destroy_bulwark=true,
        destroy_rods=true,
        endless_turkey=false,
        fellowship=true,
        forage=true,
        forage_safezones=false,
        force_drink=true,
        force_feed=true,
        get_drunk=false,
        gm_alert=false,
        lazy_merc=true,
        lesson=false,
        mag_burn=false,
        mag_cauldron=false,
        pc_alert=false,
        pop_merc=false,
        power_source=true,
        respawn_bind=false,
        revive_merc=true,
        rog_burn=false,
        rog_poison=false,
        scoot_camp=false,
        shd_burn=false,
        shm_burn=false,
        summon_brew=false,
        summon_cookies=true,
        summon_milk=false,
        summon_tea=true,
        teach_languages=false,
        toon_assist=true,
        war_burn=true,
        working_merc=true
    }
    local MagDefaultSets = {
        spell1 = 'Spear of Molten Komatiite',
        spell2 = 'Spear of Molten Luclinite',
        spell3 = 'Roiling Servant',
        spell4 = 'Chaotic Calamity',
        spell5 = 'Barrage of Many',
        spell6 = 'Shock of Carbide Steel',
        spell7 = 'Volcanic Veil',
        spell8 = 'Summon Molten Komatiite Orb',
        spell9 = 'Scorching Skin',
        spell10 = 'Twincast',
        spell11 = 'Gather Vigor',
        spell12 = '61519',
        spell13 = 'Grant Voidfrost Paradox',
        use_pet_toys = true,
        swap_gem_id = "8",
        pet_spell = 'Conscription of Water',
        pet_toys = 'Grant Shak Dathor\'s Armaments',
        pet_toy1 = 'Summoned: Shadewrought Staff',
        pet_toy2 = 'Summoned: Shadewrought Ice Spear',
        pet_toy3 = 'Summoned: Shadewrought Mindmace',
        pet_toy4 = 'Summoned: Shadewrought Fireblade',
        pet_toy_destroy1 = 'Summoned: Shadewrought Rageaxe',
        pet_toy_destroy2 = 'Summoned: Shadewrought Rageaxe',
        pet_buff1 = 'Burnout XV',
        pet_buff2 = 'Iceflame Barricade ',
        pet_buff3 = 'Aegis of Rumblecrush',
        pet_buff4 = 'Emberweave Coat',
        pet_buff5 = 'Arcane Distillect'
    }
    local CHAR_CONFIG = 'Char_' .. mq.TLO.EverQuest.Server() .. '_' .. mq.TLO.Me.CleanName() .. '_Config'

    CONFIG_DIR = mq.TLO.MacroQuest.Path() .. "\\lua\\EasyLua\\"
    SETTINGS_FILE = 'EasyLua.ini'
    SETTINGS_PATH = CONFIG_DIR..SETTINGS_FILE
    MAG_SETTINGS_FILE = 'Mage.ini'
    MAG_SETTINGS_PATH = CONFIG_DIR..MAG_SETTINGS_FILE
    LOOT_FILE = 'config.lua'
    LOOT_CONFIG_CHECK = CONFIG_DIR..LOOT_FILE
    if loot_file_exists(LOOT_CONFIG_CHECK) then
        LOOT_CONFIG = require('EasyLua.config')
    else
        LOOT_CONFIG = require('EasyLua.config_default')
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
    if file_exists(MAG_SETTINGS_PATH) and mq.TLO.Me.Class.ShortName() == 'MAG' then
        MAG_SETTINGS = LIP.load(MAG_SETTINGS_PATH)
    else
        MAG_SETTINGS = {
            [CHAR_CONFIG] = MagDefaultSets
        }
        save_mag_settings()
    end
    -- if this character doesn't have the sections in the ini, create them
    if SETTINGS[CHAR_CONFIG] == nil then
        SETTINGS[CHAR_CONFIG] = DefaultSets
        save_settings()
    end
    if mq.TLO.Me.Class.ShortName() == 'MAG' and MAG_SETTINGS[CHAR_CONFIG] == nil then
        MAG_SETTINGS[CHAR_CONFIG] = MagDefaultSets
        save_mag_settings()
    end

    -- -- populate variables from loaded data
    local saved_settings = {
        aa_rez = SETTINGS[CHAR_CONFIG]['aa_rez'],
        auto_loot = SETTINGS[CHAR_CONFIG]['auto_loot'],
        ber_burn = SETTINGS[CHAR_CONFIG]['ber_burn'],
        brd_burn = SETTINGS[CHAR_CONFIG]['brd_burn'],
        bst_burn = SETTINGS[CHAR_CONFIG]['bst_burn'],
        campfire = SETTINGS[CHAR_CONFIG]['campfire'],
        check_parcel = SETTINGS[CHAR_CONFIG]['check_parcel'],
        claim_frags = SETTINGS[CHAR_CONFIG]['claim_frags'],
        clear_cursor = SETTINGS[CHAR_CONFIG]['clear_cursor'],
        clear_rods = SETTINGS[CHAR_CONFIG]['clear_rods'],
        close_book = SETTINGS[CHAR_CONFIG]['close_book'],
        close_popup = SETTINGS[CHAR_CONFIG]['close_popup'],
        dannet_load = SETTINGS[CHAR_CONFIG]['dannet_load'],
        destroy_bulwark = SETTINGS[CHAR_CONFIG]['destroy_bulwark'],
        destroy_rods = SETTINGS[CHAR_CONFIG]['destroy_rods'],
        endless_turkey = SETTINGS[CHAR_CONFIG]['endless_turkey'],
        fellowship = SETTINGS[CHAR_CONFIG]['fellowship'],
        forage = SETTINGS[CHAR_CONFIG]['forage'],
        forage_safezones = SETTINGS[CHAR_CONFIG]['forage_safezones'],
        force_drink = SETTINGS[CHAR_CONFIG]['force_drink'],
        force_feed = SETTINGS[CHAR_CONFIG]['force_feed'],
        get_drunk = SETTINGS[CHAR_CONFIG]['get_drunk'],
        gm_alert = SETTINGS[CHAR_CONFIG]['gm_alert'],
        lazy_merc = SETTINGS[CHAR_CONFIG]['lazy_merc'],
        lesson = SETTINGS[CHAR_CONFIG]['lesson'],
        mag_burn = SETTINGS[CHAR_CONFIG]['mag_burn'],
        mag_cauldron = SETTINGS[CHAR_CONFIG]['mag_cauldron'],
        pc_alert = SETTINGS[CHAR_CONFIG]['pc_alert'],
        pop_merc = SETTINGS[CHAR_CONFIG]['pop_merc'],
        power_source = SETTINGS[CHAR_CONFIG]['power_source'],
        respawn_bind = SETTINGS[CHAR_CONFIG]['respawn_bind'],
        revive_merc = SETTINGS[CHAR_CONFIG]['revive_merc'],
        rog_burn = SETTINGS[CHAR_CONFIG]['rog_burn'],
        rog_poison = SETTINGS[CHAR_CONFIG]['rog_poison'],
        scoot_camp = SETTINGS[CHAR_CONFIG]['scoot_camp'],
        shd_burn = SETTINGS[CHAR_CONFIG]['shd_burn'],
        shm_burn = SETTINGS[CHAR_CONFIG]['shm_burn'],
        summon_brew = SETTINGS[CHAR_CONFIG]['summon_brew'],
        summon_cookies = SETTINGS[CHAR_CONFIG]['summon_cookies'],
        summon_milk = SETTINGS[CHAR_CONFIG]['summon_milk'],
        summon_tea = SETTINGS[CHAR_CONFIG]['summon_tea'],
        teach_languages = SETTINGS[CHAR_CONFIG]['teach_languages'],
        toon_assist = SETTINGS[CHAR_CONFIG]['toon_assist'],
        war_burn = SETTINGS[CHAR_CONFIG]['war_burn'],
        working_merc = SETTINGS[CHAR_CONFIG]['working_merc']
    }
    local mag_saved_settings = {
        spell1 = MAG_SETTINGS[CHAR_CONFIG]['spell1'],
        spell2 = MAG_SETTINGS[CHAR_CONFIG]['spell2'],
        spell3 = MAG_SETTINGS[CHAR_CONFIG]['spell3'],
        spell4 = MAG_SETTINGS[CHAR_CONFIG]['spell4'],
        spell5 = MAG_SETTINGS[CHAR_CONFIG]['spell5'],
        spell6 = MAG_SETTINGS[CHAR_CONFIG]['spell6'],
        spell7 = MAG_SETTINGS[CHAR_CONFIG]['spell7'],
        spell8 = MAG_SETTINGS[CHAR_CONFIG]['spell8'],
        spell9 = MAG_SETTINGS[CHAR_CONFIG]['spell9'],
        spell10 = MAG_SETTINGS[CHAR_CONFIG]['spell10'],
        spell11 = MAG_SETTINGS[CHAR_CONFIG]['spell11'],
        spell12 = MAG_SETTINGS[CHAR_CONFIG]['spell12'],
        spell13 = MAG_SETTINGS[CHAR_CONFIG]['spell13'],
        use_pet_toys = MAG_SETTINGS[CHAR_CONFIG]['use_pet_toys'],
        swap_gem_id = MAG_SETTINGS[CHAR_CONFIG]['swap_gem_id'],
        pet_spell = MAG_SETTINGS[CHAR_CONFIG]['pet_spell'],
        pet_toys = MAG_SETTINGS[CHAR_CONFIG]['pet_toys'],
        pet_toy1 = MAG_SETTINGS[CHAR_CONFIG]['pet_toy1'],
        pet_toy2 = MAG_SETTINGS[CHAR_CONFIG]['pet_toy2'],
        pet_toy3 = MAG_SETTINGS[CHAR_CONFIG]['pet_toy3'],
        pet_toy4 = MAG_SETTINGS[CHAR_CONFIG]['pet_toy4'],
        pet_toy_destroy1 = MAG_SETTINGS[CHAR_CONFIG]['pet_toy_destroy1'],
        pet_toy_destroy2 = MAG_SETTINGS[CHAR_CONFIG]['pet_toy_destroy2'],
        pet_buff1 = MAG_SETTINGS[CHAR_CONFIG]['pet_buff1'],
        pet_buff2 = MAG_SETTINGS[CHAR_CONFIG]['pet_buff2'],
        pet_buff3 = MAG_SETTINGS[CHAR_CONFIG]['pet_buff3'],
        pet_buff4 = MAG_SETTINGS[CHAR_CONFIG]['pet_buff4'],
        pet_buff5 = MAG_SETTINGS[CHAR_CONFIG]['pet_buff5']
    }
    --Default Customized Settings--
    local EAT_LEVEL = 3500
    local DRINK_LEVEL = 3500
    local GET_DRUNK_LEVEL = 180
    local COOKIES_TO_SUMMON = 20
    local SPICED_TEA_TO_SUMMON = 20
    local WARM_MILK_TO_SUMMON = 20
    local BRELL_ALE_TO_SUMMON = 20
    local COOKED_TURKEY_TO_SUMMON = 20
    local SCOOT_DISTANCE = 500
    local ALERT_DISTANCE = 500
    local TOON_ASSIST_PCT_ON = 98
    local TOON_ASSIST_PCT_OFF = 80
    local TOON_ASSIST_TARGET_DIST = 25
    local START_BURN = 98
    local STOP_BURN = 2
    local PARCEL_ZONE = 737

    --Force Feed
    local food = LOOT_CONFIG.food or {
        "Cooked Turkey",
        "Fresh Cookie",
        "Aircrips Apple",
        "Iron Ration",
        "Cluster of Kelp",
        "Large Brine Shrimp",
        "Slice of Birthday Cake",
        "Turnip",
        "Summoned: Shir Berenj"
    }
    --Force Drink
    local drink = LOOT_CONFIG.drink or {
        "Water Flask",
        "Ether-Fused Tea",
        "Warm Milk",
        "Spiced Iced Tea",
        "Summoned: Nepeta Mint Tea"
    }
    --Force Drunk
    local liquor = LOOT_CONFIG.liquor or {
        "Brell Day Ale",
        "Summoned: Ale",
        "Brandy",
        "Short Beer",
        "Mead"
    }
    --Forage Items to Destroy
    local FORAGE_DESTROY = LOOT_CONFIG.FORAGE_DESTROY or {
        "Add Your Items Here",
        "Your Item"
    }
    --Forage Items to Keep
    local FORAGE_KEEP = LOOT_CONFIG.FORAGE_KEEP or {
        "Add Your Items Here",
        "Your Item"
    }
    --Mod Rods to Destroy
    local MOD_RODS_TO_DESTROY = LOOT_CONFIG.MOD_RODS_TO_DESTROY or {
        "Wand of Pelagic Transvergence",
        "Wand of Phantasmal Transvergence",
        "Summoned: Large Modulation Shard",
        "Summoned: Dazzling Modulation Shard",
        "Summoned: Radiant Modulation Shard",
        "Rod of Prime Transvergence",
        "Rod of Mystical Transvergence",
        "Rod of Ethereal Transvergence",
        "Rod of Elemental Transvergence"
    }
    --Mod Rods to Inventory
    local MOD_RODS_TO_INVENTORY = LOOT_CONFIG.MOD_RODS_TO_INVENTORY or {
        "Wand of Pelagic Transvergence",
        "Wand of Phantasmal Transvergence",
        "Summoned: Large Modulation Shard",
        "Summoned: Dazzling Modulation Shard",
        "Summoned: Radiant Modulation Shard",
        "Rod of Prime Transvergence",
        "Rod of Mystical Transvergence",
        "Rod of Ethereal Transvergence",
        "Rod of Elemental Transvergence"
    }
    --Cauldron Items to Destroy
    local CAULDRON_TO_DESTROY = LOOT_CONFIG.CAULDRON_TO_DESTROY or {
        "Imprint of the Enhanced Minion",
        "Tavon\'s Burnished Gemstone",
        "Tavon\'s Polished Gemstone",
        "Brightedge",
        "Mardu\'s Mercurial Visor",
        "Wavethrasher",
        "Mardu\'s Maniacal Mask",
        "Tideslasher",
        "Skull of the Spire Servant",
        "Summoned: Nightblade",
        "Summoned: Darkshine Staff",
        "Solus\' Polished Gemstone",
        "Solus\' Burnished Gemstone",
        "Solus\' Marquise-Cut Gemstone",
        "Summoned: Kotahl\'s Tonic of Healing",
        "Summoned: Kotahl\'s Tonic of Clarity",
        "Summoned: Kotahl\'s Tonic of Refreshment",
        "Pail of Slop"
    }
    --Cauldron Items to Keep
    local CAULDRON_TO_KEEP = LOOT_CONFIG.CAULDRON_TO_KEEP or {
        "Aircrisp Apple",
        "Ether-Fused Tea",
        "Void Shard",
        "Bulwark of Many Portals",
        "Flamekin-Baked Rolls",
        "Diffused Green Tonic",
        "Worlu\'s Windcloak",
        "Worlu\'s Prying Eyes",
        "Regal Tonic of Greater Healing",
        "Crystallized Sulfur",
        "Exalted Tonic of Healing",
        "Murky Energy Tonic",
        "Majestic Tonic of Healing",
        "Airkin-Baked Croissant",
        "Wand of Temporal Mastery",
        "Modulating Rod",
        "Rod of Mystical Transvergence",
        "Wand of Restless Modulation",
        "Summoned: Shir Birenj",
        "Summoned: Sahdi\'s Emblem",
        "Summoned: Nepeta Mint Tea"
    }
    --Instance Zones to Show DanNet Peer Count
    local INSTANCE_ZONE = LOOT_CONFIG.INSTANCE_ZONE or {
        ["guildhalllrg_int"] = true,
        ["guildhallsml_int"] = true,
        ["guildhall3_int"] = true,
        ["shadowhaventwo_mission"] = true
     }
    --End of Default Customized Settings--
     -------------------------------------------------
    -------------- Burn Variables -------------------
    -------------------------------------------------
    local burn_variables = {
        targethp = mq.TLO.Target.PctHPs() or 0,
        targetdistance = mq.TLO.Target.Distance() or 0,
        myhp = mq.TLO.Me.PctHPs() or 0,
        maintank = mq.TLO.Group.MainTank.CleanName(),
        myendurance = mq.TLO.Me.PctEndurance() or 0,
        xtarget = mq.TLO.Me.XTarget(),
        mymana = mq.TLO.Me.PctMana() or 0,
        maintankdistance = mq.TLO.Group.MainTank.Distance() or 0,
        targetlevel = mq.TLO.Target.Level() or 0,
        mepoisoned = mq.TLO.Me.CountersPoison() or 0,
        mypethp = mq.TLO.Me.Pet.PctHPs() or 0,
        mypetdistance = mq.TLO.Me.Pet.Distance() or 0,
        mypet = mq.TLO.Me.Pet.CleanName(),
        spell_rank = '',
        spell_ready = ''
        }
    --Hunter Stuffs
    --Kaen01 HunterHUD
    -- ICONS for the checkboxes
    local done = mq.FindTextureAnimation('A_TransparentCheckBoxPressed')
    local notDone = mq.FindTextureAnimation('A_TransparentCheckBoxNormal')
    -- print format function
    local function printf(...)
        print(string.format(...))
    end
    local oldZone = 0
    local myZone = mq.TLO.Zone.ID
    local showOnlyMissing = false
    local minimize = false
    local onlySpawned = false
    local totalDone = ''
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
        ["Itzal, Luclin's Hunter"]  = "Itzal, Luclin`s Hunter"
    }

    -- Zonemap that maps zoneID's to Achievement Indexes, for zones that are speshul!
    local zoneMap = {
        [58]  = 105880,  --Hunter of Crushbone                  Clan Crusbone=crushbone

        [66]  = 106680,  --Hunter of The Ruins of Old Guk       The Reinforced Ruins of Old Guk=gukbottom
        [73]  = 107380,  --Hunter of the Permafrost Caverns     Permafrost Keep=permafrost
        [81]  = 258180,  --Hunter of The Temple of Droga        The Temple of Droga=droga
        [87]  = 208780,  --Hunter of The Burning Wood           The Burning Woods=burningwood
        [89]  = 208980,  --Hunter of The Ruins of Old Sebilis   The Reinforced Ruins of Old Sebilis=sebilis

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
            totalDone = string.format('%d/%d',tmp, curAch.Count)
            if tmp == curAch.Count then totalDone = 'Completed!' end
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
            ImGui.ProgressBar(getPctCompleted(), x-4, 14, totalDone)
            ImGui.PopStyleColor(2)
            ImGui.SetWindowFontScale(1)
        end
        
        local function createLines(spawn)
            if findspawn(spawn) ~= 0 then
                drawCheckBox(spawn)
                textEnabled(spawn)
            elseif not onlySpawned then
                drawCheckBox(spawn)
                ImGui.TextDisabled(spawn)
            end
        end

        local function RenderHunter()
            hunterProgress()
            if not minimize then ImGui.Separator() end
            for index, hunterSpawn in ipairs(myHunterSpawn) do
        
                if not minimize then
                    if showOnlyMissing then
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

    --- Split function
    ---@param inputstr string
    ---@param sep string
    ---@return table
        local function split(inputstr, sep)
            if type(inputstr) == 'string' then
                sep = sep or '%s'
                local t = {}
                for field, s in string.gmatch(inputstr, "([^" .. sep .. "]*)(" .. sep .. "?)") do
                    table.insert(t, field)
                    if s == "" then
                        return t
                    end
                end
            else
                return {}
            end
        end

    local state = {}
    state.settings = {}
    state.settings.showLineSeparators = true
    local Open, ShowUI = true, true
    local pause_switch = false
    local pause_switch_all = false
    local gm_switch = false
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
    local expansion_owned = "Pre-TOV"
    local timeDisplayNorrath = string.format("%02d:%02d", mq.TLO.GameTime.Hour(), mq.TLO.GameTime.Minute())
    local timeDisplayEarth = os.date("%H:%M:%S")
    local peerCountDanNet = ''
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

    print('\ayLoading... \ar[\aoEasy.lua\ar] \awby \agCannonballdex \at'..Version..'')
    print('\ar[\aoEasy Help\ar]\ag /easy \aw - For a list of help commands')
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
            151,
            152,
            202,
            203,
            344,
            345,
            346,
            712,
            737,
            751
        }

    -------------------------------------------------
    ------------------ On Zones --------------------
    -------------------------------------------------
    local onzones = {
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35,
    36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70,
    71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103,
    104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130,
    131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 153, 154, 155, 156, 157, 158, 159, 160,
    161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190,
    191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220,
    221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250,
    251, 252, 253, 254, 255, 256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280,
    281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310,
    311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340,
    341, 342, 343, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372, 373,
    374, 375, 376, 377, 379, 379, 380, 381, 382, 383, 384, 385, 386, 387, 388, 389, 390, 391, 392, 393, 394, 395, 386, 397, 398, 399, 400, 401, 402, 403,
    404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433,
    444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471, 472, 473,
    474, 475, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 700, 701, 702, 703, 704, 705, 706, 707, 708, 709, 710,
    711, 713, 714, 725, 726, 727, 728, 729, 230, 731, 732, 733, 734, 735, 752, 754, 755, 756, 758, 759, 763, 764, 765, 768, 769, 770, 771, 772,
    773, 774, 775, 777, 779, 780, 782, 783, 784, 785, 787, 788, 789, 790, 791, 792, 793, 794, 795, 798, 800, 813, 814, 815, 816, 817, 818, 819, 820, 821,
    822, 823, 824, 825, 826, 827, 828, 829, 830, 831, 832, 833, 834, 835, 836, 837, 838, 839, 840, 841, 842, 843, 844, 845, 846, 847, 848, 849, 850, 851, 
    852, 853, 854, 855, 856, 857, 858, 904, 996, 997, 998
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
                        print('\ar[\aoEasy\ar] \agYou Have A Campfire')
                    end
                    mq.delay('1s')
                end
            end
        end

    -------------------------------------------------
    ------------------ Pop Mercenary ----------------
    -------------------------------------------------
        local function PopMerc()
            if  mq.TLO.Mercenary.State() == 'SUSPENDED' and mq.TLO.Window('MMGW_ManageWnd/MMGW_SuspendButton').Enabled() and not mq.TLO.Me.Hovering() and mq.TLO.NearestSpawn('pc')() ~= nil then
                mq.cmd('/nomodkey /notify MMGW_ManageWnd MMGW_SuspendButton LeftMouseUp')
                print('\ar[\aoEasy\ar] \agPopping Mercenary')
            end
        end

    -------------------------------------------------
    ------------------ Revive Mercenary -------------
    -------------------------------------------------
        local function ReviveMerc()
            if mq.TLO.Mercenary.State() == 'DEAD' and mq.TLO.Window('MMGW_ManageWnd/MMGW_SuspendButton').Enabled() and not mq.TLO.Me.Hovering() and mq.TLO.NearestSpawn('pc')() ~= nil then
                mq.cmd('/nomodkey /notify MMGW_ManageWnd MMGW_SuspendButton LeftMouseUp')
                print('\ar[\aoEasy\ar] \agReviving Mercenary')
            end
        end

    -------------------------------------------------
    ------------------ Power Source -----------------
    -------------------------------------------------
        local function PowerSource()
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
                print('\ar[\aoEasy\ar] \ayUnCheck or Equip a Power Source to use one.')
                mq.delay('1s')
                mq.cmd.autoinventory()
            end
            if mq.TLO.FindItem(MySource).Power() == 0 and mq.TLO.FindItem(MySource)() ~= nil then
                mq.cmd('/ctrl /itemnotify powersource leftmouseup')
                if mq.TLO.FindItem(MySource).Power() == 0 and mq.TLO.Cursor.Name() == MySource and mq.TLO.Cursor.Name() ~= nil then
                    mq.cmd.destroy()
                    print('\ar[\aoEasy\ar] \arDestroyed:\ap Spent Power Source.')
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
    ---------------------- Working Mercenary --------
    -------------------------------------------------
        local function WorkingMerc()
            for j = 1, #onzones do
                if mq.TLO.Zone.ID() == onzones[j] and mq.TLO.Mercenary.State() == 'ACTIVE' and mq.TLO.Mercenary.Stance() ~= 'Balanced' and mq.TLO.Mercenary.Stance() ~= 'Aggressive' and not mq.TLO.Me.Hovering() then
                    print('\ar[\aoEasy\ar] \agMercenary is Back to Work!')
                    print('\ar[\aoEasy\ar] \aoYou have left a lazy zone')
                    mq.delay('3s')
                    print('\ar[\aoEasy\ar] \aySetting \atMercenary \ayStance')
                    if mq.TLO.Mercenary.Class() == 'Cleric' then
                        mq.cmd('/nomodkey /stance Balanced')
                        print('\ar[\aoEasy\ar] \aySetting \atMercenary \ayStance to Balanced')
                    else
                        mq.cmd('/nomodkey /stance Aggressive')
                        print('\ar[\aoEasy\ar] \aySetting \atMercenary \ayStance to Aggressive')
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
                    print('\ar[\aoEasy\ar] \arMercenary Just Got Lazy!')
                    print('\ar[\aoEasy\ar] \aoYou have entered a lazy zone')
                    mq.delay('3s')
                    print('\ar[\aoEasy\ar] \aySetting \atMercenary \ayto \agPassive')
                    mq.cmd('/nomodkey /stance Passive')
                    mq.delay('3s')
                end
            end
        end

    -------------------------------------------------
    ---------- Click Back To Campfire ---------------
    -------------------------------------------------
        local function Fellowship()
            if mq.TLO.Me.Fellowship.CampfireZone() ~= mq.TLO.Zone.Name() and mq.TLO.Me.Fellowship.Campfire() and mq.TLO.FindItem("Fellowship Registration Insignia").TimerReady() == 0 and not mq.TLO.Me.Hovering() then
                mq.cmd('/makemevisible')
                mq.cmdf("/useitem %s", 'Fellowship Registration Insignia')
                mq.delay('5s')
                mq.cmdf("/useitem %s", 'Fellowship Registration Insignia')
                mq.delay(10)
                print('\ar[\aoEasy\ar] \ayClicking back to camp!')
            end
        end

    -------------------------------------------------
    ---------------- Close PopUp --------------------
    -------------------------------------------------
        local function ClosePopUp()
            if mq.TLO.Window('AlertWnd').Open() then
                mq.delay('5s')
                mq.cmd('/notify AlertWnd "ALW_Dismiss_button" leftmouseup')
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
             if mq.TLO.Me.Skill('Forage')() > 0 and mq.TLO.Me.Standing() and mq.TLO.Me.FreeInventory() >= 2 and mq.TLO.Me.AbilityReady('Forage')() and not mq.TLO.Me.Combat() and mq.TLO.Cursor.ID() == nil and mq.TLO.Me.Casting() == nil then
                mq.cmd.doability('Forage')
                mq.delay('1s')
                for _, item in pairs(FORAGE_DESTROY) do
                    if mq.TLO.Cursor.ID() ~= nil and mq.TLO.Cursor.Name() == item then
                        print('\ar[\aoEasy\ar] \agForage \arDestroyed: \ap '..mq.TLO.Cursor.Name())
                        mq.cmd.destroy()
                    end
                end
                for _, item in pairs(FORAGE_DESTROY) do
                    if mq.TLO.Cursor.ID() ~= nil and mq.TLO.Cursor.Name() == item then
                        print('\ar[\aoEasy\ar] \agForage \arDestroyed: \ap '..mq.TLO.Cursor.Name())
                        mq.cmd.destroy()
                    end
                end
                for _, item in pairs(FORAGE_KEEP) do
                    if mq.TLO.Cursor.ID() ~= nil and mq.TLO.Cursor.Name() == item then
                        print('\ar[\aoEasy\ar] \agForage \agKeep: \ap '..mq.TLO.Cursor.Name())
                        mq.cmd.autoinventory()
                    end
                end
                for _, item in pairs(FORAGE_KEEP) do
                    if mq.TLO.Cursor.ID() ~= nil and mq.TLO.Cursor.Name() == item then
                        print('\ar[\aoEasy\ar] \agForage \agKeep: \ap '..mq.TLO.Cursor.Name())
                        mq.cmd.autoinventory()
                    end
                end
                if mq.TLO.Cursor.ID() ~= nil then
                    print('\ar[\aoEasy\ar] \agForage \agKeep:\ay(Not Defined) \ap '..mq.TLO.Cursor.Name())
                    mq.cmd.autoinventory()
                    mq.delay('1s')
                end
                if mq.TLO.Cursor.ID() ~= nil then
                    print('\ar[\aoEasy\ar] \agForage \agKeep:\ay(Not Defined) \ap '..mq.TLO.Cursor.Name())
                    mq.cmd.autoinventory()
                    mq.delay('1s')
                end
            end
        end

    -------------------------------------------------
    ---------------- Respawn Bind -------------------
    -------------------------------------------------
        local function RespawnBind()
            if mq.TLO.Me.Hovering() then
                mq.cmd('/beep')
                mq.cmd('/beep')
                mq.cmd('/beep')
                mq.cmd('/nomodkey /notify RespawnWnd RW_SelectButton LeftMouseUp')
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
                        if not MemberIDs[mq.TLO.NearestSpawn(i..', pc').ID()] and mq.TLO.NearestSpawn(i..', pc').Distance() <= SCOOT_DISTANCE then
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
    ---------------- Rogue Poison -------------------
    -------------------------------------------------
    local poison = {'Consigned Bite of the Shissar XXI', 'Consigned Bite of the Shissar XX', 'Consigned Bite of the Shissar XIX'}
    local legs = mq.TLO.Me.Inventory('18')()
    local function RoguePoison()
        if mq.TLO.Me.Class.ShortName() == 'ROG' and not mq.TLO.Me.Hovering() and not mq.TLO.Me.Invis() and not mq.TLO.Me.Sitting() then
            if mq.TLO.Me.Inventory('legs').TimerReady() == 0 and not mq.TLO.Me.Moving() and mq.TLO.Me.FreeInventory() >= 1 and not mq.TLO.Me.Invis() then
                if mq.TLO.Me.FreeInventory() <= 2 then
                    print('\arWarning - You are out of inventory!')
                end
                mq.cmdf('/itemnotify "%s" rightmouseup',legs)
                mq.delay('3s')
                if mq.TLO.Cursor.ID() ~= nil then
                print('\ar[\aoEasy\ar] \agRog Keep: \ap '..mq.TLO.Cursor.Name())
                mq.cmd.autoinventory()
                end
                mq.delay('2s')
                mq.cmd.doability('sneak')
                mq.delay('2s')
                mq.cmd.doability('hide')
            end
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
        if  mq.TLO.Me.Class.ShortName() == 'MAG' and not mq.TLO.Me.Invis() and not mq.TLO.Me.Combat() and not mq.TLO.Cursor.ID() and not mq.TLO.Me.Hovering() and not mq.TLO.Me.Sitting() then
            if  mq.TLO.FindItemCount(109884)() == 0 and  mq.TLO.FindItemCount(109883)() == 0 and mq.TLO.FindItemCount(109882)() == 0 and mq.TLO.FindItemCount(85480)() == 0 and mq.TLO.FindItemCount(85481)() == 0 and mq.TLO.FindItemCount(85482)() == 0 and mq.TLO.FindItemCount(52880)() == 0 and mq.TLO.FindItemCount(52795)() == 0 and not mq.TLO.Me.Moving() then
                if mq.TLO.Plugin('mq2mage')() then
                    mq.cmd('/docommand /mag pause on')
                end
                for i,v in pairs(SPELLS_TO_TRY) do
                    if tostring(mq.TLO.Me.Book(v)) ~= 'NULL' then
                        mq.cmdf('/mem "%s" 1', v)
                        mq.delay('5s')
                        mq.cmdf('/cast %s', v)
                        mq.delay('2s')
                        mq.cmd.autoinventory()
                    break
                    end
                end
                if mq.TLO.Plugin('mq2mage')() then
                    mq.cmd('/docommand /mag pause off')
                    mq.delay('1s')
                end
            end
            for i,v in pairs(CAULDRONS_TO_TRY) do
                if mq.TLO.FindItem(v)() ~= nil and not mq.TLO.Me.Moving() and mq.TLO.FindItem(v).TimerReady() == 0 and mq.TLO.Me.FreeInventory() >= 1 and not mq.TLO.Me.Combat() and not mq.TLO.Me.Hovering() and not mq.TLO.Me.Invis() and mq.TLO.Cursor.ID() == nil and not mq.TLO.Me.Casting() then
                    if mq.TLO.Me.FreeInventory() <= 2 then
                        print('\arWarning - You are out of inventory!')
                    end
                    mq.cmdf("/useitem %s", v)
                    mq.delay('11s')
                    for _, item in pairs(CAULDRON_TO_KEEP) do
                        if mq.TLO.Cursor.ID() ~= nil and mq.TLO.Cursor.Name() == item then
                            print('\ar[\aoEasy\ar] \agCauldron Keep: \ap '..mq.TLO.Cursor.Name())
                            mq.cmd.autoinventory()
                            mq.delay('1s')
                        end
                        if mq.TLO.Cursor.ID() ~= nil and mq.TLO.Cursor.Name() == item then
                            print('\ar[\aoEasy\ar] \agCauldron Keep: \ap '..mq.TLO.Cursor.Name())
                            mq.cmd.autoinventory()
                            mq.delay(500)
                        end
                    end
                    for _, item in pairs(CAULDRON_TO_DESTROY) do
                        if mq.TLO.Cursor.ID() ~= nil and mq.TLO.Cursor.Name() == item then
                            print('\ar[\aoEasy\ar] \arCauldron Destroyed: \ap '..mq.TLO.Cursor.Name())
                            mq.cmd.destroy()
                            mq.delay('1s')
                        end
                        if mq.TLO.Cursor.ID() ~= nil and mq.TLO.Cursor.Name() == item then
                            print('\ar[\aoEasy\ar] \arCauldron Destroyed: \ap '..mq.TLO.Cursor.Name())
                            mq.cmd.destroy()
                            mq.delay(500)
                        end
                    end
                    if mq.TLO.Cursor.ID() ~= nil then
                        print('\ar[\aoEasy\ar] \agCauldron \agKeep:\ay(Not Defined) \ap '..mq.TLO.Cursor.Name())
                        mq.cmd.autoinventory()
                        mq.delay('1s')
                    end
                    if mq.TLO.Cursor.ID() ~= nil then
                        print('\ar[\aoEasy\ar] \agCauldron \agKeep:\ay(Not Defined) \ap '..mq.TLO.Cursor.Name())
                        mq.cmd.autoinventory()
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
            if mq.TLO.Cursor.ID() ~= nil and mq.TLO.Cursor.Name() == mod_destroy then
                print('\ar[\aoEasy\ar] \arMod Rod Destroyed: \ap '..mq.TLO.Cursor.Name())
                mq.cmd.destroy()
            end
        end
    end

    ---------------------------------------------
    ---------------- Block Spells ---------------
    ---------------------------------------------
    local function block_spells()
        print('\ar[\aoEasy\ar] \ayAdding Mod Rods, Summoned Food and Summoned Water to the Blocked Spell List')
        mq.cmd('/blockspell add me 18798 18799 18800 26841 26842 26843 14731 14732 14733 10763 10700 2538 3188 1503 52 53 55 56 6893 6895 50 10700 10763 10764 10765')
    end

    -------------------------------------------------
    ---------------- Claim Overseer Fragments -------
    ---------- OverseerRewards.lua by Ladon ---------
    -------------------------------------------------
    local function claim_fragments()
        if mq.TLO.FindItemCount('133773')() >= 4 and not mq.TLO.Me.Hovering() then
            print('\ayConverting 4 fragments to Dispenser')
            mq.cmd('/useitem "Overseer Collection Item Dispenser Fragment"')
            mq.delay('1s')
            mq.cmd.autoinventory()
            if mq.TLO.Window('ItemDisplayWindow').Open() then
                mq.cmd('/invoke ${Window[ItemDisplayWindow].DoClose}')
            end
        end
        local function printf(...)
            print(string.format(...))
        end
        local tOverseerItems = {
            "Overseer Agent Pack",
            "Overseer Bonus Uncommon Agent",
            "Sealed Tetradrachm Coffer",
        }
        if mq.TLO.FindItemCount('72508')() >= 1  or mq.TLO.FindItemCount('86498')() >= 1 then
        for _, item in pairs(tOverseerItems) do
            printf("Looking for %s ...", item)
            mq.cmd('/cleanup')
            mq.cmd('/keypress OPEN_INV_BAGS')
            mq.delay('1s')
            if mq.TLO.FindItem(item).ID() then
            printf("Found the %s ...", item)
            mq.cmdf('/itemnotify "%s" rightmouseheld',item)
            mq.delay('1s')
            while mq.TLO.FindItem(item).ID() do
                mq.cmd('/notify ItemDisplayWindow IDW_RewardButton LeftMouseUp')
                mq.delay('1s')
            end
            end
            if mq.TLO.Window('ItemDisplayWindow').Open() then
                mq.cmd('/invoke ${Window[ItemDisplayWindow].DoClose}')
            end
        end
        mq.cmd('/keypress CLOSE_INV_BAGS')
        mq.delay('1s')
        end
    end
    
    -------------------------------------------------
    ---------------- Cookie Dispenser ---------------
    -------------------------------------------------
    local function CookieDispenser()
        if mq.TLO.FindItem('Fresh Cookie Dispenser')() and mq.TLO.FindItemCount('71980')() < COOKIES_TO_SUMMON and mq.TLO.FindItem('=Fresh Cookie Dispenser').TimerReady() == 0 and mq.TLO.Me.FreeInventory() >= 1 and not mq.TLO.Me.Combat() and not mq.TLO.Me.Invis() and not mq.TLO.Me.Sitting() and not mq.TLO.Me.Hovering() and mq.TLO.Cursor.ID() == nil and not mq.TLO.Me.Moving() then
            if mq.TLO.Me.FreeInventory() <= 2 then
                print('\arWarning - You are out of inventory!')
            end
            mq.cmdf("/useitem %s", 'Fresh Cookie Dispenser')
            mq.delay('1s')
            print('\ar[\aoEasy\ar] \agFresh Cookie Dispenser Keep: \apFresh Cookie')
            mq.cmd.autoinventory()
        end
    end

    -------------------------------------------------
    ---------------- Iced Tea Dispenser -------------
    -------------------------------------------------
    local function TeaDispenser()
        if mq.TLO.FindItem('Spiced Iced Tea Dispenser')() and mq.TLO.FindItemCount('107807')() < SPICED_TEA_TO_SUMMON and mq.TLO.FindItem('=Spiced Iced Tea Dispenser').TimerReady() == 0 and mq.TLO.Me.FreeInventory() >= 1 and not mq.TLO.Me.Combat() and not mq.TLO.Me.Invis() and not mq.TLO.Me.Sitting() and not mq.TLO.Me.Hovering() and mq.TLO.Cursor.ID() == nil and not mq.TLO.Me.Moving() then
            if mq.TLO.Me.FreeInventory() <= 2 then
                print('\arWarning - You are out of inventory!')
            end
            mq.cmdf("/useitem %s", 'Spiced Iced Tea Dispenser')
            mq.delay('1s')
            print('\ar[\aoEasy\ar] \agSpiced Iced Tea Dispenser Keep: \apSpiced Iced Tea')
            mq.cmd.autoinventory()
        end
    end

    -------------------------------------------------
    ---------------- Warm Milk Dispenser ------------
    -------------------------------------------------
    local function MilkDispenser()
        if mq.TLO.FindItem('Warm Milk Dispenser')() and mq.TLO.FindItemCount('52199')() < WARM_MILK_TO_SUMMON and mq.TLO.FindItem('=Warm Milk Dispenser').TimerReady() == 0 and mq.TLO.Me.FreeInventory() >= 1 and not mq.TLO.Me.Combat() and not mq.TLO.Me.Invis() and not mq.TLO.Me.Sitting() and not mq.TLO.Me.Hovering() and mq.TLO.Cursor.ID() == nil and not mq.TLO.Me.Moving() then
            if mq.TLO.Me.FreeInventory() <= 2 then
                print('\arWarning - You are out of inventory!')
            end
            mq.cmdf("/useitem %s", 'Warm Milk Dispenser')
            mq.delay('1s')
            print('\ar[\aoEasy\ar] \agWarm Milk Dispenser Keep: \apWarm Milk')
            mq.cmd.autoinventory()
        end
    end

    -------------------------------------------------
    -------------- Brell's Brew Dispenser -----------
    -------------------------------------------------
    local function BrewDispenser()
        if mq.TLO.FindItem('Brell\'s Brew Dispenser')() and mq.TLO.FindItemCount('48994')() < BRELL_ALE_TO_SUMMON and mq.TLO.FindItem('=Brell\'s Brew Dispenser').TimerReady() == 0 and mq.TLO.Me.FreeInventory() >= 1 and not mq.TLO.Me.Combat() and not mq.TLO.Me.Invis() and not mq.TLO.Me.Sitting() and not mq.TLO.Me.Hovering() and mq.TLO.Cursor.ID() == nil and not mq.TLO.Me.Moving() then
            if mq.TLO.Me.FreeInventory() <= 2 then
                print('\arWarning - You are out of inventory!')
            end
            mq.cmdf("/useitem %s", 'Brell\'s Brew Dispenser')
            mq.delay('1s')
            print('\ar[\aoEasy\ar] \agBrell\'s Brew Dispenser Keep: \apBrell\'s Brew')
            mq.cmd.autoinventory()
        end
    end

    -------------------------------------------------
    ---------------- Endless Turkeys ----------------
    -------------------------------------------------
    local function TurkeyDispenser()
        if mq.TLO.FindItem('Endless Turkeys')() and mq.TLO.FindItemCount('56064')() < COOKED_TURKEY_TO_SUMMON and mq.TLO.FindItem('=Endless Turkeys').TimerReady() == 0 and mq.TLO.Me.FreeInventory() >= 1 and not mq.TLO.Me.Combat() and not mq.TLO.Me.Invis() and not mq.TLO.Me.Sitting() and not mq.TLO.Me.Hovering() and mq.TLO.Cursor.ID() == nil and not mq.TLO.Me.Moving() then
            if mq.TLO.Me.FreeInventory() <= 2 then
                print('\arWarning - You are out of inventory!')
            end
            mq.cmdf("/useitem %s", 'Endless Turkeys')
            mq.delay('1s')
            print('\ar[\aoEasy\ar] \agEndless Turkeys Keep: \apEndless Turkey')
            mq.cmd.autoinventory()
        end
    end

    -------------------------------------------------
    ---------------- Force Feed ---------------------
    -------------------------------------------------
    local function ForceFeed()
        for _, v in pairs(food) do
            if mq.TLO.FindItem('=' .. v)() and mq.TLO.Me.Hunger() <= EAT_LEVEL then
                print('\ar[\aoEasy\ar] \agForce Feed: \ap '..v)
                mq.cmdf('/useitem "%s"', v)
            end
        end
    end

    -------------------------------------------------
    ---------------- Force Drink --------------------
    -------------------------------------------------
    local function ForceDrink()
        for _, j in pairs(drink) do
            if mq.TLO.FindItem('=' .. j)() and mq.TLO.Me.Thirst() <= DRINK_LEVEL then
                print('\ar[\aoEasy\ar] \agForce Drink: \ap '..j)
                mq.cmdf('/useitem "%s"', j)
            end
        end
    end

    -------------------------------------------------
    ---------------- Get Drunk ----------------------
    -------------------------------------------------
    local function GetDrunk()
        for _, k in pairs(liquor) do
            if mq.TLO.FindItem('=' .. k)() and mq.TLO.Me.Drunk() <= GET_DRUNK_LEVEL then
                print('\ar[\aoEasy\ar] \agGet Drunk: \ap '..k)
                mq.cmdf('/useitem "%s"', k)
            end
        end
    end

    -------------------------------------------------
    ---------------- Clear ModRods ------------------
    -------------------------------------------------
    local function ClearModRods()
        for _, mod_keep in pairs(MOD_RODS_TO_INVENTORY) do
            if mq.TLO.Cursor.ID() ~= nil and mq.TLO.Cursor.Name() == mod_keep then
                print('\ar[\aoEasy\ar] \agMod Rod Keep: \ap '..mq.TLO.Cursor.Name())
                mq.cmd.autoinventory()
            end
        end
    end

    -------------------------------------------------
    ---------------- Clear Cursor -------------------
    -------------------------------------------------
    local function ClearCursor()
        if mq.TLO.Cursor.ID() ~= nil then
            print('\ar[\aoEasy\ar] \agClearing Cursor \ap '..mq.TLO.Cursor.Name())
            mq.cmd.autoinventory()
        end
    end

    -------------------------------------------------
    ---------------- Close SPell Book ---------------
    -------------------------------------------------
    local function CloseBook()
        if mq.TLO.Window('SpellBookWnd').Open() then
            mq.delay(10000)
            mq.cmd('/invoke ${Window[SpellBookWnd].DoClose}')
        end
    end

    -------------------------------------------------
    ---------------- Delete Empty Bulwark -----------
    -------------------------------------------------
    local function OldBulwark()
        if mq.TLO.FindItemCount('Bulwark of Many Portals')() > 0 and mq.TLO.FindItem('Bulwark of Many Portals').Charges() < 1 and not mq.TLO.Me.Hovering() and not mq.TLO.Me.Invis() and mq.TLO.Cursor.ID() == nil and not mq.TLO.Me.Casting() then
            mq.cmd('/ctrl /itemnotify "Bulwark of Many Portals" leftmouseup')
            mq.delay('1s')
            if mq.TLO.Cursor.ID() == 85491 then
                mq.cmd.destroy()
                print('\ar[\aoEasy\ar] \arDestroyed:\ay (Empty) \apBulwark of Many Portals.')
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
                    if not MemberIDs[mq.TLO.NearestSpawn(j..', pc').ID()] and mq.TLO.NearestSpawn(j..', pc').Distance() <= ALERT_DISTANCE then
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
        if mq.TLO.Window('PlayerWindow/PW_ParcelsIcon')() == 'TRUE' and mq.TLO.Zone.ID() == PARCEL_ZONE or mq.TLO.Window('PlayerWindow/PW_ParcelsOverLimitIcon')() == 'TRUE' and mq.TLO.Zone.ID() == PARCEL_ZONE and not mq.TLO.Me.Hovering() then
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
            mq.cmd('/windowstate MerchantWnd close')
        end
    end

    -------------------------------------------------
    ---------------- Auto Loot Check ----------------
    -------------------------------------------------
    local function LootCheck ()
        if mq.TLO.Window('AdvancedLootWnd').Open() and mq.TLO.SpawnCount('npccorpse radius 300')() > 0 and not mq.TLO.Me.Hovering() and mq.TLO.Me.FreeInventory() >= 2 then
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
            end
            if mq.TLO.Window('AdvancedLootWnd').Open() then
                mq.cmd('/notify AdvancedLootWND ADLW_CLLSetCmbo ListSelect ${Window[AdvancedLootWnd].Child[ADLW_CLLSetCmbo].List[Leave on Corpse]}')
                mq.delay('1s')
                mq.cmd('/notify AdvancedLootWnd "ADLW_CLLSetBtn" leftmouseup')
            end
        end
    end

    -------------------------------------------
    ---------------- Rez Check ----------------
    -------------------------------------------
    function FirstToUpper(str)
        return (str:gsub("^%l", string.upper))
    end

    local function RezCheck ()
        if mq.TLO.Plugin('mq2dannet')() ~= nil and saved_settings.dannet_load then
        local maxdistance = 100
        local corpse_count = mq.TLO.SpawnCount('pccorpse radius '..maxdistance)()
        local peer_list = split(mq.TLO.DanNet.Peers(), '|')
        if mq.TLO.Me.Class.ShortName() == 'CLR' or mq.TLO.Me.Class.ShortName() == 'DRU' or mq.TLO.Me.Class.ShortName() == 'SHM' or mq.TLO.Me.Class.ShortName() == 'PAL' and not mq.TLO.Me.Hovering() and not mq.TLO.Me.Invis() then
            if corpse_count ~= nil then
                for c = 1, corpse_count do
                    for x = 1, #peer_list do
                        local corpse_name = mq.TLO.NearestSpawn(c..',pccorpse radius '..maxdistance).Name()
                        local corpse_name_id = mq.TLO.NearestSpawn(c..',pccorpse radius '..maxdistance).ID()
                        local dannet_member = mq.TLO.DanNet.Peers(x)()
                        local corpseadd = "'s corpse0"
                        if corpse_name_id == nil or dannet_member == nil then
                            break
                        end
                        local fellow_match = FirstToUpper(string.format("%s%s", dannet_member, corpseadd))
                        local fellow_match_strip = fellow_match:gsub('orpse.*','')
                        if not mq.TLO.Me.Hovering() and not mq.TLO.Me.Moving() and mq.TLO.Spawn(''..corpse_name_id..'').Distance() <= 100 and fellow_match == corpse_name and corpse_name_id ~= nil then
                            mq.cmdf('/target %s', fellow_match_strip)
                            mq.cmd('/dex '..dannet_member..' /consent '..mq.TLO.Me.CleanName()..'')
                            print('\ar[\aoEasy\ar] \atRezzing '..dannet_member..'')
                            mq.delay('1s')
                            mq.cmd('/corpse')
                            mq.delay('1s')
                                --Blessing of Resurrection CLR
                                if mq.TLO.Me.AltAbilityReady('3800')() then mq.cmd('/alt activate 3800') end
                                --Rejuvenation of Spirit DRU SHM
                                if mq.TLO.Me.AltAbilityReady('2051')() then mq.cmd('/alt activate 2051') end
                                --Gift of Resurrection PAL
                                if mq.TLO.Me.AltAbilityReady('3711')() then mq.cmd('/alt activate 3711') end
                                while mq.TLO.Me.Casting() do mq.delay('1s') end
                        end
                    end
                end
            end
        end
    end
end

    -------------------------------------------------
    ---------------- Toon Assist --------------------
    -------------------------------------------------
    local function ToonAssist()
    if mq.TLO.Plugin('mq2dannet')() ~= nil and saved_settings.dannet_load then
    local peercount = mq.TLO.DanNet.PeerCount('melee')()
    local targetHP = mq.TLO.Target.PctHPs() or 0
    local tank = mq.TLO.Me.CleanName()
    local mob = mq.TLO.Target.Name()
        if peercount > 0 and targetHP <= TOON_ASSIST_PCT_ON and targetHP >= TOON_ASSIST_PCT_OFF and not mq.TLO.Me.Moving() and mq.TLO.Target.Distance() <= TOON_ASSIST_TARGET_DIST then
            print('\ar[\aoEasy\ar] \arCalling \aw- \aoToon Assist.')
                mq.cmdf('/noparse /dge melee /nav spawn %s', mob)
                mq.delay(250)
                mq.cmdf('/noparse /dge tank /nav spawn %s', mob)
                mq.delay(250)
                mq.cmdf('/noparse /dge melee /assist %s', tank)
                mq.delay(250)
                mq.cmdf('/noparse /dge tank /assist %s', tank)
                mq.delay(250)
                mq.cmd('/noparse /dge melee /attack on')
                mq.delay(250)
                mq.cmd('/noparse /dge tank /attack on')
                mq.delay(10)
        end
    end
end

    -------------------------------------------------
    ---------------- Lesson -------------------------
    -------------------------------------------------
    local function Lesson()
        if mq.TLO.Me.AltAbilityReady("481")() and not mq.TLO.Me.Invis() and not mq.TLO.Me.Hovering() and not mq.TLO.Me.Sitting() then
            print('\ar[\aoEasy\ar] \atUsing Lesson.')
                    mq.cmdf('/noparse /alt act 481')
                    mq.delay('1s')
            end
        end

    -------------------------------------------------
    ---------------- War Burn -----------------------
    -------------------------------------------------
    local WAR_BURN = function ()
            if mq.TLO.Me.Class.ShortName() == 'WAR' then
            --Full Moon's Champion
            local full_moons_champion = mq.TLO.Spell('Full Moon\'s Champion').RankName()
                if mq.TLO.Me.CombatAbilityReady(full_moons_champion)() and mq.TLO.Me.Song("Full Moon\'s Champion")() == nil and not mq.TLO.Me.Hovering() and burn_variables.myendurance >= 10 then
                    mq.cmdf('/disc %s', full_moons_champion)
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..full_moons_champion..'')
                    mq.delay(490)
                end
                --Champion's Aura
                local champions_aura = mq.TLO.Spell('Champion\'s Aura').RankName()
                if mq.TLO.Me.CombatAbilityReady(champions_aura)() and mq.TLO.Me.Aura('Champion\'s Aura')() == nil and not mq.TLO.Me.Hovering() then
                    mq.cmdf('/disc %s', champions_aura)
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..champions_aura..'')
                    mq.delay(490)
                end
                --Breather
                local breather = mq.TLO.Spell('Breather').RankName()
                if mq.TLO.Me.CombatAbilityReady(breather)() and burn_variables.myendurance <= 20 and not mq.TLO.Me.Combat() and mq.TLO.Me.Song('Breather')() == nil and burn_variables.xtarget == 0 and not mq.TLO.Me.Hovering() then
                    mq.cmdf('/disc %s', breather)
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..breather..'')
                    mq.delay(490)
                end
                --Commanding Voice
                local commanding_voice = mq.TLO.Spell('Commanding Voice').RankName()
                if mq.TLO.Me.CombatAbilityReady(commanding_voice)() and mq.TLO.Me.Song("Commanding Voice")() == nil and not mq.TLO.Me.Hovering() and burn_variables.myendurance >= 10 then
                    mq.cmdf('/disc %s', commanding_voice)
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..commanding_voice..'')
                    mq.delay(490)
                end
                if mq.TLO.Me.Combat() and burn_variables.targethp >= STOP_BURN and burn_variables.targethp <= START_BURN and burn_variables.targetdistance <= 30 and burn_variables.targetdistance >= 0 and not mq.TLO.Me.Hovering() then
                --Taunt
                if mq.TLO.Me.AbilityReady('Taunt')() and burn_variables.maintank == mq.TLO.Me.CleanName() then
                    mq.cmd('/doability Taunt')
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atAbility\ag]\ao - Taunt')
                    mq.delay(490)
                end
                --Kick
                if mq.TLO.Me.AbilityReady('Kick')() and mq.TLO.Me.Inventory('14').Type() ~= 'Shield' then
                    mq.cmd('/doability Kick')
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atAbility\ag]\ao - Kick')
                    mq.delay(490)
                end
                --Disarm
                if mq.TLO.Me.AbilityReady('Disarm')() then
                    mq.cmd('/doability Disarm')
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atAbility\ag]\ao - Disarm')
                    mq.delay(490)
                end
                --Bash
                if mq.TLO.Me.AbilityReady('Bash')() and mq.TLO.Me.Inventory('14').Type() == 'Shield' then
                    mq.cmd('/doability Bash')
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atAbility\ag]\ao - Bash')
                    mq.delay(490)
                end
                --Throat Jab
                local throat_jab = mq.TLO.Spell('Throat Jab').RankName()
                if mq.TLO.Me.CombatAbilityReady(throat_jab)() and mq.TLO.Target.Buff('Throat Jab')() == nil then
                    mq.cmdf('/disc %s', throat_jab)
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..throat_jab..'')
                    mq.delay(490)
                end
                --Bracing Stance
                local shield_rupture = mq.TLO.Spell('Shield Rupture').RankName()
                if mq.TLO.Me.CombatAbilityReady(shield_rupture)() then
                    mq.cmdf('/disc %s', shield_rupture)
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..shield_rupture..'')
                    mq.delay(490)
                end
                --Namdrows' Roar
                local namdrows_roar = mq.TLO.Spell('Namdrows\' Roar').RankName()
                if mq.TLO.Me.CombatAbilityReady(namdrows_roar)() and mq.TLO.Target.Buff('Namdrows\' Roar')() == nil then
                    mq.cmdf('/disc %s', namdrows_roar)
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..namdrows_roar..'')
                    mq.delay(490)
                end
                --Bristle Recourse
                local bristle = mq.TLO.Spell('Bristle').RankName()
                if mq.TLO.Me.CombatAbilityReady(bristle)() and mq.TLO.Me.Song('Bristle Recourse')() == nil then
                    mq.cmdf('/disc %s', bristle)
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..bristle..'')
                    mq.delay(490)
                end
                --Phantom Aggressor
                local phantom_aggressor = mq.TLO.Spell('Phantom Aggressor').RankName()
                if mq.TLO.Me.CombatAbilityReady(phantom_aggressor)() then
                    mq.cmdf('/disc %s', phantom_aggressor)
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..phantom_aggressor..'')
                    mq.delay(490)
                end
                --Roar of Challenge
                local roar_of_challenge = mq.TLO.Spell('Roar of Challenge').RankName()
                if mq.TLO.Me.CombatAbilityReady(roar_of_challenge)() and burn_variables.xtarget >= 3 then
                    mq.cmdf('/disc %s', roar_of_challenge)
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..roar_of_challenge..'')
                    mq.delay(490)
                end
                --Ecliptic Shielding
                local ecliptic_shield = mq.TLO.Spell('Ecliptic_Shield').RankName()
                if mq.TLO.Me.CombatAbilityReady(ecliptic_shield)() and mq.TLO.Me.Buff('Ecliptic Shielding')() == nil then
                    mq.cmdf('/disc %s', ecliptic_shield)
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..ecliptic_shield..'')
                    mq.delay(490)
                end
                --Wade into Conflict Effect
                local wade_into_conflict = mq.TLO.Spell('Wade into Conflict').RankName()
                if mq.TLO.Me.CombatAbilityReady(wade_into_conflict)() and mq.TLO.Me.Buff('Wade into Conflict Effect')() == nil then
                    mq.cmdf('/disc %s', wade_into_conflict)
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..wade_into_conflict..'')
                    mq.delay(490)
                end
                --Penumbral Precision Effect
                local penumbral_precision = mq.TLO.Spell('Penumbral Precision').RankName()
                if mq.TLO.Me.CombatAbilityReady(penumbral_precision)() and burn_variables.targethp >= 50 and burn_variables.targethp <= 75 and mq.TLO.Me.Buff('Penumbral Expanse Effect')() == nil then
                    mq.cmdf('/disc %s', penumbral_precision)
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..penumbral_precision..'')
                    mq.delay(490)
                end
                --Knuckle Break
                local knuckle_break = mq.TLO.Spell('Knuckle Break').RankName()
                if mq.TLO.Me.CombatAbilityReady(knuckle_break)() then
                    mq.cmdf('/disc %s', knuckle_break)
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..knuckle_break..'')
                    mq.delay(490)
                end
                --Warrior's Aegis
                local warriors_aegis = mq.TLO.Spell('Warrior\'s Aegis').RankName()
                if mq.TLO.Me.CombatAbilityReady(warriors_aegis)() and mq.TLO.Me.Buff('Warrior\'s Aegis')() == nil then
                    mq.cmdf('/disc %s', warriors_aegis)
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..warriors_aegis..'')
                    mq.delay(490)
                end
                --Twilight Shout
                local twilight_shout = mq.TLO.Spell('Twilight Shout').RankName()
                if mq.TLO.Me.CombatAbilityReady(twilight_shout)() and mq.TLO.Target.Buff('Twilight Shout Effect')() == nil then
                    mq.cmdf('/disc %s', twilight_shout)
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..twilight_shout..'')
                    mq.delay(490)
                end
                --Finish the Fight
                local finish_the_fight = mq.TLO.Spell('Finish the Fight').RankName()
                if mq.TLO.Me.CombatAbilityReady(finish_the_fight)() and mq.TLO.Me.Song('Finish the Fight')() == nil then
                    mq.cmdf('/disc %s', finish_the_fight)
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atCombat Ability\ag]\ao - '..finish_the_fight..'')
                    mq.delay(490)
                end
                --Grappling Strike
                if mq.TLO.Me.AltAbilityReady('Grappling Strike')() then
                    mq.cmd('/alt activate 601')
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atAA\ag]\ao - Grappling Strike')
                    mq.delay(490)
                end
                --Projection of Fury
                if mq.TLO.Me.AltAbilityReady('Projection of Fury')() then
                    mq.cmd('/alt activate 3213')
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atAA\ag]\ao - Projection of Fury')
                    mq.delay(490)
                end
                --Rage of Rallos Zek
                if mq.TLO.Me.AltAbilityReady('Rage of Rallos Zek')() and mq.TLO.Me.Song('Rage of Rallos Zek')() == nil then
                    mq.cmd('/alt activate 131')
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atAA\ag]\ao - Rage of Rallos Zek')
                    mq.delay(490)
                end
                --Ageless Enmity
                if mq.TLO.Me.AltAbilityReady('Ageless Enmity')() then
                    mq.cmd('/alt activate 10367')
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atAA\ag]\ao - Ageless Enmity')
                    mq.delay(490)
                end
                --Blade Guardian
                if mq.TLO.Me.AltAbilityReady('Blade Guardian')() and burn_variables.myhp <= 40 and burn_variables.myhp >= 1 then
                    mq.cmd('/alt activate 967')
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atAA\ag]\ao - Blade Guardian')
                    mq.delay(490)
                end
                --Blast of Anger
                if mq.TLO.Me.AltAbilityReady('Blast of Anger')() then
                    mq.cmd('/alt activate 3646')
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atAA\ag]\ao - Blast of Anger')
                    mq.delay(490)
                end
                --Areat Taunt
                if mq.TLO.Me.AltAbilityReady('Area Taunt')() and not mq.TLO.Me.Moving() and burn_variables.xtarget >= 2 then
                    mq.cmd('/alt activate 110')
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atAA\ag]\ao - Area Taunt')
                    mq.delay(490)
                end
                --Brace for Impact
                if mq.TLO.Me.AltAbilityReady('Brace for Impact')() and burn_variables.myhp <= 30 and burn_variables.myhp >= 1 then
                    mq.cmd('/alt activate 1686')
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atAA\ag]\ao - Brace for Impact')
                    mq.delay(490)
                end
                --Call of Challenge
                if mq.TLO.Me.AltAbilityReady('Call of Challenge')() and burn_variables.targethp >= 2 and burn_variables.targethp <= 10 and mq.TLO.Target.Buff('Call of Challenge')() == nil then
                    mq.cmd('/alt activate 552')
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atAA\ag]\ao - Call of Challenge')
                    mq.delay(490)
                end
                --Gut Punch
                if mq.TLO.Me.AltAbilityReady('Gut Punch')() and mq.TLO.Target.Buff('Gut Punch')() == nil then
                    mq.cmd('/alt activate 3732')
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atAA\ag]\ao - Gut Punch')
                    mq.delay(490)
                end
                --Imperator's Command
                if mq.TLO.Me.AltAbilityReady('Imperator\'s Command')() then
                    mq.cmd('/alt activate 2011')
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atAA\ag]\ao - Imperator\'s Command')
                    mq.delay(490)
                end
                --Knee Strike
                if mq.TLO.Me.AltAbilityReady('Knee Strike')() and mq.TLO.Target.Buff('Knee Strike')() == nil then
                    mq.cmd('/alt activate 801')
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atAA\ag]\ao - Knee Strike')
                    mq.delay(490)
                end
                --Mark of the Mage Hunter
                if mq.TLO.Me.AltAbilityReady('Mark of the Mage Hunter')() and burn_variables.myhp <= 50 and burn_variables.myhp >= 1 then
                    mq.cmd('/alt activate 606')
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atAA\ag]\ao - Mark of the Mage Hunter')
                    mq.delay(490)
                end
                --Vehement Rage
                if mq.TLO.Me.AltAbilityReady('Vehement Rage')() then
                    mq.cmd('/alt activate 800')
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atAA\ag]\ao - Vehement Rage')
                    mq.delay(490)
                end
                --Press the Attack
                if mq.TLO.Me.AltAbilityReady('Press the Attack')() then
                    mq.cmd('/alt activate 467')
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atAA\ag]\ao - Press the Attack')
                    mq.delay(490)
                end
                --Respendent Glory
                if mq.TLO.Me.AltAbilityReady('Resplendent Glory')() and burn_variables.myhp <= 50 and burn_variables.myhp >= 1 then
                    mq.cmd('/alt activate 130')
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atAA\ag]\ao - Resplendent Glory')
                    mq.delay(490)
                end
                --Spire of the Warlord
                if mq.TLO.Me.AltAbilityReady('Spire of the Warlord')()  and mq.TLO.Me.Buff('Spire of the Warlord')() == nil then
                    mq.cmd('/alt activate 1400')
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atAA\ag]\ao - Spire of the Warlord')
                    mq.delay(490)
                end
                --War Cry
                if mq.TLO.Me.AltAbilityReady('War Cry')() then
                    mq.cmd('/alt activate 111')
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atAA\ag]\ao - War Cry')
                    mq.delay(490)
                end
                --Warlord's Bravery
                if mq.TLO.Me.AltAbilityReady('Warlord\'s Bravery')() and burn_variables.myhp <= 40 and burn_variables.myhp >= 1 then
                    mq.cmd('/alt activate 804')
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atAA\ag]\ao - Warlord\'s Bravery')
                    mq.delay(490)
                end
                --Warlord's Fury
                if mq.TLO.Me.AltAbilityReady('Warlord\'s Fury')() and mq.TLO.Target.Buff('Warlord\'s Fury')() == nil then
                    mq.cmd('/alt activate 688')
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atAA\ag]\ao - Warlord\'s Fury')
                    mq.delay(490)
                end
                --Warlord's Grasp
                if mq.TLO.Me.AltAbilityReady('Warlord\'s Grasp')() and mq.TLO.Target.Buff('Warlord\'s Grasp')() == nil then
                    mq.cmd('/alt activate 2002')
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atAA\ag]\ao - Warlord\'s Grasp')
                    mq.delay(490)
                end
                --Warlord's Resurgence
                if mq.TLO.Me.AltAbilityReady('Warlord\'s Resurgence')() and burn_variables.myhp <= 30 and burn_variables.myhp >= 1 then
                    mq.cmd('/alt activate 911')
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atAA\ag]\ao - Warlord\'s Resurgence')
                    mq.delay(490)
                end
                --Warlord's Tenacity
                if mq.TLO.Me.AltAbilityReady('Warlord\'s Tenacity')() and burn_variables.myhp <= 25 and burn_variables.myhp >= 1 then
                    mq.cmd('/alt activate 300')
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atAA\ag]\ao - Warlord\'s Tenacity')
                    mq.delay(490)
                end
                --Wars Sheol's Heroic Blade
                if mq.TLO.Me.AltAbilityReady('Wars Sheol\'s Heroic Blade')() then
                    mq.cmd('/alt activate 2007')
                    print('\ar[\aoEasy\ar] \agWAR Burn\aw - \ag[\atAA\ag]\ao - Wars Sheol\'s Heroic Blade')
                    mq.delay(490)
                end
            end
        end
    end
    -------------------------------------------------
    ---------------- BRD Burn -----------------------
    -------------------------------------------------
    local BRD_BURN = function ()
        if mq.TLO.Me.Class.ShortName() == 'BRD' then
            local brd_burn_variables = {
                targethp = mq.TLO.Target.PctHPs() or 0,
                targetdistance = mq.TLO.Target.Distance() or 0,
                myhp = mq.TLO.Me.PctHPs() or 0,
                maintank = mq.TLO.Group.MainTank.CleanName(),
                myendurance = mq.TLO.Me.PctEndurance() or 0,
                xtarget = mq.TLO.Me.XTarget(),
                mymana = mq.TLO.Me.PctMana() or 0,
                maintankdistance = mq.TLO.Group.MainTank.Distance() or 0,
                targetlevel = mq.TLO.Target.Level() or 0,
                mepoisoned = mq.TLO.Me.CountersPoison() or 0,
                mypethp = mq.TLO.Me.Pet.PctHPs() or 0,
                mypetdistance = mq.TLO.Me.Pet.Distance() or 0,
                mypet = mq.TLO.Me.Pet.CleanName(),
                spell_rank = '',
                spell_ready = ''
                }
            --local song1 = mq.TLO.Me.Song('Aria of Pli Xin Liako')()
            --local song2 = mq.TLO.Me.Song('Arcane Harmony')()
            --local song3 = mq.TLO.Me.Song('Von Deek\'s Spiteful Lyric')()
            --local song4 = mq.TLO.Me.Song('Shojralen\'s Song of Suffering')()
            --local song5 = mq.TLO.Me.Song('Sogran\'s Insult')()
            --local song6 = mq.TLO.Me.Song('War March of Centien Xi Va Xakra')()
            --local song7 = mq.TLO.Me.Song('Xetheg\'s Spry Sonata')()
            --local song8 = mq.TLO.Me.Song('Slumber of the Diabo')()
            --local song9 = mq.TLO.Me.Song('With \atWave of Nocturn')()
            --local song10 = mq.TLO.Me.Buff('Zelinstein\'s Lively Crescendo')()
            --local song11 = mq.TLO.Me.Song('Pulse of Nikolas')()
            --local song12 = mq.TLO.Me.Song('Chorus of Shei Vinitras')()
            --local song13 = mq.TLO.Me.Song('Composite Psalm')()

            --Mez Routine
            --Singe Mez Slumber of the Diabo
            --AOE Mez Wave of Nocturn
            if mq.TLO.Me.XTarget() >= 2 then
                for i = 1, mq.TLO.Me.XTarget() do
                    local mez_target = mq.TLO.Me.XTarget(i).ID()
                    mq.cmdf('/target id %s',mez_target)
                    if mq.TLO.Target.Mezzed() or mq.TLO.Target.Type() == 'Corpse' then
                        break
                    end
                    if mq.TLO.Target.Type() ~= 'Corpse' and mq.TLO.Target.ID() and not mq.TLO.Target.Mezzed() and brd_burn_variables.targetdistance <= 100 and brd_burn_variables.targetdistance >= 0 then
                        printf('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atSpell\ag]\ao - Mezzing \ag[\ap%s\ag] \aoID \ap%s',mq.TLO.Target.CleanName(),mez_target)
                        mq.delay('1s')
                        if mq.TLO.Me.XTarget() == 2 then
                            print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atSpell\ag]\ao - With \atSlumber of Diabo')
                            if mq.TLO.Me.Casting() then mq.cmd('/melody') end
                            mq.cmd('/melody 8')
                            while mq.TLO.Me.Casting() and not mq.TLO.Target.Mezzed() and mq.TLO.Me.XTarget() == 2 do mq.delay(10) end
                        else
                            if mq.TLO.Me.XTarget() == 3 then
                                print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atSpell\ag]\ao - With \atWave of Nocturn')
                                if mq.TLO.Me.Casting() then mq.cmd('/melody') end
                                mq.cmd('/melody 9')
                                while mq.TLO.Me.Casting() and not mq.TLO.Target.Mezzed() and mq.TLO.Me.XTarget() == 3 do mq.delay(10) end
                            else
                                if mq.TLO.Me.XTarget() == 4 then
                                    print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atSpell\ag]\ao - With \atWave of Nocturn')
                                    if mq.TLO.Me.Casting() then mq.cmd('/melody') end
                                    mq.cmd('/melody 9')
                                    while mq.TLO.Me.Casting() and not mq.TLO.Target.Mezzed() and mq.TLO.Me.XTarget() == 4 do mq.delay(10) end
                                else
                                    if mq.TLO.Me.XTarget() == 5 then
                                        print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atSpell\ag]\ao - With \atWave of Nocturn')
                                        if mq.TLO.Me.Casting() then mq.cmd('/melody') end
                                        mq.cmd('/melody 9')
                                        while mq.TLO.Me.Casting() and not mq.TLO.Target.Mezzed() and mq.TLO.Me.XTarget() == 5 do mq.delay(10) end
                                    else
                                        if mq.TLO.Me.XTarget() >= 6 then
                                            print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atSpell\ag]\ao - With \atWave of Nocturn')
                                            if mq.TLO.Me.Casting() then mq.cmd('/melody') end
                                            mq.cmd('/melody 9')
                                            while mq.TLO.Me.Casting() and not mq.TLO.Target.Mezzed() and mq.TLO.Me.XTarget() >=6 do mq.delay(10) end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    if mq.TLO.Target.Type() ~= 'Corpse' and mq.TLO.Target.ID() ~= 0 and mq.TLO.Target.Mezzed() then
                        printf('\ar[\aoEasy\ar] \agBRD Burn\aw - \aoTarget [\ap%s\ag] is Mezzed',mq.TLO.Target.CleanName())
                    end
                    mq.delay(100)
                    if brd_burn_variables.xtarget >= 2 and mq.TLO.Target.Type() ~= 'Corpse' and mq.TLO.Target.ID() ~= 0 and not mq.TLO.Target.Mezzed() then
                        printf('\ar[\aoEasy\ar] \agBRD Burn\aw - \arTarget \ag[\ap%s\ag] \arDID NOT Mez',mq.TLO.Target.CleanName())
                    end
                end
            end
            
            --End of Mez Routine
            --Buff Heal routine
            --Chorus of Shei Vinitras
            if mq.TLO.Me.XTarget() == 0 and mq.TLO.Me.Song('Chorus of Shei Vinitras')() == nil or mq.TLO.Me.XTarget() == 0 and mq.TLO.Me.Song('Chorus of Shei Vinitras')() ~= nil and mq.TLO.Me.Song('Chorus of Shei Vinitras').Duration() ~= nil and mq.TLO.Me.Song('Chorus of Shei Vinitras').Duration() <= 10000 then
                print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atSpell\ag]\ao - Heal with \atChorus of Shei Vinitras')
                if mq.TLO.Me.Casting() then mq.cmd('/melody') end
                mq.cmd('/melody 12')
                mq.delay(500)
                mq.delay('3s')
                print('HEAL DELAY')
                while mq.TLO.Me.Song('Chorus of Shei Vinitras')() == nil and mq.TLO.Me.XTarget() == 0 do mq.delay(500) end
                print('EXIT HEAL DELAY')
            end
            if mq.TLO.Me.XTarget() >= 1 and mq.TLO.Me.Song('Aria of Pli Xin Liako')() == nil and mq.TLO.Me.Song('Xetheg\'s Spry Sonata')() == nil and mq.TLO.Me.XTarget(1)() == nil then
                if mq.TLO.Me.Casting() then mq.cmd('/melody') end
                mq.cmd('/melody 1 2 3 4 6 7')
                mq.delay(500)
                print('DELAY')
                while mq.TLO.Me.Song('Aria of Pli Xin Liako')() == nil and mq.TLO.Me.Song('Xetheg\'s Spry Sonata')() == nil and mq.TLO.Me.XTarget(1)() ~= nil do mq.delay(10) end
                print('EXIT DELAY')
                if brd_burn_variables.xtarget >= 1 then
                    mq.cmdf('/assist %s',brd_burn_variables.maintank)
                    mq.delay('1s')
                    if mq.TLO.Target.Type() ~= 'Corpse' and mq.TLO.Target.ID() ~= 0 and mq.TLO.Target.Aggressive() and mq.TLO.Target.Distance() <= 100 then
                        printf('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atMelee\ag]\ao - Attacking %s',mq.TLO.Target.CleanName())
                        mq.cmdf('/nav id %s',mq.TLO.Target.ID())
                        mq.cmd('/face fast')
                        mq.cmd('/attack')
                    end
                end
            end
            --Composite Psalm
            if brd_burn_variables.myendurance <= 50 and mq.TLO.Me.XTarget(1).ID() ~= 0 then
                print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atSpell\ag]\ao - Endurance with \atComposite Psalm')
                if mq.TLO.Me.Casting() then mq.cmd('/melody') end
                mq.cmd('/melody 13')
                mq.delay(500)
                while not mq.TLO.Me.Combat() and brd_burn_variables.myendurance <= 50 and mq.TLO.Me.XTarget() < 1 and mq.TLO.Me.Song('Composite Psalm')() == nil do mq.delay(500) end
            end
            --Selo's Sonata
            if mq.TLO.Me.AltAbilityReady('Selo\'s Sonata')() and mq.TLO.Me.Buff('Selo\'s Accelerato')() == nil then
                mq.cmd('/alt activate 3704')
                print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atAA\ag]\ao - Selo\'s Sonata')
                mq.delay(490)
            end
            --End Buff Heal Routine
            if  brd_burn_variables.targethp >= STOP_BURN and brd_burn_variables.targethp <= START_BURN then
                while mq.TLO.Me.Combat() and brd_burn_variables.xtarget == 1 and brd_burn_variables.targetdistance <= 50 and brd_burn_variables.targetdistance >= 0 and mq.TLO.Target.Mezzed() == nil and not mq.TLO.Me.Hovering() and mq.TLO.Target.Aggressive() do
                    print('ENTER BURN ROUTINE')
                    mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID())
                    if mq.TLO.Target.Distance() >= 60 then
                    mq.cmdf('/nav id %s',mq.TLO.Target.ID())
                    while mq.TLO.Navigation.Active() do mq.delay(10) end
                    mq.cmd('/face fast')
                    mq.cmd('/attack')
                    end
                    --Kick
                    if mq.TLO.Me.Combat() and mq.TLO.Me.AbilityReady('Kick')() then
                        mq.cmd('/doability Kick')
                        print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atAbility\ag]\ao - Kick')
                        mq.delay(490)
                    end
                    --Combat Abilities
                    --Reflexive Rebuttal
                    local reflexive_rebuttal = mq.TLO.Spell('Reflexive Rebuttal').RankName()
                    if mq.TLO.Me.Combat() and mq.TLO.Me.CombatAbilityReady(reflexive_rebuttal)() and mq.TLO.Target() ~= nil and mq.TLO.Me.ActiveDisc() == nil and mq.TLO.Target.Aggressive() then
                        mq.cmdf('/disc %s', reflexive_rebuttal)
                        print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..reflexive_rebuttal..'')
                        mq.delay(490)
                    end
                    --Thousand Blades
                    local thousand_blades = mq.TLO.Spell('Thousand Blades').RankName()
                    if mq.TLO.Me.Combat() and mq.TLO.Me.CombatAbilityReady(thousand_blades)() and mq.TLO.Target() ~= nil and mq.TLO.Target.Aggressive() then
                        mq.cmd('/stopdisc')
                        mq.delay(100)
                        mq.cmdf('/disc %s', thousand_blades)
                        print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..thousand_blades..'')
                        mq.delay(490)
                    end
                    --Deftdance Discipline
                    local deftdance_discipline = mq.TLO.Spell('Deftdance Discipline').RankName()
                    if mq.TLO.Me.Combat() and mq.TLO.Me.CombatAbilityReady(deftdance_discipline)() and brd_burn_variables.myhp <= 25 and brd_burn_variables.myhp >= 1 and mq.TLO.Target() ~= nil and mq.TLO.Target.Aggressive() then
                        mq.cmd('/stopdisc')
                        mq.delay(100)
                        mq.cmdf('/disc %s', deftdance_discipline)
                        print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..deftdance_discipline..'')
                        mq.delay(490)
                    end
                    --Resistant Discipline
                    local resistant_discipline = mq.TLO.Spell('Resistant Discipline').RankName()
                    if mq.TLO.Me.Combat() and mq.TLO.Me.CombatAbilityReady(resistant_discipline)() and mq.TLO.Me.ActiveDisc() == nil and mq.TLO.Target() ~= nil and mq.TLO.Target.Aggressive() then
                        mq.cmdf('/disc %s', resistant_discipline)
                        print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..resistant_discipline..'')
                        mq.delay(490)
                    end
                    --AA
                    --Bladed Song
                    if mq.TLO.Me.Combat() and mq.TLO.Me.AltAbilityReady('Bladed Song')() and mq.TLO.Target.Buff('Bladed Song')() == nil and mq.TLO.Target() ~= nil and mq.TLO.Target.Aggressive() then
                        mq.cmd('/alt activate 669')
                        print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atAA\ag]\ao - Bladed Song')
                        mq.delay(490)
                    end
                    --Boastful Bellow
                    if mq.TLO.Me.Combat() and mq.TLO.Me.AltAbilityReady('Boastful Bellow')() and mq.TLO.Target.Buff('Boastful Bellow')() == nil and brd_burn_variables.myhp <= 20 and brd_burn_variables.myhp >= 1 and mq.TLO.Target() ~= nil and mq.TLO.Target.Aggressive() then
                        mq.cmd('/alt activate 199')
                        print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atAA\ag]\ao - Boastful Bellow')
                        mq.delay(490)
                    end
                    --Cacophony
                    if mq.TLO.Me.Combat() and mq.TLO.Me.AltAbilityReady('Cacophony')() and mq.TLO.Target.Buff('Cacophony')() == nil and mq.TLO.Target() ~= nil and mq.TLO.Target.Aggressive() then
                        mq.cmd('/alt activate 553')
                        print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atAA\ag]\ao - Cacophony')
                        mq.delay(490)
                    end
                    --Dance of Blades
                    if mq.TLO.Me.Combat() and mq.TLO.Me.AltAbilityReady('Dance of Blades')() and mq.TLO.Me.Song('Dance of Blades')() == nil and mq.TLO.Target() ~= nil and mq.TLO.Target.Aggressive() then
                        mq.cmd('/alt activate 359')
                        print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atAA\ag]\ao - Dance of Blades')
                        mq.delay(490)
                    end
                    --Fierce Eye
                    if mq.TLO.Me.Combat() and mq.TLO.Me.AltAbilityReady('Fierce Eye')() and mq.TLO.Me.Song('Fierce Eye')() == nil and mq.TLO.Me.GroupSize() > 2 and mq.TLO.Target() ~= nil and mq.TLO.Target.Aggressive() then
                        mq.cmd('/alt activate 3506')
                        print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atAA\ag]\ao - Fierce Eye')
                        mq.delay(490)
                    end
                    --Flurry of Notes
                    if mq.TLO.Me.Combat() and mq.TLO.Me.AltAbilityReady('Flurry of Notes')() and mq.TLO.Me.Buff('Flurry of Notes')() == nil and mq.TLO.Target() ~= nil and mq.TLO.Target.Aggressive() then
                        mq.cmd('/alt activate 899')
                        print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atAA\ag]\ao - Flurry of Notes')
                        mq.delay(490)
                    end
                    --Frenzied Kicks
                    if mq.TLO.Me.Combat() and mq.TLO.Me.AltAbilityReady('Frenzied Kicks')() and mq.TLO.Me.Song('Frenzied Kicks')() == nil and mq.TLO.Target() ~= nil and mq.TLO.Target.Aggressive() then
                        mq.cmd('/alt activate 910')
                        print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atAA\ag]\ao - Frenzied Kicks')
                        mq.delay(490)
                    end
                    --Funeral Dirge
                    if mq.TLO.Me.Combat() and mq.TLO.Me.AltAbilityReady('Funeral Dirge')() and mq.TLO.Target.Buff('Funeral Dirge')() == nil and mq.TLO.Target() ~= nil and mq.TLO.Target.Aggressive() then
                        mq.cmd('/alt activate 777')
                        print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atAA\ag]\ao - Funeral Dirge')
                        mq.delay(490)
                    end
                    --Hymn of the Last Stand
                    if mq.TLO.Me.Combat() and mq.TLO.Me.AltAbilityReady('Hymn of the Last Stand')() and mq.TLO.Me.Buff('Hymn of the Last Stand')() == nil and mq.TLO.Target() ~= nil and mq.TLO.Target.Aggressive() then
                        mq.cmd('/alt activate 668')
                        print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atAA\ag]\ao - Hymn of the Last Stand')
                        mq.delay(490)
                    end
                    --Lyrical Prankster
                    if mq.TLO.Me.Combat() and mq.TLO.Me.AltAbilityReady('Lyrical Prankster')() and brd_burn_variables.targethp >= 80 and brd_burn_variables.targethp <= 99 and mq.TLO.Target() ~= nil and mq.TLO.Target.Aggressive() then
                        mq.cmd('/alt activate 8204')
                        print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atAA\ag]\ao - Lyrical Prankster')
                        mq.delay(490)
                    end
                    --Quick Time
                    if mq.TLO.Me.Combat() and mq.TLO.Me.AltAbilityReady('Quick Time')() and mq.TLO.Me.Song('Quick Time')() == nil and mq.TLO.Target() ~= nil and mq.TLO.Target.Aggressive() then
                        mq.cmd('/alt activate 3702')
                        print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atAA\ag]\ao - Quick Time')
                        mq.delay(490)
                    end
                    --Rallying Solo
                    if mq.TLO.Me.Combat() and mq.TLO.Me.AltAbilityReady('Rallying Solo')() and (brd_burn_variables.myendurance <= 30 or brd_burn_variables.mymana <= 30) and mq.TLO.Target() ~= nil and mq.TLO.Target.Aggressive() then
                        mq.cmd('/alt activate 1136')
                        print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atAA\ag]\ao - Rallying Solo')
                        mq.delay(490)
                    end
                    --Shield of Notes
                    if mq.TLO.Me.Combat() and mq.TLO.Me.AltAbilityReady('Shield of Notes')() and mq.TLO.Me.Song('Shield of Notes')() == nil and brd_burn_variables.myhp <= 50 and brd_burn_variables.myhp >= 1 and mq.TLO.Target() ~= nil and mq.TLO.Target.Aggressive() then
                        mq.cmd('/alt activate 361')
                        print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atAA\ag]\ao - Shield of Notes')
                        mq.delay(490)
                    end
                    --Silent Displacement
                    if mq.TLO.Me.Combat() and mq.TLO.Me.AltAbilityReady('Silent Displacement')() and brd_burn_variables.myhp <= 20 and brd_burn_variables.myhp >= 1 and mq.TLO.Target() ~= nil and mq.TLO.Target.Aggressive() then
                        mq.cmd('/alt activate 1178')
                        print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atAA\ag]\ao - Silent Displacement')
                        mq.delay(490)
                    end
                    --Song of Stone
                    if mq.TLO.Me.Combat() and mq.TLO.Me.AltAbilityReady('Song of Stone')() and brd_burn_variables.targethp >= 80 and brd_burn_variables.targethp <= 99 and mq.TLO.Target() ~= nil and mq.TLO.Target.Aggressive() then
                        mq.cmd('/alt activate 544')
                        print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atAA\ag]\ao - Song of Stone')
                        mq.delay(490)
                    end
                    --Spire of the Minstrels
                    if mq.TLO.Me.Combat() and mq.TLO.Me.AltAbilityReady('Spire of the Minstrels')() and mq.TLO.Me.Song('Spire of the Minstrels')() == nil and mq.TLO.Target() ~= nil and mq.TLO.Target.Aggressive() then
                        mq.cmd('/alt activate 1420')
                        print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atAA\ag]\ao - Spire of the Minstrels')
                        mq.delay(490)
                    end
                    --Armor of Experience
                    if mq.TLO.Me.Combat() and mq.TLO.Me.AltAbilityReady('Armor of Experience')() and brd_burn_variables.myhp <= 20 and brd_burn_variables.myhp >= 1 and mq.TLO.Target() ~= nil and mq.TLO.Target.Aggressive() then
                        mq.cmd('/alt activate 2000')
                        print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atAA\ag]\ao - Armor of Experience')
                        mq.delay(490)
                    end
                    --Fading Memories
                    if mq.TLO.Me.Combat() and mq.TLO.Me.AltAbilityReady('Fading Memories')() and brd_burn_variables.myhp <= 10 and brd_burn_variables.myhp >= 1 and mq.TLO.Target.Level() <= 123 and mq.TLO.Target() ~= nil and mq.TLO.Target.Aggressive() then
                        mq.cmd('/alt activate 212')
                        mq.cmd('/alt activate 3701')
                        print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atAA\ag]\ao - Fading Memories')
                        print('\ar[\aoEasy\ar] \agBRD Burn\aw - \ag[\atAA\ag]\ao - Dirge of the Sleepwalker')
                        mq.delay(490)
                    end
                    print('EXIT BURN ROUTINE BREAK')
                    break
                end
            end
        end
    end

    -------------------------------------------------
    ---------------- SHD Burn -----------------------
    -------------------------------------------------
    local SHD_BURN = function ()
        if mq.TLO.Me.Class.ShortName() == 'SHD' then
            --Breather
            local breather = mq.TLO.Spell('Breather').RankName()
            if mq.TLO.Me.CombatAbilityReady(breather)() and burn_variables.myendurance <= 20 and not mq.TLO.Me.Combat() and mq.TLO.Me.Song('Breather')() == nil and burn_variables.xtarget == 0 and not mq.TLO.Me.Hovering() then
                mq.cmdf('/disc %s', breather)
                print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..breather..'')
                mq.delay(490)
            end
            --Dark Lord's Unity (Beza)
            if mq.TLO.Me.AltAbilityReady('Dark Lord\'s Unity (Beza)')() and mq.TLO.Me.Buff('Drape of the Akheva')() == nil and not mq.TLO.Me.Hovering() then
                mq.cmd('/alt activate 1164')
                print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atAA\ag]\ao - Dark Lord\'s Unity (Beza)')
                mq.delay(490)
            end
            --Voice of Thule (MainTank)
            if mq.TLO.Me.AltAbilityReady('Voice of Thule')() and not mq.TLO.Me.Combat() and mq.TLO.Group.MainTank.Buff('Voice of Thule')() == nil and burn_variables.maintankdistance <= 100 and burn_variables.maintankdistance >= 1 and burn_variables.maintank ~= nil and burn_variables.xtarget == 0 and not mq.TLO.Me.Hovering() then
                mq.cmdf('/target id %s', mq.TLO.Group.MainTank.ID())
                if mq.TLO.Group.MainTank.Buff('Voice of Thule')() then mq.delay('1s') return end
                mq.cmdf('/target id %s', mq.TLO.Group.MainTank.ID())
                mq.delay(50)
                printf('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atAA\ag]\ao - Voice of Thule on', burn_variables.maintank)
                mq.cmd('/alt activate 7000')
                mq.delay(490)
            end
            --Voice of Thule
            if mq.TLO.Me.AltAbilityReady('Voice of Thule')() and mq.TLO.Me.Buff('Voice of Thule')() == nil and burn_variables.maintank == mq.TLO.Me.CleanName() and not mq.TLO.Me.Combat() and burn_variables.xtarget == 0 and not mq.TLO.Me.Hovering() then
                mq.cmdf('/target id %s', mq.TLO.Me.ID())
                mq.delay(50)
                print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atAA\ag]\ao - Voice of Thule')
                mq.cmd('/alt activate 7000')
                mq.delay(490)
            end
            --Abilities
            if mq.TLO.Me.Combat() and burn_variables.targethp >= STOP_BURN and burn_variables.targethp <= START_BURN and burn_variables.targetdistance <= 30 and burn_variables.targetdistance >= 0 and not mq.TLO.Me.Hovering() then
                --Taunt
                if mq.TLO.Me.AbilityReady('Taunt')() and burn_variables.maintank == mq.TLO.Me.CleanName() then
                    mq.cmd('/doability Taunt')
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atAbility\ag]\ao - Taunt')
                    mq.delay(490)
                end
                --Disarm
                if mq.TLO.Me.AbilityReady('Disarm')() then
                    mq.cmd('/doability Disarm')
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atAbility\ag]\ao - Disarm')
                    mq.delay(490)
                end
                --Bash
                if mq.TLO.Me.AbilityReady('Bash')() and mq.TLO.Me.Inventory('14').Type() == 'Shield' then
                    mq.cmd('/doability Bash')
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atAbility\ag]\ao - Bash')
                    mq.delay(490)
                end
                --Combat Abilities
                --Reflexive Resentment
                local reflexive_resentment = mq.TLO.Spell('Reflexive Resentment').RankName()
                if mq.TLO.Me.CombatAbilityReady(reflexive_resentment)() then
                    mq.cmdf('/disc %s', reflexive_resentment)
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..reflexive_resentment..'')
                    mq.delay(490)
                end
                --Corrupted Guardian
                local corrupted_guardian = mq.TLO.Spell('Corrupted Guardian').RankName()
                if mq.TLO.Me.CombatAbilityReady(corrupted_guardian)() and mq.TLO.Me.Song('Corrupted Guardian Effect')() == nil and burn_variables.myhp <= 40 and burn_variables.myhp >= 1 then
                    mq.cmdf('/disc %s', corrupted_guardian)
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..corrupted_guardian..'')
                    mq.delay(490)
                end
                --Repudiate
                local repudiate = mq.TLO.Spell('Repudiate').RankName()
                if mq.TLO.Me.CombatAbilityReady(repudiate)() and mq.TLO.Me.Buff('Repudiate')() == nil then
                    mq.cmdf('/disc %s', repudiate)
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..repudiate..'')
                    mq.delay(490)
                end
                --Spite of Mirenilla
                local spite_of_mirenilla = mq.TLO.Spell('Spite of Mirenilla').RankName()
                if mq.TLO.Me.CombatAbilityReady(spite_of_mirenilla)() and mq.TLO.Me.Song('Spite of Mirenilla Recourse')() == nil and mq.TLO.Me.ActiveDisc.ID() == nil then
                    mq.cmdf('/disc %s', spite_of_mirenilla)
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..spite_of_mirenilla..'')
                    mq.delay(490)
                end
                --Xetheg's Carpace
                local xethegs_carpace = mq.TLO.Spell('Xetheg\'s Carpace').RankName()
                if mq.TLO.Me.CombatAbilityReady(xethegs_carpace)() and mq.TLO.Me.ActiveDisc.ID() == nil then
                    mq.cmdf('/disc %s', xethegs_carpace)
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..xethegs_carpace..'')
                    mq.delay(490)
                end
                --Sanguined Blade
                local sanguined_blade = mq.TLO.Spell('Sangquined Blade').RankName()
                if mq.TLO.Me.CombatAbilityReady(sanguined_blade)() then
                    mq.cmdf('/disc %s', sanguined_blade)
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..sanguined_blade..'')
                    mq.delay(490)
                end
                --Wounding Blade
                local wounding_blade = mq.TLO.Spell('Wounding Blade').RankName()
                if mq.TLO.Me.CombatAbilityReady(wounding_blade)() then
                    mq.cmdf('/disc %s', wounding_blade)
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..wounding_blade..'')
                    mq.delay(490)
                end
                --Terminal Breath
                local terminal_breath = mq.TLO.Spell('Terminal Breath').RankName()
                if mq.TLO.Me.CombatAbilityReady(terminal_breath)() and burn_variables.myhp <= 10 and burn_variables.myhp >= 1 then
                    mq.cmdf('/disc %s', terminal_breath)
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..terminal_breath..'')
                    mq.delay(490)
                end
                --Unrelenting Acrimony
                local unrelenting_acrimony = mq.TLO.Spell('Unrelenting Acrimony').RankName()
                if mq.TLO.Me.CombatAbilityReady(unrelenting_acrimony)() and burn_variables.maintank == mq.TLO.Me.CleanName() then
                    mq.cmdf('/disc %s', unrelenting_acrimony)
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..unrelenting_acrimony..'')
                    mq.delay(490)
                end
                --Fyrthek Mantle
                local fyrthek_mantle = mq.TLO.Spell('Fyrthek Mantle').RankName()
                if mq.TLO.Me.CombatAbilityReady(fyrthek_mantle)() and burn_variables.myhp <= 50 and burn_variables.myhp >= 1 then
                    mq.cmd('/stopdisc')
                    mq.delay(50)
                    mq.cmdf('/disc %s', fyrthek_mantle)
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..fyrthek_mantle..'')
                    mq.delay(490)
                end
                --Deflection Discipline
                local deflection_discipline = mq.TLO.Spell('Deflection Discipline').RankName()
                if mq.TLO.Me.CombatAbilityReady(deflection_discipline)() and burn_variables.myhp <= 30 and burn_variables.myhp >= 1 then
                    mq.cmdf('/disc %s', deflection_discipline)
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..deflection_discipline..'')
                    mq.delay(490)
                end
                --Leechcurse Discipline
                local leechcurse_discipline = mq.TLO.Spell('Leechcurse Discipline').RankName()
                if mq.TLO.Me.CombatAbilityReady(leechcurse_discipline)() and burn_variables.myhp <= 10 and burn_variables.myhp >= 1 then
                    mq.cmdf('/disc %s', leechcurse_discipline)
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..leechcurse_discipline..'')
                    mq.delay(490)
                end
                --Unholy Aura Discipline
                local unholy_aura_discipline = mq.TLO.Spell('Unholy Aura Discipline').RankName()
                if mq.TLO.Me.CombatAbilityReady(unholy_aura_discipline)() and mq.TLO.Me.ActiveDisc.ID() == nil then
                    mq.cmdf('/disc %s', unholy_aura_discipline)
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..unholy_aura_discipline..'')
                    mq.delay(490)
                end
                --Rigor Mortis
                local rigor_mortis = mq.TLO.Spell('Rigor Mortis').RankName()
                if mq.TLO.Me.CombatAbilityReady(rigor_mortis)() and burn_variables.myhp <= 5 and burn_variables.myhp >= 1 and not mq.TLO.Me.Feigning() 
                    or mq.TLO.Me.CombatAbilityReady(rigor_mortis)() and burn_variables.maintank ~= mq.TLO.Me.CleanName() and mq.TLO.Me.PctAggro() >= 90 and not mq.TLO.Me.Feigning() then
                    mq.cmdf('/disc %s', rigor_mortis)
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atCombat Ability\ag]\ao - '..rigor_mortis..'')
                    mq.delay('1s')
                    if burn_variables.myhp >= 20 and burn_variables.myhp <= 100 and burn_variables.maintank ~= mq.TLO.Me.CleanName() then
                        mq.cmd('/stand')
                        print('\ar[\aoEasy\ar] \agSHD Burn\aw - Standing Up')
                        mq.delay(50)
                        mq.cmd('/attack on')
                        print('\ar[\aoEasy\ar] \agSHD Burn\aw - Resume Attack')
                    end
                    mq.delay(490)
                end
                --AA
                --Ageless Enmity
                if mq.TLO.Me.AltAbilityReady('Ageless Enmity')() and burn_variables.maintank == mq.TLO.Me.CleanName() then
                    mq.cmd('/alt activate 10392')
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atAA\ag]\ao - Agless Enmity')
                    mq.delay(490)
                end
                --Death Peace
                if mq.TLO.Me.AltAbilityReady('Death Peace')() and burn_variables.maintank ~= mq.TLO.Me.CleanName() and burn_variables.myhp <= 5 and burn_variables.myhp >= 1 and not mq.TLO.Me.Feigning() then
                    mq.cmd('/alt activate 428')
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atAA\ag]\ao - Death Peace')
                    mq.delay(490)
                end
                --Death's Effigy
                if mq.TLO.Me.AltAbilityReady('Death\'s Effigy')() and burn_variables.maintank ~= mq.TLO.Me.CleanName() and burn_variables.myhp <= 3 and burn_variables.myhp >= 1 and not mq.TLO.Me.Feigning() then
                    mq.cmd('/alt activate 7756')
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atAA\ag]\ao - Death\'s Effigy')
                    mq.delay(490)
                end
                --Encroaching Darkness
                if mq.TLO.Me.AltAbilityReady('Encroaching Darkness')() and mq.TLO.Target.Buff('Encroaching Darkness')() == nil and mq.TLO.Target.Buff('Entombing Darkness')() == nil and burn_variables.targethp >= 50 then
                    mq.cmd('/alt activate 826')
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atAA\ag]\ao - Encroaching Darkness')
                    mq.delay(490)
                end
                --Projection of Doom
                if mq.TLO.Me.AltAbilityReady('Projection of Doom')() and burn_variables.targethp >= 90 then
                    mq.cmd('/alt activate 3215')
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atAA\ag]\ao - Projection of Doom')
                    mq.delay(490)
                end
                --Shield Flash
                if mq.TLO.Me.AltAbilityReady('Shield Flash')() and burn_variables.myhp <= 50 and burn_variables.myhp >= 1 then
                    mq.cmd('/alt activate 1112')
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atAA\ag]\ao - Shield Flash')
                    mq.delay(490)
                end
                --Chattering Bones
                if mq.TLO.Me.AltAbilityReady('Chattering Bones')() and burn_variables.targethp >= 90 then
                    mq.cmd('/alt activate 3822')
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atAA\ag]\ao - Chattering Bones')
                    mq.delay(490)
                end
                --Explosion of Hatred
                if mq.TLO.Me.AltAbilityReady('Explosion of Hatred')() and burn_variables.maintank == mq.TLO.Me.CleanName() and burn_variables.xtarget >= 2 then
                    mq.cmd('/alt activate 822')
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atAA\ag]\ao - Explosion of Hatred')
                    mq.delay(490)
                end
                --Explosion of Spite
                if mq.TLO.Me.AltAbilityReady('Explosion of Spite')() and burn_variables.maintank == mq.TLO.Me.CleanName() and burn_variables.xtarget >= 2 then
                    mq.cmd('/alt activate 749')
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atAA\ag]\ao - Explosion of Spite')
                    mq.delay(490)
                end
                --Gift of the Quick Spear
                if mq.TLO.Me.AltAbilityReady('Gift of the Quick Spear')() then
                    mq.cmd('/alt activate 2034')
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atAA\ag]\ao - Gift of the Quick Spear')
                    mq.delay(490)
                end
                --Harm Touch
                if mq.TLO.Me.AltAbilityReady('Harm Touch')() and burn_variables.xtarget >= 3 and burn_variables.targethp >= 50 and burn_variables.maintank == mq.TLO.Me.CleanName() then
                    mq.cmd('/alt activate 6000')
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atAA\ag]\ao - Harm Touch')
                    mq.delay(490)
                end
                --Hate's Attracktion
                if mq.TLO.Me.AltAbilityReady('Hate\'s Attraction')() and burn_variables.targethp >= 80 and burn_variables.maintank == mq.TLO.Me.CleanName() then
                    mq.cmd('/alt activate 9400')
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atAA\ag]\ao - Hate\'s Attraction')
                    mq.delay(490)
                end
                --Stream of Hatred
                if mq.TLO.Me.AltAbilityReady('Stream of Hatred')() and burn_variables.targethp >= 80 and burn_variables.maintank == mq.TLO.Me.CleanName() and burn_variables.xtarget >= 2 then
                    mq.cmd('/alt activate 731')
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atAA\ag]\ao - Stream of Hatred')
                    mq.delay(490)
                end
                --Leech Touch
                if mq.TLO.Me.AltAbilityReady('Leech Touch')() and burn_variables.targethp >= 80 then
                    mq.cmd('/alt activate 87')
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atAA\ag]\ao - Leech Touch')
                    mq.delay(490)
                end
                --Reaver's Bargain
                if mq.TLO.Me.AltAbilityReady('Reaver\'s Bargain')() and burn_variables.myhp <= 30 and burn_variables.myhp >= 1 then
                    mq.cmd('/alt activate 1116')
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atAA\ag]\ao - Reaver\'s Bargain')
                    mq.delay(490)
                end
                --Scourge Skin
                if mq.TLO.Me.AltAbilityReady('Scourge Skin')() and burn_variables.maintank == mq.TLO.Me.CleanName() then
                    mq.cmd('/alt activate 7755')
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atAA\ag]\ao - Scourge Skin')
                    mq.delay(490)
                end
                --Spire of the Reaver
                if mq.TLO.Me.AltAbilityReady('Spire of the Reaver')() then
                    mq.cmd('/alt activate 1450')
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atAA\ag]\ao - Spire of the Reaver')
                    mq.delay(490)
                end
                --T`Vyl's Resolve
                if mq.TLO.Me.AltAbilityReady('T`Vyl\'s Resolve')() then
                    mq.cmd('/alt activate 742')
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atAA\ag]\ao - T`Vyl\'s Resolve')
                    mq.delay(490)
                end
                --Thought Leech
                if mq.TLO.Me.AltAbilityReady('Thought Leech')() then
                    mq.cmd('/alt activate 651')
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atAA\ag]\ao - Thought Leech')
                    mq.delay(490)
                end
                --Veil of Darkness
                if mq.TLO.Me.AltAbilityReady('Veil of Darkness')() and burn_variables.maintank == mq.TLO.Me.CleanName() then
                    mq.cmd('/alt activate 854')
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atAA\ag]\ao - Veil of Darkness')
                    mq.delay(490)
                end
                --Vicious Bite of Chaos
                if mq.TLO.Me.AltAbilityReady('Vicious Bite of Chaos')() then
                    mq.cmd('/alt activate 825')
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atAA\ag]\ao - Vicious Bite of Chaos')
                    mq.delay(490)
                end
                --Visage of Death
                if mq.TLO.Me.AltAbilityReady('Visage of Death')() then
                    mq.cmd('/alt activate 9403')
                    print('\ar[\aoEasy\ar] \agSHD Burn\aw - \ag[\atAA\ag]\ao - Visage of Death')
                    mq.delay(490)
                end
            end
        end
    end

    -------------------------------------------------
    ---------------- BER Burn -----------------------
    -------------------------------------------------
    local BER_BURN = function ()
        if mq.TLO.Me.Class.ShortName() == 'BER' then
        --Breather
        local breather = mq.TLO.Spell('Breather').RankName()
        if mq.TLO.Me.CombatAbilityReady(breather)() and burn_variables.myendurance <= 20 and not mq.TLO.Me.Combat() and mq.TLO.Me.Song('Breather')() == nil and burn_variables.xtarget == 0 and not mq.TLO.Me.Hovering() then
            mq.cmdf('/disc %s', breather)
            print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..breather..'')
            mq.delay(490)
        end
            --Communion of Blood
            if mq.TLO.Me.AltAbilityReady('Communion of Blood')() and not mq.TLO.Me.Combat() and burn_variables.myendurance <= 25 and burn_variables.myendurance >= 0 and mq.TLO.Me.Song('Communion of Blood')() == nil and not mq.TLO.Me.Hovering() then
                mq.cmd('/alt activate 1253')
                print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atAA\ag]\ao - Communion of Blood')
                mq.delay(30000)
            end
            --Axe of the Conqueror
            local axe_of_the_conqueror = mq.TLO.Spell('Axe of the Conqueror').RankName()
                if mq.TLO.Me.CombatAbilityReady(axe_of_the_conqueror)() and mq.TLO.FindItemCount('=Axe of the Conqueror')() <= 100 and mq.TLO.FindItemCount('=Honed Axe Components')() >= 3 and not mq.TLO.Me.Hovering() then
                    mq.cmdf('/disc %s', axe_of_the_conqueror)
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..axe_of_the_conqueror..'')
                    mq.delay(3000)
                    if mq.TLO.Cursor.ID() ~= nil then
                        print('\ar[\aoEasy\ar] \agBER Burn \agKeep: \ap '..mq.TLO.Cursor.Name())
                        mq.cmd.autoinventory()
                    end
                    mq.delay(490)
                end
            --Axe of the Vindicator
            local axe_of_the_vindicator = mq.TLO.Spell('Axe of the Vindicator').RankName()
                if mq.TLO.Me.CombatAbilityReady(axe_of_the_vindicator)() and mq.TLO.FindItemCount('=Axe of the Vindicator')() <= 100 and mq.TLO.FindItemCount('=Fine Axe Components')() >= 3 and not mq.TLO.Me.Hovering() then
                    mq.cmdf('/disc %s', axe_of_the_vindicator)
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..axe_of_the_vindicator..'')
                    mq.delay(3000)
                    if mq.TLO.Cursor.ID() ~= nil then
                        print('\ar[\aoEasy\ar] \agBER Burn \agKeep: \ap '..mq.TLO.Cursor.Name())
                        mq.cmd.autoinventory()
                    end
                    mq.delay(490)
                end
                --Axe of the Mangler
            local axe_of_the_mangler = mq.TLO.Spell('Axe of the Mangler').RankName()
            if mq.TLO.Me.CombatAbilityReady(axe_of_the_mangler)() and mq.TLO.FindItemCount('=Axe of the Mangler')() <= 100 and mq.TLO.FindItemCount('=Fine Axe Components')() >= 3 and not mq.TLO.Me.Hovering() then
                mq.cmdf('/disc %s', axe_of_the_mangler)
                print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..axe_of_the_mangler..'')
                mq.delay(3000)
                if mq.TLO.Cursor.ID() ~= nil then
                    print('\ar[\aoEasy\ar] \agBER Burn \agKeep: \ap '..mq.TLO.Cursor.Name())
                    mq.cmd.autoinventory()
                end
                mq.delay(490)
            end
            --Axe of the Demolisher
            local axe_of_the_demolisher = mq.TLO.Spell('Axe of the Demolisher').RankName()
            if mq.TLO.Me.CombatAbilityReady(axe_of_the_demolisher)() and mq.TLO.FindItemCount('=Axe of the Demolisher')() <= 100 and mq.TLO.FindItemCount('=Fine Axe Components')() >= 3 and not mq.TLO.Me.Hovering() then
                mq.cmdf('/disc %s', axe_of_the_demolisher)
                print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..axe_of_the_demolisher..'')
                mq.delay(3000)
                if mq.TLO.Cursor.ID() ~= nil then
                    print('\ar[\aoEasy\ar] \agBER Burn \agKeep: \ap '..mq.TLO.Cursor.Name())
                    mq.cmd.autoinventory()
                end
                mq.delay(490)
            end
            --Abilities
            if mq.TLO.Me.Combat() and burn_variables.targethp >= STOP_BURN and burn_variables.targethp <= START_BURN and burn_variables.targetdistance <= 30 and burn_variables.targetdistance >= 0 and not mq.TLO.Me.Hovering() then
                --Frenzy
                if mq.TLO.Me.AbilityReady('Frenzy')() then
                    mq.cmd('/doability Frenzy')
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atAbility\ag]\ao - Frenzy')
                    mq.delay(490)
                end
                --Disarm
                if mq.TLO.Me.AbilityReady('Disarm')() then
                    mq.cmd('/doability Disarm')
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atAbility\ag]\ao - Disarm')
                    mq.delay(490)
                end
                --Combat Abilities
                --Ecliptic Rage
                local ecliptic_rage = mq.TLO.Spell('Ecliptic Rage').RankName()
                if mq.TLO.Me.CombatAbilityReady(ecliptic_rage)() and mq.TLO.FindItemCount('=Axe of the Mangler')() >= 1 and burn_variables.myendurance >= 10 then
                    mq.cmd('/disc 65593')
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..ecliptic_rage..'')
                    mq.delay(490)
                end
                --Mangling Discipline
                local mangling_discipline = mq.TLO.Spell('Mangling Discipline').RankName()
                if mq.TLO.Me.CombatAbilityReady(mangling_discipline)() and burn_variables.targethp >= 80 and burn_variables.targethp <= 99 and mq.TLO.Me.ActiveDisc.ID() == nil then
                    mq.cmdf('/disc %s', mangling_discipline)
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..mangling_discipline..'')
                    mq.delay(490)
                end
                --Sapping Strikes
                local sapping_strikes = mq.TLO.Spell('Sapping Strikes').RankName()
                if mq.TLO.Me.CombatAbilityReady(sapping_strikes)() and burn_variables.targethp >= 80 and burn_variables.targethp <= 99 then
                    mq.cmdf('/disc %s', sapping_strikes)
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..sapping_strikes..'')
                    mq.delay(490)
                end
                --Disconcerting Discipline
                local disconcerting_discipline = mq.TLO.Spell('Disconcerting Discipline').RankName()
                if mq.TLO.Me.CombatAbilityReady(disconcerting_discipline)() and burn_variables.targethp >= 80 and burn_variables.targethp <= 99 and mq.TLO.Me.ActiveDisc.ID() == nil then
                    mq.cmdf('/disc %s', disconcerting_discipline)
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..disconcerting_discipline..'')
                    mq.delay(490)
                end
                --Vindicator's Coalition
                local vindicators_coalition = mq.TLO.Spell('Vindicator\'s Coalition').RankName()
                if mq.TLO.Me.CombatAbilityReady(vindicators_coalition)() and mq.TLO.Me.Buff('Vindicator\'s Coalition Effect')() == nil and burn_variables.myendurance >= 10 then
                    mq.cmdf('/disc %s', vindicators_coalition)
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..vindicators_coalition..'')
                    mq.delay(490)
                end
                --Phantom Assailant
                local phantom_assailant = mq.TLO.Spell('Phantom Assailant').RankName()
                if mq.TLO.Me.CombatAbilityReady(phantom_assailant)() and burn_variables.targethp >= 80 and burn_variables.targethp <= 99 then
                    mq.cmdf('/disc %s', phantom_assailant)
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..phantom_assailant..'')
                    mq.delay(490)
                end
                --Instinctive Retaliation
                local instinctive_retaliation = mq.TLO.Spell('Instinctive Retaliation').RankName()
                if mq.TLO.Me.CombatAbilityReady(instinctive_retaliation)() and burn_variables.myhp <=50 then
                    mq.cmdf('/disc %s', instinctive_retaliation)
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..instinctive_retaliation..'')
                    mq.delay(490)
                end
                --Axe of Derakor
                local axe_of_derakor = mq.TLO.Spell('Axe of Derakor').RankName()
                if mq.TLO.Me.CombatAbilityReady(axe_of_derakor)() and mq.TLO.FindItemCount('=Axe of the Vindicator')() >= 1 then
                    mq.cmdf('/disc %s', axe_of_derakor)
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..axe_of_derakor..'')
                    mq.delay(490)
                end
                --Axe of Xin Diabo
                local axe_of_xin_diabo = mq.TLO.Spell('Axe of Xin Diabo').RankName()
                if mq.TLO.Me.CombatAbilityReady(axe_of_xin_diabo)() and mq.TLO.FindItemCount('=Axe of the Conqueror')() >= 1 then
                    mq.cmdf('/disc %s', axe_of_xin_diabo)
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..axe_of_xin_diabo..'')
                    mq.delay(490)
                end
                --Prime Retaliation
                local prime_retaliation = mq.TLO.Spell('Prime Retaliation').RankName()
                if mq.TLO.Me.CombatAbilityReady(prime_retaliation)() and burn_variables.myhp <= 89 and burn_variables.myhp >=10 then
                    mq.cmdf('/disc %s', prime_retaliation)
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..prime_retaliation..'')
                    mq.delay(490)
                end
                --Shared Violence
                local shared_violence = mq.TLO.Spell('Shared Violence').RankName()
                if mq.TLO.Me.CombatAbilityReady(shared_violence)() and burn_variables.targethp <= 99 and burn_variables.targethp >= 50 then
                    mq.cmdf('/disc %s', shared_violence)
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..shared_violence..'')
                    mq.delay(490)
                end
                --Oppressing Frenzy
                local oppressing_frenzy = mq.TLO.Spell('Oppressing Frenzy').RankName()
                if mq.TLO.Me.CombatAbilityReady(oppressing_frenzy)() and burn_variables.targethp >= 40 and burn_variables.targethp <= 99 then
                    mq.cmdf('/disc %s', oppressing_frenzy)
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..oppressing_frenzy..'')
                    mq.delay(490)
                end
                --Blinding Frenzy
                local blinding_frenzy = mq.TLO.Spell('Blinding Frenzy').RankName()
                if mq.TLO.Me.CombatAbilityReady(blinding_frenzy)() and burn_variables.myhp <= 89 and burn_variables.myhp >= 25 then
                    mq.cmd('/stopdisc')
                    mq.delay(50)
                    mq.cmdf('/disc %s', blinding_frenzy)
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..blinding_frenzy..'')
                    mq.delay(490)
                end
                --Maiming Axe Throw
                local maiming_axe_throw = mq.TLO.Spell('Maiming Axe Throw').RankName()
                if mq.TLO.Me.CombatAbilityReady(maiming_axe_throw)() then
                    mq.cmdf('/disc %s', maiming_axe_throw)
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..maiming_axe_throw..'')
                    mq.delay(490)
                end
                --Bloodthirst
                local bloodthirst = mq.TLO.Spell('Bloodthirst').RankName()
                if mq.TLO.Me.CombatAbilityReady(bloodthirst)() and burn_variables.targethp >= 50 and burn_variables.targethp <= 99 then
                    mq.cmdf('/disc %s', bloodthirst)
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..bloodthirst..'')
                    mq.delay(490)
                end
                --Buttressed Frenzy
                local buttressed_frenzy = mq.TLO.Spell('Buttressed Frenzy').RankName()
                if mq.TLO.Me.CombatAbilityReady(buttressed_frenzy)() and burn_variables.myhp >= 50 and burn_variables.myhp <= 89 and mq.TLO.Me.Buff('Buttressed Frenzy')() == nil then
                    mq.cmdf('/disc %s', buttressed_frenzy)
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..buttressed_frenzy..'')
                    mq.delay(490)
                end
                --Shriveling Strikes
                local shriveling_strikes = mq.TLO.Spell('Shriveling Strikes').RankName()
                if mq.TLO.Me.CombatAbilityReady(shriveling_strikes)() and burn_variables.targethp >= 60 and burn_variables.targethp <= 99 and mq.TLO.Me.Song('Shriveling Strikes')() == nil then
                    mq.cmdf('/disc %s', shriveling_strikes)
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..shriveling_strikes..'')
                    mq.delay(490)
                end
                --Frothing Rage
                local frothing_rage = mq.TLO.Spell('Frothing Rage').RankName()
                if mq.TLO.Me.CombatAbilityReady(frothing_rage)() and burn_variables.targethp >= 60 and burn_variables.targethp <= 99 and mq.TLO.Me.Song('Frothing Rage')() == nil then
                    mq.cmdf('/disc %s', frothing_rage)
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..frothing_rage..'')
                    mq.delay(490)
                end
                --Avenging Flurry Discipline
                local avenging_flurry_discipline = mq.TLO.Spell('Avenging Flurry Discipline').RankName()
                if mq.TLO.Me.CombatAbilityReady(avenging_flurry_discipline)() and burn_variables.targethp >= 60 and burn_variables.targethp <= 99 and mq.TLO.Me.ActiveDisc.ID() == nil then
                    mq.cmdf('/disc %s', avenging_flurry_discipline)
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..avenging_flurry_discipline..'')
                    mq.delay(490)
                end
                --Brutal Discipline
                local brutal_discipline = mq.TLO.Spell('Brutal Discipline').RankName()
                if mq.TLO.Me.CombatAbilityReady(brutal_discipline)() and burn_variables.targethp >= 60 and burn_variables.targethp <= 99 and mq.TLO.Me.ActiveDisc.ID() == nil then
                    mq.cmdf('/disc %s', brutal_discipline)
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..brutal_discipline..'')
                    mq.delay(490)
                end
                --Cleaving Acrimony Discipline
                local cleaving_acrimony_discipline = mq.TLO.Spell('Cleaving Acrimony Discipline').RankName()
                if mq.TLO.Me.CombatAbilityReady(cleaving_acrimony_discipline)() and burn_variables.targethp >= 60 and burn_variables.targethp <= 99 and mq.TLO.Me.ActiveDisc.ID() == nil then
                    mq.cmdf('/disc %s', cleaving_acrimony_discipline)
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..cleaving_acrimony_discipline..'')
                    mq.delay(490)
                end
                --Pulverizing Volley
                local pulverizing_volley = mq.TLO.Spell('Pulverizing Volley').RankName()
                if mq.TLO.Me.CombatAbilityReady(pulverizing_volley)() and burn_variables.targethp >= 60 and burn_variables.targethp <= 99 then
                    mq.cmdf('/disc %s', pulverizing_volley)
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..pulverizing_volley..'')
                    mq.delay(490)
                end
                --Cry Carnage
                local cry_carnage = mq.TLO.Spell('Cry Carnage').RankName()
                if mq.TLO.Me.CombatAbilityReady(cry_carnage)() and burn_variables.targethp >= 60 and burn_variables.targethp <= 99 and mq.TLO.Me.Song('Cry Carnage')() == nil and mq.TLO.Me.ActiveDisc.ID() == nil then
                    mq.cmdf('/disc %s', cry_carnage)
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atCombat Ability\ag]\ao - '..cry_carnage..'')
                    mq.delay(490)
                end
                --AA
                --Focused Furious Rampage
                if mq.TLO.Me.AltAbilityReady('Focused Furious Rampage')() and burn_variables.targethp >= 50 and burn_variables.targethp <= 99 then
                    mq.cmd('/alt activate 379')
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atAA\ag]\ao - Focused Furious Rampage')
                    mq.delay(490)
                end
                --Vehement Rage
                if mq.TLO.Me.AltAbilityReady('Vehement Rage')() and burn_variables.targethp >= 50 and burn_variables.targethp <= 99 and mq.TLO.Me.Song('Vehement Rage')() == nil then
                    mq.cmd('/alt activate 800')
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atAA\ag]\ao - Vehement Rage')
                    mq.delay(490)
                end
                --Binding Axe
                if mq.TLO.Me.AltAbilityReady('Binding Axe')() and burn_variables.targethp >= 50 and burn_variables.targethp <= 99 then
                    mq.cmd('/alt activate 642')
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atAA\ag]\ao - Binding Axe')
                    mq.delay(490)
                end
                --Blinding Fury
                if mq.TLO.Me.AltAbilityReady('Blinding Fury')() and burn_variables.targethp >= 50 and burn_variables.targethp <= 99 and mq.TLO.Me.Buff('Blinding Fury')() == nil then
                    mq.cmd('/alt activate 610')
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atAA\ag]\ao - Blinding Fury')
                    mq.delay(490)
                end
                --Blood Pact
                if mq.TLO.Me.AltAbilityReady('Blood Pact')() and burn_variables.targethp >= 50 and burn_variables.targethp <= 99 then
                    mq.cmd('/alt activate 387')
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atAA\ag]\ao - Blood Pact')
                    mq.delay(490)
                end
                --Blood Sustenance
                if mq.TLO.Me.AltAbilityReady('Blood Sustenance')() and burn_variables.targethp >= 1 and burn_variables.targethp <= 30 and mq.TLO.Me.Song('Blood Sustenance')() == nil then
                    mq.cmd('/alt activate 1141')
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atAA\ag]\ao - Blood Sustenance')
                    mq.delay(490)
                end
                --Blood Fury
                if mq.TLO.Me.AltAbilityReady('Blood Fury')() and burn_variables.myhp >= 96 and burn_variables.myhp <= 100 and mq.TLO.Me.Song('Blood Fury')() == nil then
                    mq.cmd('/alt activate 752')
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atAA\ag]\ao - Blood Fury')
                    mq.delay(490)
                end
                --Desperation
                if mq.TLO.Me.AltAbilityReady('Desperation')() and burn_variables.targethp >= 50 and burn_variables.targethp <= 99 then
                    mq.cmd('/alt activate 373')
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atAA\ag]\ao - Desperation')
                    mq.delay(490)
                end
                --Juggernaut Surge
                if mq.TLO.Me.AltAbilityReady('Juggernaut Surge')() and burn_variables.targethp >= 50 and burn_variables.targethp <= 99 then
                    mq.cmd('/alt activate 961')
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atAA\ag]\ao - Juggernaut Surge')
                    mq.delay(490)
                end
                --Juggernaut's Resolve
                if mq.TLO.Me.AltAbilityReady('Juggernaut\'s Resolve')() and burn_variables.myhp <= 50 and burn_variables.myhp >= 1 then
                    mq.cmd('/alt activate 836')
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atAA\ag]\ao - Juggernaut\'s Resolve')
                    mq.delay(490)
                end
                --Reckless Abandon
                if mq.TLO.Me.AltAbilityReady('Reckless Abandon')() and burn_variables.myhp <= 100 and burn_variables.myhp >= 90 and mq.TLO.Me.Song('Reckless Abandon')() == nil then
                    mq.cmd('/alt activate 3710')
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atAA\ag]\ao - Reckless Abandon')
                    mq.delay(490)
                end
                --Savage Spirit
                if mq.TLO.Me.AltAbilityReady('Savage Spirit')() and burn_variables.myhp <= 100 and burn_variables.myhp >= 90 and mq.TLO.Me.Buff('Savage Spirit')() == nil then
                    mq.cmd('/alt activate 465')
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atAA\ag]\ao - Savage Spirit')
                    mq.delay(490)
                end
                --Spire of the Juggernaut
                if mq.TLO.Me.AltAbilityReady('Spire of the Juggernaut')() and mq.TLO.Me.Buff('Spire of the Juggernaut')() == nil then
                    mq.cmd('/alt activate 1500')
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atAA\ag]\ao - Spire of the Juggernaut')
                    mq.delay(490)
                end
                --Uncanny Resilience
                if mq.TLO.Me.AltAbilityReady('Uncanny Resilience')() and burn_variables.myhp <= 30 and burn_variables.myhp >= 0 then
                    mq.cmd('/alt activate 609')
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atAA\ag]\ao - Uncanny Resilience')
                    mq.delay(490)
                end
                --Untamed Rage
                if mq.TLO.Me.AltAbilityReady('Untamed Rage')() and burn_variables.myhp >= 80 and burn_variables.myhp <= 99 and mq.TLO.Me.Buff('Untamed Rage')() == nil then
                    mq.cmd('/alt activate 374')
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atAA\ag]\ao - Untamed Rage')
                    mq.delay(490)
                end
                --Braxi's Howl
                if mq.TLO.Me.AltAbilityReady('Braxi\'s Howl')() and burn_variables.targethp >= 80 and burn_variables.targethp <= 99 then
                    mq.cmd('/alt activate 1013')
                    print('\ar[\aoEasy\ar] \agBER Burn\aw - \ag[\atAA\ag]\ao - Braxi\'s Howl')
                    mq.delay(490)
                end
            end
        end
    end

    -------------------------------------------------
    ------------------ ROG Burn ---------------------
    -------------------------------------------------
    local ROG_BURN = function ()
        if mq.TLO.Me.Class.ShortName() == 'ROG' then
            --Consigned Bite of the Shissar XXI
            if mq.TLO.FindItemCount('Consigned Bite of the Shissar XXI')() >=1 and mq.TLO.Me.Buff('Bite of the Shissar Poison XII')() == nil then
                print('/\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atClicky\ag]\ao - Consigned Bite of the Shissar XXI')
                mq.cmd('/useitem "Consigned Bite of the Shissar XXI"')
            end
            --Breather
            local breather = mq.TLO.Spell('Breather').RankName()
            if mq.TLO.Me.CombatAbilityReady(breather)() and burn_variables.myendurance <= 20 and not mq.TLO.Me.Combat() and mq.TLO.Me.Song('Breather')() == nil and burn_variables.xtarget == 0 and not mq.TLO.Me.Hovering() then
                mq.cmdf('/disc %s', breather)
                print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..breather..'')
                mq.delay(500)
            end
            --Purge Poison
            if mq.TLO.Me.AltAbilityReady('Purge Poison')() and burn_variables.myhp >= 1 and burn_variables.myhp <= 99 and burn_variables.mepoisoned >= 1 and not mq.TLO.Me.Hovering() then
                mq.cmd('/target %s',mq.TLO.Me.CleanName())
                mq.delay(100)
                mq.cmd('/alt activate 107')
                print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atAA\ag]\ao - Purge Poison')
                mq.delay(490)
            end
            --Abilities
            if mq.TLO.Me.Combat() and burn_variables.targethp >= STOP_BURN and burn_variables.targethp <= START_BURN and burn_variables.targetdistance <= 30 and burn_variables.targetdistance >= 0 and not mq.TLO.Me.Hovering() then
                --Backstab
                if mq.TLO.Me.AbilityReady('Backstab')() then
                    mq.cmd('/doability Backstab')
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atAbility\ag]\ao - Backstab')
                    mq.delay(490)
                end
                --Disarm
                if mq.TLO.Me.AbilityReady('Disarm')() then
                    mq.cmd('/doability Disarm')
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atAbility\ag]\ao - Disarm')
                    mq.delay(490)
                end
                --Combat Abilities
                --Composite Weapons
                local composite_weapons = mq.TLO.Spell('Ecliptic Rage').RankName()
                if mq.TLO.Me.CombatAbilityReady(composite_weapons)() and burn_variables.targethp <= 99 and burn_variables.targethp >= 50 and burn_variables.myendurance >= 10 then
                    mq.cmdf('/disc %s', composite_weapons)
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..composite_weapons..'')
                    mq.delay(490)
                end
                --Poisonous Coalition
                local poisonous_coalition = mq.TLO.Spell('Poisonous Coalition').RankName()
                if mq.TLO.Me.CombatAbilityReady(poisonous_coalition)() and burn_variables.targethp >= 80 and burn_variables.targethp <= 99 and burn_variables.myendurance >= 20 then
                    mq.cmdf('/disc %s', poisonous_coalition)
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..poisonous_coalition..'')
                    mq.delay(490)
                end
                --Obfuscated Blade
                local obfuscated_blade = mq.TLO.Spell('Obfuscated Blade').RankName()
                if mq.TLO.Me.CombatAbilityReady(obfuscated_blade)() and mq.TLO.Me.Song('Obfuscated Blade')() == nil then
                    mq.cmdf('/disc %s', obfuscated_blade)
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..obfuscated_blade..'')
                    mq.delay(490)
                end
                --Phantom Assassin
                local phantom_assassin = mq.TLO.Spell('Phantom Assassin').RankName()
                if mq.TLO.Me.CombatAbilityReady(phantom_assassin)() and burn_variables.targethp >= 80 and burn_variables.targethp <= 99 and mq.TLO.Me.Buff('Assassin\'s Premonition')() == nil then
                    mq.cmdf('/disc %s', phantom_assassin)
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..phantom_assassin..'')
                    mq.delay(490)
                end
                --Jugular Rend
                local jugular_rend = mq.TLO.Spell('Jugular Rend').RankName()
                if mq.TLO.Me.CombatAbilityReady(jugular_rend)() and burn_variables.targethp >=50 and burn_variables.targethp <= 99 then
                    mq.cmdf('/disc %s', jugular_rend)
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..jugular_rend..'')
                    mq.delay(490)
                end
                --Foolish Mark
                local foolish_mark = mq.TLO.Spell('Foolish Mark').RankName()
                if mq.TLO.Me.CombatAbilityReady(foolish_mark)() and burn_variables.targetlevel <= 120 and burn_variables.targetlevel >= 100 then
                    mq.cmdf('/disc %s', foolish_mark)
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..foolish_mark..'')
                    mq.delay(490)
                end
                --Baleful Aim Discipline
                local baleful_aim_discipline = mq.TLO.Spell('Baleful Aim Discipline').RankName()
                if mq.TLO.Me.CombatAbilityReady(baleful_aim_discipline)() and mq.TLO.Me.ActiveDisc.ID() == nil then
                    mq.cmdf('/disc %s', baleful_aim_discipline)
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..baleful_aim_discipline..'')
                    mq.delay(490)
                end
                --Exotoxin Discipline
                local exotoxin_discipline = mq.TLO.Spell('Exotoxin Discipline').RankName()
                if mq.TLO.Me.CombatAbilityReady(exotoxin_discipline)() and burn_variables.targethp <= 99 and burn_variables.targethp >= 50 and mq.TLO.Me.ActiveDisc.ID() == nil then
                    mq.cmdf('/disc %s', exotoxin_discipline)
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..exotoxin_discipline..'')
                    mq.delay(490)
                end
                --Ragged Edge Discipline
                local ragged_edge_discipline = mq.TLO.Spell('Ragged Edge Discipline').RankName()
                if mq.TLO.Me.CombatAbilityReady(ragged_edge_discipline)() and burn_variables.targethp >= 40 and burn_variables.targethp <= 99 and mq.TLO.Me.ActiveDisc.ID() == nil then
                    mq.cmdf('/disc %s', ragged_edge_discipline)
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..ragged_edge_discipline..'')
                    mq.delay(490)
                end
                --Agitating Smoke
                local agitating_smoke = mq.TLO.Spell('Agitating Smoke').RankName()
                if mq.TLO.Me.CombatAbilityReady(agitating_smoke)() and burn_variables.myhp <= 50 and burn_variables.myhp >= 1 and burn_variables.xtarget >= 2 and burn_variables.myendurance >= 5 then
                    mq.cmdf('/disc %s', agitating_smoke)
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..agitating_smoke..'')
                    mq.delay(490)
                end
                --Beguile
                local beguile = mq.TLO.Spell('Beguile').RankName()
                if mq.TLO.Me.CombatAbilityReady(beguile)() and burn_variables.myendurance >= 5 then
                    mq.cmdf('/disc %s', beguile)
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..beguile..'')
                    mq.delay(490)
                end
                --Pinpoint Defects
                local pinpoint_defects = mq.TLO.Spell('Pinpoint Defects').RankName()
                if mq.TLO.Me.CombatAbilityReady(pinpoint_defects)() and burn_variables.targethp >= 50 and burn_variables.targethp <= 99 and burn_variables.myendurance >= 10 then
                    mq.cmdf('/disc %s', pinpoint_defects)
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..pinpoint_defects..'')
                    mq.delay(490)
                end
                --Shadowstrike
                local shadowstrike = mq.TLO.Spell('Shadowstrike').RankName()
                if mq.TLO.Me.CombatAbilityReady(shadowstrike)() and burn_variables.targethp >= 60 and burn_variables.targethp <= 99 then
                    mq.cmdf('/disc %s', shadowstrike)
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..shadowstrike..'')
                    mq.delay(490)
                end
                --Netherbian Blade
                local netherbian_blade = mq.TLO.Spell('Netherbian Blade').RankName()
                if mq.TLO.Me.CombatAbilityReady(netherbian_blade)() and burn_variables.targethp >= 60 and burn_variables.targethp <= 99 then
                    mq.cmdf('/disc %s', netherbian_blade)
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..netherbian_blade..'')
                    mq.delay(490)
                end
                --Ambuscade
                local ambuscade = mq.TLO.Spell('Ambuscade').RankName()
                if mq.TLO.Me.CombatAbilityReady(ambuscade)() and burn_variables.targethp >= 60 and burn_variables.targethp <= 99 and burn_variables.targetlevel <= 120 and burn_variables.myendurance >= 10 then
                    mq.cmdf('/disc %s', ambuscade)
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..ambuscade..'')
                    mq.delay(490)
                end
                --Frenzied Stabbing Discipline
                local frenzied_stabbing_discipline = mq.TLO.Spell('Frenzied Stabbing Discipline').RankName()
                if mq.TLO.Me.CombatAbilityReady(frenzied_stabbing_discipline)() and burn_variables.targethp >= 60 and burn_variables.targethp <= 99 and mq.TLO.Me.ActiveDisc.ID() == nil then
                    mq.cmdf('/disc %s', frenzied_stabbing_discipline)
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..frenzied_stabbing_discipline..'')
                    mq.delay(490)
                end
                --Unseeable Discipline
                local unseeable_discipline = mq.TLO.Spell('Unseeable Discipline').RankName()
                if mq.TLO.Me.CombatAbilityReady(unseeable_discipline)() and burn_variables.targethp >= 60 and burn_variables.targethp <= 99 and mq.TLO.Me.ActiveDisc.ID() == nil then
                    mq.cmdf('/disc %s', unseeable_discipline)
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..unseeable_discipline..'')
                    mq.delay(490)
                end
                --Twisted Chance Discipline
                local twisted_chance_discipline = mq.TLO.Spell('Twisted Chance Discipline').RankName()
                if mq.TLO.Me.CombatAbilityReady(twisted_chance_discipline)() and burn_variables.targethp >= 60 and burn_variables.targethp <= 99 and mq.TLO.Me.ActiveDisc.ID() == nil then
                    mq.cmdf('/disc %s', twisted_chance_discipline)
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..twisted_chance_discipline..'')
                    mq.delay(490)
                end
                --Executioner Discipline
                local executioner_discipline = mq.TLO.Spell('Executioner Discipline').RankName()
                if mq.TLO.Me.CombatAbilityReady(executioner_discipline)() and burn_variables.targethp >= 60 and burn_variables.targethp <= 99 and mq.TLO.Me.ActiveDisc.ID() == nil then
                    mq.cmdf('/disc %s', executioner_discipline)
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..executioner_discipline..'')
                    mq.delay(490)
                end
                --Counterattack Discipline
                local counterattack_discipline = mq.TLO.Spell('Counterattack Discipline').RankName()
                if mq.TLO.Me.CombatAbilityReady(counterattack_discipline)() and burn_variables.myhp <= 60 and burn_variables.targethp >= 1 and mq.TLO.Me.ActiveDisc.ID() == nil then
                    mq.cmdf('/disc %s', counterattack_discipline)
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..counterattack_discipline..'')
                    mq.delay(490)
                end
                --Gutsy Escape
                local gutsy_escape = mq.TLO.Spell('Gutsy Escape').RankName()
                if mq.TLO.Me.CombatAbilityReady(gutsy_escape)() and burn_variables.myhp <= 10 and burn_variables.targethp >= 1 then
                    mq.cmdf('/disc %s', gutsy_escape)
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..gutsy_escape..'')
                    mq.delay(490)
                end
                --Lance
                local lance = mq.TLO.Spell('Lance').RankName()
                if mq.TLO.Me.CombatAbilityReady(lance)() and burn_variables.targethp <= 99 and burn_variables.targethp >= 75 and burn_variables.myhp >= 80 and burn_variables.myhp <= 100 and burn_variables.myendurance >= 5 then
                    mq.cmdf('/disc %s', lance)
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..lance..'')
                    mq.delay(490)
                end
                --Blinding Candascence
                local blinding_candascence = mq.TLO.Spell('Blinding Candascence').RankName()
                if mq.TLO.Me.CombatAbilityReady(blinding_candascence)() and burn_variables.targethp <= 99 and burn_variables.targethp >= 75 then
                    mq.cmdf('/disc %s', blinding_candascence)
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atCombat Ability\ag]\ao - '..blinding_candascence..'')
                    mq.delay(490)
                end
                --AA
                --Escape
                if mq.TLO.Me.AltAbilityReady('Escape')() and burn_variables.myhp >= 1 and burn_variables.myhp <= 20 then
                    mq.cmd('/alt activate 102')
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atAA\ag]\ao - Escape')
                    mq.delay(490)
                end
                --Focused Rake's Rampage
                if mq.TLO.Me.AltAbilityReady('Focused Rake\'s Rampage')() and burn_variables.targethp >= 50 and burn_variables.targethp <= 99 then
                    mq.cmd('/alt activate 378')
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atAA\ag]\ao - Focused Rake\'s Rampage')
                    mq.delay(490)
                end
                --Assassin's Premonition
                if mq.TLO.Me.AltAbilityReady('Assassin\'s Premonition')() and burn_variables.targethp >= 50 and burn_variables.targethp <= 60 and burn_variables.myendurance >= 10 then
                    mq.cmd('/alt activate 1134')
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atAA\ag]\ao - Assassin\'s Premonition')
                    mq.delay(490)
                end
                --Ligament Slice
                if mq.TLO.Me.AltAbilityReady('Ligament Slice')() and burn_variables.targethp >= 50 and burn_variables.targethp <= 99 then
                    mq.cmd('/alt activate 672')
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atAA\ag]\ao - Ligament Slice')
                    mq.delay(490)
                end
                --Rogue's Fury
                if mq.TLO.Me.AltAbilityReady('Rogue\'s Fury')() and burn_variables.targethp >= 50 and burn_variables.targethp <= 99 then
                    mq.cmd('/alt activate 3514')
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atAA\ag]\ao - Rogue\'s Fury')
                    mq.delay(490)
                end
                --Shadow's Flanking
                if mq.TLO.Me.AltAbilityReady('Shadow\'s Flanking')() and burn_variables.targethp >= 50 and burn_variables.targethp <= 99 then
                    mq.cmd('/alt activate 1506')
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atAA\ag]\ao - Shadow\'s Flanking')
                    mq.delay(490)
                end
                --Spire of the Rake
                if mq.TLO.Me.AltAbilityReady('Spire of the Rake')() and burn_variables.targethp >= 75 and burn_variables.targethp <= 99 then
                    mq.cmd('/alt activate 1410')
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atAA\ag]\ao - Spire of the Rake')
                    mq.delay(490)
                end
                --Tumble
                if mq.TLO.Me.AltAbilityReady('Tumble')() and burn_variables.myhp >= 1 and burn_variables.myhp <= 50 then
                    mq.cmd('/alt activate 673')
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atAA\ag]\ao - Tumble')
                    mq.delay(490)
                end
                --Twisted Shank
                if mq.TLO.Me.AltAbilityReady('Twisted Shank')() and burn_variables.targethp >= 50 and burn_variables.targethp <= 99 then
                    mq.cmd('/alt activate 670')
                    print('\ar[\aoEasy\ar] \agROG Burn\aw - \ag[\atAA\ag]\ao - Twisted Shank')
                    mq.delay(490)
                end
            end
        end
    end

    -------------------------------------------------
    ------------------ BST Burn ---------------------
    -------------------------------------------------
    local BST_BURN = function ()
        if mq.TLO.Me.Class.ShortName() == 'BST' then
            --Breather
            local breather = mq.TLO.Spell('Breather').RankName()
            if mq.TLO.Me.CombatAbilityReady(breather)() and burn_variables.myendurance <= 20 and not mq.TLO.Me.Combat() and mq.TLO.Me.Song('Breather')() == nil and burn_variables.xtarget == 0 and not mq.TLO.Me.Hovering() then
                mq.cmdf('/disc %s', breather)
                print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atCombat Ability\ag]\ao - '..breather..'')
                mq.delay(490)
            end
            --Paragon of Spirit
            if mq.TLO.Me.AltAbilityReady('Paragon of Spirit')() and burn_variables.mymana <= 80 and burn_variables.mymana >= 1 and mq.TLO.Me.Song('Paragon of Spirit')() == nil and mq.TLO.Me.Buff('Focused Paragon of Spirit')() == nil and not mq.TLO.Me.Hovering() then
                mq.cmd('/alt activate 128')
                print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atAA\ag]\ao - Paragon of Spirit')
                mq.delay(490)
            end
            --Focused Paragon of Spirits
            if mq.TLO.Me.AltAbilityReady('Focused Paragon of Spirits')() and burn_variables.mymana <= 80 and burn_variables.mymana >= 1 and mq.TLO.Me.Song('Paragon of Spirit')() == nil and mq.TLO.Me.Buff('Focused Paragon of Spirit')() == nil and not mq.TLO.Me.Hovering() then
                mq.cmdf('/target id %s', mq.TLO.Me.ID())
                mq.delay(50)
                mq.cmd('/alt activate 3817')
                print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atAA\ag]\ao - Focused Paragon of Spirits')
                mq.delay(490)
            end
            --Abilities
            if mq.TLO.Me.Combat() and burn_variables.targethp >= STOP_BURN and burn_variables.targethp <= START_BURN and burn_variables.targetdistance <= 30 and burn_variables.targetdistance >= 0 and not mq.TLO.Me.Hovering() then
                --Eagle Strike
                if mq.TLO.Me.AbilityReady('Eagle Strike')() then
                    mq.cmd('/doability "Eagle Strike"')
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atAbility\ag]\ao - Eagle Strike')
                    mq.delay(490)
                end
                --Round Kick
                if mq.TLO.Me.AbilityReady('Round Kick')() then
                    mq.cmd('/doability "Round Kick"')
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atAbility\ag]\ao - Round Kick')
                    mq.delay(490)
                end
                --Combat Abilities
                --Kejaan's Vindication
                local kejaans_vindication = mq.TLO.Spell('Kejaan\'s Vindication').RankName()
                if mq.TLO.Me.CombatAbilityReady(kejaans_vindication)() and burn_variables.targethp <= 99 and burn_variables.targethp >= 50 then
                    mq.cmdf('/disc %s', kejaans_vindication)
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atCombat Ability\ag]\ao - '..kejaans_vindication..'')
                    mq.delay(490)
                end
                --Reflexive Riving
                local reflexive_riving = mq.TLO.Spell('Reflexive Riving').RankName()
                if mq.TLO.Me.CombatAbilityReady(reflexive_riving)() and burn_variables.targethp >= 80 and burn_variables.targethp <= 99 then
                    mq.cmdf('/disc %s', reflexive_riving)
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atCombat Ability\ag]\ao - '..reflexive_riving..'')
                    mq.delay(490)
                end
                --Monkey's Spirit Discipline
                local monkeys_spirit_discipline = mq.TLO.Spell('Monkey\'s Spirit Discipline').RankName()
                if mq.TLO.Me.CombatAbilityReady(monkeys_spirit_discipline)() and burn_variables.myhp <= 40 and burn_variables.myhp >= 1 then
                    mq.cmdf('/disc %s', monkeys_spirit_discipline)
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atCombat Ability\ag]\ao - '..monkeys_spirit_discipline..'')
                    mq.delay(490)
                end
                --Clobber
                local clobber = mq.TLO.Spell('Clobber').RankName()
                if mq.TLO.Me.CombatAbilityReady(clobber)() and burn_variables.targethp >= 60 and burn_variables.targethp <= 99 then
                    mq.cmdf('/disc %s', clobber)
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atCombat Ability\ag]\ao - '..clobber..'')
                    mq.delay(490)
                end
                --Bestial Fierceness
                local bestial_fierceness = mq.TLO.Spell('Bestial Fierceness').RankName()
                if mq.TLO.Me.CombatAbilityReady(bestial_fierceness)() and burn_variables.targethp >=50 and burn_variables.targethp <= 99 then
                    mq.cmdf('/disc %s', bestial_fierceness)
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atCombat Ability\ag]\ao - '..bestial_fierceness..'')
                    mq.delay(490)
                end
                --Eruption of Claws
                local eruption_of_claws = mq.TLO.Spell('Eruption of Claws').RankName()
                if mq.TLO.Me.CombatAbilityReady(eruption_of_claws)() and burn_variables.targethp <= 99 and burn_variables.targethp >= 55 then
                    mq.cmdf('/disc %s', eruption_of_claws)
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atCombat Ability\ag]\ao - '..eruption_of_claws..'')
                    mq.delay(490)
                end
                --Resistant Discipline
                local resistant_discipline = mq.TLO.Spell('Resistant Discipline').RankName()
                if mq.TLO.Me.CombatAbilityReady(resistant_discipline)() then
                    mq.cmdf('/disc %s', resistant_discipline)
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atCombat Ability\ag]\ao - '..resistant_discipline..'')
                    mq.delay(490)
                end
                --Savage Rancor
                local savage_rancor = mq.TLO.Spell('Savage Rancor').RankName()
                if mq.TLO.Me.CombatAbilityReady(savage_rancor)() and burn_variables.targethp <= 99 and burn_variables.targethp >= 50 then
                    mq.cmdf('/disc %s', savage_rancor)
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atCombat Ability\ag]\ao - '..savage_rancor..'')
                    mq.delay(490)
                end
                --Protective Spirit Discipline
                local protective_spirit_discipline = mq.TLO.Spell('Protective Spirit Discipline').RankName()
                if mq.TLO.Me.CombatAbilityReady(protective_spirit_discipline)() and burn_variables.myhp <= 40 and burn_variables.myhp >= 1 then
                    mq.cmdf('/disc %s', protective_spirit_discipline)
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atCombat Ability\ag]\ao - '..protective_spirit_discipline..'')
                    mq.delay(490)
                end
                --AA
                --Falsified Death
                if mq.TLO.Me.AltAbilityReady('Falsified Death')() and burn_variables.myhp >= 1 and burn_variables.myhp <= 10 then
                    mq.cmd('/alt activate 421')
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atAA\ag]\ao - Falsified Death')
                    mq.delay(490)
                end
                --Companion's Aegis
                if mq.TLO.Me.AltAbilityReady('Companion\'s Aegis')() and burn_variables.mypethp >= 1 and burn_variables.mypethp <= 50 then
                    mq.cmd('/alt activate 441')
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Aegis')
                    mq.delay(490)
                end
                --Companion's Fortification
                if mq.TLO.Me.AltAbilityReady('Companion\'s Fortification')() and burn_variables.mypethp >= 50 and burn_variables.mypethp <= 100 then
                    mq.cmd('/alt activate 3707')
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Fortification')
                    mq.delay(490)
                end
                --Companion's Fury
                if mq.TLO.Me.AltAbilityReady('Companion\'s Fury')() and burn_variables.targethp >= 50 and burn_variables.targethp <= 99 then
                    mq.cmd('/alt activate 443')
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Fury')
                    mq.delay(490)
                end
                --Mend Companion
                if mq.TLO.Me.AltAbilityReady('Mend Companion')() and burn_variables.mypethp <= 50 and burn_variables.mypethp >= 1 then
                    mq.cmd('/alt activate 58')
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atAA\ag]\ao - Mend Companion')
                    mq.delay(490)
                end
                --Companion's Intervening Divine Aura
                if mq.TLO.Me.AltAbilityReady('Companion\'s Intervening Divine Aura')() and burn_variables.mypethp <= 20 and burn_variables.mypethp >= 1 then
                    mq.cmd('/alt activate 1580')
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Intervening Divine Aura')
                    mq.delay(490)
                end
                --Frenzied Swipes
                if mq.TLO.Me.AltAbilityReady('Frenzied Swipes')() and burn_variables.targethp >= 75 and burn_variables.targethp <= 99 then
                    mq.cmd('/alt activate 1240')
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atAA\ag]\ao - Frenzied Swipes')
                    mq.delay(490)
                end
                --Bloodlust
                if mq.TLO.Me.AltAbilityReady('Bloodlust')() and burn_variables.targethp >= 75 and burn_variables.targethp <= 99 then
                    mq.cmd('/alt activate 241')
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atAA\ag]\ao - Bloodlust')
                    mq.delay(490)
                end
                --Hobble of Spirits
                if mq.TLO.Me.AltAbilityReady('Hobble of Spirits')() and mq.TLO.Me.Pet.Buff('Hobble of Spirits')() == nil then
                    mq.cmd('/alt activate 126')
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atAA\ag]\ao - Hobble of Spirits')
                    mq.delay(490)
                end
                --Sha's Reprisal
                if mq.TLO.Me.AltAbilityReady('Sha\'s Reprisal')() and mq.TLO.Target.Buff('Sha\'s Reprisal')() == nil and burn_variables.targethp >= 1 and burn_variables.targethp <= 98 then
                    mq.cmd('/alt activate 1269')
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atAA\ag]\ao - Sha\'s Reprisal')
                    mq.delay(490)
                end
                --Spire of the Savage Lord
                if mq.TLO.Me.AltAbilityReady('Spire of the Savage Lord')() and burn_variables.targethp <= 99 and burn_variables.targethp >= 70 then
                    mq.cmd('/alt activate 1430')
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atAA\ag]\ao - Spire of the Savage Lord')
                    mq.delay(490)
                end
                --Nature's Salve
                if mq.TLO.Me.AltAbilityReady('Nature\'s Salve')() then
                    mq.cmd('/alt activate 8303')
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atAA\ag]\ao - Nature\'s Salve')
                    mq.delay(490)
                end
                --Chameleon Strike
                if mq.TLO.Me.AltAbilityReady('Chamelion Strike')() and burn_variables.targethp <= 99 and burn_variables.targethp >= 10 then
                    mq.cmd('/alt activate 11080')
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atAA\ag]\ao - Chameleon Strike')
                    mq.delay(490)
                end
                --Roar of Thunder
                if mq.TLO.Me.AltAbilityReady('Roar of Thunder')() and burn_variables.targethp >= 50 and burn_variables.targethp <= 99 then
                    mq.cmd('/alt activate 362')
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atAA\ag]\ao - Roar of Thunder')
                    mq.delay(490)
                end
                --Roaring Strike
                if mq.TLO.Me.AltAbilityReady('Roaring Strike')() and burn_variables.targethp >= 25 and burn_variables.targethp <= 99 then
                    mq.cmd('/alt activate 972')
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atAA\ag]\ao - Roaring Strike')
                    mq.delay(490)
                end
                --Pact of the Wurine
                if mq.TLO.Me.AltAbilityReady('Pact of the Wurine')() and mq.TLO.Me.Buff('Pact of the Wurine')() == nil then
                    mq.cmd('/alt activate 3709')
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atAA\ag]\ao - Pact of the Wurine')
                    mq.delay(490)
                end
                --Protection of the Warder
                if mq.TLO.Me.AltAbilityReady('Protection of the Warder')() and burn_variables.myhp <= 20 and burn_variables.myhp >= 1 then
                    mq.cmd('/alt activate 8302')
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atAA\ag]\ao - Protection of the Warder')
                    mq.delay(490)
                end
                --Ferociousness
                if mq.TLO.Me.AltAbilityReady('Ferociousness')() and burn_variables.targethp <= 99 and burn_variables.targethp >= 50 then
                    mq.cmd('/alt activate 966')
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atAA\ag]\ao - Ferociousness')
                    mq.delay(490)
                end
                --Frenzy of Spirit
                if mq.TLO.Me.AltAbilityReady('Frenzy of Spirit')() and burn_variables.targethp >= 55 and burn_variables.targethp <= 99 then
                    mq.cmd('/alt activate 127')
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atAA\ag]\ao - Frenzy of Spirit')
                    mq.delay(490)
                end
                --Group Bestial Alignment
                if mq.TLO.Me.AltAbilityReady('Group Bestial Alignment')() and burn_variables.targethp >= 75 and burn_variables.targethp <= 99 then
                    mq.cmd('/alt activate 985')
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atAA\ag]\ao - Group Bestial Alignment')
                    mq.delay(490)
                end
                --Companion's Shielding
                if mq.TLO.Me.AltAbilityReady('Companion\'s Shielding')() and burn_variables.mypethp <= 20 and burn_variables.mypethp >= 1 then
                    mq.cmd('/alt activate 444')
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Shielding')
                    mq.delay(490)
                end
                --Attack of the Warders
                if mq.TLO.Me.AltAbilityReady('Attack of the Warders')() and burn_variables.targethp >= 55 and burn_variables.targethp <= 99 then
                    mq.cmd('/alt activate 981')
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atAA\ag]\ao - Attack of the Warders')
                    mq.delay(490)
                end
                --Consumption of Spirit
                if mq.TLO.Me.AltAbilityReady('Consumption of Spirit')() and burn_variables.mymana <= 60 and burn_variables.mymana >= 1 then
                    mq.cmd('/alt activate 1239')
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atAA\ag]\ao - Consumption of Spirit')
                    mq.delay(490)
                end
                --Enduring Frenzy
                if mq.TLO.Me.AltAbilityReady('Enduring Frenzy')() and burn_variables.targethp <= 99 and burn_variables.targethp >= 75 then
                    mq.cmd('/alt activate 2068')
                    print('\ar[\aoEasy\ar] \agBST Burn\aw - \ag[\atAA\ag]\ao - Enduring Frenzy')
                    mq.delay(490)
                end
            end
        end
    end

    -------------------------------------------------
    ------------------ MAG Burn ---------------------
    -------------------------------------------------
    local mage_spells = true
    if mq.TLO.NearestSpawn('pc')() == nil then
        mage_spells = false
    end
    local MAG_LOAD_SPELLS = function ()
        print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atLoading\ag]\ao - Default Spells')
        mq.cmdf('/memspellslot 1 %s',mag_saved_settings.spell1)
        mq.delay('3s')
        mq.cmdf('/memspellslot 2 %s',mag_saved_settings.spell2)
        mq.delay('3s')
        mq.cmdf('/memspellslot 3 %s',mag_saved_settings.spell3)
        mq.delay('3s')
        mq.cmdf('/memspellslot 4 %s',mag_saved_settings.spell4)
        mq.delay('3s')
        mq.cmdf('/memspellslot 5 %s',mag_saved_settings.spell5)
        mq.delay('3s')
        mq.cmdf('/memspellslot 6 %s',mag_saved_settings.spell6)
        mq.delay('3s')
        mq.cmdf('/memspellslot 7 %s',mag_saved_settings.spell7)
        mq.delay('3s')
        mq.cmdf('/memspellslot 8 %s',mag_saved_settings.spell8)
        mq.delay('3s')
        mq.cmdf('/memspellslot 9 %s',mag_saved_settings.spell9)
        mq.delay('3s')
        mq.cmdf('/memspellslot 10 %s',mag_saved_settings.spell10)
        mq.delay('3s')
        mq.cmdf('/memspellslot 11 %s',mag_saved_settings.spell11)
        mq.delay('3s')
        mq.cmdf('/memspellslot 12 %s',mag_saved_settings.spell12)
        mq.delay('3s')
        mq.cmdf('/memspellslot 13 %s',mag_saved_settings.spell13)
        mq.delay('3s')
        print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atLoaded\ag]\ao - Spells and Ready for Battle!')
        mage_spells = false
    end
    if mq.TLO.Me.Class.ShortName() == 'MAG' and mage_spells == true then
        MAG_LOAD_SPELLS()
        mage_spells = false
    end
    local MAG_BURN = function ()
        local mag_burn_variables = {
            targethp = mq.TLO.Target.PctHPs() or 0,
            targetdistance = mq.TLO.Target.Distance() or 0,
            myhp = mq.TLO.Me.PctHPs() or 0,
            maintank = mq.TLO.Group.MainTank.CleanName(),
            myendurance = mq.TLO.Me.PctEndurance() or 0,
            xtarget = mq.TLO.Me.XTarget(),
            mymana = mq.TLO.Me.PctMana() or 0,
            maintankdistance = mq.TLO.Group.MainTank.Distance() or 0,
            targetlevel = mq.TLO.Target.Level() or 0,
            mepoisoned = mq.TLO.Me.CountersPoison() or 0,
            mypethp = mq.TLO.Me.Pet.PctHPs() or 0,
            mypetdistance = mq.TLO.Me.Pet.Distance() or 0,
            mypet = mq.TLO.Me.Pet.CleanName(),
            spell_rank = '',
            spell_ready = ''
            }
        if mag_burn_variables.mymana <= 95 and not mq.TLO.Me.Moving() and not mq.TLO.Me.Casting() and not mq.TLO.Me.Combat() and mq.TLO.Me.XTarget(1).ID() < 1 and not mq.TLO.Me.Sitting() and not mq.TLO.Target.Aggressive() then mq.cmd('/sit') end
            if mq.TLO.Me.Pet() == 'NO PET' and mq.TLO.NearestSpawn('pc')() ~= nil then
                if Debug then print('NO PET MAKING ONE DEBUG') end
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \arPET IS DEAD')
                printf('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atSpell\ag]\ao %s',mag_saved_settings.pet_spell)
                mq.cmdf('/memspellslot %s %s',mag_saved_settings.swap_gem_id,mag_saved_settings.pet_spell)
                mq.delay('5s')
                mag_burn_variables.spell_rank = mq.TLO.Spell(mag_saved_settings.pet_spell).RankName()
                print('Rank Spell: ',mq.TLO.Spell(mag_saved_settings.pet_spell).RankName())
                mag_burn_variables.spell_ready = mq.TLO.Me.SpellReady(mag_burn_variables.spell_rank)()
                print('Spell Ready: ',mq.TLO.Me.SpellReady(mag_burn_variables.spell_rank)())
                while not mag_burn_variables.spell_ready do return end
                mq.cmdf('/cast %s',mag_saved_settings.pet_spell)
                while mq.TLO.Me.Casting() do mq.delay('1s') end
                mag_burn_variables.mypet = mq.TLO.Me.Pet.CleanName()
                if mag_saved_settings.use_pet_toys and mq.TLO.Me.FreeInventory() >= 9 then
                    if Debug then print('WE HAVE ROOM FOR TOYS') end
                    if mq.TLO.FindItemCount(''..mag_saved_settings.pet_toy1..'')() < 1 and mq.TLO.FindItemCount(''..mag_saved_settings.pet_toy2..'')() < 1 and mq.TLO.FindItemCount(''..mag_saved_settings.pet_toy3..'')() < 1 and mq.TLO.FindItemCount(''..mag_saved_settings.pet_toy4..'')() < 1 and mq.TLO.Me.FreeInventory() >= 8 then
                        mq.cmdf('/memspellslot %s %s',mag_saved_settings.swap_gem_id,mag_saved_settings.pet_toys)
                        mq.delay('5s')
                        mq.cmdf('/target %s',mq.TLO.Me.CleanName())
                        print('\ar[\aoEasy\ar] \agMAG Burn\aw - \agGIVING PET TOYS')
                        mq.cmdf('/cast %s',mag_saved_settings.pet_toys)
                        while mq.TLO.Me.Casting() do mq.delay('1s') end
                        mq.cmd('/itemnotify pack10 leftmouseup')
                        mq.delay('2s')
                        mq.cmd('/itemnotify pack10 rightmouseup')
                        mq.delay('2s')
                        mq.cmd('/itemnotify pack10 leftmouseup')
                        mq.delay('2s')
                        for i = 1, mq.TLO.Me.NumBagSlots() do
                            if mq.TLO.Cursor.ID() then mq.cmdf('/ctrl /itemnotify pack%s leftmouseup',i) end
                        end
                        if Debug then print('EXIT MAKE TOYS') end
                        if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                    end
                end
                    if mq.TLO.Me.FreeInventory() <= 7 then
                        print('\arYOU ARE OUT OF INVENTORY FOR PET WEAPONS')
                    end
                    if mq.TLO.FindItemCount(''..mag_saved_settings.pet_toy1..'')() > 0 or mq.TLO.FindItemCount(''..mag_saved_settings.pet_toy2..'')() > 0 then
                        if Debug then print('GIVE TOYS PETTOY1 AND PETTOY2') end
                        mq.cmdf('/target %s',mq.TLO.Me.Pet.CleanName())
                        mq.delay('1s')
                        mq.cmdf('/itemnotify "%s" leftmouseup',mag_saved_settings.pet_toy1)
                        mq.delay(500)
                        mq.cmd('/nomodkey /click left target')
                        mq.delay(500)
                        mq.cmdf('/itemnotify "%s" leftmouseup',mag_saved_settings.pet_toy2)
                        mq.delay(500)
                        mq.cmd('/nomodkey /click left target')
                        mq.delay(500)
                        mq.cmd('/notify TradeWnd TRDW_Trade_Button leftmouseup')
                        mq.delay('1s')
                        if mq.TLO.FindItemCount('Pouch of Quellious')() >= 1 then
                            local pouch = 'Pouch of Quellious'
                            mq.cmdf('/itemnotify "%s" leftmouseup',pouch)
                            if mq.TLO.Cursor.ID() == 57261 then
                                mq.cmd.destroy()
                            end
                        end
                        while mq.TLO.FindItemCount(mag_saved_settings.pet_toy_destroy1)() >= 1 do
                            mq.cmdf('/itemnotify "%s" leftmouseup',mag_saved_settings.pet_toy_destroy1)
                            mq.delay(500)
                            if mq.TLO.Cursor() == mag_saved_settings.pet_toy_destroy1 then
                                mq.cmd.destroy()
                            else
                                mq.cmd.autoinventory()
                            end
                        end
                        while mq.TLO.FindItemCount(mag_saved_settings.pet_toy_destroy2)() >= 1 do
                            mq.cmdf('/itemnotify "%s" leftmouseup',mag_saved_settings.pet_toy_destroy2)
                            mq.delay(500)
                            if mq.TLO.Cursor() == mag_saved_settings.pet_toy_destroy2 then
                                mq.cmd.destroy()
                            else
                                mq.cmd.autoinventory()
                            end
                        end
                        printf('\ar[\aoEasy\ar] \agMAG Burn\aw - \agPet has \ap%s \agand \ap%s \agfor weapons',mag_saved_settings.pet_toy1,mag_saved_settings.pet_toy2)
                    else
                        if Debug then print('OPTIONAL PET TOYS PETTOY3 AND PETTOY4') end
                        if mq.TLO.FindItemCount(''..mag_saved_settings.pet_toy3..'')() > 0 or mq.TLO.FindItemCount(''..mag_saved_settings.pet_toy4..'')() > 0 then
                            mq.cmdf('/target %s',mq.TLO.Me.Pet.CleanName())
                            mq.delay('1s')
                            mq.cmdf('/itemnotify "%s" leftmouseup',mag_saved_settings.pet_toy3)
                            mq.delay(500)
                            mq.cmd('/nomodkey /click left target')
                            mq.delay(500)
                            mq.cmdf('/itemnotify "%s" leftmouseup',mag_saved_settings.pet_toy4)
                            mq.delay(500)
                            mq.cmd('/nomodkey /click left target')
                            mq.delay(500)
                            mq.cmd('/notify TradeWnd TRDW_Trade_Button leftmouseup')
                            mq.delay('1s')
                            if Debug then print('EXIT PET TOYS PETTOY3 AND PETTOY4') end
                            if mq.TLO.FindItemCount('Pouch of Quellious')() >= 1 then
                                local pouch = 'Pouch of Quellious'
                                mq.cmdf('/itemnotify "%s" leftmouseup',pouch)
                                if mq.TLO.Cursor.ID() == 57261 then
                                    mq.cmd.destroy()
                                end
                            end
                            if Debug then print('DETROY PETTOYDESTROY1') end
                            while mq.TLO.FindItemCount(mag_saved_settings.pet_toy_destroy1)() >= 1 do
                                mq.cmdf('/itemnotify "%s" leftmouseup',mag_saved_settings.pet_toy_destroy1)
                                mq.delay(500)
                                if mq.TLO.Cursor() == mag_saved_settings.pet_toy_destroy1 then
                                    mq.cmd.destroy()
                                else
                                    mq.cmd.autoinventory()
                                end
                            end
                            if Debug then print('DETROY PETTOYDESTROY2') end
                            while mq.TLO.FindItemCount(mag_saved_settings.pet_toy_destroy2)() >= 1 do
                                mq.cmdf('/itemnotify "%s" leftmouseup',mag_saved_settings.pet_toy_destroy2)
                                mq.delay(500)
                                if mq.TLO.Cursor() == mag_saved_settings.pet_toy_destroy2 then
                                    mq.cmd.destroy()
                                else
                                    mq.cmd.autoinventory()
                                end
                            end
                            printf('\ar[\aoEasy\ar] \agMAG Burn\aw - \agPet has \ap%s \agand \ap%s \agfor weapons',mag_saved_settings.pet_toy3,mag_saved_settings.pet_toy4)
                        end
                    end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                end
            --Pet Buffs
            if mag_burn_variables.mypet ~= nil then
                if mq.TLO.Pet.Buff(''..mag_saved_settings.pet_buff5..'')() == nil and mq.TLO.Me.Aura(''..mag_saved_settings.pet_buff5..'')() == nil and mq.TLO.Me.Pet.CleanName() ~= nil and not mq.TLO.Me.Combat() then
                    if Debug then print('BUFFING PET SPELL5') end
                    mq.cmdf('/memspellslot %s %s',mag_saved_settings.swap_gem_id,mag_saved_settings.pet_buff5)
                    mq.delay('5s')
                    mag_burn_variables.spell_rank = mq.TLO.Spell(mag_saved_settings.pet_buff5).RankName()
                    print('Rank Spell: ',mq.TLO.Spell(mag_saved_settings.pet_buff5).RankName())
                    mag_burn_variables.spell_ready = mq.TLO.Me.SpellReady(mag_burn_variables.spell_rank)()
                    print('Spell Ready: ',mq.TLO.Me.SpellReady(mag_burn_variables.spell_rank)())
                    while not mag_burn_variables.spell_ready do return end
                    mq.cmdf('/target %s',mag_burn_variables.mypet)
                    mq.delay(500)
                    printf('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atSpell\ag]\ao %s',mag_saved_settings.pet_buff5)
                    mq.cmdf('/cast %s',mag_saved_settings.pet_buff5)
                    while mq.TLO.Me.Casting() do mq.delay('1s') end
                    if Debug then print('EXIT BUFFING PET SPELL5') end
                    if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                    mq.delay(500)
                end
                if mq.TLO.Pet.Buff(''..mag_saved_settings.pet_buff1..'')() == nil and mq.TLO.Me.Pet.CleanName() ~= nil and mq.TLO.Pet.Buff('Torrent of Melancholy Recourse')() == nil then
                    if Debug then print('BUFFING PET SPELL1') end
                    mq.cmdf('/memspellslot %s %s',mag_saved_settings.swap_gem_id,mag_saved_settings.pet_buff1)
                    mq.delay('6s')
                    mag_burn_variables.spell_rank = mq.TLO.Spell(mag_saved_settings.pet_buff1).RankName()
                    print('Rank Spell: ',mq.TLO.Spell(mag_saved_settings.pet_buff1).RankName())
                    mag_burn_variables.spell_ready = mq.TLO.Me.SpellReady(mag_burn_variables.spell_rank)()
                    print('Spell Ready: ',mq.TLO.Me.SpellReady(mag_burn_variables.spell_rank)())
                    while not mag_burn_variables.spell_ready do return end
                    mq.cmdf('/target %s',mag_burn_variables.mypet)
                    mq.delay(500)
                    printf('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atSpell\ag]\ao %s',mag_saved_settings.pet_buff1)
                    mq.cmdf('/cast %s',mag_saved_settings.pet_buff1)
                    while mq.TLO.Me.Casting() do mq.delay('1s') end
                    if Debug then print('EXIT BUFFING PET SPELL1') end
                    if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                    mq.delay(500)
                end
                if mq.TLO.Pet.Buff(''..mag_saved_settings.pet_buff2..'')() == nil and mq.TLO.Me.Pet.CleanName() ~= nil then
                    if Debug then print('BUFFING PET SPELL2') end
                    mq.cmdf('/memspellslot %s %s',mag_saved_settings.swap_gem_id,mag_saved_settings.pet_buff2)
                    mq.delay('5s')
                    mag_burn_variables.spell_rank = mq.TLO.Spell(mag_saved_settings.pet_buff2).RankName()
                    print('Spell Rank: ',mq.TLO.Spell(mag_saved_settings.pet_buff2).RankName())
                    mag_burn_variables.spell_ready = mq.TLO.Me.SpellReady(mag_burn_variables.spell_rank)()
                    print('Spell Ready: ',mq.TLO.Me.SpellReady(mag_burn_variables.spell_rank)())
                    while not mag_burn_variables.spell_ready do return end
                    mq.cmdf('/target %s',mag_burn_variables.mypet)
                    mq.delay(500)
                    printf('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atSpell\ag]\ao %s',mag_saved_settings.pet_buff2)
                    mq.cmdf('/cast %s',mag_saved_settings.pet_buff2)
                    while mq.TLO.Me.Casting() do mq.delay('1s') end
                    if Debug then print('EXIT BUFFING PET SPELL2') end
                    if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                    mq.delay(500)
                end
                if mq.TLO.Pet.Buff(''..mag_saved_settings.pet_buff4..'')() == nil and mq.TLO.Pet.Buff('Circle of Emberweave Coat')() == nil and mq.TLO.Me.Pet.CleanName() ~= nil then
                    if mq.TLO.Group.Members() == 0 then
                        if Debug then print('BUFFING PET SPELL4 SINGLE') end
                    mag_burn_variables.spell_rank = mq.TLO.Spell(mag_saved_settings.pet_buff4).RankName()
                    print('Spell Rank: ',mq.TLO.Spell(mag_saved_settings.pet_buff4).RankName())
                    mag_burn_variables.spell_ready = mq.TLO.Me.SpellReady(mag_burn_variables.spell_rank)()
                    print('Spell Ready: ',mq.TLO.Me.SpellReady(mag_burn_variables.spell_rank)())
                    if not mq.TLO.Me.SpellReady(mag_burn_variables.spell_rank)() then
                        mq.cmdf('/memspellslot %s %s',mag_saved_settings.swap_gem_id,mag_saved_settings.pet_buff4)
                        mq.delay('4s')
                    end
                    while not mag_burn_variables.spell_ready do return end
                    mq.cmdf('/target %s',mag_burn_variables.mypet)
                    mq.delay(500)
                    printf('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atSpell\ag]\ao %s',mag_saved_settings.pet_buff4)
                    mq.cmdf('/cast %s',mag_saved_settings.pet_buff4)
                    while mq.TLO.Me.Casting() do mq.delay('1s') end
                    if Debug then print('EXIT BUFFING PET SPELL4 SINGLE') end
                    else
                        if Debug then print('BUFFIN PET SPELL4 AOE') end
                        local aoe = "Circle of Emberweave Coat"
                        if mq.TLO.Pet.Buff('Emberweave Coat')() == nil and mq.TLO.Pet.Buff('Circle of Emberweave Coat')() == nil then
                            mag_burn_variables.spell_rank = mq.TLO.Spell(aoe).RankName()
                            print('Spell Rank: ',mq.TLO.Spell(aoe).RankName())
                            mag_burn_variables.spell_ready = mq.TLO.Me.SpellReady(mag_burn_variables.spell_rank)()
                            print('Spell Ready: ',mq.TLO.Me.SpellReady(mag_burn_variables.spell_rank)())
                            if not mq.TLO.Me.SpellReady(mag_burn_variables.spell_rank)() then
                                mq.cmdf('/memspellslot %s %s',mag_saved_settings.swap_gem_id,mag_burn_variables.spell_rank)
                                mq.delay('2s')
                            end
                            while not mag_burn_variables.spell_ready do return end
                            mq.cmdf('/target %s',mag_burn_variables.mypet)
                            mq.delay(500)
                            printf('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atSpell\ag]\ao %s',mag_burn_variables.spell_rank)
                            mq.cmdf('/cast %s',mag_burn_variables.spell_rank)
                        while mq.TLO.Me.Casting() do mq.delay('1s') end
                        if Debug then print('EXIT BUFFING PET SPELL4 AOE') end
                        if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                        end
                    end
                end
                if mq.TLO.Pet.Buff(''..mag_saved_settings.pet_buff3..'')() == nil and mq.TLO.Me.Pet.CleanName() ~= nil and not mq.TLO.Me.Combat() and mag_burn_variables.pethp == 100 then
                    if Debug then print('BUFFING PET SPELL3') end
                    mq.cmdf('/memspellslot %s %s',mag_saved_settings.swap_gem_id,mag_saved_settings.pet_buff3)
                    mq.delay('2s')
                    mag_burn_variables.spell_rank = mq.TLO.Spell(mag_saved_settings.pet_buff3).RankName()
                    print('Spell Rank: ',mq.TLO.Spell(mag_saved_settings.pet_buff3).RankName())
                    mag_burn_variables.spell_ready = mq.TLO.Me.SpellReady(mag_burn_variables.spell_rank)()
                    print('Spell Ready: ',mq.TLO.Me.SpellReady(mag_burn_variables.spell_rank)())
                    while not mag_burn_variables.spell_ready do return end
                    mq.cmdf('/target %s',mag_burn_variables.mypet)
                    mq.delay(500)
                    printf('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atSpell\ag]\ao %s',mag_saved_settings.pet_buff3)
                    mq.cmdf('/cast %s',mag_saved_settings.pet_buff3)
                    while mq.TLO.Me.Casting() do mq.delay('1s') end
                    if Debug then print('EXIT BUFFING PET SPELL3') end
                    if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                    mq.delay(500)
                end
            end
            --Use Mount
            local ammo_buff = mq.TLO.Me.Inventory('Ammo').Spell()
            if mq.TLO.Zone.Outdoor() and mq.TLO.Me.Inventory('Ammo').Type() == 'Mount' and mq.TLO.Me.Buff(ammo_buff)() == nil then
                mq.cmdf('/useitem %s',mq.TLO.Me.Inventory('Ammo')())
                mq.delay(500)
                while mq.TLO.Me.Casting() do mq.delay('1s') end
            end
            --Summon Items
            --Sickle of Umbral Modulation
            if mq.TLO.FindItemCount('Sickle of Umbral Modulation')() < 1 and not mq.TLO.Me.Hovering() and not mq.TLO.Me.Combat() and mq.TLO.Me.XTarget(1).ID() == 0 then
                local sickle_of_umbral_modulation = 'Sickle of Umbral Modulation'
                mq.cmdf('/memspellslot %s %s',mag_saved_settings.swap_gem_id,sickle_of_umbral_modulation)
                mq.delay('5s')
                mq.cmdf('/target %s',mq.TLO.Me.CleanName())
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atSpell\ag]\ao - Sickle of Umbral Modulation')
                mq.cmdf('/cast %s',sickle_of_umbral_modulation)
                while mq.TLO.Me.Casting() do mq.delay('1s') end
                if mq.TLO.Cursor.ID() then
                    mq.cmd.autoinventory()
                end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Mass Dark Transvergence
            if mq.TLO.FindItemCount('Wand of Pelagic Transvergence')() < 1 and not mq.TLO.Me.Hovering() and not mq.TLO.Me.Combat() and mq.TLO.Me.XTarget(1).ID() == 0 then
                local mass_dark_transvergence = 'Mass Dark Transvergence'
                mq.cmdf('/memspellslot %s %s',mag_saved_settings.swap_gem_id,mass_dark_transvergence)
                mq.delay('5s')
                mq.cmdf('/target %s',mq.TLO.Me.CleanName())
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atSpell\ag]\ao - Mass Dark Transvergence')
                mq.cmdf('/cast %s',mass_dark_transvergence)
                while mq.TLO.Me.Casting() do mq.delay('1s') end
                if mq.TLO.Cursor.ID() then
                    mq.cmd.autoinventory()
                end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Summon Forbearing Minion
            if mq.TLO.FindItemCount('Summoned: Exigent Minion XXIV II')() < 1 and not mq.TLO.Me.Hovering() and not mq.TLO.Me.Combat() and mq.TLO.Me.XTarget(1).ID() == 0 then
                local summon_forbearing_minion = 'Summon Forbearing Minion'
                mq.cmdf('/memspellslot %s %s',mag_saved_settings.swap_gem_id,summon_forbearing_minion)
                mq.delay('5s')
                mq.cmdf('/target %s',mq.TLO.Me.CleanName())
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atSpell\ag]\ao - Summon Forbearing Minion')
                mq.cmdf('/cast %s',summon_forbearing_minion)
                while mq.TLO.Me.Casting() do mq.delay('1s') end
                if mq.TLO.Cursor.ID() then
                    mq.cmd.autoinventory()
                end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Summon Forebearing Servant
            if mq.TLO.FindItemCount('Summoned: Exigent Servant XXIV II')() < 1 and not mq.TLO.Me.Hovering() and not mq.TLO.Me.Combat() and mq.TLO.Me.XTarget(1).ID() == 0 then
                local summon_forbearing_servant = 'Summon Forbearing Servant'
                mq.cmdf('/memspellslot %s %s',mag_saved_settings.swap_gem_id,summon_forbearing_servant)
                mq.delay('5s')
                mq.cmdf('/target %s',mq.TLO.Me.CleanName())
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atSpell\ag]\ao - Summon Forbearing Servant')
                mq.cmdf('/cast %s',summon_forbearing_servant)
                while mq.TLO.Me.Casting() do mq.delay('1s') end
                if mq.TLO.Cursor.ID() then
                    mq.cmd.autoinventory()
                end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Summon Molten Komatiite
            if mq.TLO.FindItemCount('Molten Komatiite Orb')() < 1 and not mq.TLO.Me.Hovering() and not mq.TLO.Me.Combat() and mq.TLO.Me.XTarget(1).ID() == 0 then
                local summon_molten_komatiite = 'Summon Molten Komatiite'
                mq.cmdf('/memspellslot %s %s',mag_saved_settings.swap_gem_id,summon_molten_komatiite)
                mq.delay('5s')
                mq.cmdf('/target %s',mq.TLO.Me.CleanName())
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atSpell\ag]\ao - Summon Molten Komatiite')
                mq.cmdf('/cast %s',summon_molten_komatiite)
                while mq.TLO.Me.Casting() do mq.delay('1s') end
                if mq.TLO.Cursor.ID() then
                    mq.cmd.autoinventory()
                end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Summoned Items
            if mq.TLO.FindItemCount('Sickle of Umbral Modulation')() > 0 and mq.TLO.FindItem("Sicle of Umbral Modulation").TimerReady() == 0 and mag_burn_variables.mymana <= 80 and mag_burn_variables.mymana >= 1 and not mq.TLO.Me.Hovering() then
                print('\ar[\aoEasy\ar] \agMage Using:\ap Sickle of Umbral Modulation.')
                mq.cmdf("/useitem %s", 'Sicle of Umbral Modulation')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            if mq.TLO.FindItemCount('Wand of Pelagic Transvergence')() > 0 and mq.TLO.FindItem("Wand of Pelagic Transvergence").TimerReady() == 0 and mag_burn_variables.mymana <= 90 and mag_burn_variables.mymana >= 1 and not mq.TLO.Me.Hovering() then
                print('\ar[\aoEasy\ar] \agMage Using:\ap Wand of Pelagic Transvergence.')
                mq.cmdf("/useitem %s", 'Wand of Pelagic Transvergence')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Summoned: Kotahl's Tonic of Healing
            if mq.TLO.FindItemCount('Summoned: Kotahl\'s Tonic of Healing')() > 0 and mq.TLO.FindItem("Summoned: Kotahl's Tonic of Healing").TimerReady() == 0 and mag_burn_variables.myhp <= 90 and mag_burn_variables.myhp >= 1 and mq.TLO.Me.Song('Renewal')() == nil and not mq.TLO.Me.Hovering() then
                print('\ar[\aoEasy\ar] \agMage Using:\ap Summoned: Kotahl\'s Tonic of Healing.')
                mq.cmdf("/useitem %s", 'Summoned: Kotahl\'s Tonic of Healing')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Summoned: Kotahl's Tonic of Refreshment
            if mq.TLO.FindItemCount('Summoned: Kotahl\'s Tonic of Refreshment')() > 0 and mq.TLO.FindItem("Summoned: Kotahl's Tonic of Refreshment").TimerReady() == 0 and mag_burn_variables.myendurance <= 90 and mag_burn_variables.myendurance >= 1 and not mq.TLO.Me.Hovering() then
                print('\ar[\aoEasy\ar] \agMage Using:\ap Summoned: Kotahl\'s Tonic of Refreshment.')
                mq.cmdf("/useitem %s", 'Summoned: Kotahl\'s Tonic of Refreshment')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Summoned: Kotahl's Tonic of Clarity
            if mq.TLO.FindItemCount('Summoned: Kotahl\'s Tonic of Clarity')() > 0 and mq.TLO.FindItem("Summoned: Kotahl's Tonic of Clarity").TimerReady() == 0 and mag_burn_variables.mymana <= 90 and mag_burn_variables.mymana >= 1 and not mq.TLO.Me.Hovering() and mq.TLO.Me.Song('Paragon of Spirit')() == nil then
                print('\ar[\aoEasy\ar] \agMage Using:\ap Summoned: Kotahl\'s Tonic of Clarity.')
                mq.cmdf("/useitem %s", 'Summoned: Kotahl\'s Tonic of Clarity')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Exalted Tonic of Healing
            if mq.TLO.FindItemCount('Exalted Tonic of Healing')() > 0 and mq.TLO.FindItem("Exalted Tonic of Healing").TimerReady() == 0 and mag_burn_variables.myhp <= 90 and mag_burn_variables.myhp >= 1 and mq.TLO.Me.Song('Renewal')() == nil and not mq.TLO.Me.Hovering() then
                print('\ar[\aoEasy\ar] \agMage Using:\ap Exalted Tonic of Healing.')
                mq.cmdf("/useitem %s", 'Exalted Tonic of Healing')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Delete Ether-Fused Shard
            if mq.TLO.FindItemCount('Ether-Fused Shard')() > 0 and mq.TLO.FindItem('Ether-Fused Shard').Charges() < 1 and not mq.TLO.Me.Hovering() then
                mq.cmd('/ctrl /itemnotify "Ether-Fused Shard" leftmouseup')
                mq.delay('1s')
                if mq.TLO.Cursor.ID() == 85487 then
                    mq.cmd.destroy()
                    print('\ar[\aoEasy\ar] \arMage Destroyed:\ay (Empty) \apEther-Fused Shard.')
                end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Delete Summoned: Darkshine Staff
            if mq.TLO.FindItemCount('Summoned: Darkshine Staff')() > 0 and mq.TLO.FindItem('Summoned: Darkshine Staff').Charges() < 1 and not mq.TLO.Me.Hovering() then
                mq.cmd('/ctrl /itemnotify "Summoned: Darkshine Staff" leftmouseup')
                mq.delay('1s')
                if mq.TLO.Cursor.ID() == 109889 then
                    mq.cmd.destroy()
                    print('\ar[\aoEasy\ar] \arMage Destroyed:\ay (Empty) \apSummoned: Darkshine Staff.')
                end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Summoned: Sahdi's Emblem of the Enchanced Minion
            if mq.TLO.FindItemCount('Summoned: Sahdi\'s Emblem of the Enhanced Minion')() >=1 and mq.TLO.Me.Pet.Buff('Enhanced Minion')() == nil and mq.TLO.Me.Pet.CleanName() ~= nil then
                print('/\ar[\aoEasy\ar] \agMag Burn\aw - \ag[\atClicky\ag]\ao - Summoned: Sahdi\'s Emblem of the Enhanced Minion')
                mq.cmdf('/target %s', mq.TLO.Me.Pet.CleanName())
                mq.cmd('/useitem "Summoned: Sahdi\'s Emblem of the Enhanced Minion"')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Imprint of the Enhanced Minion
            if mq.TLO.FindItemCount('Imprint of the Enhanced Minion')() >=1 and mq.TLO.Me.Pet.Buff('Enhanced Minion')() == nil and mq.TLO.Me.Pet.CleanName() ~= nil then
                print('/\ar[\aoEasy\ar] \agMag Burn\aw - \ag[\atClicky\ag]\ao - Imprint of the Enhanced Minion')
                mq.cmdf('/target %s', mq.TLO.Me.Pet.CleanName())
                mq.cmd('/useitem "Imprint of the Enhanced Minion"')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Summon Modulation Shard
            if mq.TLO.Me.AltAbilityReady('Summon Modulation Shard')() and mq.TLO.FindItemCount('Dazzling Modulation Shard')() == 0 then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Summon Modulation Shard')
                mq.cmd('/alt activate 596')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
        if mq.TLO.Me.XTarget(1).ID() ~= 0 and mag_burn_variables.targethp >= 1 and mag_burn_variables.targethp <= 99 and mag_burn_variables.targetdistance <= 100 and mag_burn_variables.targetdistance >= 0 and mq.TLO.Target.Aggressive() and not mq.TLO.Me.Hovering() then
            --BURNING
            --Molten Komatiite Orb
            if mq.TLO.FindItemCount('Molten Komatiite Orb')() > 0 and mq.TLO.FindItem("Molten Komatiite Orb").TimerReady() == 0 and mq.TLO.Target.Aggressive() then
                mq.cmdf("/useitem %s", 'Molten Komatiite Orb')
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atItem\ag]\ao - Molten Komatiite Orb')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Summoned: Exigent Servant XXIV II
            if mq.TLO.FindItemCount('Summoned: Exigent Servant XXIV II')() > 0 and mq.TLO.FindItem("Summoned: Exigent Servant XXIV II").TimerReady() == 0 and mq.TLO.Target.Aggressive() then
                mq.cmdf("/useitem %s", 'Summoned: Exigent Servant XXIV II')
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atItem\ag]\ao - Summoned: Exigent Servant XXIV II')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Summoned: Exigent Minion XXIV II
            if mq.TLO.FindItemCount('Summoned: Exigent Minion XXIV II')() > 0 and mq.TLO.FindItem("Summoned: Exigent Minion XXIV II").TimerReady() == 0 and mq.TLO.Target.Aggressive() then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atItem\ag]\ao - Summoned: Exigent Minion XXIV II')
                mq.cmdf("/useitem %s", 'Summoned: Exigent Minion XXIV II')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            
            --Ether-Fused shard
            if mq.TLO.FindItemCount('Ether-Fused Shard')() > 0 and mq.TLO.FindItem("Ether-Fused Shard").TimerReady() == 0 and mag_burn_variables.targethp <= 98 and mag_burn_variables.targethp >= 1 and mq.TLO.Target.Aggressive() then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atItem\ag]\ao - Ether-Fused Shard')
                mq.cmdf("/useitem %s", 'Ether-Fused Shard')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Summoned: Darkshine Staff
            if mq.TLO.FindItemCount('Summoned: Darkshine Staff')() > 0 and mq.TLO.FindItem("Summoned: Darkshine Staff").TimerReady() == 0 and mag_burn_variables.targethp <= 98 and mag_burn_variables.targethp >= 1 and not mq.TLO.Me.Hovering() and mq.TLO.Target.Aggressive() then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atItem\ag]\ao - Summoned: Darkshine Staff.')
                mq.cmdf("/useitem %s", 'Summoned: Darkshine Staff')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Summoned: Voidfrost Paradox
            if mq.TLO.FindItemCount('Summoned: Voidfrost Paradox')() > 0 and mq.TLO.FindItem("Summoned: Voidfrost Paradox").TimerReady() == 0 and mag_burn_variables.targethp <= 98 and mag_burn_variables.targethp >= 1 and not mq.TLO.Me.Hovering() and mq.TLO.Target.Aggressive() then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atItem\ag]\ao - Summoned: Voidfrost Paradox.')
                mq.cmdf("/useitem %s", 'Summoned: Voidfrost Paradox')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --AA
            --Arcane Whisper
            if mq.TLO.Me.AltAbilityReady('Arcane Whisper')() then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Arcane Whisper')
                mq.cmdf('/target %s',mq.TLO.Me.CleanName())
                mq.delay(100)
                mq.cmd('/alt activate 636')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Companion's Aegis
            if mq.TLO.Me.AltAbilityReady('Companion\'s Aegis')() and mag_burn_variables.mypethp <= 50 and mag_burn_variables.mypethp >= 1 then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Aegis')
                mq.cmd('/alt activate 441')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Companion's Fortification
            if mq.TLO.Me.AltAbilityReady('Companion\'s Fortification')() and mag_burn_variables.mypethp >= 50 and mag_burn_variables.mypethp <= 100 then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Fortification')
                mq.cmd('/alt activate 3707')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Companion\'s Fury'
            if mq.TLO.Me.AltAbilityReady('Companion\'s Fury')() and mag_burn_variables.mypethp >= 50 and mag_burn_variables.mypethp <= 100 then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Fury')
                mq.cmd('/alt activate 60')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Companion's Intervening Divine Aura
            if mq.TLO.Me.AltAbilityReady('Companion\'s Intervening Divine Aura')() and mag_burn_variables.mypethp <= 30 and mag_burn_variables.mypethp >= 1 then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Intervening Divine Aura')
                mq.cmd('/alt activate 1580')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Dimensional Shield
            if mq.TLO.Me.AltAbilityReady('Dimensional Shield')() and mag_burn_variables.myhp <= 50 then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Dimensional Shield')
                mq.cmd('/alt activate 639')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Drape of Shadows
            if mq.TLO.Me.AltAbilityReady('Drape of Shadows')() and mag_burn_variables.myhp <= 20 then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Drape of Shadows')
                mq.cmd('/alt activate 8341')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Eradicate Magic
            if mq.TLO.Me.AltAbilityReady('Eradicate Magic')() and mag_burn_variables.mepoisoned >= 1 then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Eradicate Magic')
                mq.cmd('/target %s',mq.TLO.Me.CleanName())
                mq.delay(100)
                mq.cmd('/alt activate 547')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Focus of Arcanum
            if mq.TLO.Me.AltAbilityReady('Focus of Arcanum')() then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Focus of Arcanum')
                mq.cmd('/alt activate 1211')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Forceful Rejuvenation
            if mq.TLO.Me.AltAbilityReady('Forceful Rejuvenation')() then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Foreceful Rejuvenation')
                mq.cmd('/alt activate 7003')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Improved Twincast
            if mq.TLO.Me.AltAbilityReady('Improved Twincast')() then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Improved Twincast')
                mq.cmd('/alt activate 515')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Malaise
            if mq.TLO.Me.AltAbilityReady('Malaise')() and mag_burn_variables.targethp >= 50 and mag_burn_variables.targethp <= 99 and mq.TLO.Me.XTarget(1).ID() ~= 0 and mq.TLO.Target.Buff('Malosinetra')() == nil and mq.TLO.Target.Aggressive() then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Malaise')
                mq.cmd('/alt activate 1041')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Mend Companion
            if mq.TLO.Me.AltAbilityReady('Mend Companion')() and mag_burn_variables.mypethp <= 40 and mag_burn_variables.mypethp >= 1 then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Mend Companion')
                mq.cmd('/alt activate 58')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Silent Casting
            if mq.TLO.Me.AltAbilityReady('Silent Casting')() and mag_burn_variables.targethp >= 80 and mq.TLO.Target.Aggressive() then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Silent Casting')
                mq.cmd('/alt activate 500')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Summon Companion
            if mq.TLO.Me.AltAbilityReady('Summon Companion')() and mag_burn_variables.mypetdistance >= 200 or mq.TLO.Me.AltAbilityReady('Summon Companion')() and mag_burn_variables.mypetdistance >= 100 and mag_burn_variables.mypethp <= 40 and mag_burn_variables.mypethp >= 1 then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Summon Companion')
                mq.cmd('/alt activate 1215')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Companion of Necessity
            if mq.TLO.Me.AltAbilityReady('Companion of Necessity')() and mag_burn_variables.targethp <= 99 and mag_burn_variables.targethp >= 50 and mq.TLO.Target.Aggressive() then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Companion of Necessity')
                mq.cmd('/alt activate 3516')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Companion's Shielding
            if mq.TLO.Me.AltAbilityReady('Companion\'s Shielding')() and mag_burn_variables.mypethp <= 50 and mag_burn_variables.mypethp >= 1 then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Shielding')
                mq.cmd('/alt activate 265')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Elemental Conversion
            if mq.TLO.Me.AltAbilityReady('Elemental Conviersion')() and mag_burn_variables.mymana <= 50 and mag_burn_variables.mymana >=1 and mag_burn_variables.mypethp >= 50 then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Elemental Conversion')
                mq.cmd('/alt activate 2065')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Force of Elements
            if mq.TLO.Me.AltAbilityReady('Force of Elements')() and mag_burn_variables.targethp <= 75 and mag_burn_variables.targethp >= 25 and mq.TLO.Target.Aggressive() then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Force of Elements')
                mq.cmd('/alt activate 8800')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Heart of Frostone
            if mq.TLO.Me.AltAbilityReady('Heart of Frostone')() and mag_burn_variables.myhp <= 50 and mag_burn_variables.myhp >= 1 then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Heart of Frostone')
                mq.cmd('/alt activate 786')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Heart of Skyfire
            if mq.TLO.Me.AltAbilityReady('Heart of Skyfire')() and mag_burn_variables.targethp >= 40 and mag_burn_variables.targethp <= 98 and mq.TLO.Target.Aggressive() then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Heart of Skyfire')
                mq.cmd('/alt activate 785')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Host in the Shell
            if mq.TLO.Me.AltAbilityReady('Host in the Shell')() and mag_burn_variables.mypethp <= 35 and mag_burn_variables.mypethp >= 1 then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Host in the Shell')
                mq.cmd('/alt activate 8342')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Host of the Elements
            if mq.TLO.Me.AltAbilityReady('Host of the Elements')() and mag_burn_variables.targethp <= 99 and mag_burn_variables.targethp >= 60 and mq.TLO.Target.Aggressive() then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Host of the Elements')
                mq.cmd('/alt activate 207')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Second Wind Ward
            if mq.TLO.Me.AltAbilityReady('Second Wind Ward')() and mag_burn_variables.mypethp <= 60 and mag_burn_variables.targethp >= 1 and mq.TLO.Target.Aggressive() then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Second Wind Ward')
                mq.cmd('/alt activate 2066')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Servant of Ro
            if mq.TLO.Me.AltAbilityReady('Servant of Ro')() and mag_burn_variables.targethp <= 99 and mag_burn_variables.targethp >= 60 and mq.TLO.Target.Aggressive() then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Servant of Ro')
                mq.cmd('/alt activate 174')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Shield of the Elements
            if mq.TLO.Me.AltAbilityReady('Shield of the Elements')() and mag_burn_variables.myhp <= 50 and mag_burn_variables.myhp >= 1 then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Shield of the Elements')
                mq.cmd('/alt activate 603')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Spire of the Elements
            if mq.TLO.Me.AltAbilityReady('Spire of the Elements')() then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Spire of the Elements')
                mq.cmd('/alt activate 1370')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Thaumaturge's Focus
            if mq.TLO.Me.AltAbilityReady('Thaumaturge\'s Focus')() then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Thaumaturge\'s Focus')
                mq.cmd('/alt activate 390')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Thaumaturge's Unity
            if mq.TLO.Me.AltAbilityReady('Thaumaturge\'s Unity')() and mq.TLO.Me.Buff('Ophiolite Bodyguard')() == nil then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Thaumaturge\'s Unity')
                mq.cmd('/alt activate 1169')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Turn Summoned
            if mq.TLO.Me.AltAbilityReady('Turned Summoned')() and mq.TLO.Target.Race() ~= nil and mq.TLO.Target.Race() == 'Elemental' and mq.TLO.Target.Aggressive() then
                print('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atAA\ag]\ao - Turned Summoned')
                mq.cmd('/alt activate 559')
                while mq.TLO.Me.Casting() do mq.delay(250) end
                if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                mq.delay(500)
            end
            --Spell Routine
            if mag_burn_variables.mymana >=20 and not mq.TLO.Me.Hovering() then
                --Thaumaturge's Focus
                if mq.TLO.Me.SpellReady(mag_saved_settings.spell1)() and mq.TLO.Target.Aggressive() then
                    printf('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atSpell\ag]\ao - %s',mag_saved_settings.spell1)
                    mq.cmdf('/cast %s',mag_saved_settings.spell1)
                    while mq.TLO.Me.Casting() do mq.delay(250) end
                    if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                    mq.delay(500)
                end
                if mq.TLO.Me.SpellReady(mag_saved_settings.spell2)() and mq.TLO.Target.Aggressive() then
                    printf('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atSpell\ag]\ao - %s',mag_saved_settings.spell2)
                    mq.cmdf('/cast %s',mag_saved_settings.spell2)
                    while mq.TLO.Me.Casting() do mq.delay(250) end
                    if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                    mq.delay(500)
                end
                if mq.TLO.Me.SpellReady(mag_saved_settings.spell3)() and mq.TLO.Target.Aggressive() then
                    printf('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atSpell\ag]\ao - %s',mag_saved_settings.spell3)
                    mq.cmdf('/cast %s',mag_saved_settings.spell3)
                    while mq.TLO.Me.Casting() do mq.delay(250) end
                    if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                    mq.delay(500)
                end
                if mq.TLO.Me.SpellReady(mag_saved_settings.spell4)() and mq.TLO.Target.Aggressive() then
                    printf('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atSpell\ag]\ao - %s',mag_saved_settings.spell4)
                    mq.cmdf('/cast %s',mag_saved_settings.spell4)
                    while mq.TLO.Me.Casting() do mq.delay(250) end
                    if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                    mq.delay(500)
                end
                if mq.TLO.Me.SpellReady(mag_saved_settings.spell5)() and mq.TLO.Target.Aggressive() then
                    printf('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atSpell\ag]\ao - %s',mag_saved_settings.spell5)
                    mq.cmdf('/cast %s',mag_saved_settings.spell5)
                    while mq.TLO.Me.Casting() do mq.delay(250) end
                    if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                    mq.delay(500)
                end
                if mq.TLO.Me.SpellReady(mag_saved_settings.spell6)() and mq.TLO.Target.Aggressive() then
                    printf('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atSpell\ag]\ao - %s',mag_saved_settings.spell6)
                    mq.cmdf('/cast %s',mag_saved_settings.spell6)
                    while mq.TLO.Me.Casting() do mq.delay(250) end
                    if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                    mq.delay(500)
                end
                if mq.TLO.Me.SpellReady(mag_saved_settings.spell7)() and mq.TLO.Target.Aggressive() then
                    printf('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atSpell\ag]\ao - %s',mag_saved_settings.spell7)
                    mq.cmdf('/target %s',mq.TLO.Me.Pet.CleanName())
                    mq.cmdf('/cast %s',mag_saved_settings.spell7)
                    while mq.TLO.Me.Casting() do mq.delay(250) end
                    if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                    mq.delay(500)
                end
                if mq.TLO.Me.SpellReady(mag_saved_settings.spell8)() and mq.TLO.Me.PctHPs == 1 then
                    printf('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atSpell\ag]\ao - %s',mag_saved_settings.spell8)
                    mq.cmdf('/cast %s',mag_saved_settings.spell8)
                    while mq.TLO.Me.Casting() do mq.delay(250) end
                    if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                    mq.delay(500)
                end
                if mq.TLO.Me.SpellReady(mag_saved_settings.spell9)() and mq.TLO.Target.Aggressive() and mag_burn_variables.mypethp < 90 then
                    printf('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atSpell\ag]\ao - %s',mag_saved_settings.spell9)
                    mq.cmdf('/target %s',mq.TLO.Me.Pet.CleanName())
                    mq.cmdf('/cast %s',mag_saved_settings.spell9)
                    while mq.TLO.Me.Casting() do mq.delay(250) end
                    if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                    mq.delay(500)
                end
                if mq.TLO.Me.SpellReady(mag_saved_settings.spell10)() and mq.TLO.Target.Aggressive() then
                    printf('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atSpell\ag]\ao - %s',mag_saved_settings.spell10)
                    mq.cmdf('/cast %s',mag_saved_settings.spell10)
                    while mq.TLO.Me.Casting() do mq.delay(250) end
                    if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                    mq.delay(500)
                end
                if mq.TLO.Me.SpellReady(mag_saved_settings.spell11)() and mag_saved_settings.mymana <= 90 then
                    printf('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atSpell\ag]\ao - %s',mag_saved_settings.spell11)
                    mq.cmdf('/cast %s',mag_saved_settings.spell11)
                    while mq.TLO.Me.Casting() do mq.delay(250) end
                    if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                    mq.delay(500)
                end
                if mq.TLO.Me.SpellReady(mag_saved_settings.spell12)() and mq.TLO.Target.Aggressive() then
                    printf('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atSpell\ag]\ao - %s',mag_saved_settings.spell12)
                    mq.cmdf('/cast %s',mag_saved_settings.spell12)
                    while mq.TLO.Me.Casting() do mq.delay(250) end
                    if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                    mq.delay(500)
                end
                if mq.TLO.Me.SpellReady(mag_saved_settings.spell13)() and mq.TLO.FindItemCount('Summoned: Voidfrost Paradox')() < 1 then
                    printf('\ar[\aoEasy\ar] \agMAG Burn\aw - \ag[\atSpell\ag]\ao - %s',mag_saved_settings.spell13)
                    mq.cmdf('/target %s',mq.TLO.Me.CleanName())
                    mq.delay(500)
                    mq.cmdf('/cast %s',mag_saved_settings.spell13)
                    while mq.TLO.Me.Casting() do mq.delay(250) end
                    if mq.TLO.Cursor.ID() then mq.cmd.autoinventory() end
                    if mq.TLO.Me.XTarget(1).ID() >= 1 then mq.cmdf('/target id %s',mq.TLO.Me.XTarget(1).ID()) end
                    mq.delay(500)
                end
            end
        end
    end

    -------------------------------------------------
    ------------------ SHM Burn ---------------------
    -------------------------------------------------

    local SHM_BURN = function ()
        if mq.TLO.Me.Class.ShortName() == 'SHM' then
            --Breather
            local breather = mq.TLO.Spell('Breather').RankName()
            if mq.TLO.Me.CombatAbilityReady(breather)() and burn_variables.myendurance <= 20 and not mq.TLO.Me.Combat() and mq.TLO.Me.Song('Breather')() == nil and burn_variables.xtarget == 0 and not mq.TLO.Me.Hovering() then
                mq.cmdf('/disc %s', breather)
                print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atCombat Ability\ag]\ao - '..breather..'')
                mq.delay(490)
            end
            --Ancestral Aid
            if mq.TLO.Me.AltAbilityReady('Ancestral Aid')() and burn_variables.myhp <= 40 and burn_variables.myhp >= 1 then
                mq.cmd('/alt activate 447')
                print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Ancestral Aid')
                mq.delay(490)
            end
            --Cannibalization
            if mq.TLO.Me.AltAbilityReady('Cannibalization')() and burn_variables.myhp >= 80 and burn_variables.mymana <= 80 then
                mq.cmd('/alt activate 47')
                print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Cannibalization')
                mq.delay(490)
            end
            --Pact of the Wolf
            if mq.TLO.Me.AltAbilityReady('Pact of the Wolf')() and mq.TLO.Me.Song('Pact of the Wolf')() == nil then
                mq.cmd('/alt activate 707')
                print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Pact of the Wolf')
                mq.delay(490)
            end
            if burn_variables.xtarget >=1 and burn_variables.targethp >= 1 and burn_variables.targethp <= 99 and burn_variables.targetdistance <= 100 and burn_variables.targetdistance >= 0 and mq.TLO.Target.Aggressive() and not mq.TLO.Me.Hovering() then
                --AA
                --Companion's Fortification
                if mq.TLO.Me.AltAbilityReady('Companion\'s Fortification')() and burn_variables.mypethp >= 50 and burn_variables.mypethp <= 100 then
                    mq.cmd('/alt activate 3707')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Fortification')
                    mq.delay(490)
                end
                --Companion's Aegis
                if mq.TLO.Me.AltAbilityReady('Companion\'s Aegis')() and burn_variables.mypethp >= 1 and burn_variables.mypethp <= 50 then
                    mq.cmd('/alt activate 441')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Aegis')
                    mq.delay(490)
                end
                --Companion's Intervening Divine Aura
                if mq.TLO.Me.AltAbilityReady('Companion\'s Intervening Divine Aura')() and burn_variables.mypethp <= 20 and burn_variables.mypethp >= 1 then
                    mq.cmd('/alt activate 1580')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Companion\'s Intervening Divine Aura')
                    mq.delay(490)
                end
                --Focus of Arcanum
                if mq.TLO.Me.AltAbilityReady('Focus of Arcanum')() then
                    mq.cmd('/alt activate 1211')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Focus of Arcanum')
                    mq.delay(750)
                end
                --Forceful Rejuvenation
                if mq.TLO.Me.AltAbilityReady('Forceful Rejuvenation')() then
                    mq.cmd('/alt activate 7003')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Foreceful Rejuvenation')
                    mq.delay(750)
                end
                --Inconspicuous Totem
                if mq.TLO.Me.AltAbilityReady('Inconspicuous Totem')() and burn_variables.myhp <= 50 and burn_variables.myhp >= 1 and burn_variables.xtarget >= 3 then
                    mq.cmd('/alt activate 9504')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Inconspicuous Totem')
                    mq.delay(490)
                end
                --Spirit of Tala'Tak
                if mq.TLO.Me.AltAbilityReady('Spirit of Tala\'Tak')() and mq.TLO.Me.Buff('Spirit of Tala\'Tak')() == nil then
                    mq.cmd('/alt activate 859')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Spirit of Tala\'Tak')
                    mq.delay(490)
                end
                --Malaise
                if mq.TLO.Me.AltAbilityReady('Malaise')() and burn_variables.targethp >= 50 and burn_variables.targethp <= 99 and burn_variables.xtarget >= 1 and mq.TLO.Target.Buff('Malosinetra')() == nil and mq.TLO.Target.Aggressive() then
                    mq.cmd('/alt activate 1041')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Malaise')
                    mq.delay(750)
                end
                --Preincarnation
                if mq.TLO.Me.AltAbilityReady('Preincarnation')() and mq.TLO.Me.Buff('Preincarnation')() == nil then
                    mq.cmd('/alt activate 149')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Preincarnation')
                    mq.delay(490)
                end
                --Purified Spirits
                if mq.TLO.Me.AltAbilityReady('Purified Spirits')() and burn_variables.mepoisoned >= 1 then
                    mq.cmdf('/target %s',mq.TLO.Me.CleanName())
                    mq.cmd('/alt activate 626')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Purified Spirits')
                    mq.delay(490)
                end
                --Radiant Cure
                if mq.TLO.Me.AltAbilityReady('Radiant Cure')() and burn_variables.mepoisoned >= 1 then
                    mq.cmd('/alt activate 153')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Radiant Cure')
                    mq.delay(490)
                end
                --Silent Casting
                if mq.TLO.Me.AltAbilityReady('Silent Casting')() and burn_variables.targethp >= 80 and mq.TLO.Target.Aggressive() then
                    mq.cmd('/alt activate 494')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Silent Casting')
                    mq.delay(750)
                end
                --Spritual Rebuke
                if mq.TLO.Me.AltAbilityReady('Spiritual Rebuke')() and mq.TLO.Target.Aggressive() and burn_variables.targethp >= 1 and burn_variables.targethp <= 98  and burn_variables.xtarget >= 4 then
                    mq.cmd('/alt activate 147')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Spiritual Rebuke')
                    mq.delay(490)
                end
                --Summon Companion
                if mq.TLO.Me.AltAbilityReady('Summon Companion')() and burn_variables.mypetdistance >= 200 or mq.TLO.Me.AltAbilityReady('Summon Companion')() and burn_variables.mypetdistance >= 100 and burn_variables.mypethp <= 40 and burn_variables.mypethp >= 1 then
                    mq.cmd('/alt activate 1215')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Summon Companion')
                    mq.delay(750)
                end
                --Virulent Paralysis
                if mq.TLO.Me.AltAbilityReady('Virulent Paralysis')() and burn_variables.xtarget >= 1 and mq.TLO.Target.Aggressive() and burn_variables.myhp <= 50 and burn_variables.myhp >= 1 and burn_variables.targetdistance <= 50 and burn_variables.targetdistance >= 0 then
                    mq.cmd('/alt activate 992')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Virulent Paralysis')
                    mq.delay(490)
                end
                --Wind of Malaise
                if mq.TLO.Me.AltAbilityReady('Wind of Malaise')() and burn_variables.targethp <= 99 and burn_variables.targethp >= 10 and mq.TLO.Target.Aggressive() and burn_variables.xtarget >= 4 then
                    mq.cmd('/alt activate 952')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Wind of Malaise')
                    mq.delay(490)
                end
                --Ancestral Guard
                if mq.TLO.Me.AltAbilityReady('Ancestral Guard')() and burn_variables.myhp >= 1 and burn_variables.myhp <= 30 then
                    mq.cmd('/alt activate 528')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Ancestral Guard')
                    mq.delay(490)
                end
                --Call of the Ancients
                if mq.TLO.Me.AltAbilityReady('Call of the Ancients')() and burn_variables.myhp >= 1 and burn_variables.myhp <= 80 then
                    mq.cmd('/alt activate 321')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Call of the Ancients')
                    mq.delay(490)
                end
                --Dampen Resistance
                if mq.TLO.Me.AltAbilityReady('Dampen Resistance')() then
                    mq.cmd('/alt activate 857')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Dampen Resistance')
                    mq.delay(490)
                end
                --Fleeting Spirit
                if mq.TLO.Me.AltAbilityReady('Feeting Spirit')() and burn_variables.targethp <= 99 and burn_variables.targethp >= 75 then
                    mq.cmd('/alt activate 1138')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Fleeting Spirit')
                    mq.delay(490)
                end
                --Rabid Bear
                if mq.TLO.Me.AltAbilityReady('Rabid Bear')() and burn_variables.targethp >= 55 and burn_variables.targethp <= 99 and mq.TLO.Target.Aggressive() and mq.TLO.Me.Combat() then
                    mq.cmd('/alt activate 50')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Rabid Bear')
                    mq.delay(490)
                end
                --Soothsayer's Intervention
                if mq.TLO.Me.AltAbilityReady('Soothsayer\'s Intervention')() and burn_variables.myhp <= 40 and burn_variables.myhp >= 1 then
                    mq.cmdf('/target %s',mq.TLO.Me.CleanName())
                    mq.cmd('/alt activate 619')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Soothsayer\'s Intervention')
                    mq.delay(490)
                end
                --Spire of the Ancestors
                if mq.TLO.Me.AltAbilityReady('Spire of the Ancestors')() then
                    mq.cmd('/alt activate 1490')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Spire of the Ancestors')
                    mq.delay(490)
                end
                --Spirit Call
                if mq.TLO.Me.AltAbilityReady('Spirit Call')() and burn_variables.targethp >= 55 and burn_variables.targethp <= 99 and mq.TLO.Target.Aggressive() and burn_variables.xtarget >= 1 then
                    mq.cmd('/alt activate 177')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Spirit Call')
                    mq.delay(490)
                end
                --Spirit Guardian
                if mq.TLO.Me.AltAbilityReady('Spirit Guardian')() and burn_variables.myhp <= 30 and burn_variables.myhp >= 1 then
                    mq.cmdf('/target %s',mq.TLO.Me.CleanName())
                    mq.cmd('/alt activate 614')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Spirit Guardian')
                    mq.delay(490)
                end
                --Spirit of Urgency
                if mq.TLO.Me.AltAbilityReady('Spirit of Urgency')() and burn_variables.targethp <= 99 and burn_variables.targethp >= 10 and mq.TLO.Target.Aggressive() and burn_variables.myhp <= 25 and burn_variables.myhp >= 1 then
                    mq.cmd('/alt activate 948')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Spirit of Urgency')
                    mq.delay(490)
                end
                --Spiritual Blessing
                if mq.TLO.Me.AltAbilityReady('Spiritual Blessing')() and burn_variables.myhp <= 20 and burn_variables.myhp >= 1 then
                    mq.cmdf('/target %s',mq.TLO.Me.CleanName())
                    mq.cmd('/alt activate 151')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Spiritual Blessing')
                    mq.delay(490)
                end
                --Spiritual Channeling
                if mq.TLO.Me.AltAbilityReady('Spiritual Channeling')() and burn_variables.mymana <= 5 and burn_variables.myhp >= 25 then
                    mq.cmd('/alt activate 446')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Spiritual Channeling')
                    mq.delay(490)
                end
                --Turgur's Swarm
                if mq.TLO.Me.AltAbilityReady('Turgur\'s Swarm')() and burn_variables.targethp <= 98 and burn_variables.targethp >= 50 and mq.TLO.Target.Aggressive() and burn_variables.xtarget >= 1 and mq.TLO.Target.Buff('Turgur\'s Insects')() == nil then
                    mq.cmd('/alt activate 3729')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Turgur\'s Swarm')
                    mq.delay(490)
                end
                --Union of Spirits
                if mq.TLO.Me.AltAbilityReady('Union of Spirits')() and burn_variables.myhp <= 25 and burn_variables.myhp >= 1 then
                    mq.cmdf('/target %s',mq.TLO.Me.CleanName())
                    mq.cmd('/alt activate 662')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Union of Spirits')
                    mq.delay(490)
                end
                --Pack of Lunar Wolves
                if mq.TLO.Me.AltAbilityReady('Pack of Lunar Wolves')() and mq.TLO.Me.Buff('Pack of Lunar Wolves')() == nil then
                    mq.cmd('/alt activate 1166')
                    print('\ar[\aoEasy\ar] \agSHM Burn\aw - \ag[\atAA\ag]\ao - Pack of Lunar Wolves')
                    mq.delay(490)
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
            name = 'Claim Frags',
            helper = 'Converts Overseer Fragments to Dispenser',
            selected = saved_settings.claim_frags,
            action = claim_fragments
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
            name = 'Teach',
            helper = 'Teach Languages to Your Group',
            selected = saved_settings.teach_languages,
            action = Language
            }, {
            name = 'Forage',
            helper = 'Will only forage when standing',
            selected = saved_settings.forage,
            action = Forage
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
            name = 'Summon Milk',
            helper = 'Uses Warm Milk Dispenser',
            selected = saved_settings.summon_milk,
            action = MilkDispenser
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
        }
    }
    local classoptions = {
        {
            name = 'ROG Poison',
            helper = 'Summons Poison Using Leg Slot (Rogue Only)',
            selected = saved_settings.rog_poison,
            action = RoguePoison
        }, {
            name = 'MAG Cauldron',
            helper = 'Summon Items Using Cauldron (Mage Only)',
            selected = saved_settings.mag_cauldron,
            action = CheckCauldron,
        }, {
            name = 'AA Rez',
            helper = 'Rez DanNet Peers within 100 ft (DRU, SHM, PAL, CLR Only)(DanNet Required)',
            selected = saved_settings.aa_rez,
            action = RezCheck
        }, {
            name = 'WAR Burn',
            helper = 'Warrior Unleash Damage (WAR Only)',
            selected = saved_settings.war_burn,
            action = WAR_BURN
        }, {
            name = 'BRD Burn',
            helper = 'BARD Unleash Damage (BARD Only)',
            selected = saved_settings.brd_burn,
            action = BRD_BURN
        }, {
            name = 'SHD Burn',
            helper = 'SK Unleash Damage (SK Only)',
            selected = saved_settings.shd_burn,
            action = SHD_BURN
        }, {
            name = 'BER Burn',
            helper = 'Berserker Unleash Damage (Berserker Only)',
            selected = saved_settings.ber_burn,
            action = BER_BURN
        }, {
            name = 'ROG Burn',
            helper = 'Rogue Unleash Damage (Rogue Only)',
            selected = saved_settings.rog_burn,
            action = ROG_BURN
        }, {
            name = 'BST Burn',
            helper = 'Beast Unleash Damage (Beastlord Only)',
            selected = saved_settings.bst_burn,
            action = BST_BURN
        }, {
            name = 'MAG Burn',
            helper = 'Magician Unleash Damage (Magician Only)',
            selected = saved_settings.mag_burn,
            action = MAG_BURN
        }, {
            name = 'SHM Burn',
            helper = 'Shaman Unleash Damage (Shaman Only)',
            selected = saved_settings.shm_burn,
            action = SHM_BURN
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
        },   {
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
        }
    }

    local function UpdateTime()
        timeDisplayNorrath = string.format("%02d:%02d", mq.TLO.GameTime.Hour(), mq.TLO.GameTime.Minute())
        timeDisplayEarth = os.date("%H:%M:%S")
    end
        
    local function Cannon()
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
        while mq.TLO.Me.Fellowship.CampfireZone() ~= nil and mq.TLO.Me.Fellowship.CampfireDuration.TotalSeconds() >= 1 do
            CampFireZone = mq.TLO.Me.Fellowship.CampfireZone()
            break
        end
        while mq.TLO.Me.Fellowship.CampfireDuration.TotalSeconds() ~= nil and mq.TLO.Me.Fellowship.Campfire() ~= nil do
            CampfireDuration = mq.TLO.Me.Fellowship.CampfireDuration.TotalSeconds()
            break
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
    end
    local function CannonGUI()
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
        if mq.TLO.Me.HaveExpansion(29)() then
            expansion_owned = "Night of Shadows"
        end
        if mq.TLO.Me.HaveExpansion(28)() and not mq.TLO.Me.HaveExpansion(29)() then
            expansion_owned = "Terror of Luclin"
        end
        if mq.TLO.Me.HaveExpansion(27)() and not mq.TLO.Me.HaveExpansion(28)() and not mq.TLO.Me.HaveExpansion(29)() then
            expansion_owned = "Claws of Veeshan"
        end
        if mq.TLO.Me.HaveExpansion(26)() and not mq.TLO.Me.HaveExpansion(27)() and not mq.TLO.Me.HaveExpansion(28)() and not mq.TLO.Me.HaveExpansion(29)() then
            expansion_owned = "Torment of Velious"
        end
        if Open then
        Open, ShowUI = ImGui.Begin('Easy.lua by Cannonballdex', Open)
        ImGui.SetWindowSize(500, 250, ImGuiCond.Once)
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
                    mq.cmd('/lua stop easylua')
                end
                ImGui.SameLine()
                HelpMarker("End My Script")
                if mq.TLO.Plugin('mq2dannet')() ~= nil and saved_settings.dannet_load then
                ImGui.SameLine()
                if ImGui.Button(ICONS.FA_STOP) then
                    mq.cmd('/dge /lua stop easylua')
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
                    mq.cmd('/lua stop easylua')
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
                        mq.cmd('/dgex /lua pause easylua')
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
                        mq.cmd('/dgex /lua pause easylua')
                        pause_switch_all = true
                    end
                    HelpMarker("Pause all actions of the script on all toons connected to DanNet")                              
                    ImGui.SameLine()
                    if ImGui.Button(ICONS.FA_STOP) then
                        mq.cmd('/dgex /lua stop easylua')
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
            ImGui.TextColored(0, 1, 1, 1, ICONS.FA_TREE)
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
            ImGui.TextColored(0, 1, 1, 1, ICONS.MD_SLOW_MOTION_VIDEO)
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
                ImGui.TextColored(0, 1, 1, 1, ICONS.FA_FIRE)
                HelpMarker('Campfire Location')
                ImGui.SameLine()
                if mq.TLO.Me.Fellowship.CampfireZone() then
                    ImGui.TextColored(1, 1, .5, 1,"[ " .. CampFireZone .. " ]")
                else
                    ImGui.TextColored(0, 0.8, 1, 1,"[ " .. CampFireZone .. " ]")
                end
                ImGui.SameLine() ImGui.Text('|')
                ImGui.SameLine()
                ImGui.TextColored(0, 1, 1, 1, ICONS.MD_AV_TIMER)
                HelpMarker('Time Remaining on Campfire')
            end
            if mq.TLO.GameTime.Hour() ~= nil then
                ImGui.SameLine()
                ImGui.TextColored(0, 0.8, 1, 1,"[ " .. CampfireDuration/60 .. " ]")
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
                ImGui.TextColored(0, 1, 1, 1, ICONS.MD_POWER_INPUT)
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
                ImGui.TextColored(0, 1, 1, 1, ICONS.MD_POWER_SETTINGS_NEW)
                HelpMarker('Power Remaining')
                ImGui.SameLine()
                if MySourcePower == nil then
                    MySourcePower = 1000*0
                end
                ImGui.TextColored(0, 0.8, 1, 1,"[ " .. MySourcePower/1000 .. " ]")
                ImGui.SameLine() ImGui.Text('|')
                ImGui.SameLine()
                ImGui.TextColored(0, 1, 1, 1, ICONS.MD_POWER)
                HelpMarker('Total Power Remaining On All Power Sources In Inventory')
                ImGui.SameLine()
                ImGui.TextColored(0, 0.8, 1, 1,"[ " .. MySourcePower*MySourceCount/1000 .. " ]")
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
                            print('\ar[\aoEasy\ar] GM Alert: \aySetting all toons using CWTN to Manual Mode')
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
                ImGui.Separator()
                if ImGui.BeginTabBar('Main', ImGuiTabBarFlags.Reorderable) then
                    ImGui.PushStyleColor(ImGuiCol.TabActive, 0, 0, 0, 0.25)
                    -- Start Options Tab
                    ImGui.PushID('Options')
                    if ImGui.BeginTabItem('Options') then
                        HelpMarker('Selected options will activate if all requirements are met.')
                        ImGui.BeginTable("Script Options",3)
                        for _, value in ipairs(options) do
                            ImGui.TableNextColumn()
                            value.selected = ImGui.Checkbox(value.name, value.selected) ImGui.SameLine() HelpMarker(value.helper)
                        end
                        ImGui.EndTable()
                        ImGui.EndTabItem()
                    end
                    ImGui.PopID()
                    -- Start Camp Tab
                    ImGui.PushID('Camp')
                    if ImGui.BeginTabItem('Camp') then
                        HelpMarker('Selected options will activate if all requirements are met.')
                        ImGui.BeginTable("Script Options",3)
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
                            SCOOT_DISTANCE, _ = ImGui.SliderInt('##SliderInt_Scoot ', SCOOT_DISTANCE, 1, 1000, "%d")
                            ImGui.SameLine()
                            ImGui.PushItemWidth(1)
                            SCOOT_DISTANCE, _ = ImGui.InputInt('##inputint###inputstandard_Scoot', SCOOT_DISTANCE, 1, 1000, ImGuiInputTextFlags.None)
                            if SCOOT_DISTANCE < 1 then SCOOT_DISTANCE = 1 end
                            if SCOOT_DISTANCE > 1000 then SCOOT_DISTANCE = 1000 end
                            HelpMarker('Scoot Camp if PC within this Distance')
                            ImGui.Text('Alert PC Trigger Distance:')
                            ImGui.SameLine()
                            ImGui.PushItemWidth(100)
                            ALERT_DISTANCE, _ = ImGui.SliderInt('##SliderInt_Alert ', ALERT_DISTANCE, 1, 1000, "%d")
                            ImGui.SameLine()
                            ImGui.PushItemWidth(1)
                            ALERT_DISTANCE, _ = ImGui.InputInt('##inputint###inputstandard_Alert', ALERT_DISTANCE, 1, 1000, ImGuiInputTextFlags.None)
                            if ALERT_DISTANCE < 1 then ALERT_DISTANCE = 1 end
                            if ALERT_DISTANCE > 1000 then ALERT_DISTANCE = 1000 end
                            HelpMarker('Alert if PC within this Distance')
                            ImGui.Text('Call for Toon Assist:')
                            ImGui.SameLine()
                            ImGui.PushItemWidth(100)
                            TOON_ASSIST_PCT_ON, _ = ImGui.SliderInt('##SliderInt_On ', TOON_ASSIST_PCT_ON, 1, 100, "%d")
                            ImGui.SameLine()
                            ImGui.PushItemWidth(1)
                            TOON_ASSIST_PCT_ON, _ = ImGui.InputInt('##inputint###inputstandard_On', TOON_ASSIST_PCT_ON, 1, 100, ImGuiInputTextFlags.None)
                            if TOON_ASSIST_PCT_ON < 1 then TOON_ASSIST_PCT_ON = 1 end
                            if TOON_ASSIST_PCT_ON > 100 then TOON_ASSIST_PCT_ON = 100 end
                            HelpMarker('Mob % HP to call toon assist')
                            ImGui.Text('Stop Call for Toon Assist:')
                            ImGui.SameLine()
                            ImGui.PushItemWidth(100)
                            TOON_ASSIST_PCT_OFF, _ = ImGui.SliderInt('##SliderInt_Off ', TOON_ASSIST_PCT_OFF, 1, 100, "%d")
                            ImGui.SameLine()
                            ImGui.PushItemWidth(1)
                            TOON_ASSIST_PCT_OFF, _ = ImGui.InputInt('##inputint###inputstandard_Off', TOON_ASSIST_PCT_OFF, 1, 100, ImGuiInputTextFlags.None)
                            if TOON_ASSIST_PCT_OFF < 1 then TOON_ASSIST_PCT_OFF = 1 end
                            if TOON_ASSIST_PCT_OFF > 100 then TOON_ASSIST_PCT_OFF = 100 end
                            HelpMarker('Mob % HP to stop calling toon assist')
                            ImGui.EndTable()
                        end
                        ImGui.EndTabItem()
                    end
                    ImGui.PopID()
                    -- Start Merc Tab
                    ImGui.PushID('Merc')
                    if ImGui.BeginTabItem('Merc') then
                        HelpMarker('Mercenary Options.')
                        ImGui.BeginTable("Merc Options",3)
                        for _, value in ipairs(mercoptions) do
                            ImGui.TableNextColumn()
                            value.selected = ImGui.Checkbox(value.name, value.selected) ImGui.SameLine() HelpMarker(value.helper)
                        end
                        ImGui.EndTable()
                        ImGui.EndTabItem()
                    end
                    ImGui.PopID()
                    -- Start Class Tab
                    ImGui.PushID('Class')
                    if ImGui.BeginTabItem('Class') then
                        HelpMarker('Class Options.')
                        ImGui.BeginTable("Class Options",3)
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
                            START_BURN, _ = ImGui.SliderInt('##SliderInt_Scoot ', START_BURN, 1, 100, "%d")
                            ImGui.SameLine()
                            ImGui.PushItemWidth(1)
                            START_BURN, _ = ImGui.InputInt('##inputint###inputstandard_Scoot', START_BURN, 1, 100, ImGuiInputTextFlags.None)
                            if START_BURN < 1 then START_BURN = 1 end
                            if START_BURN > 100 then START_BURN = 100 end
                            HelpMarker('Start Burn When Mobs Hits This PCT HP')
                            ImGui.Text('Mob HP PCT to Stop Burn:')
                            ImGui.SameLine()
                            ImGui.PushItemWidth(100)
                            STOP_BURN, _ = ImGui.SliderInt('##SliderInt_Alert ', STOP_BURN, 1, 100, "%d")
                            ImGui.SameLine()
                            ImGui.PushItemWidth(1)
                            STOP_BURN, _ = ImGui.InputInt('##inputint###inputstandard_Alert', STOP_BURN, 1, 100, ImGuiInputTextFlags.None)
                            if STOP_BURN < 1 then STOP_BURN = 1 end
                            if STOP_BURN > 100 then STOP_BURN = 100 end
                            HelpMarker('Stop Burn When Mob Hits This PCT HP')
                            ImGui.EndTable()
                        end
                        ImGui.EndTabItem()
                        end
                        ImGui.PopID()
                        --- Account
                        ImGui.PushID('Account')
                        if ImGui.BeginTabItem('Account') then
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
                            if  me_krono >= 5 then
                                ImGui.TextColored(0,1,0,1,"[ " ..  me_krono .. " ]")
                            elseif  me_krono <= 4 and  me_krono >= 2 then
                                ImGui.TextColored(0.6, 0.6, 0, 1,"[ " ..  me_krono .. " ]")
                            elseif  me_krono <= 1 then
                                ImGui.TextColored(0.95, 0.05, 0.05, 1,"[ " ..  me_krono .. " ]")
                            end
                            if mq.TLO.NearestSpawn('pc')() ~= nil then
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
                            ImGui.TextColored(1, 1, .5, 1,"[ " .. mq.TLO.Me.Origin() .. " ]")
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
                            ImGui.EndTabItem()
                            end
                        end
                        ImGui.PopID()
                        --- Zone Info
                        ImGui.PushID('Zone Info')
                        if ImGui.BeginTabItem('Zone Info') then
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
                                    if ImGui.BeginTable('Players', 9, ImGuiTableFlags.Resizable + ImGuiTableFlags.Borders) then
                                        ImGui.TableSetupColumn('Name', (ImGuiTableColumnFlags.DefaultSort + ImGuiTableColumnFlags.WidthFixed), 20.0, ColumnID_Name)
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
                                        for k = 1, mq.TLO.SpawnCount('pc')() do
                                            local player = mq.TLO.NearestSpawn(k,'pc')
                                                if mq.TLO.NearestSpawn('pc')() ~= nil then
                                                    local item = player[k + 1]
                                                    ImGui.TableNextRow()
                                                    ImGui.TableNextColumn()
                                                    ImGui.Text(string.format('%s', player.CleanName()))
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
                                                    ImGui.Text(string.format('%s', player.LocYXZ()))
                                                end
                                                if mq.TLO.NearestSpawn('pc')() == nil then
                                                    mq.delay(30000)
                                                    break
                                                end
                                            end
                                            ImGui.EndTable()
                                        end
                                    end
                                    ImGui.EndTabItem()
                                end
                                ImGui.PopID()
                                --- Clickies                                                        
                                ImGui.PushID('Clickies')
                                if ImGui.BeginTabItem('Clickies') then
                                    HelpMarker('Use Food and Drink Clickies.')
                                    ImGui.BeginTable("Item Options",3)
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
                                        ImGui.Text('Cookies:')
                                        ImGui.SameLine()
                                        ImGui.PushItemWidth(100)
                                        COOKIES_TO_SUMMON, _ = ImGui.SliderInt('##SliderInt_Cookies ', COOKIES_TO_SUMMON, 1, 100, "%d")
                                        ImGui.SameLine()
                                        ImGui.PushItemWidth(1)
                                        COOKIES_TO_SUMMON, _ = ImGui.InputInt('##inputint###inputstandard_Cookies', COOKIES_TO_SUMMON, 1, 100, ImGuiInputTextFlags.None)
                                        if COOKIES_TO_SUMMON < 1 then COOKIES_TO_SUMMON = 1 end
                                        if COOKIES_TO_SUMMON > 100 then COOKIES_TO_SUMMON = 100 end
                                        HelpMarker('Quantity of Cookies to Summon')
                                        ImGui.SameLine()
                                        local cookie_count = mq.TLO.FindItemCount('71980')()
                                        ImGui.Text(string.format('You have (%s) Fresh Cookies', cookie_count))
                                        ImGui.Text('Tea:')
                                        ImGui.SameLine()
                                        ImGui.PushItemWidth(100)
                                        SPICED_TEA_TO_SUMMON, _ = ImGui.SliderInt('##SliderInt_Tea ', SPICED_TEA_TO_SUMMON, 1, 100, "%d")
                                        ImGui.SameLine()
                                        ImGui.PushItemWidth(1)
                                        SPICED_TEA_TO_SUMMON, _ = ImGui.InputInt('##inputint###inputstandard_Tea', SPICED_TEA_TO_SUMMON, 1, 100, ImGuiInputTextFlags.None)
                                        if SPICED_TEA_TO_SUMMON < 1 then SPICED_TEA_TO_SUMMON = 1 end
                                        if SPICED_TEA_TO_SUMMON > 100 then SPICED_TEA_TO_SUMMON = 100 end
                                        HelpMarker('Quantity of Spiced Tea to Summon')
                                        ImGui.SameLine()
                                        local tea_count = mq.TLO.FindItemCount('107807')()
                                        ImGui.Text(string.format('You have (%s) Spiced Tea', tea_count))
                                        ImGui.Text('Milk:')
                                        ImGui.SameLine()
                                        ImGui.PushItemWidth(100)
                                        WARM_MILK_TO_SUMMON, _ = ImGui.SliderInt('##SliderInt_Milk ', WARM_MILK_TO_SUMMON, 1, 100, "%d")
                                        ImGui.SameLine()
                                        ImGui.PushItemWidth(1)
                                        WARM_MILK_TO_SUMMON, _ = ImGui.InputInt('##inputint###inputstandard_Milk', WARM_MILK_TO_SUMMON, 1, 100, ImGuiInputTextFlags.None)
                                        if WARM_MILK_TO_SUMMON < 1 then WARM_MILK_TO_SUMMON = 1 end
                                        if WARM_MILK_TO_SUMMON > 100 then WARM_MILK_TO_SUMMON = 100 end
                                        HelpMarker('Quantity of Warm Milk to Summon')
                                        ImGui.SameLine()
                                        local milk_count = mq.TLO.FindItemCount('52199')()
                                        ImGui.Text(string.format('You have (%s) Warm Milk', milk_count))
                                        ImGui.Text('Turkey:')
                                        ImGui.SameLine()
                                        ImGui.PushItemWidth(100)
                                        COOKED_TURKEY_TO_SUMMON, _ = ImGui.SliderInt('##SliderInt_Turkey ', COOKED_TURKEY_TO_SUMMON, 1, 100, "%d")
                                        ImGui.SameLine()
                                        ImGui.PushItemWidth(1)
                                        COOKED_TURKEY_TO_SUMMON, _ = ImGui.InputInt('##inputint###inputstandard_Turkey', COOKED_TURKEY_TO_SUMMON, 1, 100, ImGuiInputTextFlags.None)
                                        if COOKED_TURKEY_TO_SUMMON < 1 then COOKED_TURKEY_TO_SUMMON = 1 end
                                        if COOKED_TURKEY_TO_SUMMON > 100 then COOKED_TURKEY_TO_SUMMON = 100 end
                                        HelpMarker('Quantity of Cooked Turkey to Summon')
                                        ImGui.SameLine()
                                        local turkey_count = mq.TLO.FindItemCount('56064')()
                                        ImGui.Text(string.format('You have (%s) Cooked Turkey', turkey_count))
                                        ImGui.Text('Brew:')
                                        ImGui.SameLine()
                                        ImGui.PushItemWidth(100)
                                        BRELL_ALE_TO_SUMMON, _ = ImGui.SliderInt('##SliderInt_Brells ', BRELL_ALE_TO_SUMMON, 1, 100, "%d")
                                        ImGui.SameLine()
                                        ImGui.PushItemWidth(1)
                                        BRELL_ALE_TO_SUMMON, _ = ImGui.InputInt('##inputint###inputstandard_Brells', BRELL_ALE_TO_SUMMON, 1, 100, ImGuiInputTextFlags.None)
                                        if BRELL_ALE_TO_SUMMON < 1 then BRELL_ALE_TO_SUMMON = 1 end
                                        if BRELL_ALE_TO_SUMMON > 100 then BRELL_ALE_TO_SUMMON = 100 end
                                        HelpMarker('Quantity of Brell Day Ale to Summon')
                                        ImGui.SameLine()
                                        local brew_count = mq.TLO.FindItemCount('48994')()
                                        ImGui.Text(string.format('You have (%s) Brell Day Ale', brew_count))
                                        ImGui.EndTable()
                                    end
                                    ImGui.EndTabItem()
                                end
                                ImGui.PopID()
                                --- Hunter                                                        
                                ImGui.PushID('Hunter')
                                if ImGui.BeginTabItem('Hunter') then
                                    HelpMarker('Hunter Achievements')
                                    RenderTitle()
                                    ImGui.Separator()
                                    if curAch.ID then
                                        RenderHunter()
                                    end
                                    ImGui.EndTabItem()
                                end
                                ImGui.PopID()
                                -- Favorites
                                ImGui.PushID('Favs')
                                if ImGui.BeginTabItem('Favs') then
                                    HelpMarker('Can only run One Macro at a time')
                                    ImGui.BeginTable("FavoriteMacros",3)
                                    ImGui.TableNextColumn() if ImGui.Button('Guild Bank') then mq.cmd('/mac guildbankbot') end ImGui.SameLine() HelpMarker('Deposit and Set Guild Bank Items To Public. (Requires guildbankbot.mac)')
                                    ImGui.TableNextColumn() if ImGui.Button('Block Spells') then block_spells() end ImGui.SameLine() HelpMarker('Adds Mod Rod and Summoned Food and Drink to Blocked Spell List.')
                                    ImGui.TableNextColumn() if ImGui.Button('Claim Collectibles') then mq.cmd('/mac claim') end ImGui.SameLine() HelpMarker('Claims Un-Claimed Collectibles in your inventory. (Requires claim.mac)')
                                    ImGui.TableNextColumn() if ImGui.Button('Lazy Lobby Rez') then mq.cmd('/mac lazylobbyrez') end ImGui.SameLine() HelpMarker('Summon Corpse in the Guild Lobby. (Requires LazyLobbyRez.mac')
                                    ImGui.TableNextColumn() if ImGui.Button('Start Overseer') then mq.cmd('/mac overseer') end ImGui.SameLine() HelpMarker('Starts Overseer. (Requires overseer.mac)')
                                    ImGui.TableNextColumn() if ImGui.Button('Stop Macro') then mq.cmd('/end mac') end ImGui.SameLine() HelpMarker('Stops Macro from running')
                                    ImGui.TableNextColumn() if ImGui.Button('Resupply') then mq.cmd('/lua run resupply') end ImGui.SameLine() HelpMarker('Resupply Regents and Supplies. (Requires resupply.lua)')
                                    ImGui.TableNextColumn() if ImGui.Button('Dumpster Dive') then mq.cmd('/mac dumpsterdive') mq.cmd('/timed 100 /dive start') end ImGui.SameLine() HelpMarker('Dumpster Dive. (Requires dumpsterdive.mac)')
                                    ImGui.TableNextColumn() if ImGui.Button('Parcel Stuff') then mq.cmd('/mac parcel') end ImGui.SameLine() HelpMarker('Parcel Items To Specified Toons. (Requires parcel.mac)')
                                    ImGui.TableNextColumn() if ImGui.Button('ToonCollect') then mq.cmd('/lua run tooncollect') end ImGui.SameLine() HelpMarker('Claim Dispensers. (Requires tooncollect.lua)')
                                    ImGui.TableNextColumn() if ImGui.Button('Sell Stuff') then mq.cmd('/mac sellstuff') end ImGui.SameLine() HelpMarker('Sell Items. Have to target vendor. (Requires sellstuff.mac)')
                                    ImGui.TableNextColumn() if ImGui.Button('Big Bag') then mq.cmd('/lua run cbbags') end ImGui.SameLine() HelpMarker('Opens Big Bag (Requires cbb.lua))')
                                    ImGui.TableNextColumn() if ImGui.Button('Big Bank Bag') then mq.cmd('/lua run cbbbags') end ImGui.SameLine() HelpMarker('Opens Big Bag (Requires cbbbags.lua))')
                                    ImGui.TableNextColumn() if ImGui.Button('Ignore Mob') then mq.cmdf('/addignore "%s"',mq.TLO.Target.CleanName()) end ImGui.SameLine() HelpMarker('Adds targeted mob to ignore list.')
                                    ImGui.EndTable()
                                    ImGui.EndTabItem()
                                    ImGui.PopStyleColor()
                                    ImGui.PopID()
                                end
                                ImGui.EndTabBar()
                            end
                        end
                        ImGui.End()
                    end
    end
    local function help()
        print('\ar[\aoEasy.lua\ar] \awby \agCannonballdex \at'..Version..'')
        print('\ar[\aoEasy Help\ar]\ag /easy campfire \aw - Will drop a campfire if requirements are met')
        print('\ar[\aoEasy Help\ar]\ag /easy war \aw - One time activate WAR_Burn routine')
        print('\ar[\aoEasy Help\ar]\ag /easy rog \aw - One time activate ROG_Burn routine')
        print('\ar[\aoEasy Help\ar]\ag /easy brd \aw - One time activate BRD_Burn routine')
        print('\ar[\aoEasy Help\ar]\ag /easy shd \aw - One time activate SHD_Burn routine')
        print('\ar[\aoEasy Help\ar]\ag /easy ber \aw - One time activate BER_Burn routine')
        print('\ar[\aoEasy Help\ar]\ag /easy bst \aw - One time activate BST_Burn routine')
        print('\ar[\aoEasy Help\ar]\ag /easy mag \aw - One time activate MAG_Burn routine')
        print('\ar[\aoEasy Help\ar]\ag /easy shm \aw - One time activate SHM_Burn routine')
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
        if cmd == 'war' then
            WAR_BURN()
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
        if cmd == 'shm' then
            SHM_BURN()
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
            mq.cmd('/lua stop easylua')
        end
    end
mq.imgui.init('CannonGUI', CannonGUI)
mq.bind('/easy', bind_easy)
while Open do
    Keep_DanNet_Loaded()
    Cannon()
    mq.delay(500)
    UpdateTime()
    if oldZone ~= myZone() then
        updateTables()
        oldZone = myZone()
    end
    Check_Gamestate()
end