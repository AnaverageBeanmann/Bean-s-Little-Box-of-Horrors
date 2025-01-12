AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = {"models/vj_blboh/erectus.mdl"}
ENT.EntitiesToNoCollide = {"npc_vj_blboh_horror"}
ENT.StartHealth = 2000
ENT.HullType = HULL_LARGE
--------------------
ENT.VJ_NPC_Class = {"CLASS_DEMON"}
--------------------
ENT.BloodColor = VJ.BLOOD_COLOR_OIL
--------------------
ENT.HasDeathAnimation = true
ENT.AnimTbl_Death = {"vjseq_death"}
ENT.HasDeathCorpse = false
--------------------
ENT.MeleeAttackDistance = 40
ENT.MeleeAttackDamageDistance = 60
ENT.TimeUntilMeleeAttackDamage = false
--------------------
ENT.RangeAttackEntityToSpawn = "obj_vj_blboh_erectus_horrorball"
ENT.AnimTbl_RangeAttack = {"vjseq_flinch"}
ENT.RangeDistance = 1000
ENT.RangeToMeleeDistance = 0
ENT.RangeAttackAnimationFaceEnemy = false
ENT.TimeUntilRangeAttackProjectileRelease = 0.1
ENT.NextRangeAttackTime = 8
ENT.NextRangeAttackTime_DoRand = 10
--------------------
ENT.DisableFootStepSoundTimer = true
--------------------
ENT.HasBreathSound = false
ENT.SoundTbl_FootStep = {"vj_blboh/erectus/taller_step.wav"}
ENT.SoundTbl_Breath = {"vj_blboh/erectus/rageloop.wav"}
ENT.SoundTbl_Idle = {
	"vj_blboh/erectus/chase1.wav",
	"vj_blboh/erectus/chase2.wav",
	"vj_blboh/erectus/chase3.wav",
	"vj_blboh/erectus/chase4.wav"
}
ENT.SoundTbl_BeforeMeleeAttack = {"vj_blboh/erectus/attack.wav"}
ENT.SoundTbl_Death = {"vj_blboh/erectus/die.wav"}
ENT.NextSoundTime_Breath = VJ.SET(1.05,1.05)
ENT.NextSoundTime_Idle = VJ.SET(1,2)
ENT.FootstepSoundLevel = 75
ENT.BreathSoundLevel = 70
ENT.BeforeMeleeAttackSoundLevel = 70
ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
ENT.DeathSoundPitch = VJ.SET(80, 70)
--------------------
ENT.BLBOH_Erectus_Raged = false
ENT.BLBOH_Erectus_FogT = 0
ENT.BLBOH_Erectus_Spawning = true
ENT.BLBOH_SpawnLightLevel = "0"
ENT.BLBOH_HasPortal = false
--------------------
function ENT:Init()

	self:SetModelScale(2)
	self:SetCollisionBounds(Vector(8, 8, 60), Vector(-8, -8, 0))

	self.DisableFindEnemy = true
	self.CanInvestigate = false
	self:AddFlags(FL_NOTARGET)
	self.GodMode = true
	self.MovementType = VJ_MOVETYPE_STATIONARY
	self.CanTurnWhileStationary = false
	self:SetMaterial("hud/killicons/default")
	self:DrawShadow(false)
	self.HasSounds = false

	self.SpawnLight = ents.Create("light_dynamic")
	self.SpawnLight:SetKeyValue("brightness", "7.5")
	self.SpawnLight:SetKeyValue("distance", "0")
	self.SpawnLight:SetLocalPos(self:GetPos())
	self.SpawnLight:SetLocalAngles(self:GetAngles())
	self.SpawnLight:Fire("Color", "255 100 100 255")
	self.SpawnLight:SetParent(self)
	self.SpawnLight:Spawn()
	self.SpawnLight:Activate()
	self.SpawnLight:Fire("SetParentAttachment","chest")
	self.SpawnLight:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(self.SpawnLight)

	self.SpawnSprite1 = ents.Create("env_sprite")
	self.SpawnSprite1:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
	self.SpawnSprite1:SetKeyValue("scale", "1.5")
	self.SpawnSprite1:SetKeyValue("rendermode","5")
	self.SpawnSprite1:SetKeyValue("rendercolor","255 100 100 255")
	self.SpawnSprite1:SetKeyValue("spawnflags","1") -- If animated
	self.SpawnSprite1:SetParent(self)
	self.SpawnSprite1:Fire("SetParentAttachment", "chest")
	self.SpawnSprite1:Fire("Kill", "", 13)
	self.SpawnSprite1:Spawn()
	self.SpawnSprite1:Activate()
	self:DeleteOnRemove(self.SpawnSprite1)

	util.ScreenShake(self:GetPos(), 5, 5, 10, 750)

	VJ.EmitSound(self,{"npc/antlion/rumble1.wav"},75,math.random(50,55))

	timer.Simple(1,function() if IsValid(self) then

		self.SpawnSprite2 = ents.Create("env_sprite")
		self.SpawnSprite2:SetKeyValue("model","sprites/blueflare1.vmt")
		self.SpawnSprite2:SetKeyValue("scale", "1.5")
		self.SpawnSprite2:SetKeyValue("rendermode","5")
		self.SpawnSprite2:SetKeyValue("rendercolor","255 100 100 255")
		self.SpawnSprite2:SetKeyValue("spawnflags","1") -- If animated
		self.SpawnSprite2:SetParent(self)
		self.SpawnSprite2:Fire("SetParentAttachment", "chest")
		self.SpawnSprite2:Fire("Kill", "", 13)
		self.SpawnSprite2:Spawn()
		self.SpawnSprite2:Activate()
		self:DeleteOnRemove(self.SpawnSprite2)

	end end)

	timer.Simple(3,function() if IsValid(self) then

		self.SpawnSprite3 = ents.Create("env_sprite")
		self.SpawnSprite3:SetKeyValue("model","sprites/combineball_glow_black_1.vmt")
		self.SpawnSprite3:SetKeyValue("scale", "0.5")
		self.SpawnSprite3:SetKeyValue("rendermode","5")
		self.SpawnSprite3:SetKeyValue("rendercolor","255 100 100 255")
		self.SpawnSprite3:SetKeyValue("spawnflags","1") -- If animated
		self.SpawnSprite3:SetParent(self)
		self.SpawnSprite3:Fire("SetParentAttachment", "chest")
		self.SpawnSprite3:Spawn()
		self.SpawnSprite3:Activate()
		self:DeleteOnRemove(self.SpawnSprite3)

	end end)

	timer.Simple(5,function() if IsValid(self) then

		self.DisableFindEnemy = false
		self.CanInvestigate = true
		self:RemoveFlags(FL_NOTARGET)
		self.GodMode = false
		self.MovementType = VJ_MOVETYPE_GROUND
		self.CanTurnWhileStationary = true
		self:SetMaterial("")
		self:DrawShadow(true)
		self.HasSounds = true

		self.BLBOH_Erectus_Spawning = false
		self.BLBOH_SpawnLightBoom = true

		self:StopParticles() -- i don't think we actually need this

		effects.BeamRingPoint(self:GetPos() + self:GetUp() * 50 + self:GetRight() * 0, 0.8, 0, 100, 5, 5, Color(255, 195, 195), {material="sprites/physgbeamb", framerate=20})
		effects.BeamRingPoint(self:GetPos() + self:GetUp() * 75 + self:GetRight() * 0, 0.8, 0, 150, 5, 5, Color(255, 195, 195), {material="sprites/physgbeamb", framerate=20})
		effects.BeamRingPoint(self:GetPos() + self:GetUp() * 100 + self:GetRight() * 0, 0.8, 0, 100, 5, 5, Color(255, 195, 195), {material="sprites/physgbeamb", framerate=20})

		util.ScreenShake(self:GetPos(), 10, 10, 2.5, 1000)

		VJ.EmitSound(self,"ambient/explosions/exp"..math.random(1,4)..".wav",80,100)
		VJ.EmitSound(self,"ambient/explosions/exp"..math.random(1,4)..".wav",80,90)
		VJ.EmitSound(self,"weapons/physcannon/energy_sing_explosion2.wav",70,55)

		timer.Simple(0.1,function() if IsValid(self) then

			self.SpawnSprite1:Fire("Kill", "", 0)

		end end)

		timer.Simple(0.3,function() if IsValid(self) then

			self.SpawnSprite2:Fire("Kill", "", 0)

		end end)

		timer.Simple(0.3,function() if IsValid(self) then

			self.SpawnSprite3:Fire("Kill", "", 0)

		end end)

	end end)

	timer.Simple(8,function() if IsValid(self) then

		self.HasRangeAttack = true -- do we need this?

	end end)

	timer.Simple(10,function() if IsValid(self) then

		self.SpawnLight:Fire("Kill", "", 0)

	end end)

