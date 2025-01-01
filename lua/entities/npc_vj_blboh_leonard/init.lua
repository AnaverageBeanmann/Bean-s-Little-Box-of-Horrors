AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = {"models/vj_blboh/leonard.mdl"}
ENT.StartHealth = 1000
-- ENT.HullType = HULL_HUMAN

ENT.VJ_NPC_Class = {"CLASS_DEMON"}

ENT.BloodColor = "Red"

ENT.AlwaysWander = true

-- ENT.CallForHelp = false

ENT.HasMeleeAttack = true
ENT.MeleeAttackDamageType = DMG_CRUSH
ENT.AnimTbl_MeleeAttack = {"vjseq_attack"}
ENT.MeleeAttackAnimationFaceEnemy = false
ENT.MeleeAttackDistance = 75
ENT.MeleeAttackDamageDistance = 110
ENT.TimeUntilMeleeAttackDamage = false

ENT.HasRangeAttack = true
ENT.AnimTbl_RangeAttack = {"vjseq_attack_range"}
ENT.RangeAttackAnimationFaceEnemy = false
ENT.TimeUntilRangeAttackProjectileRelease = false
ENT.RangeDistance = 1000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 0 -- How close does it have to be until it uses melee?
ENT.NextRangeAttackTime = 10 -- How much time until it can use any attack again? | Counted in Seconds
ENT.NextRangeAttackTime_DoRand = 20 -- False = Don't use random time | Number = Picks a random number between the regular timer and this timer
ENT.DisableDefaultLeapAttackDamageCode = true -- Disables the default leap attack damage code

-- ENT.AnimTbl_Walk = {ACT_RUN}

ENT.DisableFootStepSoundTimer = true

ENT.FootStepSoundLevel = 80
ENT.AlertSoundLevel = 100
ENT.IdleSoundLevel = 80
ENT.ExtraMeleeAttackSoundLevel = 80
ENT.MeleeAttackMissSoundLevel = 80
ENT.BeforeRangeAttackSoundLevel = 80

ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100

ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds

ENT.SoundTbl_FootStep = {
	"vj_blboh/leonard/step_1.mp3",
	"vj_blboh/leonard/step_2.mp3",
	"vj_blboh/leonard/step_3.mp3",
	"vj_blboh/leonard/step_4.mp3",
	"vj_blboh/leonard/step_5.mp3",
	"vj_blboh/leonard/step_6.mp3"
}
ENT.SoundTbl_Idle = {
	"vj_blboh/leonard/idle1.mp3",
	"vj_blboh/leonard/idle2.mp3"
}
ENT.SoundTbl_Alert = {
	"vj_blboh/leonard/alert1.mp3",
	"vj_blboh/leonard/alert2.mp3",
	"vj_blboh/leonard/alert3.mp3"
}
ENT.SoundTbl_MeleeAttack = {
	"vj_blboh/leonard/impact1.mp3",
	"vj_blboh/leonard/impact2.mp3"
}
ENT.SoundTbl_MeleeAttackExtra = {
	"vj_blboh/leonard/concrete_break2.wav",
	"vj_blboh/leonard/concrete_break3.wav"
}
ENT.SoundTbl_MeleeAttackMiss = {
	"vj_blboh/leonard/impact1.mp3",
	"vj_blboh/leonard/impact2.mp3"
}
ENT.SoundTbl_BeforeRangeAttack = {
	"vj_blboh/leonard/alert1.mp3",
	"vj_blboh/leonard/alert2.mp3",
	"vj_blboh/leonard/alert3.mp3"
}

