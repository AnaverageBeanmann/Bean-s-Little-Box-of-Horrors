AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = "models/vj_blboh/heavy.mdl"
ENT.StartHealth = 300
ENT.ControllerParams = {
	ThirdP_Offset = Vector(40, 0, -40), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "bip_head", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(0, 0, 0), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = true, -- Should the bone shrink? Useful if the bone is obscuring the player's view
	FirstP_CameraBoneAng = 0, -- Should the camera's angle be affected by the bone's angle? | 0 = No, 1 = Pitch, 2 = Yaw, 3 = Roll
	FirstP_CameraBoneAng_Offset = 0, -- How much should the camera's angle be rotated by? | Useful for weird bone angles
}
--------------------
ENT.UsePoseParameterMovement = true
--------------------
ENT.EnemyTimeout = 8
ENT.AlertTimeout = VJ.SET(8, 8) -- vrej why does this have to be vj.set aaaaa
ENT.VJ_NPC_Class = {"CLASS_BLBOH"}
-- ENT.InvestigateSoundMultiplier = 13.5 -- might be too much
ENT.InvestigateSoundMultiplier = 18 -- might be too much
--------------------
ENT.GodMode = true
-- ENT.BloodColor = VJ.BLOOD_COLOR_OIL
--------------------
ENT.HasMeleeAttack = false
ENT.MeleeAttackDamage = 0
ENT.AnimTbl_MeleeAttack = false
ENT.MeleeAttackDistance = 60
ENT.MeleeAttackAngleRadius = 15
ENT.MeleeAttackDamageDistance  = 70
ENT.MeleeAttackDamageAngleRadius = 15
ENT.NextMeleeAttackTime = 0.1


-- ENT.MeleeAttackDamageType = DMG_CLUB
-- ENT.MeleeAttackDistance = 75
-- ENT.MeleeAttackDamageDistance = 90
ENT.TimeUntilMeleeAttackDamage = 0.1
--------------------
-- ENT.DisableFootStepSoundTimer = true
ENT.FootstepSoundTimerWalk = 0.2
ENT.FootstepSoundTimerRun = 0.2
ENT.HasBreathSound = false
ENT.SoundTbl_FootStep = {
	"vj_blboh/heavy/s_fs1.wav",
	"vj_blboh/heavy/s_fs2.wav",
	"vj_blboh/heavy/s_fs3.wav",
	"vj_blboh/heavy/s_fs4.wav"
}
ENT.SoundTbl_Breath = "vj_blboh/heavy/m_custom_danger.wav"
ENT.SoundTbl_Investigate = {
	"vj_blboh/heavy/s_heavy_inv1.wav",
	"vj_blboh/heavy/s_heavy_inv2.wav"
}
-- ENT.SoundTbl_LostEnemy = {
	-- "vj_blboh/heavy/s_heavy_deagg1.wav",
	-- "vj_blboh/heavy/s_heavy_deagg2.wav"
-- }
-- ENT.SoundTbl_Alert = {
	-- "vj_blboh/heavy/s_heavy_chase1.wav",
	-- "vj_blboh/heavy/s_heavy_chase2.wav"
-- }
-- ENT.SoundTbl_BeforeMeleeAttack = {
	-- "vj_blboh/wretch/hurt1.wav",
	-- "vj_blboh/wretch/hurt2.wav",
	-- "vj_blboh/wretch/hurt3.wav",
-- }
-- ENT.SoundTbl_MeleeAttack = {
	-- "npc/zombie/claw_strike1.wav",
	-- "npc/zombie/claw_strike2.wav",
	-- "npc/zombie/claw_strike3.wav"
-- }
-- ENT.SoundTbl_MeleeAttackMiss = {
	-- "weapons/knife/knife_slash1.wav",
	-- "weapons/knife/knife_slash2.wav"
-- }
-- ENT.SoundTbl_Pain = {
	-- "vj_blboh/wretch/hurt1.wav",
	-- "vj_blboh/wretch/hurt2.wav",
	-- "vj_blboh/wretch/hurt3.wav"
-- }
-- ENT.SoundTbl_Death = "vj_blboh/wretch/gargle3.wav"
ENT.NextSoundTime_Breath = VJ.SET(17,17)
ENT.FootstepSoundLevel = 80
ENT.BreathSoundLevel = 110
ENT.InvestigateSoundLevel = 95
ENT.LostEnemySoundLevel = 95
ENT.AlertSoundLevel = 95
ENT.MainSoundPitch = 100
-- ENT.BeforeMeleeAttackSoundPitch = VJ.SET(95, 120)
-- ENT.PainSoundPitch = VJ.SET(80,110)
-- ENT.DeathSoundPitch = VJ.SET(60, 100)
--------------------
ENT.BLBOH_DoSpawnSequence = false
ENT.BLBOH_Heavy_PlayingIdleMusic = false
ENT.BLBOH_Heavy_PlayingChaseMusic = false
ENT.BLBOH_Heavy_UseAltMusic = false
ENT.BLBOH_Heavy_PlayerToggleCooldown = CurTime()
ENT.BLBOH_Heavy_PlayerReloadSoundCooldown = CurTime()
ENT.BLBOH_Heavy_PlayerJumpCooldown = CurTime()
ENT.BLBOH_Heavy_KillingSomeone = false
ENT.BLBOH_Heavy_PlayDeagSound = true
--------------------
function ENT:PreInit()
	if GetConVar("vj_blboh_spawn_sequences"):GetInt() == 1 then
		self.BLBOH_DoSpawnSequence = true
	end
	if GetConVar("vj_blboh_heavy_altmusic"):GetInt() == 1 then
		self.BLBOH_Heavy_UseAltMusic = true
	end
