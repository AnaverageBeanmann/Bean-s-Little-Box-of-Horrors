local AddonName = "Bean's Little Box of Horrors"
local AddonType = "NPC"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')

	local vCat = "Bean's Little Box of Horrors"
	-- VJ.AddCategoryInfo(vCat, {Icon = "icons/vj_singularity.png"})

	-- Original Guys - Part 1, The Old Blood
	VJ.AddNPC("Cultist","npc_vj_blboh_cultist",vCat)
	VJ.AddNPC("Wretch","npc_vj_blboh_wretch",vCat)
	VJ.AddNPC("Horror","npc_vj_blboh_horror",vCat)
	VJ.AddNPC("Stalker","npc_vj_blboh_stalker",vCat)
	VJ.AddNPC("Erectus","npc_vj_blboh_erectus",vCat)
	VJ.AddNPC("Preacher","npc_vj_blboh_preacher",vCat)
	VJ.AddNPC("The Chupacabra","npc_vj_blboh_michael",vCat)
	VJ.AddNPC("The Follower","npc_vj_blboh_leonard",vCat)
	VJ.AddNPC("The Shepherd","npc_vj_blboh_shepherd",vCat)

	-- New Guys - Part 2 - The New Blood
	-- VJ.AddNPC("Thrall","npc_vj_blboh_thrall",vCat) -- Can grab and punch you; didn't finish him for Damned, but giving him another chance
	-- VJ.AddNPC("Flock","npc_vj_blboh_flock",vCat) -- Minion summoned by The Shepherd; basically a fast zombie, gameplay-wise
	-- VJ.AddNPC("Tortured","npc_vj_blboh_Tortured",vCat) -- Blind; look into whether we're suing the servant suiter or angelo as the model
	-- VJ.AddNPC("Crunatus","npc_vj_blboh_cultist_blood",vCat) -- Maranox Infirmux
	-- VJ.AddNPC("Secretary","npc_vj_blboh_secretary",vCat) -- Forces you to look at him while he does psychic damage
	-- VJ.AddNPC("Semper","npc_vj_blboh_semper",vCat) -- Teleports around
	-- VJ.AddNPC("Tarako","npc_vj_blboh_tarako",vCat) -- Cannot move at all while being looked at
	-- VJ.AddNPC("Goreshile Spawn","npc_vj_blboh_goreshile_spawn",vCat) -- Goreshile minion
	-- VJ.AddNPC("Goreshile","npc_vj_blboh_goreshile",vCat) -- Spooky take on the ZS Giga Gore Child
	-- VJ.AddNPC("Ball of Dread","npc_vj_blboh_ballofdread",vCat) -- Black ball of fog that floats around; you can hear screams from inside it
	-- VJ.AddNPC("Chainsaw Dude","npc_vj_blboh_chainsawdude",vCat) -- Doom 3 fat zombie armed with a chainsaw utilizing l4d2 sounds; he'll be retextured to wear a flannel jacket, and he'll have a bag bonemerged to his head that'll fall off on death
	-- VJ.AddNPC("Costas","npc_vj_blboh_costas",vCat) -- Floating headless skeleton torso w/ a sword and shield, has some light blue light effects
	-- VJ.AddNPC("Evocator","npc_vj_blboh_evocator",vCat) -- Necromancer guy who can summon Undead, Costas, and Lost Souls/Hatefuls
	-- VJ.AddNPC("Lost Soul","npc_vj_blboh_lostsoul",vCat) -- Basically the same thing from Doom; does Hateful work as a name? idk it feels like we should save it for something more threatening
	-- VJ.AddNPC("Butcher","npc_vj_blboh_butcher",vCat) -- Based on the ZS boss; fast guy with a fast melee attack that also has lifesteal

	-- Non-Canons
	-- VJ.AddNPC("The Walrus","npc_vj_blboh_nathan",vCat)

	-- Special Guests, done by Warkin Iskander Volselli
	VJ.AddNPC("Undead","npc_vj_blboh_undead",vCat) -- ombie
	VJ.AddNPC("Tormenter","npc_vj_blboh_tormenter",vCat)
	VJ.AddNPC("Hollow","npc_vj_blboh_hollow",vCat)


	-- Thrall - Appearance based on the Thralls from FAITH
	-- Flock - Ghost Dog/Buddy from gm_stable
	-- Tortured - Servant Suiter
	-- Crunatus - Cultist model, but with a grey robe
	-- Secretary - Suited skeleton with glowing eyes
	-- Semper - player.mdl
	-- Tarako - https://www.youtube.com/watch?v=1guJsD-au7I
	-- Goreshiles - Shadowy Giga Gore Child
	-- Ball of Dread - Black void of fog

	-- May or may not add
	-- VJ.AddNPC("Withering Bones","npc_vj_blboh_witheringbones",vCat) -- [] Wither Skeletons be like
	-- VJ.AddNPC("The Creature","npc_vj_blboh_creature",vCat) -- [] Runs away if you look at it?


	/*
	Model for Erectus, The Shepherd, and The Chupacabra are from Half-Life 2
	Model for Wretch and Preacher are from from Get a Life
	Model for Cultist is from Death: A Grim Bundle
	Cultist Knife model from Escape from Tarkov
	Model for Horror is from here *link to poison zombie playermodel*
	Model for Stalker is from Half-Life 2 Beta

	Base texture for The Chupacabra taken from this addon *link to the rake model*

	Common Infected Animations for Cultist taken from Left 4 Dead Common Infected NPCs
	Animations for Erectus taken from Cry of Fear
	Horror animations provided by Warkin Iskander Volselli

	Various NPCs use sounds from Half-Life 2
	Sounds for Cultist, The Shepherd, and The Chupacabra taken from FAITH
	Sounds for Horror and Erectus taken from Ghouls Forest 3
	Sounds for Wretch taken from Sabiru

	The Follower's model and some sounds are from Silent Hill: Downpour; other Follower sounds are from Dying Light and the Resident Evil 2 Remake

	Code for Blackscary in Crack-Life Resurgence referenced for the Stalker's mechanic


	Model for Undead from Underhell
	Animations for Undead from No More Room In Hell and Call of Duty: WWII
	Sounds for Undead from They Hunger: Lost Souls and Call of Duty: Black Ops
	Tormentor barbed wire from The Feeder model
	Tormentor projectile tracking code taken from Half-Life Resurgence

	*/

	VJ.AddConVar("vj_blboh_performance_mode", 0, {FCVAR_ARCHIVE})
	VJ.AddConVar("vj_blboh_spawn_sequences", 1, {FCVAR_ARCHIVE})
	VJ.AddConVar("vj_blboh_michael_killable", 1, {FCVAR_ARCHIVE})
	VJ.AddConVar("vj_blboh_michael_killable_timesneedtofendoff", 2, {FCVAR_ARCHIVE})
	VJ.AddConVar("vj_blboh_michael_omniscience", 1, {FCVAR_ARCHIVE})
	VJ.AddConVar("vj_blboh_leonard_killable", 1, {FCVAR_ARCHIVE})
	VJ.AddConVar("vj_blboh_leonard_killable_timesneedtofendoff", 2, {FCVAR_ARCHIVE})

	if CLIENT then
		hook.Add("PopulateToolMenu", "VJ_ADDTOMENU_BLBOH", function()
			spawnmenu.AddToolMenuOption("DrVrej", "SNPC Configures", "Bean's Little Box of Horrors", "Bean's Little Box of Horrors", "", "", function(Panel)
				if !game.SinglePlayer() && !LocalPlayer():IsAdmin() then
					Panel:AddControl("Label", {Text = "#vjbase.menu.general.admin.not"})
					Panel:AddControl( "Label", {Text = "#vjbase.menu.general.admin.only"})
					return
				end
				Panel:AddControl("Button", {Text = "#vjbase.menu.general.reset.everything", Command = "vj_blboh_michael_killable 1\vj_blboh_michael_killable_timesneedtofendoff 2\vj_blboh_performance_mode 0\vj_blboh_spawn_sequences 1"})
				Panel:AddControl( "Label", {Text = "Please respawn any existing NPCs after changing stuff in here!"})

				-- local vj_blboh_reset = {Options = {}, CVars = {}, Label = "Gamemode-Accurate Preset:", MenuButton = "0"}
					-- vj_blboh_reset.Options["#vjbase.menugeneral.default"] = {
					-- vj_slashco_slashers_killable = "0",
				-- }
				-- Panel:AddControl("ComboBox", vj_blboh_reset)

				Panel:AddControl("Checkbox", {Label = "Enable Spawn Sequences?", Command = "vj_blboh_spawn_sequences"})

				Panel:AddControl("Checkbox", {Label = "Performance Mode?", Command = "vj_blboh_performance_mode"})
				Panel:ControlHelp("If this is enabled, we'll try to reduce particles and effects anywhere applicable.")

				Panel:AddControl("Checkbox", {Label = "Chupacabra is killable?", Command = "vj_blboh_michael_killable"})
				Panel:AddControl("Slider", {Label = "Total Chupacabra fend-offs:", Command = "vj_blboh_michael_killable_timesneedtofendoff", Min = 0, Max = 10})
				Panel:ControlHelp("This is the total ammount of times The Chupacabra has to be fended off before it's killable.")
				Panel:ControlHelp("You have to get it to leave by doing damage for the count to go down; having it stop because it got bored doesn't count.")
				Panel:ControlHelp("If the ConVar above this one is disabled, then this does nothing.")
				Panel:AddControl("Checkbox", {Label = "Chupacabra can be omniscient?", Command = "vj_blboh_michael_omniscience"})
				Panel:ControlHelp("If The Chupacabra's search patience meter runs out from not finding anyone for long enough, he'll be able to see where everyone is.")
				Panel:ControlHelp("Disabling this ConVar prevents him from doing that.")

				Panel:AddControl("Checkbox", {Label = "The Follower is killable?", Command = "vj_blboh_leonard_killable"})
				Panel:AddControl("Slider", {Label = "Total Follower fend-offs:", Command = "vj_blboh_leonard_killable_timesneedtofendoff", Min = 0, Max = 10})
				Panel:ControlHelp("This is the total ammount of times The Follower has to be fended off before it's killable.")
				Panel:ControlHelp("If the ConVar above this one is disabled, then this does nothing.")
			end)
		end)
	end

	/*
	examples
	
	Panel:AddControl("Checkbox", {Label = "", Command = ""})
	
	Panel:AddControl("Slider", {Label = "", Command = "", Min = 1, Max = 10000})

	local example_combobox = {Options = {}, CVars = {}, Label = "", MenuButton = "0"}
	example_combobox.Options["Default"] = {convar_name = 1}
	example_combobox.Options["Option 1"] = {convar_name = 2}
	example_combobox.Options["Option 2"] = {convar_name = 3}
	Panel:AddControl("ComboBox", example_combobox)
	
	Panel:ControlHelp("")
	
	Panel:AddControl( "Label", {Text = "Note: Only admins can change these settings!"})
	*/


	/*
	Credits
	- An average Beanmann: Main dev of this addon, creator of the majority of the NPCs in this pack, making spawnicons.
	- Warkin Iskander Volselli: Creator of all the NPCs in the Special Guests section, making the model for the Butcher, providing the Stalker's moving attack animations, providing the Horror's animations, foley sounds for The Follower, writing lore.
	- Smokey: Playtesting and feedback.
	- DrVrej: Creator of VJ Base.
	- Valve: Any and all Half-Life 2 and Left 4 Dead assets, Half-Life 2 Beta Stalker.
	- Stalker's behavior and some code for it was based on Crack-Life Resurgence's interpretation of Blackscary.
	- Darkborn: Follower's door breaking code taken from LNR.
	- Cide: Creator of Get a Life, which the Wretch and Preacher's models are from.
	- Dawson: Death model, used by Cultists.
	- Battlestate Games: EFT Cultist Knife.
	- We Create Stuff: Undead's model, body for Butcher's model.
	- Animations for the Undead are from No More Room In Hell and Call of Duty: WWII.
	- TeamPsykskallar: Taller animations, from Cry of Fear.
	- Preacher's spawn animations are from Call of Duty Zombies.
	- Vatra Games: Any and all assets relating to Silent Hill Downpour's Bogeyman.
	- Capcom: Leonard's footsteps, which are from the Resident Evil 2 Remake.
	- Airdorf Games: Any and all sounds from FAITH: The Unholy Trinity.
	- Cutmanmike: Sounds from Ghouls Forest 3.
	- Sounds for the Undead are from They Hunger: Lost Souls.
	*/


