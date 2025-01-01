AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = {"models/vj_blboh/erectus.mdl"}
ENT.EntitiesToNoCollide = {"npc_vj_blboh_horror"}
-- ENT.StartHealth = 1000
ENT.StartHealth = 2000
ENT.HullType = HULL_LARGE
--------------------
ENT.VJ_NPC_Class = {"CLASS_DEMON"}
--------------------
ENT.BloodColor = "Oil"
-- ENT.BloodColor = VJ.BLOOD_COLOR_OIL
--------------------
-- ENT.MeleeAttackDamage = 10
ENT.HasMeleeAttackKnockBack = true
ENT.MeleeAttackDistance = 40
ENT.MeleeAttackDamageDistance = 60
ENT.TimeUntilMeleeAttackDamage = false
--------------------
ENT.HasRangeAttack = false
ENT.RangeAttackEntityToSpawn = "obj_vj_blboh_erectus_horrorball" -- The entity that is spawned when range attacking
ENT.AnimTbl_RangeAttack = {"vjseq_flinch"} -- Range Attack Animations
ENT.RangeDistance = 1000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 10 -- How close does it have to be until it uses melee?
ENT.RangeAttackAnimationFaceEnemy = false -- Should it face the enemy while playing the range attack animation?
ENT.RangeToMeleeDistance = 0 -- How close does it have to be until it uses melee?
ENT.TimeUntilRangeAttackProjectileRelease = 0.1 -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 8 -- How much time until it can use a range attack?
ENT.NextRangeAttackTime_DoRand = 10 -- False = Don't use random time | Number = Picks a random number between the regular timer and this timer
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "chest" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
--------------------
ENT.DisableFootStepSoundTimer = true
--------------------
ENT.HasDeathAnimation = true
ENT.AnimTbl_Death = {"vjseq_death"}
ENT.HasDeathRagdoll = false
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
-- ENT.SoundTbl_MeleeAttack = {
	-- "physics/body/body_medium_impact_hard1.wav",
	-- "physics/body/body_medium_impact_hard2.wav",
	-- "physics/body/body_medium_impact_hard3.wav",
	-- "physics/body/body_medium_impact_hard4.wav",
	-- "physics/body/body_medium_impact_hard5.wav",
	-- "physics/body/body_medium_impact_hard6.wav"
-- }
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
--------------------
		-- ENT.SoundTbl_MeleeAttackMiss = {"vj_blboh/erectus/taller_swing.wav"}
		-- ENT.SoundTbl_MeleeAttackExtra = {"vj_blboh/erectus/taller_player_punch.wav"}
