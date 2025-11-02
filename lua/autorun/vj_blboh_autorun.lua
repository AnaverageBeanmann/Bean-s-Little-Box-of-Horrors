local AddonName = "Bean's Little Box of Horrors"
local AddonType = "NPC"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')

	local vCat = "Bean's Little Box of Horrors"
	VJ.AddCategoryInfo(vCat, {Icon = "icons/vj_icon_blboh.png"})

	-- The Old Blood
	VJ.AddNPC("Cultist","npc_vj_blboh_cultist",vCat)
	VJ.AddNPC("Wretch","npc_vj_blboh_wretch",vCat)
	VJ.AddNPC("Horror","npc_vj_blboh_horror",vCat)
	VJ.AddNPC("Stalker","npc_vj_blboh_stalker",vCat)
	VJ.AddNPC("Preacher","npc_vj_blboh_preacher",vCat)
	VJ.AddNPC("Erectus","npc_vj_blboh_erectus",vCat)
	VJ.AddNPC("Chupacabra","npc_vj_blboh_chupacabra",vCat)

	-- The New Blood
	VJ.AddNPC("Forlorn","npc_vj_blboh_forlorn",vCat)
	VJ.AddNPC("Crunatus","npc_vj_blboh_crunatus",vCat)
	VJ.AddNPC("The Psycho","npc_vj_blboh_psycho",vCat)

	-- Non-Canons
	VJ.AddNPC("Semper","npc_vj_blboh_semper",vCat)
	VJ.AddNPC("Heavy","npc_vj_blboh_heavy",vCat)

	VJ.AddConVar("vj_blboh_spawn_sequences", 1, {FCVAR_ARCHIVE})
	VJ.AddConVar("vj_blboh_heavy_altmusic", 0, {FCVAR_ARCHIVE})

	if CLIENT then
		hook.Add("PopulateToolMenu", "VJ_ADDTOMENU_BLBOH", function()
			spawnmenu.AddToolMenuOption("DrVrej", "SNPC Configures", "Bean's Little Box of Horrors", "Bean's Little Box of Horrors", "", "", function(Panel)
				if !game.SinglePlayer() && !LocalPlayer():IsAdmin() then
					Panel:AddControl("Label", {Text = "#vjbase.menu.general.admin.not"})
					Panel:AddControl( "Label", {Text = "#vjbase.menu.general.admin.only"})
					return
				end
				Panel:AddControl( "Label", {Text = "These changes only affect NPCs spawned AFTER the changes are made!"})
				Panel:AddControl("Button", {Text = "#vjbase.menu.general.reset.everything", Command = "vj_blboh_spawn_sequences 1"})

				Panel:AddControl("Checkbox", {Label = "Enable Spawn Sequences?", Command = "vj_blboh_spawn_sequences"})

				Panel:AddControl("Checkbox", {Label = "Alternate Heavy Ambience?", Command = "vj_blboh_heavy_altmusic"})
				Panel:ControlHelp("If enabled, Heavy will use the ambience from Custom Mode, instead of the ambience from Turbine.")
			end)
		end)
	end

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