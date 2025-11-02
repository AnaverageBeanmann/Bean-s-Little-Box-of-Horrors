AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = "models/vj_blboh/semper.mdl"
ENT.StartHealth = 500
-- ENT.ControllerParams = {
	-- ThirdP_Offset = Vector(30, 0, -60), -- The offset for the controller when the camera is in third person
	-- FirstP_Bone = "Antlion.FangTopL1_Bone", -- If left empty, the base will attempt to calculate a position for first person
	-- FirstP_Offset = Vector(20, 0, 40), -- The offset for the controller when the camera is in first person
	-- FirstP_ShrinkBone = true, -- Should the bone shrink? Useful if the bone is obscuring the player's view
	-- FirstP_CameraBoneAng = 0, -- Should the camera's angle be affected by the bone's angle? | 0 = No, 1 = Pitch, 2 = Yaw, 3 = Roll
	-- FirstP_CameraBoneAng_Offset = 0, -- How much should the camera's angle be rotated by? | Useful for weird bone angles
-- }
--------------------
ENT.VJ_NPC_Class = {"CLASS_BLBOH"}
-- ENT.HasPoseParameterLooking = false
--------------------
-- ENT.BloodColor = VJ.BLOOD_COLOR_OIL
--------------------
ENT.HasDeathAnimation = true
ENT.AnimTbl_Death = {"vjseq_spawn"}
--------------------
-- ENT.MeleeAttackDamage = math.random(1,50)
-- ENT.MeleeAttackDamage = math.random(0,40)
-- ENT.MeleeAttackDamage = 5
ENT.AnimTbl_MeleeAttack = {"vjseq_shoot"}
-- ENT.MeleeAttackDamageType = DMG_CLUB
ENT.MeleeAttackDistance = 30
ENT.MeleeAttackDamageDistance = 45
ENT.TimeUntilMeleeAttackDamage = 0.1
--------------------
-- ENT.DisableFootStepSoundTimer = true
ENT.HasExtraMeleeAttackSounds = true
ENT.SoundTbl_FootStep = {
	"npc/footsteps/hardboot_generic1.wav",
	"npc/footsteps/hardboot_generic2.wav",
	"npc/footsteps/hardboot_generic3.wav",
	"npc/footsteps/hardboot_generic4.wav",
	"npc/footsteps/hardboot_generic5.wav",
	"npc/footsteps/hardboot_generic6.wav",
	"npc/footsteps/hardboot_generic8.wav",
	"npc/fast_zombie/foot1.wav",
	"npc/fast_zombie/foot2.wav",
	"npc/fast_zombie/foot3.wav",
	"npc/fast_zombie/foot4.wav",
	"player/footsteps/metalgrate1.wav",
	"player/footsteps/metalgrate2.wav",
	"player/footsteps/metalgrate3.wav",
	"player/footsteps/metalgrate4.wav",
}
ENT.SoundTbl_Breath = {
	"player/breathe1.wav",
	"ambient/music/mirame_radio_thru_wall.wav", -- css sound
	"ambient/alarms/city_siren_loop2.wav",
	"ambient/machines/spin_loop.wav",
	"ambient/machines/wall_loop1.wav",
	"ambient/machines/laundry_machine1_amb.wav",
	"ambient/wind/wind1.wav",
	"physics/wood/wood_plank_scrape_smooth_loop1.wav",
	"test/temp/soundscape_test/tv_music.wav",
	"test/temp/soundscape_test/cabin_wall.wav",
	"test/temp/soundscape_test/cabin_ambience.wav",
	"vehicles/tank_turret_loop1.wav",
	"npc/attack_helicopter/aheli_weapon_fire_loop3.wav",
	"ambient/atmosphere/tone_quiet.wav",
	"npc/attack_helicopter/aheli_crashing_loop1.wav",
	"ambient/alarms/train_crossing_bell_loop1.wav",
	"ambient/atmosphere/corridor.wav",
	"ambient/levels/citadel/citadel_drone_loop5.wav",
	"ambient/levels/citadel/drone1lp.wav",
	"vo/trainyard/cit_pacing.wav",
	"ambience/mechwhine.wav",
}
ENT.SoundTbl_Idle = {
	"vo/citadel/al_bitofit.wav",
	"vo/citadel/al_wonderwhere.wav",
	"vo/citadel/al_thereheis.wav",
	"vo/citadel/br_failing11.wav",
	"vo/citadel/br_laugh01.wav",
	"vo/citadel/br_oheli07.wav",
	"vo/citadel/br_oheli08.wav",
	"vo/citadel/br_youfool.wav",
	"vo/citadel/eli_goodgod.wav",
	"vo/citadel/eli_mygirl.wav",
	"vo/citadel/eli_notobreen.wav",
	"vo/citadel/eli_save.wav",
	"vo/citadel/gman_exit02.wav",
	"vo/canals/arrest_helpme.wav",
	"vo/canals/premassacre.wav",
	"vo/trainyard/wife_canttake.wav",
	"vo/trainyard/wife_end.wav",
	"vo/trainyard/wife_please.wav",
	"vo/trainyard/wife_whattodo.wav",
	"vo/trainyard/husb_okay.wav",
	"vo/trainyard/husb_dontworry.wav",
	"vo/trainyard/husb_allright.wav",
	"vo/trainyard/cit_window_look.wav",
	"vo/trainyard/male01/cit_bench01.wav",
	"vo/trainyard/male01/cit_bench02.wav",
	"vo/trainyard/male01/cit_bench03.wav",
	"vo/trainyard/male01/cit_bench04.wav",
	"vo/npc/male01/runforyourlife01.wav",
	"vo/npc/male01/runforyourlife02.wav",
	"vo/npc/male01/runforyourlife03.wav",
	"vo/npc/male01/no01.wav",
	"vo/npc/male01/no02.wav",
	"vo/npc/male01/moan01.wav",
	"vo/npc/male01/moan02.wav",
	"vo/npc/male01/moan03.wav",
	"vo/npc/male01/moan04.wav",
	"vo/npc/male01/moan05.wav",
	"vo/npc/male01/heretohelp01.wav",
	"buttons/blip1.wav",
	"buttons/button1.wav",
	"buttons/button2.wav",
	"buttons/button3.wav",
	"buttons/button4.wav",
	"buttons/button5.wav",
	"buttons/button6.wav",
	"buttons/button8.wav",
	"buttons/button9.wav",
	"buttons/button10.wav",
	"buttons/button14.wav",
	"buttons/button15.wav",
	"buttons/button16.wav",
	"buttons/button17.wav",
	"buttons/button18.wav",
	"buttons/button19.wav",
	"buttons/button24.wav",
	"common/wpn_select.wav",
	"common/wpn_moveselect.wav",
	"common/wpn_hudoff.wav",
	"common/wpn_hudoff.wav",
	"common/warning.wav",
	"common/bugreporter_succeeded.wav",
	"common/bugreporter_failed.wav",
	"ambient/voices/cough1.wav",
	"ambient/voices/cough2.wav",
	"ambient/voices/cough3.wav",
	"ambient/voices/cough4.wav",
	"vox/a.wav", -- hl1 sound
	"resource/warning.wav",
	"player/suit_denydevice.wav",
	"ambient/creatures/seagull_idle1.wav",
	"ambient/creatures/seagull_idle2.wav",
	"ambient/creatures/seagull_idle3.wav",
	"vo/ravenholm/monk_blocked01.wav",
	"npc/antlion_guard/foot_heavy1.wav",
	"hl1/fvox/fuzz.wav",
	"hl1/fvox/percent.wav",
	"ambient/machines/floodgate_move_short1.wav",
	"ambient/machines/thumper_top.wav",
	"ambient/water/drip2.wav",
	"npc/manhack/mh_blade_snick1.wav",
	"npc/metropolice/vo/gota10-107sendairwatch.wav",
	"npc/metropolice/vo/utlthatsuspect.wav",
	"ambient/wind/windgust.wav",
	"npc/combine_soldier/vo/eighty.wav",
	"npc/combine_soldier/vo/slash.wav",
	"npc/combine_soldier/vo/targetmyradial.wav",
	"vo/citadel/al_thatshim.wav",
	"vo/citadel/al_watchout01.wav",
	"vo/canals/arrest_stop.wav",
	"physics/wood/wood_box_impact_bullet4.wav",
	"physics/wood/wood_crate_impact_hard3.wav",
	"plats/bigstop1.wav",
	"plats/squeekstop1.wav",
	"npc/zombie/zombie_alert2.wav",
	"doors/default_locked.wav",
	"doors/door_metal_medium_close1.wav",
	"vo/npc/male01/heretohelp02.wav",
	"vo/npc/male01/ow02.wav",
	"vo/npc/male01/pain07.wav",
	"vo/novaprospekt/eli_getoutofhere.wav",
	"items/ammo_pickup.wav",
	"ui/buttonrollover.wav",
	"vehicles/crane/crane_magnet_switchon.wav",
	"physics/wood/wood_crate_break3.wav",
	"vo/citadel/br_create.wav",
	"npc/env_headcrabcanister/incoming.wav",
	"npc/metropolice/pain2.wav",
	"player/sprayer.wav",
	"items/flashlight1.wav",
	"items/suitchargeok1.wav",
	"music/radio1.mp3",
	"ambient/levels/streetwar/building_rubble1.wav",
	"friends/message.wav",
	"friends/friend_online.wav",
	"ambient/materials/vent_scurry_medium.wav",
	"vo/eli_lab/eli_handle.wav",
	"vo/eli_lab/eli_handle_b.wav",
	"vo/eli_lab/eli_staytogether02.wav",
	"vo/breencast/br_welcome07.wav",
	"vo/k_lab2/kl_howandwhen02.wav",
	"vo/k_lab/al_whatcat01.wav",
	"vo/trainyard/man_whereyoutakingme.wav",
	"vo/trainyard/husb_think.wav",
	"vo/trainyard/cit_water.wav",
	"vo/trainyard/cit_train_geton.wav",
	"vo/trainyard/cit_drunk.wav",
	"vo/trainyard/male01/cit_pedestrian03.wav",
	"ambient/creatures/town_child_scream1.wav",
	"ambient/creatures/town_moan1.wav",
	"ambient/energy/zap9.wav",
	"ambient/voices/playground_memory.wav",
	"ambient/atmosphere/metallic2.wav",
	"ambient/creatures/town_muffled_cry1.wav",
	"ambient/creatures/rats3.wav",
	"npc/stalker/go_alert2.wav",
	"npc/stalker/breathing3.wav",
	"npc/zombie_poison/pz_idle4.wav",
	"npc/zombie_poison/pz_call1.wav",
	"npc/roller/mine/rmine_chirp_quest1.wav",
	"npc/roller/mine/rmine_shockvehicle2.wav",
	"vo/eli_lab/al_dad_scared01.wav",
	"vo/eli_lab/mo_gowithalyx01.wav",
	"vo/npc/female01/watchout.wav",
	"vo/canals/shanty_badtime.wav",
	"weapons/smg1/smg1_fire1.wav",
	"weapons/rpg/shotdown.wav",
	"npc/overwatch/radiovoice/highpriorityregion.wav",
	"vo/coast/odessa/nlo_greet_nag01.wav",
	"vo/novaprospekt/al_backdown.wav",
	"npc/vort/vort_foot1.wav",
}
ENT.SoundTbl_Alert = {
	"doors/handle_pushbar_open1.wav",
	"doors/door_screen_move1.wav",
	"npc/combine_gunship/see_enemy.wav",
	"npc/strider/striderx_alert2.wav",
	"ambient/levels/labs/teleport_mechanism_windup1.wav",
	"items/suitchargeno1.wav",
	"ambient/alarms/train_horn2.wav",
	"ambient/levels/streetwar/gunship_distant2.wav",
	"vo/canals/matt_beglad_b.wav",
	"npc/vort/vort_explode1.wav",
	"npc/headcrab_poison/ph_pain2.wav",
	"ambient/fire/mtov_flame2.wav",
	"ambient/levels/coast/coastbird6.wav",
	"ambient/machines/heli_pass_quick2.wav",
}
ENT.SoundTbl_BeforeMeleeAttack = {
	"npc/zombie/zo_attack1.wav",
	"npc/barnacle/barnacle_digesting1.wav",
	"npc/barnacle/barnacle_tongue_pull2.wav",
	"npc/overwatch/radiovoice/404zone.wav",
	"weapons/pistol/pistol_fire2.wav",
	"weapons/grenade/tick1.wav",
	"vo/coast/odessa/male01/nlo_getyourjeep.wav",
	"vo/coast/barn/male01/youmadeit.wav",
	"vehicles/v8/v8_stop1.wav",
	"physics/glass/glass_impact_bullet2.wav",
	"physics/plastic/plastic_box_break1.wav",
	"npc/vort/vort_foot2.wav",
	"npc/antlion_guard/angry2.wav",
}
-- ENT.SoundTbl_MeleeAttack = {
	-- "npc/zombie/claw_strike1.wav",
	-- "npc/zombie/claw_strike2.wav",
	-- "npc/zombie/claw_strike3.wav"
-- }
ENT.SoundTbl_MeleeAttackExtra = {
	"npc/zombie_poison/pz_alert1.wav",
	"npc/headcrab_poison/ph_talk2.wav",
	"npc/roller/mine/rmine_predetonate.wav",
	"npc/attack_helicopter/aheli_charge_up.wav",
	"npc/footsteps/hardboot_generic1.wav",
	"npc/manhack/bat_away.wav",
	"npc/crow/hop1.wav",
	"ambient/levels/streetwar/city_battle1.wav",
	"ambient/creatures/pigeon_idle2.wav",
	"ambient/levels/coast/antlion_hill_ambient1.wav",
}
-- ENT.SoundTbl_MeleeAttackMiss = {
	-- "weapons/knife/knife_slash1.wav",
	-- "weapons/knife/knife_slash2.wav"
-- }
ENT.SoundTbl_RangeAttack = {
	"npc/strider/charging.wav",
	"ambient/atmosphere/city_skypass1.wav",
	"ambient/atmosphere/hole_hit2.wav",
	"ambient/atmosphere/hole_hit5.wav",
	"common/bugreporter_failed.wav",
	"vo/trainyard/cit_nerve.wav",
	"vo/coast/odessa/nlo_cub_carry.wav",
	"vo/ravenholm/monk_helpme01.wav",
	"weapons/cguard/charging.wav",
	"npc/sniper/sniper1.wav",
	"weapons/ar2/ar2_altfire.wav",
	"vo/novaprospekt/al_almostthere.wav",
	"vo/coast/barn/male01/chatter.wav",
	"npc/headcrab_poison/ph_poisonbite1.wav",
}
-- ENT.SoundTbl_Pain = {
	-- "npc/antlion/pain1.wav",
	-- "npc/metropolice/gear6.wav",
	-- "npc/fast_zombie/fz_scream1.wav",
	-- "npc/headcrab/attack1.wav",
	-- "npc/headcrab/alert1.wav",
	-- "npc/manhack/grind_flesh2.wav",
	-- "buttons/lever6.wav",
	-- "npc/metropolice/vo/acquiringonvisual.wav",
	-- "npc/turret_floor/active.wav",
	-- "npc/advisor/advisorheadvx05.wav",
	-- "npc/barnacle/barnacle_bark1.wav",
	-- "vo/eli_lab/airlock_cit01.wav",
	-- "beams/beamstart5.wav",
-- }
ENT.SoundTbl_Impact = {
	"npc/antlion/pain1.wav",
	"npc/metropolice/gear6.wav",
	"npc/fast_zombie/fz_scream1.wav",
	"npc/headcrab/attack1.wav",
	"npc/headcrab/alert1.wav",
	"npc/manhack/grind_flesh2.wav",
	"buttons/lever6.wav",
	"npc/metropolice/vo/acquiringonvisual.wav",
	"npc/turret_floor/active.wav",
	"npc/advisor/advisorheadvx05.wav",
	"npc/barnacle/barnacle_bark1.wav",
	"vo/eli_lab/airlock_cit01.wav",
	"beams/beamstart5.wav",
	"ambient/materials/platedrop1.wav",
	"ambient/machines/keyboard6_clicks.wav",
	"ambient/creatures/pigeon_idle2.wav",
	"npc/scanner/cbot_discharge1.wav",
	"npc/turret_floor/click1.wav",
	"friends/friend_join.wav",
	"physics/cardboard/cardboard_box_break1.wav",
	"physics/glass/glass_pottery_break1.wav",
	"physics/glass/glass_sheet_impact_soft3.wav",
	"plats/crane/vertical_stop.wav",
	"plats/bigstop1.wav",
	"common/bugreporter_failed.wav",
	"common/warning.wav",
	"doors/default_locked.wav",
	"doors/latchunlocked1.wav",
	"ambient/voices/squeal1.wav",
	"ambient/voices/f_scream1.wav",
	"ambient/voices/m_scream1.wav",
	"vo/citadel/br_youneedme.wav",
	"npc/zombie/zombie_pain4.wav",
	"ambient/materials/metal_groan.wav",
	"physics/wood/wood_box_impact_bullet4.wav",
	"physics/wood/wood_box_impact_hard2.wav",
	"physics/wood/wood_strain4.wav",
	"vo/ravenholm/monk_pain05.wav",
	"npc/strider/striderx_pain8.wav",
	"npc/zombie/zombie_pain6.wav",
	"npc/barnacle/barnacle_pull2.wav",
	"npc/roller/mine/rmine_tossed1.wav",
}
ENT.SoundTbl_Death = {
	"ambient/levels/labs/teleport_winddown1.wav",
	"ambient/materials/shipgroan1.wav",
	"ambient/materials/shipgroan3.wav",
	"plats/ttrain_brake1.wav",
	"common/bugreporter_failed.wav",
	"physics/wood/wood_crate_break1.wav",
	"vo/citadel/al_dadsorry.wav",
	"npc/stalker/go_alert2a.wav",
	"npc/zombie/zombie_die1.wav",
	"npc/env_headcrabcanister/explosion.wav",
	"npc/barnacle/barnacle_die1.wav",
}
ENT.ImpactSoundChance = 2
ENT.NextSoundTime_Idle = VJ.SET(0,1)
ENT.BreathSoundLevel = 80
ENT.ImpactSoundLevel = 80
ENT.MainSoundPitch = 100
ENT.ImpactSoundPitch = 100
-- ENT.BeforeMeleeAttackSoundPitch = VJ.SET(95, 120)
-- ENT.PainSoundPitch = VJ.SET(80,110)
-- ENT.DeathSoundPitch = VJ.SET(60, 100)
--------------------
ENT.BLBOH_DoSpawnSequence = false
ENT.BLBOH_CanDoSpawnSequence = true
ENT.BLBOH_Semper_ErrorVisible = false
ENT.BLBOH_Semper_TrueHP = 1
ENT.BLBOH_Semper_KillTheBastard = false
ENT.BLBOH_Semper_CorruptionLevel = 0
-- 0 - No Corruption
-- 1 - Visual Effects Light Mode
-- 2 - Visual Effects
-- 3 - Full Package
ENT.BLBOH_Semper_TextureTable = {
	"models/player/player_chrome1",
	"models/player/player_chrome1",
	"models/player/player_chrome1",
	"models/player/player_chrome1",
	"models/player/player_chrome1",
	"models/player/player_chrome1",
	"models/player/player_chrome1",
	"models/player/player_chrome1",
	"models/wireframe",
	"models/wireframe",
	"models/wireframe",
	"models/wireframe",
	"models/wireframe",
	"models/wireframe",
	"models/wireframe",
	"models/wireframe",
	"debug/debugempty",
	"debug/debugempty",
	"debug/debugempty",
	"debug/debugempty",
	"debug/debugempty",
	"debug/debugempty",
	"debug/debugempty",
	"debug/debugempty",
	"models/error/new light1",
	"models/error/new light1",
	"models/error/new light1",
	"models/error/new light1",
	"models/error/new light1",
	"models/error/new light1",
	"models/error/new light1",
	"models/error/new light1",
	"models/debug/debugwhite",
	"models/debug/debugwhite",
	"models/debug/debugwhite",
	"models/debug/debugwhite",
	"models/shadertest/shader3",
	"models/shadertest/shader3",
	"models/shadertest/shader3",
	"models/shadertest/shader3",
	"models/shadertest/shader4",
	"models/shadertest/shader4",
	"models/shadertest/shader4",
	"models/shadertest/shader4",
	"models/combine_advisor/lens",
	"models/combine_advisor/lens",
	"models/combine_advisor/lens",
	"models/combine_advisor/lens",
	"models/alyx/emptool_glow",
	"models/alyx/emptool_glow",
	"models/alyx/emptool_glow",
	"models/alyx/emptool_glow",
	"models/screenspace",
	"models/screenspace",
	"models/screenspace",
	"models/screenspace",
	"models/headcrab_classic/headcrabsheet",
	"models/headcrab_classic/headcrabsheet",
	"models/zombie_fast/fast_zombie_sheet",
	"models/zombie_fast/fast_zombie_sheet",
	"models/charple/charple1_sheet",
	"models/charple/charple1_sheet",
	"models/flesh",
	"models/flesh",
	"models/shadertest/vertexlitbumpedtexturewithselfillum",
	"models/shadertest/vertexlitbumpedtexturewithselfillum",
	"matsys_regressionqtest/background"
}
-- 8 = Common
-- 4 = Uncommon
-- 2 = Rare
-- 1 = Very Rare
ENT.BLBOH_Semper_PropCorruptionMaterials = {
	"models/player/player_chrome1",
	"models/wireframe",
	"debug/debugempty",
	"models/error/new light1"
}
ENT.BLBOH_Semper_DamageTypesTable = {
	DMG_GENERIC,
	DMG_CRUSH,
	DMG_BULLET,
	DMG_SLASH,
	DMG_BURN,
	DMG_VEHICLE,
	DMG_FALL,
	DMG_BLAST,
	DMG_CLUB,
	DMG_SHOCK,
	DMG_SONIC,
	DMG_ENERGYBEAM,
	DMG_PREVENT_PHYSICS_FORCE,
	DMG_NEVERGIB,
	DMG_ALWAYSGIB,
	DMG_DROWN,
	DMG_PARALYZE,
	DMG_NERVEGAS,
	DMG_POISON,
	DMG_RADIATION,
	DMG_DROWNRECOVER,
	DMG_ACID,
	DMG_SLOWBURN,
	DMG_REMOVENORAGDOLL,
	DMG_PHYSGUN,
	DMG_PLASMA,
	DMG_AIRBOAT,
	DMG_DISSOLVE,
	DMG_BLAST_SURFACE,
	DMG_DIRECT,
	DMG_BUCKSHOT,
	DMG_SNIPER,
	DMG_MISSILEDEFENSE
}
--------------------
function ENT:PreInit()
	if GetConVar("vj_blboh_spawn_sequences"):GetInt() == 1 && self.BLBOH_CanDoSpawnSequence then
		self.BLBOH_DoSpawnSequence = true
	end
	self.BLBOH_Semper_CorruptionLevel = GetConVar("vj_blboh_semper_corruptionlevel"):GetInt()
	if self.BLBOH_Semper_CorruptionLevel > 3 or self.BLBOH_Semper_CorruptionLevel < 0 then
		self.BLBOH_Semper_CorruptionLevel = 0 -- failsafe incase the value is set to some unsupported number
	end