--------------------
ENT.BLBOH_Erectus_Raged = false
ENT.BLBOH_Erectus_FogT = 0
ENT.BLBOH_Erectus_Spawning = true
ENT.BLBOH_SpawnLightLevel = "0"
ENT.BLBOH_HasPortal = false
--------------------
function ENT:Init()
	-- self:SetCollisionBounds(Vector(50, 50, 100), Vector(-50, -50, 0)) -- Collision bounds of the NPC | WARNING: All 4 Xs and Ys should be the same!
	-- self:SetSurroundingBounds(Vector(-300, -300, 0), Vector(300, 300, 500)) -- Damage bounds of the NPC, doesn't effect collision or OBB | NOTE: Only set this if the base one is not good enough! | Use "cl_ent_absbox" to view the bounds
	self:SetModelScale(2)
	self:SetCollisionBounds(Vector(8, 8, 60), Vector(-8, -8, 0))

	self.HasSounds = false
	util.ScreenShake(self:GetPos(), 5, 5, 10, 750)
	self:SetSolid(SOLID_NONE)
	self.HasMeleeAttack = false
	self.HasRangeAttack = false
	self.GodMode = true
	self.MovementType = VJ_MOVETYPE_STATIONARY
	self.CanTurnWhileStationary = false
	self:SetMaterial("hud/killicons/default")
	self:DrawShadow(false)
	self.DisableFindEnemy = true


	-- ParticleEffectAttach("fire_medium_01_glow",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("chest"))

	VJ.EmitSound(self,{"npc/antlion/rumble1.wav"},75,math.random(50,55))

	self.PreLaunchLight = ents.Create("light_dynamic")
	self.PreLaunchLight:SetKeyValue("brightness", "7.5")
	self.PreLaunchLight:SetKeyValue("distance", "0")
	self.PreLaunchLight:SetLocalPos(self:GetPos())
	self.PreLaunchLight:SetLocalAngles(self:GetAngles())
	self.PreLaunchLight:Fire("Color", "255 100 100 255")
	-- self.PreLaunchLight:SetKeyValue("style", 2)
	self.PreLaunchLight:SetParent(self)
	self.PreLaunchLight:Spawn()
	self.PreLaunchLight:Activate()
	self.PreLaunchLight:Fire("SetParentAttachment","chest")
	self.PreLaunchLight:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(self.PreLaunchLight)

	self.ChestGlow1 = ents.Create("env_sprite")
	self.ChestGlow1:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
	self.ChestGlow1:SetKeyValue("scale", "1.5")
	self.ChestGlow1:SetKeyValue("rendermode","5")
	self.ChestGlow1:SetKeyValue("rendercolor","255 100 100 255")
	self.ChestGlow1:SetKeyValue("spawnflags","1") -- If animated
	self.ChestGlow1:SetParent(self)
	self.ChestGlow1:Fire("SetParentAttachment", "chest")
	self.ChestGlow1:Fire("Kill", "", 13)
	self.ChestGlow1:Spawn()
	self.ChestGlow1:Activate()
	self:DeleteOnRemove(self.ChestGlow1)

	timer.Simple(1,function() if IsValid(self) then
		self.ChestGlow2 = ents.Create("env_sprite")
		self.ChestGlow2:SetKeyValue("model","sprites/blueflare1.vmt")
		self.ChestGlow2:SetKeyValue("scale", "1.5")
		self.ChestGlow2:SetKeyValue("rendermode","5")
		self.ChestGlow2:SetKeyValue("rendercolor","255 100 100 255")
		self.ChestGlow2:SetKeyValue("spawnflags","1") -- If animated
		self.ChestGlow2:SetParent(self)
		self.ChestGlow2:Fire("SetParentAttachment", "chest")
		self.ChestGlow2:Fire("Kill", "", 13)
		self.ChestGlow2:Spawn()
		self.ChestGlow2:Activate()
		self:DeleteOnRemove(self.ChestGlow2)
	end end)

	timer.Simple(3,function() if IsValid(self) then
		self.ChestGlow3 = ents.Create("env_sprite")
		self.ChestGlow3:SetKeyValue("model","sprites/combineball_glow_black_1.vmt")
		self.ChestGlow3:SetKeyValue("scale", "0.5")
		self.ChestGlow3:SetKeyValue("rendermode","5")
		self.ChestGlow3:SetKeyValue("rendercolor","255 100 100 255")
		self.ChestGlow3:SetKeyValue("spawnflags","1") -- If animated
		self.ChestGlow3:SetParent(self)
		self.ChestGlow3:Fire("SetParentAttachment", "chest")
		self.ChestGlow3:Spawn()
		self.ChestGlow3:Activate()
		self:DeleteOnRemove(self.ChestGlow3)
	end end)

	timer.Simple(5,function() if IsValid(self) then
		timer.Simple(0.1,function() if IsValid(self) then
			self.ChestGlow1:Fire("Kill", "", 0)
		end end)
		timer.Simple(0.3,function() if IsValid(self) then
			self.ChestGlow2:Fire("Kill", "", 0)
		end end)
		timer.Simple(0.3,function() if IsValid(self) then
			self.ChestGlow3:Fire("Kill", "", 0)
		end end)
		VJ.EmitSound(self,"ambient/explosions/exp"..math.random(1,4)..".wav",80,100)
		VJ.EmitSound(self,"ambient/explosions/exp"..math.random(1,4)..".wav",80,90)
		VJ.EmitSound(self,"weapons/physcannon/energy_sing_explosion2.wav",70,55)
		util.ScreenShake(self:GetPos(), 10, 10, 2.5, 1000)
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
		-- effects.BeamRingPoint(self:GetPos(), 0.80, 0, 200, 5, 5, Color(255, 100, 100), {material="sprites/physgbeamb", framerate=20})
		-- effects.BeamRingPoint(self:GetPos(), 0.80, 0, 400, 5, 5, Color(255, 100, 100), {material="sprites/physgbeamb", framerate=20})
		
		effects.BeamRingPoint(self:GetPos() + self:GetUp() * 50 + self:GetRight() * 0, 0.8, 0, 100, 5, 5, Color(255, 195, 195), {material="sprites/physgbeamb", framerate=20})
		effects.BeamRingPoint(self:GetPos() + self:GetUp() * 75 + self:GetRight() * 0, 0.8, 0, 150, 5, 5, Color(255, 195, 195), {material="sprites/physgbeamb", framerate=20})
		effects.BeamRingPoint(self:GetPos() + self:GetUp() * 100 + self:GetRight() * 0, 0.8, 0, 100, 5, 5, Color(255, 195, 195), {material="sprites/physgbeamb", framerate=20})
		
		self.BLBOH_Erectus_Spawning = false


		-- self:GivePortal()

	end end)
	timer.Simple(8,function() if IsValid(self) then
		self.HasRangeAttack = true
	end end)
	timer.Simple(10,function() if IsValid(self) then
		self.PreLaunchLight:Fire("Kill", "", 0)
	end end)

