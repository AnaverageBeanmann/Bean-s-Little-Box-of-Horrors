AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = {"models/vj_blboh/shepherd.mdl"}
-- ENT.StartHealth = 666
-- ENT.StartHealth = 2000
ENT.StartHealth = 6666
--------------------
ENT.VJ_NPC_Class = {"CLASS_DEMON"}
--------------------
ENT.BloodColor = VJ.BLOOD_COLOR_RED
ENT.MoveOrHideOnDamageByEnemy = false
--------------------
ENT.AnimTbl_MeleeAttack = {"vjseq_MeleeAttack01", "vjseq_melee_slice"}
ENT.TimeUntilMeleeAttackDamage = 0.7
--------------------
ENT.Weapon_NoSpawnMenu = true
ENT.Weapon_StrafeWhileFiring = false
ENT.Weapon_FindCoverOnReload  = false
--------------------
ENT.FootStepTimeRun = 0.25
ENT.FootStepTimeWalk = 0.5
ENT.SoundTbl_FootStep = {
	"npc/footsteps/hardboot_generic1.wav",
	"npc/footsteps/hardboot_generic2.wav",
	"npc/footsteps/hardboot_generic3.wav",
	"npc/footsteps/hardboot_generic4.wav",
	"npc/footsteps/hardboot_generic5.wav",
	"npc/footsteps/hardboot_generic6.wav",
	"npc/footsteps/hardboot_generic8.wav"
}
ENT.SoundTbl_RandomHellNoise = {
	"npc/zombie/zombie_voice_idle5.wav",
	"npc/zombie/zombie_voice_idle6.wav",
	"npc/zombie_poison/pz_alert1.wav",
	"npc/zombie_poison/pz_alert2.wav",
	"npc/zombie_poison/pz_call1.wav",
	"npc/zombie_poison/pz_throw2.wav",
	"npc/zombie_poison/pz_throw3.wav",
	"npc/fast_zombie/fz_alert_close1.wav",
	"npc/fast_zombie/fz_alert_far1.wav",
	"npc/fast_zombie/fz_frenzy1.wav",
	"npc/fast_zombie/fz_scream1.wav",
	"npc/antlion_guard/angry1.wav",
	"npc/antlion_guard/angry2.wav",
	"npc/antlion_guard/angry3.wav",
}
ENT.GeneralSoundPitch1 = 100
--------------------
-- use hlr tor for reference on how to do the spawning stuff
ENT.Tor_NextSpawnT = 0
--------------------
function ENT:Init()

	self.DisableFindEnemy = true
	self.CanInvestigate = false
	self:AddFlags(FL_NOTARGET)
	self.GodMode = true
	self.MovementType = VJ_MOVETYPE_STATIONARY
	self.CanTurnWhileStationary = false
	self:SetMaterial("hud/killicons/default")
	self:DrawShadow(false)
	self.HasSounds = false

	ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))
	ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))
	ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))
	ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))
	ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))
	ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))
	ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))
	ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))

	util.ScreenShake(self:GetPos(), 5, 5, 15, 350)

	PrintMessage(4,"-= A TERRIBLE FORCE HAS AWAKENED =-")

	VJ.EmitSound(self,{"npc/antlion/rumble1.wav"},90,50)

	timer.Simple(3,function() if IsValid(self) then

		self.ShepherdSpawnLight = ents.Create("light_dynamic")
		self.ShepherdSpawnLight:SetKeyValue("brightness", "5")
		self.ShepherdSpawnLight:SetKeyValue("distance", "500")
		self.ShepherdSpawnLight:SetLocalPos(self:GetPos())
		self.ShepherdSpawnLight:SetLocalAngles(self:GetAngles())
		self.ShepherdSpawnLight:Fire("Color", "255 0 0 255")
		self.ShepherdSpawnLight:SetParent(self)
		self.ShepherdSpawnLight:Spawn()
		self.ShepherdSpawnLight:Activate()
		self.ShepherdSpawnLight:Fire("SetParentAttachment","chest")
		self.ShepherdSpawnLight:Fire("TurnOn", "", 0)
		self:DeleteOnRemove(self.ShepherdSpawnLight)

		local ShepherdSpawnSprite_Glow = ents.Create("env_sprite")
		ShepherdSpawnSprite_Glow:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
		ShepherdSpawnSprite_Glow:SetKeyValue("scale", "1.5")
		ShepherdSpawnSprite_Glow:SetKeyValue("rendermode","5")
		ShepherdSpawnSprite_Glow:SetKeyValue("rendercolor","142 0 0 255")
		ShepherdSpawnSprite_Glow:SetKeyValue("spawnflags","1") -- If animated
		ShepherdSpawnSprite_Glow:SetParent(self)
		ShepherdSpawnSprite_Glow:Fire("SetParentAttachment", "chest")
		ShepherdSpawnSprite_Glow:Fire("Kill", "", 13)
		ShepherdSpawnSprite_Glow:Spawn()
		ShepherdSpawnSprite_Glow:Activate()
		self:DeleteOnRemove(ShepherdSpawnSprite_Glow)
		
		local ShepherdSpawnSprite_Flare = ents.Create("env_sprite")
		ShepherdSpawnSprite_Flare:SetKeyValue("model","sprites/blueflare1.vmt")
		ShepherdSpawnSprite_Flare:SetKeyValue("scale", "1.5")
		ShepherdSpawnSprite_Flare:SetKeyValue("rendermode","5")
		ShepherdSpawnSprite_Flare:SetKeyValue("rendercolor","255 0 0 255")
		ShepherdSpawnSprite_Flare:SetKeyValue("spawnflags","1") -- If animated
		ShepherdSpawnSprite_Flare:SetParent(self)
		ShepherdSpawnSprite_Flare:Fire("SetParentAttachment", "chest")
		ShepherdSpawnSprite_Flare:Fire("Kill", "", 13)
		ShepherdSpawnSprite_Flare:Spawn()
		ShepherdSpawnSprite_Flare:Activate()
		self:DeleteOnRemove(ShepherdSpawnSprite_Flare)
		
		local ShepherdSpawnSprite_Combine = ents.Create("env_sprite")
		ShepherdSpawnSprite_Combine:SetKeyValue("model","sprites/combineball_glow_black_1.vmt")
		ShepherdSpawnSprite_Combine:SetKeyValue("scale", "1")
		ShepherdSpawnSprite_Combine:SetKeyValue("rendermode","5")
		ShepherdSpawnSprite_Combine:SetKeyValue("rendercolor","255 0 0 255")
		ShepherdSpawnSprite_Combine:SetKeyValue("spawnflags","1") -- If animated
		ShepherdSpawnSprite_Combine:SetParent(self)
		ShepherdSpawnSprite_Combine:Fire("SetParentAttachment", "chest")
		ShepherdSpawnSprite_Combine:Fire("Kill", "", 13)
		ShepherdSpawnSprite_Combine:Spawn()
		ShepherdSpawnSprite_Combine:Activate()
		self:DeleteOnRemove(ShepherdSpawnSprite_Combine)

		ParticleEffectAttach("fire_medium_01_glow",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))

		self:Shepherd_PlayHellScream()

		VJ.EmitSound(self,{"npc/antlion/rumble1.wav"},90,50)

	end end)

	timer.Simple(6,function() if IsValid(self) then
		self:Shepherd_PlayHellScream()
		VJ.EmitSound(self,{"npc/antlion/rumble1.wav"},90,50)
	end end)

	timer.Simple(9,function() if IsValid(self) then
		self:Shepherd_PlayHellScream()
		VJ.EmitSound(self,{"npc/antlion/rumble1.wav"},90,50)
	end end)

	timer.Simple(11,function() if IsValid(self) then
		self:Shepherd_PlayHellScream()
		VJ.EmitSound(self,{"npc/antlion/rumble1.wav"},90,90)
	end end)

	timer.Simple(13,function() if IsValid(self) then

		VJ.EmitSound(self,{"npc/antlion/rumble1.wav"},90,90)

		self.ShepherdSpawnLight:Fire("Kill", "", 0)

		self.ShepherdJustAboutToSpawnLight = ents.Create("light_dynamic")
		self.ShepherdJustAboutToSpawnLight:SetKeyValue("brightness", "7")
		self.ShepherdJustAboutToSpawnLight:SetKeyValue("distance", "800")
		self.ShepherdJustAboutToSpawnLight:SetLocalPos(self:GetPos())
		self.ShepherdJustAboutToSpawnLight:SetLocalAngles(self:GetAngles())
		self.ShepherdJustAboutToSpawnLight:Fire("Color", "255 0 0 255")
		self.ShepherdJustAboutToSpawnLight:SetParent(self)
		self.ShepherdJustAboutToSpawnLight:Spawn()
		self.ShepherdJustAboutToSpawnLight:Activate()
		self.ShepherdJustAboutToSpawnLight:Fire("SetParentAttachment","chest")
		self.ShepherdJustAboutToSpawnLight:Fire("TurnOn", "", 0)
		self:DeleteOnRemove(self.ShepherdJustAboutToSpawnLight)

		VJ.EmitSound(self,"ambient/explosions/exp"..math.random(1,4)..".wav",100,100)
		VJ.EmitSound(self,"ambient/creatures/town_child_scream1.wav",100,math.random(60,70))
		self:Shepherd_PlayHellScream()

	end end)

	timer.Simple(15,function() if IsValid(self) then

		self.DisableFindEnemy = false
		self.CanInvestigate = true
		self:RemoveFlags(FL_NOTARGET)
		self.GodMode = false
		self.MovementType = VJ_MOVETYPE_GROUND
		self.CanTurnWhileStationary = true
		self:SetMaterial("")
		self:DrawShadow(true)
		self.HasSounds = true

		self:Give("weapon_vj_blboh_shepherd_gun")
		-- self:Give("weapon_vj_spas12")

		local CrucifixSprite_Glow = ents.Create("env_sprite")
		CrucifixSprite_Glow:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
		CrucifixSprite_Glow:SetKeyValue("scale", "0.1")
		CrucifixSprite_Glow:SetKeyValue("rendermode","5")
		CrucifixSprite_Glow:SetKeyValue("rendercolor","142 0 0 255")
		CrucifixSprite_Glow:SetKeyValue("spawnflags","1") -- If animated
		CrucifixSprite_Glow:SetParent(self)
		CrucifixSprite_Glow:Fire("SetParentAttachment", "crucifix")
		CrucifixSprite_Glow:Spawn()
		CrucifixSprite_Glow:Activate()
		self:DeleteOnRemove(CrucifixSprite_Glow)
		
		local CrucifixSprite_Flare = ents.Create("env_sprite")
		CrucifixSprite_Flare:SetKeyValue("model","sprites/blueflare1.vmt")
		CrucifixSprite_Flare:SetKeyValue("scale", "0.1")
		CrucifixSprite_Flare:SetKeyValue("rendermode","5")
		CrucifixSprite_Flare:SetKeyValue("rendercolor","255 0 0 255")
		CrucifixSprite_Flare:SetKeyValue("spawnflags","1") -- If animated
		CrucifixSprite_Flare:SetParent(self)
		CrucifixSprite_Flare:Fire("SetParentAttachment", "crucifix")
		CrucifixSprite_Flare:Spawn()
		CrucifixSprite_Flare:Activate()
		self:DeleteOnRemove(CrucifixSprite_Flare)
		
		local CrucifixSprite_Combine = ents.Create("env_sprite")
		CrucifixSprite_Combine:SetKeyValue("model","sprites/combineball_glow_black_1.vmt")
		CrucifixSprite_Combine:SetKeyValue("scale", "0.1")
		CrucifixSprite_Combine:SetKeyValue("rendermode","5")
		CrucifixSprite_Combine:SetKeyValue("rendercolor","255 0 0 255")
		CrucifixSprite_Combine:SetKeyValue("spawnflags","1") -- If animated
		CrucifixSprite_Combine:SetParent(self)
		CrucifixSprite_Combine:Fire("SetParentAttachment", "crucifix")
		CrucifixSprite_Combine:Spawn()
		CrucifixSprite_Combine:Activate()
		self:DeleteOnRemove(CrucifixSprite_Combine)

		self.CrucifixLight = ents.Create("light_dynamic")
		self.CrucifixLight:SetKeyValue("brightness", "2")
		self.CrucifixLight:SetKeyValue("distance", "200")
		self.CrucifixLight:SetLocalPos(self:GetPos())
		self.CrucifixLight:SetLocalAngles(self:GetAngles())
		self.CrucifixLight:Fire("Color", "255 0 0 255")
		self.CrucifixLight:SetParent(self)
		self.CrucifixLight:Spawn()
		self.CrucifixLight:Activate()
		self.CrucifixLight:Fire("SetParentAttachment","crucifix")
		self.CrucifixLight:Fire("TurnOn", "", 0)
		self:DeleteOnRemove(self.CrucifixLight)

		self.ShepherdJustAboutToSpawnLight:Fire("Kill", "", 0)

		self:StopParticles()
		ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))

		for k, v in ipairs(ents.FindByClass("player")) do
			v:ScreenFade(1,Color(125,0,0),3,0.1)
		end

		PrintMessage(4,"-= THE SHEPHERD IS HERE =-")

		VJ.EmitSound(self,"ambient/explosions/exp"..math.random(1,4)..".wav",100,100)
		VJ.EmitSound(self,"ambient/explosions/exp"..math.random(1,4)..".wav",85,100)
		VJ.EmitSound(self,"ambient/levels/labs/teleport_postblast_thunder1.wav",100,50)
		VJ.EmitSound(self,"weapons/physcannon/energy_sing_explosion2.wav",100,50)
		VJ.EmitSound(self,"ambient/creatures/town_zombie_call1.wav",0,30)
		VJ.EmitSound(self,"ambient/voices/playground_memory.wav",0,30)
		self:Shepherd_PlayHellScream()

	end end)