end
--------------------
function ENT:Init()

	self:CapabilitiesRemove(CAP_ANIMATEDFACE)
					-- self:SetFlexWeight(10,1)
	if self.BLBOH_DoSpawnSequence then

	end

	-- self.BLBOH_Heavy_MusicIdle = CreateSound(self,"vj_blboh/heavy/m_custom.wav")
	if self.BLBOH_Heavy_UseAltMusic then
		self.BLBOH_Heavy_MusicIdle = CreateSound(self,"vj_blboh/heavy/m_custom.wav")
	else
		self.BLBOH_Heavy_MusicIdle = CreateSound(self,"vj_blboh/heavy/m_main.wav")
	end
	self.BLBOH_Heavy_MusicIdle:SetSoundLevel(110)
	self.BLBOH_Heavy_MusicIdle:Play()
	self.BLBOH_Heavy_PlayingIdleMusic = true

	self:SetFlexWeight(2,-1)
	self:SetFlexWeight(3,-1)
end
--------------------
function ENT:OnThink()
	-- if self.Alerted && !self.HasBreathSound then
		-- self.HasBreathSound = true
	-- elseif !self.Alerted && self.HasBreathSound then
		-- self.HasBreathSound = false
	-- end
end
--------------------
function ENT:OnThinkActive()
	if self.BLBOH_Heavy_KillingSomeone then return end
	if
		self.BLBOH_Heavy_PlayingChaseMusic &&
		(
			(
				!self.VJ_IsBeingControlled &&
				!IsValid(self:GetEnemy()) &&
				!self.Alerted
			)
			or
			(
				self.VJ_IsBeingControlled &&
				self.BLBOH_Heavy_PlayerToggleCooldown < CurTime() &&
				self.VJ_TheController:KeyDown(IN_ATTACK2)
			)
		)
	then
		self.BLBOH_Heavy_PlayerToggleCooldown = CurTime() + 3
		self.BLBOH_Heavy_MusicChase:Stop()
		self.BLBOH_Heavy_PlayingChaseMusic = false
		if self.BLBOH_Heavy_UseAltMusic then
			self.BLBOH_Heavy_MusicIdle = CreateSound(self,"vj_blboh/heavy/m_custom.wav")
		else
			self.BLBOH_Heavy_MusicIdle = CreateSound(self,"vj_blboh/heavy/m_main.wav")
		end
		self.BLBOH_Heavy_MusicIdle:SetSoundLevel(110)
		self.BLBOH_Heavy_MusicIdle:Play()
		self.BLBOH_Heavy_PlayingIdleMusic = true
		self:SetFlexWeight(10,0)
		self.HasMeleeAttack = false
		if self.BLBOH_Heavy_PlayDeagSound then
			VJ.EmitSound(self,"vj_blboh/heavy/s_heavy_deagg"..math.random(1,2)..".wav",95,100)
		end
	elseif
		!self.BLBOH_Heavy_PlayingChaseMusic &&
		(
			(
				!self.VJ_IsBeingControlled &&
				IsValid(self:GetEnemy())
			)
			or
			(
				self.VJ_IsBeingControlled &&
				self.BLBOH_Heavy_PlayerToggleCooldown < CurTime() &&
				self.VJ_TheController:KeyDown(IN_ATTACK2)
			)
		)
	then
		self.BLBOH_Heavy_PlayerToggleCooldown = CurTime() + 3
		self.BLBOH_Heavy_MusicIdle:Stop()
		self.BLBOH_Heavy_PlayingIdleMusic = false
		if self.BLBOH_Heavy_UseAltMusic then
			self.BLBOH_Heavy_MusicChase = CreateSound(self,"vj_blboh/heavy/m_custom_danger.wav")
		else
			-- self.BLBOH_Heavy_MusicChase = CreateSound(self,"vj_blboh/heavy/m_chase.wav")
			self.BLBOH_Heavy_MusicChase = CreateSound(self,"vj_blboh/heavy/m_chase_stereo.wav")
		end
		self.BLBOH_Heavy_MusicChase:SetSoundLevel(110)
		self.BLBOH_Heavy_MusicChase:Play()
		self.BLBOH_Heavy_PlayingChaseMusic = true
		self:SetFlexWeight(10,1)
		if !self.VJ_IsBeingControlled then
			self.HasMeleeAttack = true
		else
			timer.Simple(1,function() if IsValid(self) then
				self.HasMeleeAttack = true
			end end)
		end
		VJ.EmitSound(self,"vj_blboh/heavy/s_heavy_chase"..math.random(1,2)..".wav",95,100)		
		if IsValid(self:GetEnemy()) then -- just in case
			VJ.EmitSound(self:GetEnemy(),"vj_blboh/heavy/s_sting.wav",95,100)
		else
			VJ.EmitSound(self,"vj_blboh/heavy/s_sting.wav",95,100)
		end
	end
	if self.VJ_IsBeingControlled then
		if self.VJ_TheController:KeyDown(IN_JUMP) && self.BLBOH_Heavy_PlayerJumpCooldown < CurTime() && self:OnGround() then
			self.BLBOH_Heavy_PlayerJumpCooldown = CurTime() + 1
			if self:GetActivity() == ACT_RUN then
				self:SetVelocity(self:GetUp() * 200 + self:GetForward() * 345)
			elseif self:GetActivity() == ACT_WALK then
				self:SetVelocity(self:GetUp() * 200 + self:GetForward() * 230)
			else
				self:SetVelocity(self:GetUp() * 200 + self:GetForward() * 100)
			end
			self:PlayAnim("vjseq_jumpstart_melee", true, 0.5)
		end
		if self.VJ_TheController:KeyDown(IN_RELOAD) && self.BLBOH_Heavy_PlayerReloadSoundCooldown < CurTime() then
			self.BLBOH_Heavy_PlayerReloadSoundCooldown = CurTime() + 5
			VJ.EmitSound(self,self.SoundTbl_Investigate,self.InvestigateSoundLevel,100)
		end
	end