end
--------------------
function ENT:OnInput(key, activator, caller, data)
	if key == "step" then
		VJ.EmitSound(self,self.SoundTbl_FootStep,self.FootStepSoundLevel)
 -- util.ScreenShake( Vector pos, number amplitude, number frequency, number duration, number radius, boolean airshake = false )
		util.ScreenShake(self:GetPos(), 5, 5, 1, 350)
		-- self:RemovePortal()
	end
	if key == "attack" then
		self.MeleeAttackDamage = 50
		self.MeleeAttackDamageType = DMG_CLUB
		self.SoundTbl_MeleeAttack = {"vj_blboh/erectus/taller_player_punch.wav"}
		self.SoundTbl_MeleeAttackMiss = {"vj_blboh/erectus/taller_swing.wav"}
		self:MeleeAttackCode()
	end
	if key == "stomp" then

		self.MeleeAttackDamage = 150
		self.MeleeAttackDamageType = DMG_CRUSH
		self.SoundTbl_MeleeAttack = {"vj_blboh/erectus/taller_stamp.wav"}
		self.SoundTbl_MeleeAttackMiss = {"vj_blboh/erectus/taller_wall_punch.wav"}

		util.ScreenShake(self:GetPos(), 10, 5, 1, 350)

		self:MeleeAttackCode()

		VJ.ApplyRadiusDamage(self, self, self:GetPos() + self:GetForward() * 25 + self:GetRight() * 12, 200, 15, DMG_PHYSGUN, true, true, {DisableVisibilityCheck=true, Force=8110})
		effects.BeamRingPoint(self:GetPos() + self:GetForward() * 25 + self:GetRight() * 12, 0.80, 0, 200, 5, 5, Color(100, 100, 100), {material="sprites/physgbeamb", framerate=20})
		effects.BeamRingPoint(self:GetPos() + self:GetForward() * 25 + self:GetRight() * 12, 0.80, 0, 100, 5, 5, Color(100, 100, 100), {material="sprites/physgbeamb", framerate=20})
		effects.BeamRingPoint(self:GetPos() + self:GetForward() * 25 + self:GetRight() * 12, 0.80, 0, 300, 5, 5, Color(100, 100, 100), {material="sprites/physgbeamb", framerate=20})

		ParticleEffect("strider_impale_ground",self:GetPos() + self:GetForward() * 25 + self:GetRight() * 12,Angle(0,0,0),nil)
		ParticleEffect("strider_cannon_impact",self:GetPos() + self:GetForward() * 25 + self:GetRight() * 12,Angle(0,0,0),nil)

		VJ.EmitSound(self,{"ambient/machines/thumper_dust.wav"},100,math.random(100,90))

		local effectData = EffectData()
		-- effectData:SetOrigin(self:GetPos()+self:GetForward()*90+self:GetRight()*8)
		effectData:SetOrigin(self:GetPos())
		effectData:SetScale(200)
		util.Effect("ThumperDust", effectData)

		for _, v in ipairs(ents.FindInSphere(self:GetPos(), 150)) do
			if v:IsPlayer() and v:Alive() then
				v:SetLocalVelocity(v:GetVelocity()+Vector(0,0,300))
			end
		end

	end
	if key == "death" then

		local bloodeffect = EffectData()
		bloodeffect:SetOrigin(self:GetPos() + self:GetUp()*25 + self:GetForward()*50)
		bloodeffect:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
		bloodeffect:SetScale(200)
		util.Effect("VJ_Blood1",bloodeffect)
		local bloodeffect = EffectData()
		bloodeffect:SetOrigin(self:GetPos() + self:GetUp()*25 + self:GetForward()*-50)
		bloodeffect:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
		bloodeffect:SetScale(200)
		util.Effect("VJ_Blood1",bloodeffect)
		local bloodeffect = EffectData()
		bloodeffect:SetOrigin(self:GetPos() + self:GetUp()*25 + self:GetRight()*50)
		bloodeffect:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
		bloodeffect:SetScale(200)
		util.Effect("VJ_Blood1",bloodeffect)
		local bloodeffect = EffectData()
		bloodeffect:SetOrigin(self:GetPos() + self:GetUp()*25 + self:GetRight()*-50)
		bloodeffect:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
		bloodeffect:SetScale(200)
		util.Effect("VJ_Blood1",bloodeffect)

		VJ.ApplyRadiusDamage(self, self, self:GetPos(), 140, 20, DMG_PHYSGUN, false, true, {DisableVisibilityCheck=true, Force=8110})

		ParticleEffect("strider_impale_ground",self:GetPos(),Angle(0,0,0),nil)
		ParticleEffect("strider_cannon_impact",self:GetPos(),Angle(0,0,0),nil)

		VJ.EmitSound(self,{"ambient/machines/thumper_dust.wav"},100,math.random(100,90))
		VJ.EmitSound(self,{"vj_blboh/leonard/concrete_break2.wav"},80,math.random(50,40))

		local effectData = EffectData()
		-- effectData:SetOrigin(self:GetPos()+self:GetForward()*90+self:GetRight()*8)
		effectData:SetOrigin(self:GetPos())
		effectData:SetScale(200)
		util.Effect("ThumperDust", effectData)

		for _, v in ipairs(ents.FindInSphere(self:GetPos(), 140)) do
			if v:IsPlayer() and v:Alive() then
				v:SetLocalVelocity(v:GetVelocity()+Vector(0,0,350))
			end
		end

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
	timer.Simple(math.random(1,5),function() if IsValid(self) then
		self.HasRangeAttack = true
	end end)

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
			-- self.ErectusLight:SetKeyValue("distance", "1000")
			self.ErectusLight:Fire("Color", "255 0 0 255")
			self.ErectusChestSprite1:SetKeyValue("rendercolor","142 0 0 255")
			self.ErectusChestSprite2:SetKeyValue("rendercolor","255 0 0 255")
			self.ErectusChestSprite3:SetKeyValue("rendercolor","255 0 0 255")
		end
	end end)
