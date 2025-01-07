AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = "models/vj_blboh/cultist.mdl"
ENT.StartHealth = 100
ENT.VJC_Data = {
	CameraMode = 1,
	ThirdP_Offset = Vector(60, 15, -60),
}
--------------------
ENT.VJ_NPC_Class = {"CLASS_DEMON"}
--------------------
ENT.BloodColor = VJ.BLOOD_COLOR_RED
--------------------
ENT.MeleeAttackDistance = 35
ENT.MeleeAttackDamageDistance = 60
ENT.TimeUntilMeleeAttackDamage = false
ENT.MeleeAttackBleedEnemy = true
ENT.MeleeAttackBleedEnemyDamage = 1
ENT.MeleeAttackBleedEnemyTime = 0.5
ENT.MeleeAttackBleedEnemyReps = 8
--------------------
ENT.HasRangeAttack = true
ENT.RangeAttackEntityToSpawn = "obj_vj_blboh_cultist_knife_projectile"
ENT.RangeDistance = 350
ENT.RangeToMeleeDistance = 100
ENT.TimeUntilRangeAttackProjectileRelease = 0.42
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
	"vj_blboh/cultist/knife_slash1.wav",
	"vj_blboh/cultist/knife_slash2.wav"
}
ENT.SoundTbl_Death = {"vj_blboh/cultist/death.mp3"}
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
		if self:GetSequence() == 16 then -- stab
			self.MeleeAttackDamage = 15
			self.MeleeAttackBleedEnemyChance = 1
			self.SoundTbl_MeleeAttack = {"vj_blboh/cultist/knife_stab.wav"}
		else -- slash
			self.MeleeAttackDamage = 10
			self.MeleeAttackBleedEnemyChance = 3
			self.SoundTbl_MeleeAttack = {
				"vj_blboh/cultist/knife_hit1.wav",
				"vj_blboh/cultist/knife_hit2.wav",
				"vj_blboh/cultist/knife_hit3.wav",
				"vj_blboh/cultist/knife_hit4.wav"
			}
		end
		self:MeleeAttackCode()
	end
	if key == "throw" then
		-- self:RangeAttackCode()
	end
end
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

	self.SpawnLight = ents.Create("light_dynamic")
	self.SpawnLight:SetKeyValue("brightness", "7.5")
	self.SpawnLight:SetKeyValue("distance", "0")
	self.SpawnLight:SetLocalPos(self:GetPos())
	self.SpawnLight:SetLocalAngles(self:GetAngles())
	self.SpawnLight:Fire("Color", "255 0 0 255")
	self.SpawnLight:SetParent(self)
	self.SpawnLight:Spawn()
	self.SpawnLight:Activate()
	self.SpawnLight:Fire("SetParentAttachment","portal")
	self.SpawnLight:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(self.SpawnLight)

	self.SpawnSprite1 = ents.Create("env_sprite")
	self.SpawnSprite1:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
	self.SpawnSprite1:SetKeyValue("scale", "1.5")
	self.SpawnSprite1:SetKeyValue("rendermode","5")
	self.SpawnSprite1:SetKeyValue("rendercolor","142 0 0 255")
	self.SpawnSprite1:SetKeyValue("spawnflags","1") -- If animated
	self.SpawnSprite1:SetParent(self)
	self.SpawnSprite1:Fire("SetParentAttachment", "portal")
	self.SpawnSprite1:Fire("Kill", "", 13)
	self.SpawnSprite1:Spawn()
	self.SpawnSprite1:Activate()
	self:DeleteOnRemove(self.SpawnSprite1)

	ParticleEffectAttach("fire_medium_01_glow",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))

	util.ScreenShake(self:GetPos(), 5, 5, 5, 450)

	VJ.EmitSound(self,{"npc/antlion/rumble1.wav"},75,math.random(150,175))

	timer.Simple(1,function() if IsValid(self) then

		self.SpawnSprite2 = ents.Create("env_sprite")
		self.SpawnSprite2:SetKeyValue("model","sprites/blueflare1.vmt")
		self.SpawnSprite2:SetKeyValue("scale", "1.5")
		self.SpawnSprite2:SetKeyValue("rendermode","5")
		self.SpawnSprite2:SetKeyValue("rendercolor","255 0 0 255")
		self.SpawnSprite2:SetKeyValue("spawnflags","1") -- If animated
		self.SpawnSprite2:SetParent(self)
		self.SpawnSprite2:Fire("SetParentAttachment", "portal")
		self.SpawnSprite2:Fire("Kill", "", 13)
		self.SpawnSprite2:Spawn()
		self.SpawnSprite2:Activate()
		self:DeleteOnRemove(self.SpawnSprite2)

	end end)

	timer.Simple(2,function() if IsValid(self) then

		self.DisableFindEnemy = false
		self.CanInvestigate = true
		self:RemoveFlags(FL_NOTARGET)
		self.GodMode = false
		self.MovementType = VJ_MOVETYPE_GROUND
		self.CanTurnWhileStationary = true
		self:SetMaterial("")
		self:DrawShadow(true)
		self.HasSounds = true

		self.BLBOH_SpawnLightBoom = true

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

		self:StopParticles()
		effects.BeamRingPoint(self:GetPos() + self:GetUp() * 20, 0.5, 0, 40, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
		effects.BeamRingPoint(self:GetPos() + self:GetUp() * 40, 0.5, 0, 60, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
		effects.BeamRingPoint(self:GetPos() + self:GetUp() * 60, 0.5, 0, 40, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
		util.ScreenShake(self:GetPos(), 10, 5, 2.5, 300)

		VJ.EmitSound(self,"ambient/explosions/exp"..math.random(1,4)..".wav",80,100)
		VJ.EmitSound(self,"ambient/explosions/exp"..math.random(1,4)..".wav",80,100)
		VJ.EmitSound(self,"weapons/physcannon/energy_sing_explosion2.wav",70,75)

		timer.Simple(0.1,function() if IsValid(self) then
			self.SpawnSprite1:Fire("Kill", "", 0)
		end end)

		timer.Simple(0.3,function() if IsValid(self) then
			self.SpawnSprite2:Fire("Kill", "", 0)
		end end)

	end end)

	timer.Simple(4,function() if IsValid(self) then
		self.SpawnLight:Fire("Kill", "", 0)
	end end)

end
--------------------
function ENT:TranslateActivity(act)
	if act == ACT_RUN && self.BLBOH_Cultist_Sprinting then
		return ACT_SPRINT
	end
	return act
end
--------------------
function ENT:OnThink()

	if IsValid(self.SpawnLight) then

		self.SpawnLight:SetKeyValue("distance", self.BLBOH_SpawnLightLevel)

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

end
--------------------
function ENT:OnThinkActive()

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
	return self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos
end
--------------------
function ENT:RangeAttackProjVelocity(projectile)

	-- return (self:GetEnemy():GetPos() - self:GetPos()) * 2.5 + self:GetUp() * math.random(100,150) + self:GetRight() * math.random(-0,0) + (self:GetEnemy():GetVelocity() * 1)

	local phys = projectile:GetPhysicsObject()
	if IsValid(phys) && phys:IsGravityEnabled() then
		return VJ.CalculateTrajectory(self, self:GetEnemy(), "Line", projectile:GetPos(), 0.5, 1000)
	end

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