end
--------------------
function ENT:Shepherd_PlayHellScream()
	effects.BeamRingPoint(self:GetPos(), 0.80, 0, 175, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
	util.ScreenShake(self:GetPos(), 50, 5, 3, 750)
	VJ.EmitSound(self,"ambient/fire/ignite.wav",75,math.random(45,70))
	VJ.EmitSound(self,self.SoundTbl_RandomHellNoise,80,math.random(50,90))
end
--------------------
function ENT:OnAlert(ent)
		self:VJ_ACT_PLAYACTIVITY({"vjseq_idleangrytoshoot"},true,false)
end
--------------------
function ENT:SetAnimationTranslations(wepHoldType)
	self.BaseClass.SetAnimationTranslations(self, wepHoldType)
	if wepHoldType == "crossbow" or wepHoldType == "shotgun" then
		self.AnimationTranslations[ACT_RELOAD] = ACT_RELOAD_SMG1
		
		self.AnimationTranslations[ACT_IDLE] = ACT_IDLE
		self.AnimationTranslations[ACT_IDLE_ANGRY] = ACT_IDLE_ANGRY
		
		self.AnimationTranslations[ACT_WALK] = ACT_WALK_RIFLE
		self.AnimationTranslations[ACT_WALK_AIM] = ACT_WALK_AIM_RIFLE
		
		self.AnimationTranslations[ACT_RUN] = ACT_RUN_RIFLE
		self.AnimationTranslations[ACT_RUN_AIM] = ACT_RUN_AIM_RIFLE
		self.Weapon_CanCrouchAttack = false -- It shouldn't crouch when using a shotgun or crossbow hold types!
	else
		self.Weapon_CanCrouchAttack = true
	end
end
--------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
	if status == "Initial" then
		PrintMessage(4,"-= THE SHEPHERD IS GONE =-")
		for k, v in ipairs(ents.FindByClass("player")) do
			v:ScreenFade(1,Color(125,0,0),10,0.1)
		end
		VJ.EmitSound(self,{"npc/stalker/go_alert2.wav"},0,25)
	end
end
--------------------
function ENT:CustomOnRemove()
	-- If the NPC was removed, then remove its children as well, but not when it's killed!
	if !self.Dead then
		if IsValid(self.Tor_Ally1) then self.Tor_Ally1:Remove() end
		if IsValid(self.Tor_Ally2) then self.Tor_Ally2:Remove() end
		if IsValid(self.Tor_Ally3) then self.Tor_Ally3:Remove() end
	end
end