ENT.BHLCIE_Follower_CurrentMode = 0
/*
0 - Attack Mode
1 - Hiding
*/
ENT.BHLCIE_Follower_HideTime = 0
ENT.BHLCIE_Follower_Difficulty = 1
/*
1 - Easy
2 - Medium
3 - Hard
*/
ENT.BHLCIE_Follower_UnCloaking = false
ENT.BHLCIE_Follower_Cloaking = false
ENT.BHLCIE_Follower_CloakLevel = 256
ENT.BHLCIE_Follower_ResetCloak = false
ENT.BHLCIE_Follower_Smoking = false
ENT.BHLCIE_Follower_SmokeTime = 0
ENT.BHLCIE_Follower_RangeLocation = nil
--------------------
function ENT:PreInit()
	-- self.AnimTbl_Run = {ACT_WALK}
	self.MeleeAttackDamage = 45
	-- self.BHLCIE_Follower_Difficulty = GetConVar("hl1_coop_sv_skill"):GetInt()
	if self.BHLCIE_Follower_Difficulty == 4 then
		self.BHLCIE_Follower_Difficulty = 3
	end
	if self.BHLCIE_Follower_Difficulty == 3 then -- Hard
		self.StartHealth = 3000
		-- self.AnimTbl_Run = {ACT_SPRINT}
		self.MeleeAttackDamage = 75
	elseif self.BHLCIE_Follower_Difficulty == 2 then -- Medium
		self.StartHealth = 2000
		-- self.AnimTbl_Run = {ACT_RUN}
		self.MeleeAttackDamage = 60
	end
	-- self.StartHealth = self.StartHealth * player.GetCount()
	-- self.StartHealth = self.StartHealth * player.GetCount() * 0.5
	self:SetHealth(self.StartHealth)
end
--------------------
function ENT:Init()

	self.GodMode = true
	self.MovementType = VJ_MOVETYPE_STATIONARY
	self.CanTurnWhileStationary = false
	self:SetMaterial("hud/killicons/default")
	self:DrawShadow(false)
	self.HasSounds = false
	self.HasMeleeAttack = false
	self.HasRangeAttack = false
	self:SetSolid(SOLID_NONE)

	timer.Simple(1,function() if IsValid(self) then

		VJ.EmitSound(self,"ambient/fire/ignite.wav",70,50)
		self.BHLCIE_Follower_Smoking = true

	end end)

	timer.Simple(5,function() if IsValid(self) then
		self:SetColor(Color(255, 255, 255, 0))
		self:VJ_ACT_PLAYACTIVITY({"vjseq_extra"},true,false,false)
		self.BHLCIE_Follower_UnCloaking = true
		self.GodMode = false
		self.MovementType = VJ_MOVETYPE_GROUND
		self.CanTurnWhileStationary = true
		self.HasMeleeAttack = true
		self.HasRangeAttack = true
		-- constraint.NoCollide(self,ents.FindByClass("npc_vj_*"))
	end end)

