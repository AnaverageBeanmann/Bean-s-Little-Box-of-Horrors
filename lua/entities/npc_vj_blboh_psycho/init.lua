AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = "models/vj_blboh/psycho.mdl"
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
ENT.MeleeAttackDamage = 20
ENT.AnimTbl_MeleeAttack = {"vjges_range_melee2_b"}
-- ENT.MeleeAttackDistance = 60
-- ENT.MeleeAttackAngleRadius = 15
-- ENT.MeleeAttackDamageDistance  = 70
-- ENT.MeleeAttackDamageAngleRadius = 15
ENT.TimeUntilMeleeAttackDamage = 0.4
ENT.NextMeleeAttackTime = 1.5


-- ENT.MeleeAttackDamageType = DMG_CLUB
-- ENT.MeleeAttackDistance = 75
-- ENT.MeleeAttackDamageDistance = 90
--------------------
-- ENT.DisableFootStepSoundTimer = true
ENT.FootstepSoundTimerWalk = 0.5
ENT.FootstepSoundTimerRun = 0.25
ENT.HasBreathSound = true
ENT.HasExtraMeleeAttackSounds = true
ENT.SoundTbl_FootStep = {
	"vj_blboh/heavy/s_fs1.wav",
	"vj_blboh/heavy/s_fs2.wav",
	"vj_blboh/heavy/s_fs3.wav",
	"vj_blboh/heavy/s_fs4.wav"
}
ENT.SoundTbl_Breath = "vj_blboh/psycho/tinkybreath.ogg"
-- ENT.SoundTbl_LostEnemy = {
	-- "vj_blboh/heavy/s_heavy_deagg1.wav",
	-- "vj_blboh/heavy/s_heavy_deagg2.wav"
-- }
-- ENT.SoundTbl_Alert = {
	-- "vj_blboh/heavy/s_heavy_chase1.wav",
	-- "vj_blboh/heavy/s_heavy_chase2.wav"
-- }
ENT.SoundTbl_BeforeMeleeAttack = {
	"vj_blboh/psycho/tinky_impact1.ogg",
	"vj_blboh/psycho/tinky_impact2.ogg",
	"vj_blboh/psycho/tinky_impact3.ogg"
}
ENT.SoundTbl_MeleeAttack = {
	"weapons/axe/melee_axe_01.wav",
	"weapons/axe/melee_axe_02.wav",
	"weapons/axe/melee_axe_03.wav"
}
ENT.SoundTbl_MeleeAttackExtra = {
	"vj_blboh/psycho/AXEHIT2.ogg",
	"vj_blboh/psycho/AXEHIT3.ogg"
}
ENT.SoundTbl_MeleeAttackMiss = {
	"weapons/knife/knife_slash1.wav",
	"weapons/knife/knife_slash2.wav"
}
-- ENT.SoundTbl_Pain = {
	-- "vj_blboh/wretch/hurt1.wav",
	-- "vj_blboh/wretch/hurt2.wav",
	-- "vj_blboh/wretch/hurt3.wav"
-- }
-- ENT.SoundTbl_Death = "vj_blboh/wretch/gargle3.wav"
ENT.NextSoundTime_Breath = VJ.SET(9,9)
ENT.BreathSoundLevel = 50
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