end
--------------------
function ENT:Init()

	-- if self.BLBOH_DoSpawnSequence then
	-- end

	self.MeleeAttackDamageType = VJ.PICK(self.BLBOH_Semper_DamageTypesTable)

	timer.Simple(0.0001, function() if IsValid(self) then
		self.BLBOH_Semper_TrueHP = self:GetMaxHealth()
		-- PrintMessage(4,"true hp is "..self.BLBOH_Semper_TrueHP.."")
	end end)

end
--------------------
function ENT:OnThinkActive()
	if math.random(1,5) == 1 && !self.BLBOH_Semper_ErrorVisible then
		self:SetMaterial(VJ.PICK(self.BLBOH_Semper_TextureTable))
		if self.BLBOH_Semper_CorruptionLevel > 0 then
			for _, v in ipairs(ents.FindInSphere(self:GetPos(), 150)) do
				if v:GetClass() == "prop_physics" or v:GetClass() == "prop_ragdoll" then
					-- local originaltexture = v
					-- v:SetMaterial(VJ.PICK(self.BLBOH_Semper_PropCorruptionMaterials))
					-- timer.Simple(math.random(0.5,1.5), function() if IsValid(v) then
						-- v:SetMaterial("")
					-- end end)
				end
			end
		end
		if !self.BLBOH_Semper_ErrorVisible && math.random(1,15) == 1 && !self.BLBOH_Semper_KillTheBastard then
			self.BLBOH_Semper_ErrorVisible = true
			self:SetMaterial("hud/killicons/default")
			self:DrawShadow(false)
			self.SemperError = ents.Create("prop_dynamic")
			self.SemperError:SetModel("models/error.mdl")
			self.SemperError:SetLocalPos(self:GetPos())
			self.SemperError:SetLocalAngles(self:GetAngles())
			self.SemperError:SetOwner(self)
			self.SemperError:SetParent(self)
			self.SemperError:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
			self.SemperError:Spawn()
			self.SemperError:Activate()
			self.SemperError:SetSolid(SOLID_NONE)
			timer.Simple(math.random(0.1,1),function() if IsValid(self) && self.BLBOH_Semper_ErrorVisible then
				self.BLBOH_Semper_ErrorVisible = false
				self.SemperError:Remove()
				self:SetMaterial(VJ.PICK(self.BLBOH_Semper_TextureTable))
				self:DrawShadow(true)
			end end)
		end
	end
	if !self.BLBOH_Semper_KillTheBastard then
		self:SetHealth(math.random(1,9999))
		self:SetMaxHealth(math.random(1,9999))
	end