end
--------------------
function ENT:OnInput(key, activator, caller, data)

	if key == "step" then

		util.ScreenShake(self:GetPos(), 5, 5, 1, 350)

		VJ.EmitSound(self,self.SoundTbl_FootStep,self.FootStepSoundLevel)

	end

	if key == "attack" then

		self.MeleeAttackDamage = 50
		self.MeleeAttackDamageType = DMG_CLUB
		self.HasMeleeAttackKnockBack = true

		self.SoundTbl_MeleeAttack = {"vj_blboh/erectus/taller_player_punch.wav"}
		self.SoundTbl_MeleeAttackMiss = {"vj_blboh/erectus/taller_swing.wav"}

		self:MeleeAttackCode()

	end

	if key == "stomp" then

		self.MeleeAttackDamage = 150
		self.MeleeAttackDamageType = DMG_CRUSH
		self.HasMeleeAttackKnockBack = false
		self.SoundTbl_MeleeAttack = {"vj_blboh/erectus/taller_stamp.wav"}
		self.SoundTbl_MeleeAttackMiss = {"vj_blboh/erectus/taller_wall_punch.wav"}

		self:MeleeAttackCode()

		VJ.ApplyRadiusDamage(self, self, self:GetPos() + self:GetForward() * 25 + self:GetRight() * 12, 200, 15, DMG_PHYSGUN, true, true, {DisableVisibilityCheck=true, Force=8110})

		for _, v in ipairs(ents.FindInSphere(self:GetPos(), 150)) do
			if v:IsPlayer() and v:Alive() then -- make this affect npcs, nextbots, and props
				v:SetLocalVelocity(v:GetVelocity()+Vector(0,0,300))
			end
		end

		util.ScreenShake(self:GetPos(), 10, 5, 1, 350)

		effects.BeamRingPoint(self:GetPos() + self:GetForward() * 25 + self:GetRight() * 12, 0.80, 0, 200, 5, 5, Color(100, 100, 100), {material="sprites/physgbeamb", framerate=20})
		effects.BeamRingPoint(self:GetPos() + self:GetForward() * 25 + self:GetRight() * 12, 0.80, 0, 100, 5, 5, Color(100, 100, 100), {material="sprites/physgbeamb", framerate=20})
		effects.BeamRingPoint(self:GetPos() + self:GetForward() * 25 + self:GetRight() * 12, 0.80, 0, 300, 5, 5, Color(100, 100, 100), {material="sprites/physgbeamb", framerate=20})

		ParticleEffect("strider_impale_ground",self:GetPos() + self:GetForward() * 25 + self:GetRight() * 12,Angle(0,0,0),nil)
		ParticleEffect("strider_cannon_impact",self:GetPos() + self:GetForward() * 25 + self:GetRight() * 12,Angle(0,0,0),nil)

		local ThumperDustEffectData = EffectData()
		ThumperDustEffectData:SetOrigin(self:GetPos()) -- make this appear at the foot?
		ThumperDustEffectData:SetScale(200)
		util.Effect("ThumperDust", ThumperDustEffectData)

		VJ.EmitSound(self,{"ambient/machines/thumper_dust.wav"},100,math.random(100,90))

	end

	if key == "death" then

		VJ.ApplyRadiusDamage(self, self, self:GetPos(), 140, 20, DMG_PHYSGUN, false, true, {DisableVisibilityCheck=true, Force=8110})

		for _, v in ipairs(ents.FindInSphere(self:GetPos(), 140)) do
			if v:IsPlayer() and v:Alive() then -- add npc nextbot and prop support blah blah blah
				v:SetLocalVelocity(v:GetVelocity()+Vector(0,0,350))
			end
		end

		local DeathFogEffect = EffectData()
		DeathFogEffect:SetOrigin(self:GetPos() + self:GetUp()*25 + self:GetForward()*50)
		DeathFogEffect:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
		DeathFogEffect:SetScale(200)
		util.Effect("VJ_Blood1",DeathFogEffect)
		DeathFogEffect:SetOrigin(self:GetPos() + self:GetUp()*25 + self:GetForward()*-50)
		util.Effect("VJ_Blood1",DeathFogEffect)
		DeathFogEffect:SetOrigin(self:GetPos() + self:GetUp()*25 + self:GetRight()*50)
		util.Effect("VJ_Blood1",DeathFogEffect)
		DeathFogEffect:SetOrigin(self:GetPos() + self:GetUp()*25 + self:GetRight()*-50)
		util.Effect("VJ_Blood1",DeathFogEffect)

		ParticleEffect("strider_impale_ground",self:GetPos(),Angle(0,0,0),nil)
		ParticleEffect("strider_cannon_impact",self:GetPos(),Angle(0,0,0),nil)

		local effectData = EffectData()
		effectData:SetOrigin(self:GetPos())
		effectData:SetScale(200)
		util.Effect("ThumperDust", effectData)

		-- make it stop playing its death sound too?
		VJ.EmitSound(self,{"ambient/machines/thumper_dust.wav"},100,math.random(100,90))
		VJ.EmitSound(self,{"vj_blboh/leonard/concrete_break2.wav"},80,math.random(50,40))

	end

