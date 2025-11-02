AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = "models/vj_blboh/wretch.mdl"
ENT.StartHealth = 150 -- original value was 200
ENT.ControllerParams = {
	ThirdP_Offset = Vector(30, 0, -60), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "Antlion.FangTopL1_Bone", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(20, 0, 40), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = true, -- Should the bone shrink? Useful if the bone is obscuring the player's view
	FirstP_CameraBoneAng = 0, -- Should the camera's angle be affected by the bone's angle? | 0 = No, 1 = Pitch, 2 = Yaw, 3 = Roll
	FirstP_CameraBoneAng_Offset = 0, -- How much should the camera's angle be rotated by? | Useful for weird bone angles
}
--------------------
ENT.VJ_NPC_Class = {"CLASS_BLBOH"}
ENT.HasPoseParameterLooking = false
--------------------
ENT.BloodColor = VJ.BLOOD_COLOR_OIL
--------------------
-- ENT.MeleeAttackDamage = 10 -- if this is staying at 10 then we can remove it, since 10 is the default
ENT.MeleeAttackDamageType = DMG_CLUB
ENT.MeleeAttackDistance = 75
ENT.MeleeAttackDamageDistance = 90
ENT.TimeUntilMeleeAttackDamage = false
--------------------
ENT.DisableFootStepSoundTimer = true
ENT.SoundTbl_FootStep = {
	"npc/fast_zombie/foot1.wav",
	"npc/fast_zombie/foot2.wav",
	"npc/fast_zombie/foot3.wav",
	"npc/fast_zombie/foot4.wav"
}
ENT.SoundTbl_Alert = {
	"vj_blboh/wretch/hurt1.wav",
	"vj_blboh/wretch/hurt2.wav",
	"vj_blboh/wretch/hurt3.wav",
	"vj_blboh/wretch/gargle3.wav"
}
ENT.SoundTbl_BeforeMeleeAttack = {
	"vj_blboh/wretch/hurt1.wav",
	"vj_blboh/wretch/hurt2.wav",
	"vj_blboh/wretch/hurt3.wav",
}
ENT.SoundTbl_MeleeAttack = {
	"npc/zombie/claw_strike1.wav",
	"npc/zombie/claw_strike2.wav",
	"npc/zombie/claw_strike3.wav"
}
ENT.SoundTbl_MeleeAttackMiss = {
	"weapons/knife/knife_slash1.wav",
	"weapons/knife/knife_slash2.wav"
}
ENT.SoundTbl_Pain = {
	"vj_blboh/wretch/hurt1.wav",
	"vj_blboh/wretch/hurt2.wav",
	"vj_blboh/wretch/hurt3.wav"
}
ENT.SoundTbl_Death = "vj_blboh/wretch/gargle3.wav"
ENT.BeforeMeleeAttackSoundPitch = VJ.SET(95, 120)
ENT.PainSoundPitch = VJ.SET(80,110)
ENT.DeathSoundPitch = VJ.SET(60, 100)
--------------------
ENT.BLBOH_DoSpawnSequence = false
ENT.BLBOH_CanDoSpawnSequence = true
ENT.BLBOH_Wretch_TauntCooldown = CurTime()
ENT.BLBOH_Wretch_DodgeCooldown = CurTime()
ENT.BLBOH_Wretch_Underground = false
ENT.BLBOH_Wretch_UndergroundHideTime = CurTime()
ENT.BLBOH_Wretch_UndergroundRumbleTime = CurTime()
ENT.BLBOH_Wretch_UndergroundPlayerDelay = CurTime()
ENT.BLBOH_Wretch_DiggingOut = false
--------------------
function ENT:PreInit()
	if GetConVar("vj_blboh_spawn_sequences"):GetInt() == 1 && self.BLBOH_CanDoSpawnSequence then
		self.BLBOH_DoSpawnSequence = true
	end