ENT.BLBOH_Psycho_InAChase = false
ENT.BLBOH_Psycho_RecoveringFromSwing = false
ENT.BLBOH_Psycho_Sprinting = false
ENT.BLBOH_Psycho_SprintCountdown = 30
ENT.BLBOH_Psycho_TeleportCooldown = 45
ENT.BLBOH_Psycho_Stamina = 100
ENT.BLBOH_Psycho_Exhausted = false
ENT.BLBOH_Psycho_DespawnTimer = 100
ENT.BLBOH_Psycho_AntiStuckPos = nil
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

	if self.BLBOH_DoSpawnSequence then

	end

	self.BLBOH_PsychoAxeModel = ents.Create("prop_physics")	
	self.BLBOH_PsychoAxeModel:SetModel("models/vj_blboh/psycho_axe.mdl")
	self.BLBOH_PsychoAxeModel:SetLocalPos(self:GetPos())
	self.BLBOH_PsychoAxeModel:SetLocalAngles(self:GetAngles())			
	self.BLBOH_PsychoAxeModel:SetOwner(self)
	self.BLBOH_PsychoAxeModel:SetParent(self)
	self.BLBOH_PsychoAxeModel:Fire("SetParentAttachmentMaintainOffset","anim_attachment_LH")
	self.BLBOH_PsychoAxeModel:Fire("SetParentAttachment","anim_attachment_RH")
	self.BLBOH_PsychoAxeModel:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	self.BLBOH_PsychoAxeModel:Spawn()
	self.BLBOH_PsychoAxeModel:Activate()
	self.BLBOH_PsychoAxeModel:SetSolid(SOLID_NONE)
	self.BLBOH_PsychoAxeModel:AddEffects(EF_BONEMERGE)
	-- self.BLBOH_Heavy_MusicIdle = CreateSound(self,"vj_blboh/heavy/m_custom.wav")
	-- if self.BLBOH_Heavy_UseAltMusic then
		-- self.BLBOH_Heavy_MusicIdle = CreateSound(self,"vj_blboh/heavy/m_custom.wav")
	-- else
		-- self.BLBOH_Heavy_MusicIdle = CreateSound(self,"vj_blboh/heavy/m_main.wav")
	-- end
	-- self.BLBOH_Heavy_MusicIdle:SetSoundLevel(110)
	-- self.BLBOH_Heavy_MusicIdle:Play()
	self.BLBOH_Heavy_PlayingIdleMusic = true

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

	if !self.BLBOH_Psycho_InAChase &&
		(
			(
				!self.VJ_IsBeingControlled &&
				IsValid(self:GetEnemy()) &&
				self.Alerted &&
				!self.BLBOH_Psycho_Exhausted
			)
			or
			(
				self.VJ_IsBeingControlled &&
				self.BLBOH_Heavy_PlayerToggleCooldown < CurTime() &&
				self.VJ_TheController:KeyDown(IN_ATTACK2)
			)
		)
	then
		self.BLBOH_Psycho_InAChase = true
		self.BLBOH_Heavy_PlayerToggleCooldown = CurTime() + 3
		self.BLBOH_Heavy_PlayingIdleMusic = false
		self.BLBOH_Heavy_MusicChase = CreateSound(self,"vj_blboh/psycho/FknShthd.wav")
		self.BLBOH_Heavy_MusicChase:SetSoundLevel(110)
		self.BLBOH_Heavy_MusicChase:Play()
		self.BLBOH_Heavy_MusicChase2 = CreateSound(self,"vj_blboh/psycho/FknShthdCopy.wav")
		self.BLBOH_Heavy_MusicChase2:SetSoundLevel(110)
		self.BLBOH_Heavy_MusicChase2:Play()
		self.BLBOH_Heavy_MusicChase3 = CreateSound(self,"vj_blboh/psycho/FknShthdCopy2.wav")
		self.BLBOH_Heavy_MusicChase3:SetSoundLevel(110)
		self.BLBOH_Heavy_MusicChase3:Play()
		self.BLBOH_Heavy_PlayingChaseMusic = true
		if IsValid(self:GetEnemy()) then -- just in case
			VJ.EmitSound(self:GetEnemy(),"vj_blboh/psycho/Stinger2.ogg",95,100)
		else
			VJ.EmitSound(self,"vj_blboh/psycho/Stinger2.ogg",95,100)
		end
	elseif self.BLBOH_Psycho_InAChase then
		if IsValid(self:GetEnemy()) && !self.BLBOH_Psycho_Exhausted then
			-- enemy is farther than 300 units and is either not looking at us or we can't see them
			if (!(self:GetEnemy():GetForward():Dot((self:GetPos() -self:GetEnemy():GetPos()):GetNormalized()) > math.cos(math.rad(60))) or !self:Visible(self:GetEnemy())) && self:GetPos():Distance(self:GetEnemy():GetPos()) >= 300 then
				self.BLBOH_Psycho_TeleportCooldown = self.BLBOH_Psycho_TeleportCooldown - 1
				if self.BLBOH_Psycho_TeleportCooldown <= 0 then
					self.BLBOH_Psycho_TeleportCooldown = 45
					local tr1 = util.TraceLine({
						start = self:GetEnemy():GetPos() + self:GetEnemy():OBBCenter(),
						endpos = self:GetEnemy():GetPos() + self:GetEnemy():OBBCenter() + self:GetEnemy():GetForward()*200,
						filter = self:GetEnemy()
					})
					if !tr1.Hit then
						self.BLBOH_Psycho_Stamina = self.BLBOH_Psycho_Stamina - math.random(3,7)
						if self.BLBOH_Psycho_Stamina <= 1 then
							self.BLBOH_Psycho_Stamina = 1
						end
						PrintMessage(3,""..self.BLBOH_Psycho_Stamina.."")
						local randtelpitch = math.random(95,105)
						VJ.EmitSound(self,"vj_blboh/psycho/teleport1.ogg",80,randtelpitch)
						VJ.EmitSound(self:GetEnemy(),"vj_blboh/psycho/teleport1.ogg",80,randtelpitch)
						timer.Simple(0.25, function() if IsValid(self) then
							for _, v in ipairs(player.GetAll()) do
								if v:IsPlayer() && v:Visible(self) then
									v:ScreenFade(1,Color(0,0,0),0.15,0.15)
								end
							end
							if !tr1.Hit then
								self.BLBOH_Psycho_AntiStuckPos = self:GetPos()
								local DeathCloud = EffectData()
								DeathCloud:SetOrigin(self:GetAttachment(self:LookupAttachment("chest")).Pos)
								DeathCloud:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
								DeathCloud:SetScale(200)
								util.Effect("VJ_Blood1",DeathCloud)
								if IsValid(self:GetEnemy()) then
									self:SetPos(self:GetEnemy():GetPos() + self:GetEnemy():GetForward()*200 + self:GetUp()*10)
								end
								timer.Simple(0.1, function() if IsValid(self) then
									local DeathCloud = EffectData()
									DeathCloud:SetOrigin(self:GetAttachment(self:LookupAttachment("chest")).Pos)
									DeathCloud:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
									DeathCloud:SetScale(200)
									util.Effect("VJ_Blood1",DeathCloud)
									for _, v in ipairs(player.GetAll()) do
										if v:IsPlayer() && v:Visible(self) then
											v:ScreenFade(1,Color(0,0,0),0.15,0.15)
										end
									end
									local myCenterPos = self:GetPos() + self:OBBCenter()
									local tr1 = util.TraceLine({
										start = myCenterPos,
										endpos = myCenterPos + self:GetForward()*40,
										filter = self
									})
									local tr2 = util.TraceLine({
										start = myCenterPos,
										endpos = myCenterPos + self:GetForward()*-40,
										filter = self
									})
									local tr3 = util.TraceLine({
										start = myCenterPos,
										endpos = myCenterPos + self:GetRight()*40,
										filter = self
									})

									local tr4 = util.TraceLine({
										start = myCenterPos,
										endpos = myCenterPos + self:GetRight()*-40,
										filter = self
									})
									if tr1.Hit or tr2.Hit or tr3.Hit or tr4.Hit then -- stuck prevention
										VJ.EmitSound(self,"vj_blboh/psycho/teleport1.ogg",80,randtelpitch)
										self:SetPos(self.BLBOH_Psycho_AntiStuckPos)
									end
								end end)
								self:SetTurnTarget(self:GetEnemy(),0,false,false)
							end
						end end)
					end
				end
			elseif self:GetPos():Distance(self:GetEnemy():GetPos()) >= 225 && !self.BLBOH_Psycho_Exhausted && !self.BLBOH_Psycho_Sprinting && !self.BLBOH_Psycho_RecoveringFromSwing  then
				self.BLBOH_Psycho_SprintCountdown = self.BLBOH_Psycho_SprintCountdown - 1
				-- PrintMessage(3,""..self.BLBOH_Psycho_SprintCountdown.."")
				if self.BLBOH_Psycho_SprintCountdown <= 0 then
					self.BLBOH_Psycho_Sprinting = true
					self.BLBOH_Psycho_SprintCountdown = 30
					self.AnimTbl_MeleeAttack = {"vjges_range_melee"}
					self.MeleeAttackDamage = 15
					self.TimeUntilMeleeAttackDamage = 0.25
					-- self:SetPlaybackRate(3)
					-- PrintMessage(4,"test")
				end
			end
		end
		if
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
			self.BLBOH_Psycho_InAChase = false
			self.BLBOH_Heavy_PlayerToggleCooldown = CurTime() + 3

			VJ.EmitSound(self,"vj_blboh/psycho/ambient_bell.ogg",110,100)
			VJ.EmitSound(self,"vj_blboh/psycho/ambient_bell.ogg",110,100)

			if self.BLBOH_Psycho_Exhausted then
				self.BLBOH_Psycho_TiredMusic:Stop()
				self.BLBOH_Psycho_TiredMusic2:Stop()
				self.BLBOH_Psycho_TiredMusic3:Stop()
				self.BLBOH_Psycho_Exhausted = false
				self.BLBOH_Psycho_Stamina = 100
				self.EnemyTimeout = 15
				self.AlertTimeout = VJ.SET(14, 16)
				self.AnimTbl_MeleeAttack = {"vjges_range_melee2_b"}
				self.MeleeAttackDamage = 20
				self.TimeUntilMeleeAttackDamage = 0.4
				self.FootstepSoundTimerRun = 0.25
				self.BreathSoundLevel = 50
			end

			if self.BLBOH_Heavy_PlayingChaseMusic then
				self.BLBOH_Heavy_MusicChase:Stop()
				self.BLBOH_Heavy_MusicChase2:Stop()
				self.BLBOH_Heavy_MusicChase3:Stop()
				self.BLBOH_Heavy_PlayingChaseMusic = false
			end
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
function ENT:OnMeleeAttack(status, enemy)
	if status == "Init" then
		if !self.BLBOH_Psycho_RecoveringFromSwing && !self.BLBOH_Psycho_Exhausted then
			self.BLBOH_Psycho_RecoveringFromSwing = true
			timer.Simple(math.random(1.5,2), function() if IsValid(self) then
				self.BLBOH_Psycho_RecoveringFromSwing = false
			end end)
		end
		if self.BLBOH_Psycho_Sprinting then
			-- self:SetPlaybackRate(1)
			self.BLBOH_Psycho_Sprinting = false
			timer.Simple(2,function() if IsValid(self) then
				self.AnimTbl_MeleeAttack = {"vjges_range_melee2_b"}
				self.MeleeAttackDamage = 20
				self.TimeUntilMeleeAttackDamage = 0.4
			end end)
		end
	end