end
--------------------
function ENT:TranslateActivity(act)
	if act == ACT_RUN && !self.BLBOH_Erectus_Raged then
		return ACT_WALK
	end
	return act
end
--------------------
function ENT:GivePortal()

	self.BLBOH_HasPortal = true

	self.HasRangeAttack = false

	VJ.EmitSound(self,{"vj_blboh/erectus/unfect.ogg"},85,math.random(90,110))

	timer.Simple(1,function() if IsValid(self) then

		self.ErectusLight = ents.Create("light_dynamic")
		self.ErectusLight:SetKeyValue("brightness", "5")
		self.ErectusLight:SetKeyValue("distance", "150")
		self.ErectusLight:SetLocalPos(self:GetPos())
		self.ErectusLight:SetLocalAngles(self:GetAngles())
		self.ErectusLight:Fire("Color", "100 100 100 255")
		self.ErectusLight:SetParent(self)
		self.ErectusLight:Spawn()
		self.ErectusLight:Activate()
		self.ErectusLight:Fire("SetParentAttachment","chest")
		self.ErectusLight:Fire("TurnOn", "", 0)
		self:DeleteOnRemove(self.ErectusLight)

		self.ErectusChestSprite1 = ents.Create("env_sprite")
		self.ErectusChestSprite1:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
		self.ErectusChestSprite1:SetKeyValue("scale", "0.35")
		self.ErectusChestSprite1:SetKeyValue("rendermode","5")
		self.ErectusChestSprite1:SetKeyValue("rendercolor","100 100 100 255")
		self.ErectusChestSprite1:SetKeyValue("spawnflags","1") -- If animated
		self.ErectusChestSprite1:SetParent(self)
		self.ErectusChestSprite1:Fire("SetParentAttachment", "chest")
		self.ErectusChestSprite1:Spawn()
		self.ErectusChestSprite1:Activate()
		self:DeleteOnRemove(self.ErectusChestSprite1)
		
		self.ErectusChestSprite2 = ents.Create("env_sprite")
		self.ErectusChestSprite2:SetKeyValue("model","sprites/blueflare1.vmt")
		self.ErectusChestSprite2:SetKeyValue("scale", "0.35")
		self.ErectusChestSprite2:SetKeyValue("rendermode","5")
		self.ErectusChestSprite2:SetKeyValue("rendercolor","100 100 100 255")
		self.ErectusChestSprite2:SetKeyValue("spawnflags","1") -- If animated
		self.ErectusChestSprite2:SetParent(self)
		self.ErectusChestSprite2:Fire("SetParentAttachment", "chest")
		self.ErectusChestSprite2:Spawn()
		self.ErectusChestSprite2:Activate()
		self:DeleteOnRemove(self.ErectusChestSprite2)
		
		self.ErectusChestSprite3 = ents.Create("env_sprite")
		self.ErectusChestSprite3:SetKeyValue("model","sprites/combineball_glow_black_1.vmt")
		self.ErectusChestSprite3:SetKeyValue("scale", "0.35")
		self.ErectusChestSprite3:SetKeyValue("rendermode","5")
		self.ErectusChestSprite3:SetKeyValue("rendercolor","255 0 0 255")
		self.ErectusChestSprite3:SetKeyValue("spawnflags","1") -- If animated
		self.ErectusChestSprite3:SetParent(self)
		self.ErectusChestSprite3:Fire("SetParentAttachment", "chest")
		self.ErectusChestSprite3:Spawn()
		self.ErectusChestSprite3:Activate()
		self:DeleteOnRemove(self.ErectusChestSprite3)

		if self.BLBOH_Erectus_Raged then

			self.ErectusLight:Fire("Color", "255 0 0 255")
			self.ErectusChestSprite1:SetKeyValue("rendercolor","142 0 0 255")
			self.ErectusChestSprite2:SetKeyValue("rendercolor","255 0 0 255")
			self.ErectusChestSprite3:SetKeyValue("rendercolor","255 0 0 255")

		end

	end end)

	timer.Simple(math.random(1,5),function() if IsValid(self) then

		self.HasRangeAttack = true

	end end)