end
--------------------
function ENT:Init()

	if self.BLBOH_DoSpawnSequence then

		local SpawnEffectData = EffectData()

		self.EnemyDetection = false
		self.CanInvestigate = false
		self:AddFlags(FL_NOTARGET)
		self.GodMode = true
		self:SetMaterial("hud/killicons/default")
		self:DrawShadow(false)
		self.HasSounds = false

		self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK,3)

		timer.Simple(1,function() if IsValid(self) then
			SpawnEffectData:SetOrigin(self:GetPos())
			SpawnEffectData:SetScale(25)
			util.Effect("ThumperDust", SpawnEffectData)

			SpawnEffectData:SetOrigin(self:GetPos() + self:GetUp()*25 + self:GetForward()*25)
			SpawnEffectData:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
			SpawnEffectData:SetScale(50)
			util.Effect("VJ_Blood1",SpawnEffectData)

			SpawnEffectData:SetOrigin(self:GetPos() + self:GetUp()*25 + self:GetForward()*-25)
			util.Effect("VJ_Blood1",SpawnEffectData)

			SpawnEffectData:SetOrigin(self:GetPos() + self:GetUp()*25 + self:GetRight()*25)
			util.Effect("VJ_Blood1",SpawnEffectData)

			SpawnEffectData:SetOrigin(self:GetPos() + self:GetUp()*25 + self:GetRight()*-25)
			util.Effect("VJ_Blood1",SpawnEffectData)

			-- why is this here?
			SpawnEffectData:SetOrigin(self:GetPos())
			util.Effect("ThumperDust", SpawnEffectData)

			util.ScreenShake(self:GetPos(), 1, 40, 3, 600)

			VJ.EmitSound(self,"npc/antlion/muffled_boulder_impact_hard"..math.random(1,2)..".wav",80,math.random(80,110))

			timer.Simple(1,function() if IsValid(self) then

				SpawnEffectData:SetOrigin(self:GetPos())
				SpawnEffectData:SetScale(40)
				util.Effect("ThumperDust", SpawnEffectData)

				SpawnEffectData:SetOrigin(self:GetPos() + self:GetUp()*25 + self:GetForward()*25)
				SpawnEffectData:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
				SpawnEffectData:SetScale(75)
				util.Effect("VJ_Blood1",SpawnEffectData)

				SpawnEffectData:SetOrigin(self:GetPos() + self:GetUp()*25 + self:GetForward()*-25)
				util.Effect("VJ_Blood1",SpawnEffectData)

				SpawnEffectData:SetOrigin(self:GetPos() + self:GetUp()*25 + self:GetRight()*25)
				util.Effect("VJ_Blood1",SpawnEffectData)

				SpawnEffectData:SetOrigin(self:GetPos() + self:GetUp()*25 + self:GetRight()*-25)
				util.Effect("VJ_Blood1",SpawnEffectData)

				SpawnEffectData:SetOrigin(self:GetPos())
				util.Effect("ThumperDust", SpawnEffectData)

				util.ScreenShake(self:GetPos(), 1.5, 40, 3, 600)

				VJ.EmitSound(self,"npc/antlion/muffled_boulder_impact_hard"..math.random(1,2)..".wav",80,math.random(80,110))

			end end)

			timer.Simple(1.5,function() if IsValid(self) then

				self:PlayAnim({"vjseq_digout"},true,false)

			end end)

			timer.Simple(2,function() if IsValid(self) then

				self.EnemyDetection = true
				self.CanInvestigate = true
				self:RemoveFlags(FL_NOTARGET)
				self.GodMode = false
				-- self.MovementType = VJ_MOVETYPE_GROUND
				-- self.CanTurnWhileStationary = true
				self:SetMaterial("")
				self:DrawShadow(true)
				self.HasSounds = true

				SpawnEffectData:SetOrigin(self:GetPos() + self:GetUp()*25 + self:GetForward()*25)
				SpawnEffectData:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
				SpawnEffectData:SetScale(100)
				util.Effect("VJ_Blood1",SpawnEffectData)

				SpawnEffectData:SetOrigin(self:GetPos() + self:GetUp()*25 + self:GetForward()*-25)
				util.Effect("VJ_Blood1",SpawnEffectData)

				SpawnEffectData:SetOrigin(self:GetPos() + self:GetUp()*25 + self:GetRight()*25)
				util.Effect("VJ_Blood1",SpawnEffectData)

				SpawnEffectData:SetOrigin(self:GetPos() + self:GetUp()*25 + self:GetRight()*-25)
				util.Effect("VJ_Blood1",SpawnEffectData)

				SpawnEffectData:SetOrigin(self:GetPos())
				util.Effect("ThumperDust", SpawnEffectData)

				util.ScreenShake(self:GetPos(), 2.5, 40, 3, 450)

				VJ.EmitSound(self,"physics/concrete/boulder_impact_hard"..math.random(1,4)..".wav",80,math.random(80,110))
				-- VJ.EmitSound(self,self.SoundTbl_Alert,80)


			end end)
		end end)
	end