end
--------------------
-- function ENT:OnInput(key, activator, caller, data)
-- end
--------------------
function ENT:OnFootstepSound(moveType, sdFile)
	if math.random(1,3) == 1 then
		self.FootstepSoundTimerRun = self.FootstepSoundTimerRun + 0.1
	else
		self.FootstepSoundTimerRun = self.FootstepSoundTimerRun - 0.1
	end
	if self.FootstepSoundTimerRun >= 1 then
		self.FootstepSoundTimerRun = 0.5
	elseif self.FootstepSoundTimerRun <= 0.1  then
		if math.random(1,3) == 1 then
			self.FootstepSoundTimerRun = 0.5
		else
			self.FootstepSoundTimerRun = 0.1
		end
	end
	-- PrintMessage(4,"footstep timer is "..self.FootstepSoundTimerRun.."")
end
--------------------
-- function ENT:OnAlert(ent)
-- end
--------------------
function ENT:OnMeleeAttack(status, enemy)
	if status == "PreInit" then
		self.MeleeAttackDamage = math.random(0,40)
		self.MeleeAttackDamageType = VJ.PICK(self.BLBOH_Semper_DamageTypesTable)
		-- if math.random(1,3) == 1 then
			-- self.TimeUntilMeleeAttackDamage = self.TimeUntilMeleeAttackDamage - 1
		-- else
		-- end
		-- TimeUntilMeleeAttackDamage
	end