end
--------------------
function ENT:RemovePortal()

	if !self.BLBOH_HasPortal then return end -- just incase this somehow runs while we don't have a portal

	self.BLBOH_HasPortal = false
			
	self.ErectusLight:Fire("Kill", "", 0)
	self.ErectusChestSprite1:Fire("Kill", "", 0.1)
	self.ErectusChestSprite2:Fire("Kill", "", 0.1)
	self.ErectusChestSprite3:Fire("Kill", "", 0.1)
			
	VJ.EmitSound(self,{"ambient/machines/machine1_hit"..math.random(1,2)..".wav"},80,math.random(90,110))

end
--------------------
function ENT:OnThinkActive()

	if IsValid(self.SpawnLight) then

		self.SpawnLight:SetKeyValue("distance", self.BLBOH_SpawnLightLevel)

		if !self.BLBOH_SpawnLightBoom then

			self.BLBOH_SpawnLightLevel = self.BLBOH_SpawnLightLevel + 3

		end

		if self.BLBOH_SpawnLightBoom then

			if self.BLBOH_SpawnLightFadeStage == 1 then

				self.BLBOH_SpawnLightLevel = self.BLBOH_SpawnLightLevel + 2.5

			elseif self.BLBOH_SpawnLightFadeStage == 2 then

				self.BLBOH_SpawnLightLevel = self.BLBOH_SpawnLightLevel - 7.5

			else

				self.BLBOH_SpawnLightLevel = self.BLBOH_SpawnLightLevel + 30

			end

			timer.Simple(0.25,function() if IsValid(self) && self.BLBOH_SpawnLightFadeStage != 1 then

				self.BLBOH_SpawnLightFadeStage = 1

			end end)

			timer.Simple(0.5,function() if IsValid(self) && self.BLBOH_SpawnLightFadeStage != 2 then

				self.BLBOH_SpawnLightFadeStage = 2

			end end)

		end

	end

	if !self.Dead && !self.BLBOH_HasPortal && self.IsAbleToRangeAttack && !self.BLBOH_Erectus_Spawning then
		self:GivePortal()
	end

	if (self:Health() < (self:GetMaxHealth() * 0.5)) && !self.BLBOH_Erectus_Raged && !self.Dead && !IsValid(self.SpawnLight) then

		self.BLBOH_Erectus_Raged = true

		self.RangeAttackEntityToSpawn = "obj_vj_blboh_erectus_horrorball_rage"

		self.NextRangeAttackTime = 3
		self.NextRangeAttackTime_DoRand = 5

		util.ScreenShake(self:GetPos(), 5, 10, 2, 700)

		self.HasBreathSound = true

		VJ.EmitSound(self,{"vj_blboh/erectus/enrage.wav"},100,100)
		VJ.EmitSound(self,{"vj_blboh/erectus/die.wav"},80,math.random(100,90))

		if IsValid(self.ErectusChestSprite1) && IsValid(self.ErectusChestSprite2) && IsValid(self.ErectusChestSprite3) && IsValid(self.ErectusLight) then -- see if we can replace this with just "if !self.BLBOH_HasPortal then"
			self.ErectusLight:Fire("Color", "255 0 0 255")
			self.ErectusChestSprite1:SetKeyValue("rendercolor","142 0 0 255")
			self.ErectusChestSprite2:SetKeyValue("rendercolor","255 0 0 255")
			self.ErectusChestSprite3:SetKeyValue("rendercolor","255 0 0 255")
		end

		self.EyeSprite1 = ents.Create("env_sprite")
		self.EyeSprite1:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
		self.EyeSprite1:SetKeyValue("scale", "0.05")
		self.EyeSprite1:SetKeyValue("rendermode","5")
		self.EyeSprite1:SetKeyValue("rendercolor","255 0 0 255")
		self.EyeSprite1:SetKeyValue("spawnflags","1") -- If animated
		self.EyeSprite1:SetParent(self)
		self.EyeSprite1:Fire("SetParentAttachment", "eyeglow1")
		self.EyeSprite1:Spawn()
		self.EyeSprite1:Activate()
		self:DeleteOnRemove(self.EyeSprite1)

		self.EyeSprite2 = ents.Create("env_sprite")
		self.EyeSprite2:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
		self.EyeSprite2:SetKeyValue("scale", "0.05")
		self.EyeSprite2:SetKeyValue("rendermode","5")
		self.EyeSprite2:SetKeyValue("rendercolor","255 0 0 255")
		self.EyeSprite2:SetKeyValue("spawnflags","1") -- If animated
		self.EyeSprite2:SetParent(self)
		self.EyeSprite2:Fire("SetParentAttachment", "eyeglow2")
		self.EyeSprite2:Spawn()
		self.EyeSprite2:Activate()
		self:DeleteOnRemove(self.EyeSprite2)

		self.RageMouthLight = ents.Create("light_dynamic")
		self.RageMouthLight:SetKeyValue("brightness", "3")
		self.RageMouthLight:SetKeyValue("distance", "300")
		self.RageMouthLight:SetLocalPos(self:GetPos())
		self.RageMouthLight:SetLocalAngles(self:GetAngles())
		self.RageMouthLight:Fire("Color", "255 0 0 255")
		self.RageMouthLight:SetParent(self)
		self.RageMouthLight:Spawn()
		self.RageMouthLight:Activate()
		self.RageMouthLight:Fire("SetParentAttachment","mouth")
		self.RageMouthLight:Fire("TurnOn", "", 0)
		self:DeleteOnRemove(self.RageMouthLight)

		self:SetColor(Color(255,142,142,255))

	end