end
--------------------
-- function ENT:OnResetEnemy()
	-- if !IsValid(self:GetEnemy()) then
		-- if self.BLBOH_Heavy_PlayingChaseMusic then
			-- self.BLBOH_Heavy_MusicChase:Stop()
			-- self.BLBOH_Heavy_MusicChaseDuplicate:Stop()
			-- self.BLBOH_Heavy_PlayingChaseMusic = false
			-- self.BLBOH_Heavy_MusicIdle = CreateSound(self,"vj_blboh/heavy/m_custom.wav")
			-- self.BLBOH_Heavy_MusicIdle = CreateSound(self,"vj_blboh/heavy/m_main.wav")
			-- self.BLBOH_Heavy_MusicIdle:SetSoundLevel(110)
			-- self.BLBOH_Heavy_MusicIdle:Play()
			-- self.BLBOH_Heavy_PlayingIdleMusic = true
		-- end
		-- self:SetFlexWeight(10,0)
	-- end
-- end
--------------------
-- function ENT:OnAlert(ent)
	-- if self.BLBOH_Heavy_PlayingIdleMusic then
		-- self.HasMeleeAttack = true
		-- self.BLBOH_Heavy_MusicIdle:Stop()
		-- self.BLBOH_Heavy_PlayingIdleMusic = false
		-- self.BLBOH_Heavy_MusicChase = CreateSound(self,"vj_blboh/heavy/m_custom_danger.wav")
		-- if self.BLBOH_Heavy_UseAltMusic then
			-- self.BLBOH_Heavy_MusicChase = CreateSound(self,"vj_blboh/heavy/m_custom_danger.wav")
		-- else
			-- self.BLBOH_Heavy_MusicChase = CreateSound(self,"vj_blboh/heavy/m_chase.wav")
		-- end
		-- self.BLBOH_Heavy_MusicChase:SetSoundLevel(110)
		-- self.BLBOH_Heavy_MusicChase:Play()
		-- self.BLBOH_Heavy_MusicChaseDuplicate = CreateSound(self,"vj_blboh/heavy/m_custom_dangercopy.wav")
		-- self.BLBOH_Heavy_MusicChaseDuplicate:SetSoundLevel(110)
		-- self.BLBOH_Heavy_MusicChaseDuplicate:Play()
		-- self.BLBOH_Heavy_PlayingChaseMusic = true
		-- if IsValid(self:GetEnemy()) then
			-- VJ.EmitSound(self:GetEnemy(),"vj_blboh/heavy/s_sting.wav",95,100)
		-- else
			-- VJ.EmitSound(self,"vj_blboh/heavy/s_sting.wav",95,100)
		-- end
		-- self:SetFlexWeight(10,1)
	-- end