end
--------------------
function ENT:OnThinkActive()
	-- Dodging
	if (
			(
				!self.VJ_IsBeingControlled &&
				!self:IsBusy("Activites") &&
				self.AttackState == VJ.ATTACK_STATE_NONE &&
				self:OnGround() &&
				!self.IsGuard &&
				IsValid(self:GetEnemy()) &&
				(self:GetEnemy():GetForward():Dot((self:GetPos() -self:GetEnemy():GetPos()):GetNormalized()) > math.cos(math.rad(10))) && -- enemy is looking right at us
				math.random(1,5) == 1
			)
		-- ^^^ check if we're not being controlled, not busy, not attacking, we're on the ground, not guarding, we have a valid enemy, our enemy is looking at us, and a 1/5 chance passes
		or
			(
				self.VJ_IsBeingControlled &&
				(
					self.VJ_TheController:KeyDown(IN_JUMP) && self.VJ_TheController:KeyDown(IN_MOVELEFT)
					or
					self.VJ_TheController:KeyDown(IN_JUMP) && self.VJ_TheController:KeyDown(IN_MOVERIGHT)
				)
			)
		) &&
		!self.BLBOH_Wretch_Underground &&
		self.BLBOH_Wretch_DodgeCooldown < CurTime()
	then
		if !self.VJ_IsBeingControlled then
			self.BLBOH_Wretch_DodgeCooldown = CurTime() + math.random(3,7)
			if math.random(1,2) == 1 then
				self:PlayAnim("vjseq_scuttleleft","LetAttacks",0.5,"Visible")
			else
				self:PlayAnim("vjseq_scuttlert","LetAttacks",0.5,"Visible")
			end
		else
			self.BLBOH_Wretch_DodgeCooldown = CurTime() + 0.5
			self.BLBOH_Wretch_UndergroundPlayerDelay = CurTime() + 0.5
			if self.VJ_TheController:KeyDown(IN_JUMP) && self.VJ_TheController:KeyDown(IN_MOVELEFT) then
				self:PlayAnim("vjseq_scuttleleft","LetAttacks",0.5,"Visible")
			elseif self.VJ_TheController:KeyDown(IN_JUMP) && self.VJ_TheController:KeyDown(IN_MOVERIGHT) then
				self:PlayAnim("vjseq_scuttlert","LetAttacks",0.5,"Visible")
			end
		end
	end
	-- Underground Stuff
	if self.VJ_IsBeingControlled && self.VJ_TheController:KeyDown(IN_ATTACK2) && !self.BLBOH_Wretch_Underground && self.BLBOH_Wretch_UndergroundPlayerDelay < CurTime() then
		self.BLBOH_Wretch_UndergroundPlayerDelay = CurTime() + 3
		self.BLBOH_Wretch_Underground = true
		self:PlayAnim("vjseq_digin",true,3,false)
	end
	if self.BLBOH_Wretch_Underground && !self.BLBOH_Wretch_DiggingOut then
		if (self.BLBOH_Wretch_UndergroundHideTime < CurTime() && !self.VJ_IsBeingControlled) or (self.VJ_IsBeingControlled && self.VJ_TheController:KeyDown(IN_ATTACK2) && self.BLBOH_Wretch_UndergroundPlayerDelay < CurTime()) then
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
			-- make sure we're not inside anything
			if !tr1.Hit && !tr2.Hit && !tr3.Hit && !tr4.Hit then
				self.BLBOH_Wretch_DiggingOut = true
				self.BLBOH_Wretch_UndergroundPlayerDelay = CurTime() + 3
				self:PlayAnim("vjseq_digout",true,2,false)
			else
				if self.VJ_IsBeingControlled then
					local randdigoutfailmsg = math.random(1,3)
					if randdigoutfailmsg == 1 then
						self.VJ_TheController:ChatPrint("That's a bad spot, you'd get stuck.")
					elseif randdigoutfailmsg == 2 then
						self.VJ_TheController:ChatPrint("No, you'd get stuck there.")
					else
						self.VJ_TheController:ChatPrint("Not there, you'd get stuck.")
					end
					self.VJ_TheController:SendLua("surface.PlaySound('buttons/button18.wav')")
					self.BLBOH_Wretch_UndergroundPlayerDelay = CurTime() + 1
				else
					self.BLBOH_Wretch_UndergroundHideTime = CurTime() + math.random(1,3)
				end
			end
		end
		if self.BLBOH_Wretch_UndergroundRumbleTime < CurTime() then
			if self:IsMoving() then
				self.BLBOH_Wretch_UndergroundRumbleTime = CurTime() + 1
				local UndergroundRumbleEffectData = EffectData()
				UndergroundRumbleEffectData:SetOrigin(self:GetPos())
				UndergroundRumbleEffectData:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
				UndergroundRumbleEffectData:SetScale(75)
				util.Effect("VJ_Blood1",UndergroundRumbleEffectData)
				util.ScreenShake(self:GetPos(), 1, 40, 3, 600)
				VJ.EmitSound(self,"npc/antlion/muffled_boulder_impact_hard"..math.random(1,2)..".wav",80,math.random(80,110))
			else
				self.BLBOH_Wretch_UndergroundRumbleTime = CurTime() + 0.25
			end
		end
	end
	-- Growling
	if (
			(
				!self.VJ_IsBeingControlled &&
				IsValid(self:GetEnemy()) &&
				self:IsUnreachable(self:GetEnemy()) &&
				math.random(1,25) == 1 &&
				self:OnGround()
			)
		or
			(
				self.VJ_IsBeingControlled &&
				self.VJ_TheController:KeyDown(IN_RELOAD)
			)
		)
		&&
		!self.BLBOH_Wretch_Underground &&
		self.BLBOH_Wretch_TauntCooldown < CurTime()
	then
		if !self.VJ_IsBeingControlled then
			self.BLBOH_Wretch_TauntCooldown = CurTime() + math.random(5,15)
		else
			self.BLBOH_Wretch_TauntCooldown = CurTime() + 4
			self.BLBOH_Wretch_UndergroundPlayerDelay = CurTime() + 3
		end
		self:PlayAnim("vjseq_taunt","LetAttacks",3,"Visible")
	end