end
--------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	if key == "step" then
		if self.BHLCIE_Follower_CurrentMode == 0 then
			VJ.EmitSound(self,self.SoundTbl_FootStep,self.FootStepSoundLevel)
			util.ScreenShake(self:GetPos(), 5, 5, 1, 350)
		end
	end
	if key == "attack" then
		self:MeleeAttackCode()
	end
	if key == "attack_shockwave" then

		local pos = self:LocalToWorld(Vector(90,8,0))

		-- if self.BHLCIE_Follower_Difficulty == 3 then
			-- VJ.ApplyRadiusDamage(self, self, pos, 100, 20, DMG_CRUSH, true, true, {DisableVisibilityCheck=true, Force=8110})
		-- elseif self.BHLCIE_Follower_Difficulty == 2 then
			-- VJ.ApplyRadiusDamage(self, self, pos, 100, 15, DMG_CRUSH, true, true, {DisableVisibilityCheck=true, Force=8110})
		-- else
			VJ.ApplyRadiusDamage(self, self, pos, 100, 10, DMG_CRUSH, true, true, {DisableVisibilityCheck=true, Force=8110})
		-- end

		util.ScreenShake(self:GetPos(), 100, 200, 3, 500)

		for _, v in ipairs(ents.FindInSphere(pos, 100)) do
			if v:IsPlayer() and v:Alive() then
				v:SetLocalVelocity(v:GetVelocity()+Vector(0,0,350))
			end
		end

		ParticleEffect("strider_impale_ground",pos,Angle(0,0,0),nil)
		ParticleEffect("strider_cannon_impact",pos,Angle(0,0,0),nil)

		VJ.EmitSound(self,{"ambient/machines/thumper_dust.wav"},100,math.random(100,90))

		local effectData = EffectData()
		effectData:SetOrigin(self:GetPos()+self:GetForward()*90+self:GetRight()*8)
		effectData:SetScale(200)
		util.Effect("ThumperDust", effectData)

	end
	if key == "follower_raise" then
		VJ.EmitSound(self,"vj_blboh/leonard/raiseweapon"..math.random(1,4)..".mp3",75)
	end
	if key == "follower_woosh" then
		VJ.EmitSound(self,"vj_blboh/leonard/swing"..math.random(1,4)..".mp3",75)
	end
	if key == "follower_requip" then
		VJ.EmitSound(self,"vj_blboh/leonard/lowerweapon"..math.random(1,4)..".mp3",75)
	end
	if key == "follower_rumble" then

		if !IsValid(self:GetEnemy()) then return end

		self.dummyEnt = ents.Create("prop_dynamic")
		if IsValid(self.dummyEnt) then
			self.dummyEnt:SetPos(self:GetEnemy():GetPos())
			self.dummyEnt:SetModel("models/Gibs/HGIBS.mdl")
			self.dummyEnt:Spawn()
			self.dummyEnt:SetMoveType(MOVETYPE_NONE)
			self.dummyEnt:SetSolid(SOLID_NONE)

			self.dummyEnt:SetMaterial("models/debug/debugwhite")
			self.dummyEnt:SetRenderFX( 16 )
			self.dummyEnt:SetRenderMode( RENDERMODE_TRANSCOLOR )
			self.dummyEnt:SetColor(Color(255, 0, 0, 255))
			effects.BeamRingPoint(self.dummyEnt:GetPos()+self.dummyEnt:GetUp()*5, 0.80, 0, 200, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
			timer.Simple(0.80,function() if IsValid(self.dummyEnt) then
				effects.BeamRingPoint(self.dummyEnt:GetPos()+self.dummyEnt:GetUp()*5, 0.80, 0, 200, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
			end end)
			timer.Simple(1.60,function() if IsValid(self.dummyEnt) then
				effects.BeamRingPoint(self.dummyEnt:GetPos()+self.dummyEnt:GetUp()*5, 0.80, 0, 200, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
			end end)

			VJ.EmitSound(self.dummyEnt,{"npc/antlion/rumble1.wav"},70,math.random(100,90))
			util.ScreenShake(self.dummyEnt:GetPos(), 100, 100, 5, 250)
			timer.Simple(2.5,function() if IsValid(self.dummyEnt) then

				-- if self.BHLCIE_Follower_Difficulty == 3 then
					-- VJ.ApplyRadiusDamage(self, self, self.dummyEnt:GetPos(), 175, 40, DMG_CRUSH, true, true, {DisableVisibilityCheck=true, Force=8110, UpForce=8110})
				-- elseif self.BHLCIE_Follower_Difficulty == 2 then
					-- VJ.ApplyRadiusDamage(self, self, self.dummyEnt:GetPos(), 175, 30, DMG_CRUSH, true, true, {DisableVisibilityCheck=true, Force=8110, UpForce=8110})
				-- else
					VJ.ApplyRadiusDamage(self, self, self.dummyEnt:GetPos(), 175, 20, DMG_CRUSH, true, true, {DisableVisibilityCheck=true, Force=8110, UpForce=8110})
				-- end

				util.ScreenShake(self.dummyEnt:GetPos(), 175, 200, 3, 500)

				for _, v in ipairs(ents.FindInSphere(self.dummyEnt:GetPos(), 175)) do
					if v:IsPlayer() and v:Alive() then
						v:SetLocalVelocity(v:GetVelocity()+Vector(0,0,500))
					end
				end

				ParticleEffect("strider_impale_ground",self.dummyEnt:GetPos(),Angle(0,0,0),nil)
				ParticleEffect("strider_cannon_impact",self.dummyEnt:GetPos(),Angle(0,0,0),nil)

				VJ.EmitSound(self.dummyEnt,{"ambient/machines/thumper_dust.wav"},100,math.random(100,90))
				VJ.EmitSound(self.dummyEnt,{"vj_blboh/leonard/concrete_break"..math.random(2,3)..".wav"},100,math.random(100,90))

				local effectData = EffectData()
				effectData:SetOrigin(self.dummyEnt:GetPos())
				effectData:SetScale(250)
				util.Effect("ThumperDust", effectData)

				self.dummyEnt:Remove()
			end end)
		end
	end
	if key == "whoosh" then
		VJ.EmitSound(self,"physics/nearmiss/whoosh_huge2.wav",75)
	end
	if key == "follower_shhh" then
		VJ.EmitSound(self,"vj_blboh/leonard/idle"..math.random(1,2)..".mp3",80,100)
	end
end
--------------------
function ENT:TranslateActivity(act)
	-- have him sprint when you're too far and run when you're close enough
	-- if act == ACT_IDLE then
		-- return ACT_IDLE_ON_FIRE
	-- end
	-- if act == ACT_WALK || act == ACT_RUN then
		-- return ACT_WALK_ON_FIRE
	-- end
	return act
end
--------------------
function ENT:OnThink()

	if self.BHLCIE_Follower_UnCloaking == true then
		if !self.BHLCIE_Follower_ResetCloak then
			self.BHLCIE_Follower_ResetCloak = true
			self.BHLCIE_Follower_CloakLevel = 0
			self:SetRenderMode( RENDERMODE_TRANSCOLOR )
			self:SetMaterial("")
		end
		self.BHLCIE_Follower_CloakLevel = self.BHLCIE_Follower_CloakLevel + 5
		self:SetColor(Color(255, 255, 255, self.BHLCIE_Follower_CloakLevel))
		if self.BHLCIE_Follower_CloakLevel >= 255 then
			self.BHLCIE_Follower_UnCloaking = false
			self:SetColor(Color(255, 255, 255, 255))
			self:DrawShadow(true)
			self.HasSounds = true
			self:SetSolid(SOLID_BBOX)

			self.CanTurnWhileStationary = true
			self.HasMeleeAttack = true
			self.HasRangeAttack = true
			self.HasSounds = true
			self.GodMode = false

		end
	end

	if self.BHLCIE_Follower_Cloaking == true then
		if !self.BHLCIE_Follower_ResetCloak then
			self.BHLCIE_Follower_ResetCloak = true
			self.BHLCIE_Follower_CloakLevel = 255
			self:SetRenderMode( RENDERMODE_TRANSCOLOR )
		end
		self.BHLCIE_Follower_CloakLevel = self.BHLCIE_Follower_CloakLevel - 5
		self:SetColor(Color(255, 255, 255, self.BHLCIE_Follower_CloakLevel))
		if self.BHLCIE_Follower_CloakLevel <= 0 then
			self.BHLCIE_Follower_Cloaking = false
			self:SetColor(Color(255, 255, 255, 0))
			self:DrawShadow(false)
			self.HasSounds = false
		end
	end

	if self.BHLCIE_Follower_Smoking == true then
		if self.BHLCIE_Follower_SmokeTime < CurTime() then
			ParticleEffect("generic_smoke",self:GetPos(),self:GetAngles(),self)
			self.BHLCIE_Follower_SmokeTime = CurTime() + 1
		end
		timer.Simple(10,function() if IsValid(self) then
			self.BHLCIE_Follower_Smoking = false
			self:SetSolid(SOLID_BBOX)
		end end)
	end

end
--------------------
function ENT:OnThinkActive()

	if self.BHLCIE_Follower_CurrentMode == 1 then -- we're hiding

		if self.BHLCIE_Follower_HideTime < CurTime() then

			self.BHLCIE_Follower_CurrentMode = 0

			timer.Simple(1,function() if IsValid(self) then

				self.BHLCIE_Follower_ResetCloak = false

				self.BHLCIE_Follower_UnCloaking = true

				-- self:SetPos(Vector(1937.447021, -243.794281, 256.031250))

				-- self.MovementType = VJ_MOVETYPE_GROUND

				self:VJ_ACT_PLAYACTIVITY({"vjseq_extra"},true,false,false)

				VJ.EmitSound(self,"ambient/fire/ignite.wav",70,50)

				timer.Simple(0.01,function() if IsValid(self) then
					self.BHLCIE_Follower_Smoking = true
					self:RemoveFlags(FL_NOTARGET)
					self.HasSounds = false
					self.Behavior = VJ_BEHAVIOR_AGGRESSIVE
				end end)

			end end)

		end

	end

end
--------------------
function ENT:OnDamaged(dmginfo, hitgroup, status)
	if status == "PreDamage" then
		if (self:Health() - dmginfo:GetDamage()) <= 0 && self.Dead == false then -- if we take lethal damage then..

			dmginfo:ScaleDamage(0) -- to avoid him actually dying

			self:DrawShadow(false)

			VJ.EmitSound(self,"ambient/fire/ignite.wav",70,50)
			self.BHLCIE_Follower_Smoking = true

			self.BHLCIE_Follower_Cloaking = true
			self.BHLCIE_Follower_ResetCloak = false

			self:SetSolid(SOLID_NONE)

			self:VJ_ACT_PLAYACTIVITY({"vjseq_extra"},true,false,false) -- rename this function and all other instances of it to PlayAnim
			-- self.MovementType = VJ_MOVETYPE_STATIONARY
			self.HasMeleeAttack = false
			self.HasRangeAttack = false
			self.HasSounds = false
			-- self.Behavior = VJ_BEHAVIOR_AGGRESSIVE
			self.Behavior = VJ_BEHAVIOR_PASSIVE
			self:AddFlags(FL_NOTARGET)

			self:SetHealth(self.StartHealth)
			self.GodMode = true
			timer.Simple(0.15, function() if IsValid(self) then
				self:SetHealth(self.StartHealth)
			end end)

			timer.Simple(5,function() if IsValid(self) then
				if self.BHLCIE_Follower_Difficulty == 3 then
					self.BHLCIE_Follower_HideTime = CurTime() + math.random(60,180)
				elseif self.BHLCIE_Follower_Difficulty == 2 then
					self.BHLCIE_Follower_HideTime = CurTime() + math.random(90,240)
				else
					-- self.BHLCIE_Follower_HideTime = CurTime() + math.random(120,300)
					self.BHLCIE_Follower_HideTime = CurTime() + math.random(10,10)
					-- self.BHLCIE_Follower_HideTime = CurTime() + math.random(5,10)
				end
				-- self:SetPos(Vector(4365.166016, 10242.131836, -6495.968750))
				self.BHLCIE_Follower_CurrentMode = 1
			end end)

		end
	end
end
--------------------
function ENT:OnDeath(dmginfo, hitgroup, status) -- just incase this happens somehow
	if status == "Finish" then
		if IsValid(self.dummyEnt) then
			self.dummyEnt:StopParticles()
			self.dummyEnt:Remove()
		end
	end
end
--------------------
function ENT:CustomOnRemove()
	if IsValid(self.dummyEnt) then
		self.dummyEnt:StopParticles()
		self.dummyEnt:Remove()
	end
end
--------------------