-- end
--------------------
-- function ENT:OnMeleeAttack(status, enemy)
	-- local tr = util.TraceLine({
		-- start = self:GetPos(),
		-- endpos = self:GetPos() + self:GetForward()*80,
		-- filter = {self, "obj_vj_bullseye"}
	-- })
	-- if status == "PostInit" && (!self.VJ_IsBeingControlled or self.VJ_IsBeingControlled && tr.Hit) then

		-- if enemy:GetClass() == "obj_vj_bullseye" then return end

		-- self:StopMoving(true)
		-- self.MovementType = VJ_MOVETYPE_STATIONARY
		-- self.CanTurnWhileStationary = false
		-- VJ.EmitSound(enemy,"vj_blboh/heavy/s_sting_die.wav",95,100)
		-- VJ.EmitSound(enemy,"vj_blboh/heavy/s_heavy_grab.wav",80,100)
		-- enemy:SetPos(self:GetPos() + self:GetForward()*50)
		-- self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK,2.5)

		-- if enemy:IsPlayer() then
			-- enemy:Freeze(true)
			-- enemy:StripWeapons()
			-- enemy:ScreenFade(0, Color(0,0,0), 0.65, 0)
			-- enemy:SetEyeAngles(Angle(self:GetAngles().x,(self:GetPos() -enemy:GetPos()):Angle().y,self:GetAngles().z))
		-- end
		-- timer.Simple(0.1,function() if IsValid(self) then
			-- self:PlayAnim("vjseq_layer_taunt07_Halloween", true, 3)
		-- end end)
		-- timer.Simple(0.65,function()
			-- if IsValid(self) then
				-- VJ.EmitSound(self,"vj_blboh/heavy/s_heavy_scream.wav",95,100)
				-- VJ.EmitSound(enemy,"vj_blboh/heavy/m_dying.wav",80,100)
				-- self:SetFlexWeight(10,1)
				-- self:SetFlexWeight(35,1)
				-- self:SetFlexWeight(38,1)
				-- self:SetFlexWeight(39,1)
				-- self.SpawnLight = ents.Create("light_dynamic")
				-- self.SpawnLight:SetKeyValue("brightness", "0.5")
				-- self.SpawnLight:SetKeyValue("distance", "50")
				-- self.SpawnLight:SetLocalPos(self:GetPos())
				-- self.SpawnLight:SetLocalAngles(self:GetAngles())
				-- self.SpawnLight:Fire("Color", "64 0 0 255")
				-- self.SpawnLight:SetParent(self)
				-- self.SpawnLight:Spawn()
				-- self.SpawnLight:Activate()
				-- self.SpawnLight:Fire("SetParentAttachment","eyes")
				-- self.SpawnLight:Fire("TurnOn", "", 0)
				-- self:DeleteOnRemove(self.SpawnLight)
			-- end
			-- if IsValid(enemy) then
				-- util.ScreenShake(enemy:GetPos(), 10, 40, 5, 100)
				-- if IsValid(self) then
					-- enemy:SetPos(self:GetPos() + self:GetForward()*50)
				-- end
			-- end
		-- end)
		-- if enemy.IsVJBaseSNPC && enemy.MovementType == VJ_MOVETYPE_GROUND then
			-- enemy:StopMoving()
			-- local ang = self:GetAngles()
			-- enemy:SetAngles(Angle(ang.x,(self:GetPos() -enemy:GetPos()):Angle().y,ang.z))
			-- enemy:SetState(VJ_STATE_ONLY_ANIMATION)
			-- enemy:AddFlags(FL_NOTARGET)
		-- end
		-- timer.Simple(2.5,function()
			-- if IsValid(self) then
				-- self.CanTurnWhileStationary = true
				-- self.MovementType = VJ_MOVETYPE_GROUND
				-- self:SetFlexWeight(10,0)
				-- self:SetFlexWeight(35,0)
				-- self:SetFlexWeight(38,0)
				-- self:SetFlexWeight(39,0)
				-- if self.SpawnLight != nil then
					-- self.SpawnLight:Fire("Kill", "", 0)
				-- end
			-- end
			-- if IsValid(enemy) then
				-- VJ.EmitSound(enemy,"vj_blboh/heavy/s_death"..math.random(1,2)..".wav",80,100)
				-- if enemy:IsPlayer() then
					-- enemy:ScreenFade(1, Color(128,0,0), 1, 0.5)
					-- enemy:Freeze(false)
				-- end
				-- local d = DamageInfo()
				-- if IsValid(self) then
					-- d:SetAttacker(self)
					-- d:SetDamage(enemy:GetMaxHealth() + 9000)
				-- else
					-- d:SetDamage(enemy:GetMaxHealth() + 9000)
					-- d:SetAttacker(enemy)
				-- end
				-- d:SetDamageType(DMG_DIRECT)
				-- enemy:TakeDamageInfo(d)
				-- timer.Simple(0.1,function() if IsValid(enemy) and !enemy:IsPlayer() and !enemy.Dead and enemy:GetClass() != "obj_vj_bullseye" then
					-- enemy:AddFlags(FL_NOTARGET)
					-- enemy:Dissolve()
				-- end end)
				-- timer.Simple(1,function() if IsValid(self) then
					-- VJ.EmitSound(self,"vj_blboh/heavy/s_heavy_taunt"..math.random(1,2)..".wav",95,100)
				-- end end)
			-- end
		-- end)
	-- end