end
--------------------
function ENT:OnAlert(ent)
	self.BLBOH_Wretch_TauntCooldown = CurTime() + math.random(5,15)
end
--------------------
function ENT:OnDamaged(dmginfo, hitgroup, status)
	if
		status == "PostDamage" &&
		!self.VJ_IsBeingControlled &&
		self:Health() > 0 &&
		math.random(1,15) == 1 &&
		IsValid(self:GetEnemy()) &&
		self:GetPos():Distance(self:GetEnemy():GetPos()) >= 250 &&
		self:IsUnreachable(self:GetEnemy()) == false &&
		!self.BLBOH_Wretch_Underground
	then
		self.BLBOH_Wretch_Underground = true
		self.BLBOH_Wretch_UndergroundHideTime = CurTime() + math.random(5,15)
		self:PlayAnim("vjseq_digin",true,3,false)
	-- if status == "PostDamage" && self:IsUnreachable(self:GetEnemy()) == false then
		-- PrintMessage(3,"test")
	end
end
--------------------
function ENT:OnInput(key, activator, caller, data)

	if key == "step" && self:GetMaterial() != "hud/killicons/default" && !self.BLBOH_Wretch_Underground then

		VJ.EmitSound(self,self.SoundTbl_FootStep,self.FootstepSoundLevel)
		-- VJ.EmitSound(self,"npc/antlion/foot"..math.random(1,4)..".wav",60)
		VJ.EmitSound(self,"roach/ds1/d_foliage/c2330-foot"..math.random(1,3)..".wav.mp3",55,math.random(80,90))

	elseif key == "attack" or key == "attack_double" then

		self:MeleeAttackCode()

	elseif key == "jump" && !self.BLBOH_Wretch_Underground then

	elseif key == "land" && !self.BLBOH_Wretch_Underground then

		VJ.EmitSound(self,"physics/body/body_medium_impact_hard"..math.random(1,6)..".wav",65)

	elseif key == "tauntsound" then

		VJ.EmitSound(self,"npc/antlion_guard/frustrated_growl"..math.random(1,3)..".wav",80,100)

	elseif key == "digin" then

		VJ.EmitSound(self,"npc/antlion/digdown1.wav",80,math.random(70,80))
		local DigEffectData = EffectData()
		DigEffectData:SetOrigin(self:GetPos())
		DigEffectData:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
		DigEffectData:SetScale(100)
		util.Effect("VJ_Blood1",DigEffectData)
		timer.Simple(0.75,function() if IsValid(self) then
			util.Effect("VJ_Blood1",DigEffectData)
		end end)

	elseif key == "dighide" then

		self.BLBOH_Wretch_DiggingOut = false
		self.BLBOH_Wretch_UndergroundRumbleTime = CurTime() + 1

		self.HasMeleeAttack = false
		self.GodMode = true
		self:AddFlags(FL_NOTARGET)
		self:SetSolid(SOLID_NONE)
		self:SetMaterial("hud/killicons/default")
		-- self:SetMaterial("models/wireframe")
		self:DrawShadow(false)
		self.HasSounds = false

		self.HealthRegenParams = {
			Enabled = true,
			Amount = 3,
			Delay = VJ.SET(2,2), -- see if this works as just a number and not a VJ.SET
		}
		self:CapabilitiesRemove(CAP_MOVE_JUMP)
		self:RemoveAllDecals()

	elseif key == "digout" then

		self.BLBOH_Wretch_Underground = false

		self.HasMeleeAttack = true
		self.GodMode = false
		self:RemoveFlags(FL_NOTARGET)
		self:SetSolid(SOLID_BBOX)
		self:SetMaterial("")
		self:DrawShadow(true)
		self.HasSounds = true

		self.HealthRegenParams = {
			Enabled = false,
		}
		self:CapabilitiesAdd(CAP_MOVE_JUMP)

		local DigOutEffectData = EffectData()
		DigOutEffectData:SetOrigin(self:GetPos())
		DigOutEffectData:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
		DigOutEffectData:SetScale(100)
		util.Effect("VJ_Blood1",DigOutEffectData)
		-- VJ.EmitSound(self,"npc/antlion/digdown1.wav",80,math.random(70,80))
		VJ.EmitSound(self,"physics/concrete/boulder_impact_hard"..math.random(1,4)..".wav",80,math.random(80,110))
		VJ.EmitSound(self,self.SoundTbl_BeforeMeleeAttack,75,math.random(95,120))

	end

end
--------------------
function ENT:Controller_Initialize(ply, controlEnt)
	ply:ChatPrint("MOUSE2: Dig")
	ply:ChatPrint("Digging puts you underground, making you slow and harmless, but immune to threats and you gain slow health regen.")
	ply:ChatPrint("Click Mouse2 while underground to come back up to the surface.")
	ply:ChatPrint("JUMP + LEFT/RIGHT: Dodge")
	ply:ChatPrint("Hold JUMP and then press LEFT or Right to dodge in that direction.")
	ply:ChatPrint("RELOAD: Growl")
	timer.Simple(0.1, function() if IsValid(self) then
		self.BLBOH_Wretch_TauntCooldown = CurTime() - 15
		self.BLBOH_Wretch_DodgeCooldown = CurTime() - 15
	end end)
end
--------------------
function ENT:TranslateActivity(act)
	if act == ACT_RUN && self.BLBOH_Wretch_Underground then
		return ACT_WALK
	end
	return act
end