end
--------------------
function ENT:MeleeAttackKnockbackVelocity(hitEnt)
	return self:GetForward() * 150 + self:GetUp() * 250
end
--------------------
function ENT:CustomRangeAttackCode_AfterProjectileSpawn(projectile)
	if self.BLBOH_HasPortal then
		self:RemovePortal()
	end
end
--------------------
function ENT:RangeAttackProjSpawnPos(projectile)
	return self:GetAttachment(self:LookupAttachment("chest")).Pos
end
--------------------
function ENT:RangeAttackProjVelocity(projectile)
	return (self:GetEnemy():GetPos() - self:GetPos()) *0.45 + self:GetUp() * math.random(-200,200) + self:GetRight() * math.random(-200,200)
end
--------------------
function ENT:OnDeath(dmginfo, hitgroup, status)

	if status == "Initial" then

		if self.BLBOH_HasPortal && IsValid(self.ErectusLight) then

			self:RemovePortal()

		end

		if self.BLBOH_Erectus_Raged then

			self.EyeSprite1:Fire("Kill", "", 0.1)
			self.EyeSprite1:Fire("Kill", "", 0.1)
			self.RageMouthLight:Fire("Kill", "", 0)
			VJ.EmitSound(self,{"vj_blboh/erectus/enrageend.wav"},100,100)

		end

	end

	if status == "Finish" then

		-- now that i think about it, do we actually need this?
		local DeathFogEffect = EffectData()
		DeathFogEffect:SetOrigin(self:GetPos() + self:GetUp()*25)
		DeathFogEffect:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
		DeathFogEffect:SetScale(200)
		util.Effect("VJ_Blood1",DeathFogEffect)

	end

end
--------------------