-- end
--------------------
function ENT:OnMeleeAttackExecute(status, ent, isProp)
	-- local tr = util.TraceLine({
		-- start = self:GetPos(),
		-- endpos = self:GetPos() + self:GetForward()*80,
		-- filter = {self, "obj_vj_bullseye"}
	-- })
	-- if status == "PreDamage" && (!self.VJ_IsBeingControlled or self.VJ_IsBeingControlled && tr.Hit) then
	if status == "PreDamage" then

		if ent:GetClass() == "obj_vj_bullseye" or isProp then return end

		self.BLBOH_Heavy_KillingSomeone = true
		self:StopMoving(true)
		self.MovementType = VJ_MOVETYPE_STATIONARY
		self.CanTurnWhileStationary = false
		VJ.EmitSound(ent,"vj_blboh/heavy/s_sting_die.wav",95,100)
		VJ.EmitSound(ent,"vj_blboh/heavy/s_heavy_grab.wav",80,100)
		ent:SetPos(self:GetPos() + self:GetForward()*50)
		self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK,2.5)

		if self.BLBOH_Heavy_PlayingChaseMusic then -- better safe than sorry
			self.BLBOH_Heavy_MusicChase:Stop()
			-- self.BLBOH_Heavy_PlayingChaseMusic = false
		end

		if ent:IsPlayer() then
			ent:Freeze(true)
			ent:StripWeapons()
			ent:ScreenFade(0, Color(0,0,0), 0.65, 0)
			ent:SetEyeAngles(Angle(self:GetAngles().x,(self:GetPos() -ent:GetPos()):Angle().y,self:GetAngles().z))
		end

		if self.VJ_IsBeingControlled then
			self.HasMeleeAttack = false
		end

		timer.Simple(0.1,function() if IsValid(self) then
			self:PlayAnim("vjseq_layer_taunt07_Halloween", true, 3)
		end end)
		timer.Simple(0.65,function()
			if IsValid(self) then
				VJ.EmitSound(self,"vj_blboh/heavy/s_heavy_scream.wav",95,100)
				self:SetFlexWeight(10,1)
				self:SetFlexWeight(35,1)
				self:SetFlexWeight(38,1)
				self:SetFlexWeight(39,1)
				self.SpawnLight = ents.Create("light_dynamic")
				self.SpawnLight:SetKeyValue("brightness", "0.5")
				self.SpawnLight:SetKeyValue("distance", "50")
				self.SpawnLight:SetLocalPos(self:GetPos())
				self.SpawnLight:SetLocalAngles(self:GetAngles())
				self.SpawnLight:Fire("Color", "64 0 0 255")
				self.SpawnLight:SetParent(self)
				self.SpawnLight:Spawn()
				self.SpawnLight:Activate()
				self.SpawnLight:Fire("SetParentAttachment","eyes")
				self.SpawnLight:Fire("TurnOn", "", 0)
				self:DeleteOnRemove(self.SpawnLight)
			end
			if IsValid(ent) then
				VJ.EmitSound(ent,"vj_blboh/heavy/m_dying.wav",95,100)
				util.ScreenShake(ent:GetPos(), 10, 40, 5, 100)
				if IsValid(self) then
					ent:SetPos(self:GetPos() + self:GetForward()*50)
				end
			end
		end)
		if ent.IsVJBaseSNPC && ent.MovementType == VJ_MOVETYPE_GROUND then
			ent:StopMoving()
			local ang = self:GetAngles()
			ent:SetAngles(Angle(ang.x,(self:GetPos() -ent:GetPos()):Angle().y,ang.z))
			ent:SetState(VJ_STATE_ONLY_ANIMATION)
			ent:AddFlags(FL_NOTARGET)
		end
		timer.Simple(2.5,function()
			if IsValid(self) then
				self.BLBOH_Heavy_KillingSomeone = false
				self.CanTurnWhileStationary = true
				self:SetFlexWeight(10,0)
				self:SetFlexWeight(35,0)
				self:SetFlexWeight(38,0)
				self:SetFlexWeight(39,0)
				if self.SpawnLight != nil then
					self.SpawnLight:Fire("Kill", "", 0)
				end
			end
			if IsValid(ent) then
				VJ.EmitSound(ent,"vj_blboh/heavy/s_death"..math.random(1,2)..".wav",80,100)
				if ent:IsPlayer() then
					ent:ScreenFade(1, Color(128,0,0), 1, 0.5)
					ent:Freeze(false)
				end
				local d = DamageInfo()
				if IsValid(self) then
					d:SetAttacker(self)
					d:SetDamage(ent:GetMaxHealth() + 9000)
				else
					d:SetDamage(ent:GetMaxHealth() + 9000)
					d:SetAttacker(ent)
				end
				d:SetDamageType(DMG_DIRECT)
				ent:TakeDamageInfo(d)
				timer.Simple(0.1,function() if IsValid(ent) and !ent:IsPlayer() and (ent:Health() > 0 or ent:GetClass() == "npc_rollermine") and ent:GetClass() != "obj_vj_bullseye" then
					ent:AddFlags(FL_NOTARGET)
					ent:Dissolve()
				end end)
				timer.Simple(1,function() if IsValid(self) then
					VJ.EmitSound(self,"vj_blboh/heavy/s_heavy_taunt"..math.random(1,2)..".wav",95,100)
				end end)
				timer.Simple(3,function() if IsValid(self) then
					self.MovementType = VJ_MOVETYPE_GROUND
					if !self.VJ_IsBeingControlled then
						if IsValid(self:GetEnemy()) then
							self.BLBOH_Heavy_PlayingChaseMusic = false
							-- this feels like a shitty way to do this but whatever, it works for now
							self.BLBOH_Heavy_PlayerToggleCooldown = CurTime() + 3
							self.BLBOH_Heavy_MusicIdle:Stop()
							self.BLBOH_Heavy_PlayingIdleMusic = false
							if self.BLBOH_Heavy_UseAltMusic then
								self.BLBOH_Heavy_MusicChase = CreateSound(self,"vj_blboh/heavy/m_custom_danger.wav")
							else
								-- self.BLBOH_Heavy_MusicChase = CreateSound(self,"vj_blboh/heavy/m_chase.wav")
								self.BLBOH_Heavy_MusicChase = CreateSound(self,"vj_blboh/heavy/m_chase_stereo.wav")
							end
							self.BLBOH_Heavy_MusicChase:SetSoundLevel(110)
							self.BLBOH_Heavy_MusicChase:Play()
							self.BLBOH_Heavy_PlayingChaseMusic = true
							self:SetFlexWeight(10,1)
						else
							self.BLBOH_Heavy_PlayDeagSound = false
							self.Alerted = false
						end


					else
						-- feels really shitty just copying this chunk of code but it works for now
						self.BLBOH_Heavy_PlayerToggleCooldown = CurTime() + 1
						self.BLBOH_Heavy_MusicChase:Stop()
						self.BLBOH_Heavy_PlayingChaseMusic = false
						if self.BLBOH_Heavy_UseAltMusic then
							self.BLBOH_Heavy_MusicIdle = CreateSound(self,"vj_blboh/heavy/m_custom.wav")
						else
							self.BLBOH_Heavy_MusicIdle = CreateSound(self,"vj_blboh/heavy/m_main.wav")
						end
						self.BLBOH_Heavy_MusicIdle:SetSoundLevel(110)
						self.BLBOH_Heavy_MusicIdle:Play()
						self.BLBOH_Heavy_PlayingIdleMusic = true
						self:SetFlexWeight(10,0)
					end
				end end)
				timer.Simple(3.15,function() if IsValid(self) then
					self.BLBOH_Heavy_PlayDeagSound = true
				end end)
			end
		end)
	end