end
--------------------
-- function ENT:OnMeleeAttackExecute(status, ent, isProp)
-- end
--------------------
function ENT:OnDamaged(dmginfo, hitgroup, status)
	if status == "PreDamage" then
		self.BLBOH_Semper_TrueHP = self.BLBOH_Semper_TrueHP - dmginfo:GetDamage()
		-- PrintMessage(4,"true hp is "..self.BLBOH_Semper_TrueHP.."")
		if self.BLBOH_Semper_TrueHP <= 0 then
			self.BLBOH_Semper_KillTheBastard = true
			self:SetHealth(1)
			self:SetMaxHealth(1)
			if self.BLBOH_Semper_ErrorVisible then
				self.BLBOH_Semper_ErrorVisible = false
				self.SemperError:Remove()
				self:SetMaterial(VJ.PICK(self.BLBOH_Semper_TextureTable))
				self:DrawShadow(true)
			end
		else
			-- it's set up like this so semper doesn't die while he still has true hp
			if self:Health() > 1 then
				dmginfo:SetDamage(1)
			else
				dmginfo:SetDamage(0)
			end
		end
	elseif status == "PostDamage" then
		if math.random(1,25) == 1 then
			self:StopMoving(true)
		end
		-- self.NextPainSoundT = math.random(0,1)
	end
end
--------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
	if status == "Init" then
		self:Dissolve(0)
	end
end
--------------------
-- function ENT:Controller_Initialize(ply, controlEnt)
	-- ply:ChatPrint("MOUSE2: Dig")
	-- ply:ChatPrint("Digging puts you underground, making you slow and harmless, but immune to threats and you gain slow health regen")
	-- ply:ChatPrint("Click Mouse2 while underground to come back up to the surface.")
	-- ply:ChatPrint("JUMP + LEFT/RIGHT: Dodge")
	-- ply:ChatPrint("Hold JUMP and then press LEFT or Right to dodge in that direction.")
	-- ply:ChatPrint("RELOAD: Growl")
	-- timer.Simple(0.1, function() if IsValid(self) then
		-- self.BLBOH_Wretch_TauntCooldown = CurTime() - 15
		-- self.BLBOH_Wretch_DodgeCooldown = CurTime() - 15
	-- end end)
-- end
--------------------
-- function ENT:TranslateActivity(act)
	-- if act == ACT_RUN && self.BLBOH_Wretch_Underground then
		-- return ACT_WALK
	-- end
	-- return act
-- end