end
--------------------
function ENT:RemovePortal()
			VJ.EmitSound(self,{"ambient/machines/machine1_hit"..math.random(1,2)..".wav"},80,math.random(90,110))
			
	-- if IsValid(self.ErectusChestSprite1) && IsValid(self.ErectusChestSprite2) && IsValid(self.ErectusChestSprite3) && IsValid(self.ErectusLight) then
		self.ErectusLight:Fire("Kill", "", 0)
		self.ErectusChestSprite1:Fire("Kill", "", 0.1)
		self.ErectusChestSprite2:Fire("Kill", "", 0.1)
		self.ErectusChestSprite3:Fire("Kill", "", 0.1)
		self.BLBOH_HasPortal = false
	-- end
end
--------------------
function ENT:OnThinkActive()

	if IsValid(self.PreLaunchLight) then
		self.PreLaunchLight:SetKeyValue("distance", self.BLBOH_SpawnLightLevel)
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

	-- if self.IsAbleToRangeAttack && !self.BLBOH_HasPortal && !self.Dead && !self.BLBOH_Erectus_Spawning then
	if !self.Dead && !self.BLBOH_HasPortal && self.IsAbleToRangeAttack && !self.BLBOH_Erectus_Spawning then
		self:GivePortal()
	end

	-- if self.BLBOH_Erectus_FogT < CurTime() && self.IsAbleToRangeAttack && !self.BLBOH_Erectus_Spawning then
		-- if self.BLBOH_Erectus_Raged then
			-- local bloodeffect = EffectData()
			-- bloodeffect:SetOrigin(self:GetAttachment(self:LookupAttachment("chest")).Pos)
			-- bloodeffect:SetColor(VJ_Color2Byte(Color(75,0,0,255)))
			-- bloodeffect:SetScale(15)
			-- util.Effect("VJ_Blood1",bloodeffect)
		-- else
			-- local bloodeffect = EffectData()
			-- bloodeffect:SetOrigin(self:GetAttachment(self:LookupAttachment("chest")).Pos)
			-- bloodeffect:SetColor(VJ_Color2Byte(Color(0,0,0,255)))
			-- bloodeffect:SetScale(15)
			-- util.Effect("VJ_Blood1",bloodeffect)
		-- end
		-- self.BLBOH_Erectus_FogT = CurTime() + 0.1
		-- self.BLBOH_Erectus_FogT = CurTime() + 1
	-- end

	if (self:Health() < (self:GetMaxHealth() * 0.5)) && !self.BLBOH_Erectus_Raged && !self.Dead && !IsValid(self.PreLaunchLight) then

		self.BLBOH_Erectus_Raged = true
		self.RangeAttackEntityToSpawn = "obj_vj_blboh_erectus_horrorball_rage"

		util.ScreenShake(self:GetPos(), 5, 10, 2, 700)

		self.HasBreathSound = true

		VJ.EmitSound(self,{"vj_blboh/erectus/enrage.wav"},100,100)
		VJ.EmitSound(self,{"vj_blboh/erectus/die.wav"},80,math.random(100,90))

		if IsValid(self.ErectusChestSprite1) && IsValid(self.ErectusChestSprite2) && IsValid(self.ErectusChestSprite3) && IsValid(self.ErectusLight) then -- see if we can replace this with just "if !self.BLBOH_HasPortal then"
			-- self.ErectusLight:SetKeyValue("distance", "1000")
			self.ErectusLight:Fire("Color", "255 0 0 255")
			self.ErectusChestSprite1:SetKeyValue("rendercolor","142 0 0 255")
			self.ErectusChestSprite2:SetKeyValue("rendercolor","255 0 0 255")
			self.ErectusChestSprite3:SetKeyValue("rendercolor","255 0 0 255")
		end

		self.EyeGlow1 = ents.Create("env_sprite")
		self.EyeGlow1:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
		self.EyeGlow1:SetKeyValue("scale", "0.05")
		self.EyeGlow1:SetKeyValue("rendermode","5")
		self.EyeGlow1:SetKeyValue("rendercolor","255 0 0 255")
		self.EyeGlow1:SetKeyValue("spawnflags","1") -- If animated
		self.EyeGlow1:SetParent(self)
		self.EyeGlow1:Fire("SetParentAttachment", "eyeglow1")
		self.EyeGlow1:Spawn()
		self.EyeGlow1:Activate()
		self:DeleteOnRemove(self.EyeGlow1)

		self.EyeGlow2 = ents.Create("env_sprite")
		self.EyeGlow2:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
		self.EyeGlow2:SetKeyValue("scale", "0.05")
		self.EyeGlow2:SetKeyValue("rendermode","5")
		self.EyeGlow2:SetKeyValue("rendercolor","255 0 0 255")
		self.EyeGlow2:SetKeyValue("spawnflags","1") -- If animated
		self.EyeGlow2:SetParent(self)
		self.EyeGlow2:Fire("SetParentAttachment", "eyeglow2")
		self.EyeGlow2:Spawn()
		self.EyeGlow2:Activate()
		self:DeleteOnRemove(self.EyeGlow2)

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

		-- local colorredd = Color(255,142,142,255)
		self:SetColor(Color(255,142,142,255))

		self.NextRangeAttackTime = 3 -- How much time until it can use a range attack?
		self.NextRangeAttackTime_DoRand = 5 -- False = Don't use random time | Number = Picks a random number between the regular timer and this timer

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
			self.EyeGlow1:Fire("Kill", "", 0.1)
			self.EyeGlow2:Fire("Kill", "", 0.1)
			self.RageMouthLight:Fire("Kill", "", 0)
			VJ.EmitSound(self,{"vj_blboh/erectus/enrageend.wav"},100,100)
		end
	end
	if status == "Finish" then
		local bloodeffect = EffectData()
		bloodeffect:SetOrigin(self:GetPos() + self:GetUp()*25)
		bloodeffect:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
		bloodeffect:SetScale(200)
		util.Effect("VJ_Blood1",bloodeffect)
	end
end
--------------------