-- !!!!!! DON'T TOUCH ANYTHING BELOW THIS !!!!!! -------------------------------------------------------------------------------------------------------------------------
	AddCSLuaFile()
	VJ.AddAddonProperty(AddonName, AddonType)
else
	if CLIENT then
		chat.AddText(Color(0, 200, 200), AddonName,
		Color(0, 255, 0), " was unable to install, you are missing ",
		Color(255, 100, 0), "VJ Base!")
	end
	
	timer.Simple(1, function()
		if not VJBASE_ERROR_MISSING then
			VJBASE_ERROR_MISSING = true
			if CLIENT then
				// Get rid of old error messages from addons running on older code...
				if VJF && type(VJF) == "Panel" then
					VJF:Close()
				end
				VJF = true
				
				local frame = vgui.Create("DFrame")
				frame:SetSize(600, 160)
				frame:SetPos((ScrW() - frame:GetWide()) / 2, (ScrH() - frame:GetTall()) / 2)
				frame:SetTitle("Error: VJ Base is missing!")
				frame:SetBackgroundBlur(true)
				frame:MakePopup()
	
				local labelTitle = vgui.Create("DLabel", frame)
				labelTitle:SetPos(250, 30)
				labelTitle:SetText("VJ BASE IS MISSING!")
				labelTitle:SetTextColor(Color(255,128,128))
				labelTitle:SizeToContents()
				
				local label1 = vgui.Create("DLabel", frame)
				label1:SetPos(170, 50)
				label1:SetText("Garry's Mod was unable to find VJ Base in your files!")
				label1:SizeToContents()
				
				local label2 = vgui.Create("DLabel", frame)
				label2:SetPos(10, 70)
				label2:SetText("You have an addon installed that requires VJ Base but VJ Base is missing. To install VJ Base, click on the link below. Once\n                                                   installed, make sure it is enabled and then restart your game.")
				label2:SizeToContents()
				
				local link = vgui.Create("DLabelURL", frame)
				link:SetSize(300, 20)
				link:SetPos(195, 100)
				link:SetText("VJ_Base_Download_Link_(Steam_Workshop)")
				link:SetURL("https://steamcommunity.com/sharedfiles/filedetails/?id=131759821")
				
				local buttonClose = vgui.Create("DButton", frame)
				buttonClose:SetText("CLOSE")
				buttonClose:SetPos(260, 120)
				buttonClose:SetSize(80, 35)
				buttonClose.DoClick = function()
					frame:Close()
				end
			elseif (SERVER) then
				VJF = true
				timer.Remove("VJBASEMissing")
				timer.Create("VJBASE_ERROR_CONFLICT", 5, 0, function()
					print("VJ Base is missing! Download it from the Steam Workshop! Link: https://steamcommunity.com/sharedfiles/filedetails/?id=131759821")
				end)
			end
		end
	end)
end