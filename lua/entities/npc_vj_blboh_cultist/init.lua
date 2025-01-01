AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = "models/vj_blboh/cultist.mdl"
ENT.StartHealth = 100
--------------------
ENT.VJ_NPC_Class = {"CLASS_DEMON"}
--------------------
ENT.BloodColor = "Red"
-- ENT.BloodColor = VJ.BLOOD_COLOR_RED
--------------------
ENT.MeleeAttackDamage = 15
ENT.MeleeAttackDistance = 35
ENT.MeleeAttackDamageDistance = 60
ENT.TimeUntilMeleeAttackDamage = false
ENT.MeleeAttackBleedEnemy = true
-- maybe try fiddling with these settings?
-- ENT.MeleeAttackBleedEnemyChance = 3 -- Chance that the enemy bleeds | 1 = always
ENT.MeleeAttackBleedEnemyDamage = 1 -- How much damage per repetition
ENT.MeleeAttackBleedEnemyTime = 0.5 -- How much time until the next repetition?
ENT.MeleeAttackBleedEnemyReps = 8 -- How many repetitions?
--------------------
ENT.HasRangeAttack = true
ENT.RangeAttackEntityToSpawn = "obj_vj_blboh_cultist_knife_projectile"
ENT.RangeDistance = 350
ENT.RangeToMeleeDistance = 100
ENT.TimeUntilRangeAttackProjectileRelease = false
-- ENT.NextRangeAttackTime = 3
ENT.NextRangeAttackTime_DoRand = 10
--------------------
ENT.DisableFootStepSoundTimer = true
ENT.SoundTbl_FootStep = {
	"npc/fast_zombie/foot1.wav",
	"npc/fast_zombie/foot2.wav",
	"npc/fast_zombie/foot3.wav",
	"npc/fast_zombie/foot4.wav"
}
ENT.SoundTbl_Alert = {
	"vj_blboh/cultist/burn_in_hell.mp3",
	"vj_blboh/cultist/destroy_the_child.mp3",
	"vj_blboh/cultist/reap_what_you_sow.mp3",
	"vj_blboh/cultist/swear_by_his_throne.mp3",
	"vj_blboh/cultist/thy_faith_is_weak.mp3",
	"vj_blboh/cultist/we_know_what_you_did.mp3"
}
ENT.SoundTbl_MeleeAttackMiss = {
	"weapons/knife/knife_slash1.wav",
	"weapons/knife/knife_slash2.wav"
}
ENT.SoundTbl_Death = {
	"vj_blboh/cultist/death.mp3"
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
--------------------
ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
--------------------
ENT.BLBOH_Cultist_Sprinting = false
ENT.BLBOH_SpawnLightLevel = "0"
ENT.BLBOH_SpawnLightBoom = false
ENT.BLBOH_SpawnLightFadeStage = 0
--------------------
function ENT:OnInput(key, activator, caller, data)
	if key == "step" then
		VJ.EmitSound(self,self.SoundTbl_FootStep,self.FootStepSoundLevel)
	end
	if key == "attack" then
		if self:GetSequence() == 16 then
			self.MeleeAttackDamage = 15
			self.MeleeAttackBleedEnemyChance = 1
			self.SoundTbl_MeleeAttack = {"weapons/knife/knife_stab.wav"}
		else
			self.MeleeAttackDamage = 10
			self.MeleeAttackBleedEnemyChance = 3
			-- we gotta get these sounds into the sounds folder
			self.SoundTbl_MeleeAttack = {
				"weapons/knife/knife_hit1.wav",
				"weapons/knife/knife_hit2.wav",
				"weapons/knife/knife_hit3.wav",
				"weapons/knife/knife_hit4.wav"
			}
		end
		self:MeleeAttackCode()
	end
	if key == "throw" then
		self:RangeAttackCode()
	end
end
--------------------
function ENT:Init()
	if math.random(1,5) == 1 then
		self:SetBodygroup(1,1)
		self:SetBodygroup(2,1)
	end
	if math.random(1,3) == 1 then
		self:SetBodygroup(6,1)
	end
	if math.random(1,3) == 1 then
		self:SetBodygroup(7,1)
	end
	self.HasSounds = false
	util.ScreenShake(self:GetPos(), 5, 5, 5, 450)
	self:SetSolid(SOLID_NONE)
	self.HasMeleeAttack = false
	self.GodMode = true
	self.MovementType = VJ_MOVETYPE_STATIONARY
	self.CanTurnWhileStationary = false
	self:SetMaterial("hud/killicons/default")
	self:DrawShadow(false)
	self.DisableFindEnemy = true

	ParticleEffectAttach("fire_medium_01_glow",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))

	VJ.EmitSound(self,{"npc/antlion/rumble1.wav"},75,math.random(150,175))

	self.PreLaunchLight = ents.Create("light_dynamic")
	self.PreLaunchLight:SetKeyValue("brightness", "7.5")
	self.PreLaunchLight:SetKeyValue("distance", "0")
	self.PreLaunchLight:SetLocalPos(self:GetPos())
	self.PreLaunchLight:SetLocalAngles(self:GetAngles())
	self.PreLaunchLight:Fire("Color", "255 0 0 255")
	-- self.PreLaunchLight:SetKeyValue("style", 2)
	self.PreLaunchLight:SetParent(self)
	self.PreLaunchLight:Spawn()
	self.PreLaunchLight:Activate()
	self.PreLaunchLight:Fire("SetParentAttachment","portal")
	self.PreLaunchLight:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(self.PreLaunchLight)

	self.ChestGlow1 = ents.Create("env_sprite")
	self.ChestGlow1:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
	self.ChestGlow1:SetKeyValue("scale", "1.5")
	self.ChestGlow1:SetKeyValue("rendermode","5")
	self.ChestGlow1:SetKeyValue("rendercolor","142 0 0 255")
	self.ChestGlow1:SetKeyValue("spawnflags","1") -- If animated
	self.ChestGlow1:SetParent(self)
	self.ChestGlow1:Fire("SetParentAttachment", "portal")
	self.ChestGlow1:Fire("Kill", "", 13)
	self.ChestGlow1:Spawn()
	self.ChestGlow1:Activate()
	self:DeleteOnRemove(self.ChestGlow1)

	timer.Simple(1,function() if IsValid(self) then
		self.ChestGlow2 = ents.Create("env_sprite")
		self.ChestGlow2:SetKeyValue("model","sprites/blueflare1.vmt")
		self.ChestGlow2:SetKeyValue("scale", "1.5")
		self.ChestGlow2:SetKeyValue("rendermode","5")
		self.ChestGlow2:SetKeyValue("rendercolor","255 0 0 255")
		self.ChestGlow2:SetKeyValue("spawnflags","1") -- If animated
		self.ChestGlow2:SetParent(self)
		self.ChestGlow2:Fire("SetParentAttachment", "portal")
		self.ChestGlow2:Fire("Kill", "", 13)
		self.ChestGlow2:Spawn()
		self.ChestGlow2:Activate()
		self:DeleteOnRemove(self.ChestGlow2)
	end end)

	timer.Simple(2,function() if IsValid(self) then
		timer.Simple(0.1,function() if IsValid(self) then
			self.ChestGlow1:Fire("Kill", "", 0)
		end end)
		timer.Simple(0.3,function() if IsValid(self) then
			self.ChestGlow2:Fire("Kill", "", 0)
		end end)
		VJ.EmitSound(self,"ambient/explosions/exp"..math.random(1,4)..".wav",80,100)
		VJ.EmitSound(self,"ambient/explosions/exp"..math.random(1,4)..".wav",80,100)
		VJ.EmitSound(self,"weapons/physcannon/energy_sing_explosion2.wav",70,75)
		util.ScreenShake(self:GetPos(), 10, 5, 2.5, 300)
		self:StopParticles()
		self:SetSolid(SOLID_BBOX)
		self.HasMeleeAttack = true
		self.GodMode = false
		self.MovementType = VJ_MOVETYPE_GROUND
		self.CanTurnWhileStationary = true
		self:SetMaterial("")
		self:DrawShadow(true)
		self.HasSounds = true
		self.DisableFindEnemy = false
		self.BLBOH_SpawnLightBoom = true
		-- effects.BeamRingPoint(self:GetPos(), 0.80, 0, 90, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
		-- effects.BeamRingPoint(self:GetPos(), 0.80, 0, 180, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
		effects.BeamRingPoint(self:GetPos() + self:GetUp() * 20, 0.5, 0, 40, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
		effects.BeamRingPoint(self:GetPos() + self:GetUp() * 40, 0.5, 0, 60, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
		effects.BeamRingPoint(self:GetPos() + self:GetUp() * 60, 0.5, 0, 40, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
		self.CultistKnifeModel = ents.Create("prop_physics")	
		self.CultistKnifeModel:SetModel("models/vj_blboh/cultist_knife.mdl")
		self.CultistKnifeModel:SetLocalPos(self:GetPos())
		self.CultistKnifeModel:SetLocalAngles(self:GetAngles())			
		self.CultistKnifeModel:SetOwner(self)
		self.CultistKnifeModel:SetParent(self)
		self.CultistKnifeModel:Fire("SetParentAttachmentMaintainOffset","anim_attachment_LH")
		self.CultistKnifeModel:Fire("SetParentAttachment","anim_attachment_RH")
		self.CultistKnifeModel:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
		self.CultistKnifeModel:Spawn()
		self.CultistKnifeModel:Activate()
		self.CultistKnifeModel:SetSolid(SOLID_NONE)
		self.CultistKnifeModel:AddEffects(EF_BONEMERGE)
	end end)
	timer.Simple(5,function() if IsValid(self) then
		self.PreLaunchLight:Fire("Kill", "", 0)
	end end)
end
--------------------
function ENT:Shepherd_PlayHellScream()
	effects.BeamRingPoint(self:GetPos(), 0.80, 0, 175, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
	VJ.EmitSound(self,"ambient/fire/ignite.wav",75,math.random(45,70))
	VJ.EmitSound(self,self.SoundTbl_RandomHellNoise,80,math.random(90,100))
	util.ScreenShake(self:GetPos(), 50, 5, 3, 750)
end
--------------------
function ENT:TranslateActivity(act)
	if act == ACT_RUN && self.BLBOH_Cultist_Sprinting then
		return ACT_SPRINT
	end
	return act
end
--------------------
function ENT:OnThinkActive()
	-- PrintMessage(4,""..self:GetSequence().."")
	if IsValid(self.PreLaunchLight) then
		self.PreLaunchLight:SetKeyValue("distance", self.BLBOH_SpawnLightLevel)
		if !self.BLBOH_SpawnLightBoom then
			self.BLBOH_SpawnLightLevel = self.BLBOH_SpawnLightLevel + 2.5
		end
		if self.BLBOH_SpawnLightBoom then
			if self.BLBOH_SpawnLightFadeStage == 1 then
				self.BLBOH_SpawnLightLevel = self.BLBOH_SpawnLightLevel + 2.5
			elseif self.BLBOH_SpawnLightFadeStage == 2 then
				self.BLBOH_SpawnLightLevel = self.BLBOH_SpawnLightLevel - 7.5
			else
				self.BLBOH_SpawnLightLevel = self.BLBOH_SpawnLightLevel + 15
			end
			timer.Simple(0.25,function() if IsValid(self) && self.BLBOH_SpawnLightFadeStage != 1 then
				self.BLBOH_SpawnLightFadeStage = 1
			end end)
			timer.Simple(0.5,function() if IsValid(self) && self.BLBOH_SpawnLightFadeStage != 2 then
				self.BLBOH_SpawnLightFadeStage = 2
			end end)
		end
	end
	-- check to make sure this isn't being spammed
	if self:GetEnemy() == nil then return end -- don't run this if we have no enemy
	if !self.BLBOH_Cultist_Sprinting && self:GetPos():Distance(self:GetEnemy():GetPos()) >= 300 then -- enemy is too far, start sprinting
		self.BLBOH_Cultist_Sprinting = true
	end
	if self.BLBOH_Cultist_Sprinting && self:GetPos():Distance(self:GetEnemy():GetPos()) < 300 then -- go back to running since we're close enough
		self.BLBOH_Cultist_Sprinting = false
	end
end
--------------------
function ENT:RangeAttackProjSpawnPos(projectile)
	return self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos -- Attachment example
	-- return self:GetPos() + self:GetUp() * 20
end
--------------------
function ENT:RangeAttackProjVelocity(projectile)
	return (self:GetEnemy():GetPos() - self:GetPos()) * 2.5 + self:GetUp() * math.random(150,200) + self:GetRight() * math.random(-10,10)
end
--------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
	if status == "Finish" then
		self:CreateGibEntity("prop_physics",self.CultistKnifeModel:GetModel(),{Pos=self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos,Ang=self:GetAngles()})
		self:SetBodygroup(1,1)
		self:SetBodygroup(2,1)
	end
end
--------------------