end
--------------------
-- function ENT:OnDamaged(dmginfo, hitgroup, status)
-- end
--------------------
-- function ENT:OnInput(key, activator, caller, data)
-- end
--------------------
function ENT:CustomOnRemove()
	if self.BLBOH_Heavy_PlayingIdleMusic then
		self.BLBOH_Heavy_MusicIdle:Stop()
	end
	if self.BLBOH_Heavy_PlayingChaseMusic then
		self.BLBOH_Heavy_MusicChase:Stop()
		-- self.BLBOH_Heavy_MusicChaseDuplicate:Stop()
	end
end
--------------------
function ENT:Controller_Initialize(ply, controlEnt)
	ply:ChatPrint("MOUSE2: Toggle Attack Mode")
	ply:ChatPrint("You need to wait 3 seconds before you can toggle attack mode again.")
	ply:ChatPrint("RELOAD: Play Investigate Sound")
	ply:ChatPrint("JUMP: Jump")
	-- self.MeleeAttackAngleRadius = 35
	-- self.MeleeAttackDamageAngleRadius = 40
end
--------------------
-- function ENT:TranslateActivity(act)
	-- if self.VJ_IsBeingControlled && act == ACT_RUN && !self.BLBOH_Heavy_PlayingChaseMusic then
		-- return ACT_WALK
	-- end
	-- return act
-- end