end
--------------------
function ENT:OnMeleeAttackExecute(status, ent, isProp)
	if status == "Init" then
		self.BLBOH_Psycho_Stamina = self.BLBOH_Psycho_Stamina - math.random(3,7)
		PrintMessage(3,""..self.BLBOH_Psycho_Stamina.."")
		if self.BLBOH_Psycho_Stamina <= 0 && !self.BLBOH_Psycho_Exhausted then
			self.BLBOH_Psycho_Exhausted = true

			self.BLBOH_Heavy_MusicChase:Stop()
			self.BLBOH_Heavy_MusicChase2:Stop()
			self.BLBOH_Heavy_MusicChase3:Stop()
			self.BLBOH_Heavy_PlayingChaseMusic = false


			self.BLBOH_Psycho_TiredMusic = CreateSound(self,"vj_blboh/psycho/TrdShthd.wav")
			self.BLBOH_Psycho_TiredMusic:SetSoundLevel(110)
			self.BLBOH_Psycho_TiredMusic:Play()
			self.BLBOH_Psycho_TiredMusic2 = CreateSound(self,"vj_blboh/psycho/TrdShthdCopy.wav")
			self.BLBOH_Psycho_TiredMusic2:SetSoundLevel(110)
			self.BLBOH_Psycho_TiredMusic2:Play()
			self.BLBOH_Psycho_TiredMusic3 = CreateSound(self,"vj_blboh/psycho/TrdShthdCopy2.wav")
			self.BLBOH_Psycho_TiredMusic3:SetSoundLevel(110)
			self.BLBOH_Psycho_TiredMusic3:Play()

			for _, v in ipairs(ents.FindInSphere(self:GetPos(), 1000)) do
				if v:IsPlayer() and v:Alive() then
					v:PrintMessage(4,"LOSE HIM")
				end
			end

			self.EnemyTimeout = 3
			self.AlertTimeout = VJ.SET(3, 5)
			self.AnimTbl_MeleeAttack = {"vjseq_seq_baton_swing"}
			self.MeleeAttackDamage = 10
			self.TimeUntilMeleeAttackDamage = 0.45
			self.FootstepSoundTimerRun = 0.5
			self.BreathSoundLevel = 55
		end
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
	if self.BLBOH_Heavy_PlayingChaseMusic then
		self.BLBOH_Heavy_MusicChase:Stop()
		self.BLBOH_Heavy_MusicChase2:Stop()
		self.BLBOH_Heavy_MusicChase3:Stop()
	end
	if self.BLBOH_Psycho_Exhausted then
		self.BLBOH_Psycho_TiredMusic:Stop()
		self.BLBOH_Psycho_TiredMusic2:Stop()
		self.BLBOH_Psycho_TiredMusic3:Stop()
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
function ENT:TranslateActivity(act)
	if act == ACT_IDLE then
		if self.BLBOH_Psycho_Exhausted then
			return ACT_HL2MP_IDLE_ANGRY
		elseif self.BLBOH_Psycho_Sprinting then
			return ACT_HL2MP_IDLE_MELEE
		elseif self.Alerted then
			return ACT_HL2MP_IDLE_MELEE2
		else
			return ACT_HL2MP_IDLE_SUITCASE
		end
	elseif act == ACT_WALK then
		if self.Alerted && !self.BLBOH_Psycho_Exhausted then
			return ACT_HL2MP_WALK_MELEE2
		else
			return ACT_HL2MP_WALK_SUITCASE
		end
	elseif act == ACT_RUN then
		if self.BLBOH_Psycho_Exhausted then
			return ACT_HL2MP_WALK_SUITCASE
		elseif self.BLBOH_Psycho_RecoveringFromSwing then
			return ACT_HL2MP_WALK_MELEE2
		elseif self.BLBOH_Psycho_Sprinting then
			return ACT_HL2MP_RUN_MELEE
		else
			return ACT_HL2MP_RUN_MELEE2
		end
	end
	return act
end