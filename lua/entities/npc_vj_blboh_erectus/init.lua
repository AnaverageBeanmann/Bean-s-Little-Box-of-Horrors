AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = "models/vj_blboh/erectus.mdl"
ENT.StartHealth = 3000
ENT.HullType = HULL_MEDIUM_TALL
ENT.ControllerParams = {
	CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(0, 0, -40), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "ValveBiped.Bip01_Head1", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(5, 0, 10), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = true, -- Should the bone shrink? Useful if the bone is obscuring the player's view
	FirstP_CameraBoneAng = 0, -- Should the camera's angle be affected by the bone's angle? | 0 = No, 1 = Pitch, 2 = Yaw, 3 = Roll
	FirstP_CameraBoneAng_Offset = 0, -- How much should the camera's angle be rotated by? | Useful for weird bone angles
}
--------------------
ENT.VJ_NPC_Class = {"CLASS_BLBOH"}
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
ENT.RangeAttackAnimationFaceEnemy = false
ENT.RangeAttackMinDistance = 0
ENT.RangeAttackMaxDistance = 1000
ENT.RangeAttackAngleRadius = 180
ENT.TimeUntilRangeAttackProjectileRelease = 0.1
ENT.NextRangeAttackTime = VJ.SET(8,10)
--------------------
ENT.DisableFootStepSoundTimer = true
ENT.HasBreathSound = false
ENT.SoundTbl_FootStep = "vj_blboh/erectus/taller_step.wav"
ENT.SoundTbl_Breath = "vj_blboh/erectus/rageloop.wav"
ENT.SoundTbl_Idle = {
	"vj_blboh/erectus/chase1.wav",
	"vj_blboh/erectus/chase2.wav",
	"vj_blboh/erectus/chase3.wav",
	"vj_blboh/erectus/chase4.wav"
}
ENT.SoundTbl_BeforeMeleeAttack = "vj_blboh/erectus/attack.wav"
ENT.SoundTbl_Death = "vj_blboh/erectus/die.wav"
ENT.NextSoundTime_Breath = VJ.SET(1.05,1.05)
ENT.NextSoundTime_Idle = VJ.SET(3,6)
ENT.FootstepSoundLevel = 75
ENT.BreathSoundLevel = 80
ENT.BeforeMeleeAttackSoundLevel = 70
ENT.MainSoundPitch = 100
ENT.IdleSoundPitch = VJ.SET(90,110)
ENT.BeforeMeleeAttackSoundPitch = VJ.SET(95,105)
ENT.DeathSoundPitch = VJ.SET(80, 70)
--------------------
ENT.BLBOH_DoSpawnSequence = false
ENT.BLBOH_CanDoSpawnSequence = true
ENT.BLBOH_IsHordeBoss = false
ENT.BLBOH_SpawnLightLevel = "0"
ENT.BLBOH_HasPortal = false
ENT.BLBOH_Erectus_ENRAGED = false
ENT.BLBOH_Erectus_FogT = 0
ENT.BLBOH_Erectus_Spawning = false
ENT.BLBOH_Erectus_GottaGoFast = false
ENT.BLBOH_Erectus_TooFarTimer = CurTime()
ENT.BLBOH_Erectus_CountDownTFT = false
ENT.BLBOH_Erectus_PlayerStamina = 0
ENT.BLBOH_Erectus_PlayerSprintToggleDelay = CurTime()
ENT.BLBOH_Erectus_PlayerStaminaPrintDelay = CurTime()
--------------------
function ENT:PreInit()
	if GetConVar("vj_blboh_spawn_sequences"):GetInt() == 1 && self.BLBOH_CanDoSpawnSequence then
		self.BLBOH_DoSpawnSequence = true
	end
end
--------------------
function ENT:Init()

	-- self:CapabilitiesRemove(bit.bor(CAP_ANIMATEDFACE))

	self:SetCollisionBounds(Vector(16, 16, 120), Vector(-16, -16, 0))

	if self.BLBOH_DoSpawnSequence then

		self.BLBOH_Erectus_Spawning = true

		self.EnemyDetection = false
		self.CanInvestigate = false
		self:AddFlags(FL_NOTARGET)
		self.GodMode = true
		self:SetMaterial("hud/killicons/default")
		self:DrawShadow(false)
		self.HasSounds = false

		self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK,5)

		self.SpawnLight = ents.Create("light_dynamic")
		self.SpawnLight:SetKeyValue("brightness", "7.5")
		self.SpawnLight:SetKeyValue("distance", "0")
		self.SpawnLight:SetLocalPos(self:GetPos())
		self.SpawnLight:SetLocalAngles(self:GetAngles())
		self.SpawnLight:Fire("Color", "100 100 100 255")
		self.SpawnLight:SetParent(self)
		self.SpawnLight:Spawn()
		self.SpawnLight:Activate()
		self.SpawnLight:Fire("SetParentAttachment","chest")
		self.SpawnLight:Fire("TurnOn", "", 0)
		self:DeleteOnRemove(self.SpawnLight)

		self.SpawnSprite1 = ents.Create("env_sprite")
		self.SpawnSprite1:SetKeyValue("model","vj_base/sprites/glow.vmt")
		self.SpawnSprite1:SetKeyValue("scale", "2")
		self.SpawnSprite1:SetKeyValue("rendermode","5")
		self.SpawnSprite1:SetKeyValue("rendercolor","100 100 100 255")
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
			self.SpawnSprite2:SetKeyValue("model","sprites/vj_blboh/blueflare1.vmt")
			self.SpawnSprite2:SetKeyValue("scale", "1.5")
			self.SpawnSprite2:SetKeyValue("rendermode","5")
			self.SpawnSprite2:SetKeyValue("rendercolor","100 100 100 255")
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
			self.SpawnSprite3:SetKeyValue("model","sprites/vj_blboh/combineball_glow_black_1.vmt")
			self.SpawnSprite3:SetKeyValue("scale", "0.5")
			self.SpawnSprite3:SetKeyValue("rendermode","5")
			self.SpawnSprite3:SetKeyValue("rendercolor","100 100 100 255")
			self.SpawnSprite3:SetKeyValue("spawnflags","1") -- If animated
			self.SpawnSprite3:SetParent(self)
			self.SpawnSprite3:Fire("SetParentAttachment", "chest")
			self.SpawnSprite3:Spawn()
			self.SpawnSprite3:Activate()
			self:DeleteOnRemove(self.SpawnSprite3)

		end end)

		timer.Simple(5,function() if IsValid(self) then

			self.EnemyDetection = true
			self.CanInvestigate = true
			self:RemoveFlags(FL_NOTARGET)
			self.GodMode = false
			self:SetMaterial("")
			self:DrawShadow(true)
			self.HasSounds = true

			self.BLBOH_Erectus_Spawning = false
			self.BLBOH_SpawnLightBoom = true

			self:StopParticles() -- i don't think we actually need this

			effects.BeamRingPoint(self:GetPos() + self:GetUp() * 50 + self:GetRight() * 0, 0.8, 0, 100, 5, 5, Color(195, 195, 195), {material="sprites/physgbeamb", framerate=20})
			effects.BeamRingPoint(self:GetPos() + self:GetUp() * 75 + self:GetRight() * 0, 0.8, 0, 150, 5, 5, Color(195, 195, 195), {material="sprites/physgbeamb", framerate=20})
			effects.BeamRingPoint(self:GetPos() + self:GetUp() * 100 + self:GetRight() * 0, 0.8, 0, 100, 5, 5, Color(195, 195, 195), {material="sprites/physgbeamb", framerate=20})

			util.ScreenShake(self:GetPos(), 10, 10, 2.5, 1000)

			VJ.EmitSound(self,"ambient/explosions/exp"..math.random(1,4)..".wav",80,100)
			VJ.EmitSound(self,"ambient/explosions/exp"..math.random(1,4)..".wav",80,90)
			VJ.EmitSound(self,"weapons/physcannon/energy_sing_explosion2.wav",70,55)

			if self.BLBOH_IsHordeBoss then
				self.SoundTbl_SoundTrack = {"vj_blboh/horde/Oki_Doki!!.mp3"}
				self.HasSoundTrack = true
				self:StartSoundTrack()
			end

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
		-- timer.Simple(8,function() if IsValid(self) then
			-- self.HasRangeAttack = true -- do we need this?
		-- end end)
		timer.Simple(10,function() if IsValid(self) then
			self.SpawnLight:Fire("Kill", "", 0)
		end end)
	else
		-- self.HasRangeAttack = true
	end

end
--------------------
function ENT:BLBOH_GivePortal()

	self.BLBOH_HasPortal = true

	self.HasRangeAttack = false

	VJ.EmitSound(self,{"vj_blboh/erectus/unfect.ogg"},85,math.random(90,110))

	timer.Simple(1,function() if IsValid(self) then

		self.ErectusLight = ents.Create("light_dynamic")
		self.ErectusLight:SetKeyValue("brightness", "7")
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
		self.ErectusChestSprite1:SetKeyValue("model","vj_base/sprites/glow.vmt")
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
		self.ErectusChestSprite2:SetKeyValue("model","sprites/vj_blboh/blueflare1.vmt")
		self.ErectusChestSprite2:SetKeyValue("scale", "0.75")
		self.ErectusChestSprite2:SetKeyValue("rendermode","5")
		self.ErectusChestSprite2:SetKeyValue("rendercolor","100 100 100 255")
		self.ErectusChestSprite2:SetKeyValue("spawnflags","1") -- If animated
		self.ErectusChestSprite2:SetParent(self)
		self.ErectusChestSprite2:Fire("SetParentAttachment", "chest")
		self.ErectusChestSprite2:Spawn()
		self.ErectusChestSprite2:Activate()
		self:DeleteOnRemove(self.ErectusChestSprite2)
		
		self.ErectusChestSprite3 = ents.Create("env_sprite")
		self.ErectusChestSprite3:SetKeyValue("model","sprites/vj_blboh/combineball_glow_black_1.vmt")
		self.ErectusChestSprite3:SetKeyValue("scale", "0.5")
		self.ErectusChestSprite3:SetKeyValue("rendermode","5")
		self.ErectusChestSprite3:SetKeyValue("rendercolor","100 100 100 255")
		self.ErectusChestSprite3:SetKeyValue("spawnflags","1") -- If animated
		self.ErectusChestSprite3:SetParent(self)
		self.ErectusChestSprite3:Fire("SetParentAttachment", "chest")
		self.ErectusChestSprite3:Spawn()
		self.ErectusChestSprite3:Activate()
		self:DeleteOnRemove(self.ErectusChestSprite3)

		if self.BLBOH_Erectus_ENRAGED then

			self.ErectusLight:Fire("Color", "255 0 0 255")
			self.ErectusChestSprite1:SetKeyValue("rendercolor","142 0 0 255")
			-- self.ErectusChestSprite2:SetKeyValue("scale", "0.35")
			self.ErectusChestSprite2:SetKeyValue("rendercolor","255 0 0 255")
			-- self.ErectusChestSprite3:SetKeyValue("scale", "0.35")
			self.ErectusChestSprite3:SetKeyValue("rendercolor","255 0 0 255")

		end

	end end)

	timer.Simple(math.random(1,5),function() if IsValid(self) then

		self.HasRangeAttack = true

	end end)

end
--------------------
function ENT:BLBOH_RemovePortal()

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

	-- if self.HasRangeAttack then
		-- PrintMessage(4,"yeah")
	-- else
		-- PrintMessage(4,"nah")
	-- end

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
		self:BLBOH_GivePortal()
	end
	if (self:Health() < (self:GetMaxHealth() * 0.5)) && !self.BLBOH_Erectus_ENRAGED && !self.Dead && !IsValid(self.SpawnLight) then
		self.BLBOH_Erectus_ENRAGED = true
		-- self.RangeAttackEntityToSpawn = "obj_vj_blboh_erectus_horrorball_rage"
		-- self.AnimTbl_RangeAttack = false
		self.NextRangeAttackTime = VJ.SET(3,5)
		util.ScreenShake(self:GetPos(), 5, 10, 2, 700)
		self.HasBreathSound = true
		-- self.BeforeMeleeAttackSoundPitch = VJ.SET(90,100)
		VJ.EmitSound(self,{"vj_blboh/erectus/enrage.wav"},100,100)
		VJ.EmitSound(self,{"vj_blboh/erectus/die.wav"},80,math.random(100,90))
		if IsValid(self.ErectusChestSprite1) && IsValid(self.ErectusChestSprite2) && IsValid(self.ErectusChestSprite3) && IsValid(self.ErectusLight) then -- see if we can replace this with just "if !self.BLBOH_HasPortal then"
			self.ErectusLight:Fire("Color", "255 0 0 255")
			self.ErectusChestSprite1:SetKeyValue("rendercolor","142 0 0 255")
			-- self.ErectusChestSprite2:SetKeyValue("scale", "0.35")
			self.ErectusChestSprite2:SetKeyValue("rendercolor","255 0 0 255")
			-- self.ErectusChestSprite3:SetKeyValue("scale", "0.35")
			self.ErectusChestSprite3:SetKeyValue("rendercolor","255 0 0 255")
		end
		self.EyeSprite1 = ents.Create("env_sprite")
		self.EyeSprite1:SetKeyValue("model","vj_base/sprites/glow.vmt")
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
		self.EyeSprite2:SetKeyValue("model","vj_base/sprites/glow.vmt")
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
	if !self.VJ_IsBeingControlled then
		if
			self:GetEnemy() != nil &&
			(
				!self.BLBOH_Erectus_ENRAGED &&
				self:GetPos():Distance(self:GetEnemy():GetPos()) >= 1000
			or
				self.BLBOH_Erectus_ENRAGED &&
				self:GetPos():Distance(self:GetEnemy():GetPos()) >= 650
			) &&
			!self.BLBOH_Erectus_CountDownTFT
		then
			if self.BLBOH_Erectus_GottaGoFast then
				self.BLBOH_Erectus_TooFarTimer = CurTime() + 3
			else
				self.BLBOH_Erectus_TooFarTimer = CurTime() + 6
			end
			self.BLBOH_Erectus_CountDownTFT = true
			-- PrintMessage(4,"Countdown is True")
			-- self.BLBOH_Erectus_TooFarTimer = 2
		elseif
			!self.BLBOH_Erectus_GottaGoFast &&
			(
				self:GetEnemy() == nil
			or
				self:GetEnemy() != nil &&
				(
					!self.BLBOH_Erectus_ENRAGED &&
					self:GetPos():Distance(self:GetEnemy():GetPos()) <= 500
				or
					self.BLBOH_Erectus_ENRAGED &&
					self:GetPos():Distance(self:GetEnemy():GetPos()) <= 300
				)
			) &&
				self.BLBOH_Erectus_CountDownTFT
		then
			self.BLBOH_Erectus_CountDownTFT = false
			-- PrintMessage(4,"Countdown is False")
		end
		if self.BLBOH_Erectus_CountDownTFT && self.BLBOH_Erectus_TooFarTimer < CurTime() && !self.BLBOH_Erectus_GottaGoFast then
			self.BLBOH_Erectus_GottaGoFast = true
			-- PrintMessage(4,"Too far for too long; Erectus is speeding up")
		end
	else
		if self.VJ_TheController:KeyDown(IN_JUMP) && self.BLBOH_Erectus_PlayerSprintToggleDelay < CurTime() then
			self.BLBOH_Erectus_PlayerSprintToggleDelay = CurTime() + 1
			if !self.BLBOH_Erectus_GottaGoFast then
				self.BLBOH_Erectus_GottaGoFast = true
				self.VJ_TheController:ChatPrint("Starting sprint!")
				self.VJ_TheController:SendLua("surface.PlaySound('player/suit_sprint.wav')")
			elseif self.BLBOH_Erectus_GottaGoFast then
				self.VJ_TheController:ChatPrint("Stopping sprint!")
				self.VJ_TheController:SendLua("surface.PlaySound('player/suit_denydevice.wav')")
				self.BLBOH_Erectus_GottaGoFast = false
			end
		elseif self.VJ_TheController:KeyDown(IN_RELOAD) && self.BLBOH_Erectus_PlayerStaminaPrintDelay < CurTime() then
			self.BLBOH_Erectus_PlayerStaminaPrintDelay = CurTime() + 1
			self.VJ_TheController:ChatPrint("Your stamina value is "..self.BLBOH_Erectus_PlayerStamina..".")
			self.VJ_TheController:SendLua("surface.PlaySound('buttons/button16.wav')")
		end
		-- PrintMessage(4,""..self.BLBOH_Erectus_PlayerStamina.."")
		if !self.BLBOH_Erectus_GottaGoFast && self.BLBOH_Erectus_PlayerStamina < 500 then
			if !self.BLBOH_Erectus_ENRAGED then
				self.BLBOH_Erectus_PlayerStamina = self.BLBOH_Erectus_PlayerStamina + 7
			else
				self.BLBOH_Erectus_PlayerStamina = self.BLBOH_Erectus_PlayerStamina + 4
			end
			if self.BLBOH_Erectus_PlayerStamina >= 500 then
				self.BLBOH_Erectus_PlayerStamina = 500
				self.VJ_TheController:ChatPrint("Stamina is full!")
				self.VJ_TheController:SendLua("surface.PlaySound('items/suitchargeno1.wav')")
			end
		elseif self.BLBOH_Erectus_GottaGoFast then
			if !self.BLBOH_Erectus_ENRAGED then
				self.BLBOH_Erectus_PlayerStamina = self.BLBOH_Erectus_PlayerStamina - 1
			else
				self.BLBOH_Erectus_PlayerStamina = self.BLBOH_Erectus_PlayerStamina - 3
			end
			if self.BLBOH_Erectus_PlayerStamina <= 0 then
				self.BLBOH_Erectus_GottaGoFast = false
				self.VJ_TheController:ChatPrint("Ran out of stamina!")
				self.VJ_TheController:SendLua("surface.PlaySound('player/suit_denydevice.wav')")
			end
		end
		-- if self.BLBOH_Erectus_PlayerStamina
	end


-- ENT.BLBOH_Erectus_GottaGoFast = false
-- ENT.BLBOH_Erectus_TooFarTimer = CurTime()
-- ENT.BLBOH_Erectus_CountDownTFT = false
end
--------------------
function ENT:OnInput(key, activator, caller, data)

	if key == "step" then
		util.ScreenShake(self:GetPos(), 5, 5, 1, 350)
		VJ.EmitSound(self,self.SoundTbl_FootStep,self.FootstepSoundLevel)
	elseif key == "attack" then
		self.MeleeAttackDamage = 50
		self.MeleeAttackDamageType = DMG_CLUB
		self.HasMeleeAttackKnockBack = true
		self.SoundTbl_MeleeAttack = {"vj_blboh/erectus/taller_player_punch.wav"}
		self.SoundTbl_MeleeAttackMiss = {"vj_blboh/erectus/taller_swing.wav"}
		self:MeleeAttackCode()
	elseif key == "stomp" then
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
	elseif key == "death" then
		VJ.ApplyRadiusDamage(self, self, self:GetPos(), 140, 20, DMG_PHYSGUN, false, true, {DisableVisibilityCheck=true, Force=8110})
		for _, v in ipairs(ents.FindInSphere(self:GetPos(), 140)) do
			if v:IsPlayer() and v:Alive() then -- add npc nextbot and prop support blah blah blah
				v:SetLocalVelocity(v:GetVelocity()+Vector(0,0,350))
			end
		end
		self:SetMaterial("hud/killicons/default")
		self:DrawShadow(false)
		util.ScreenShake(self:GetPos(), 15, 15, 2, 500)
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
		VJ.STOPSOUND(self.CurrentDeathSound)
		VJ.EmitSound(self,{"ambient/machines/thumper_dust.wav"},100,math.random(100,90))
		VJ.EmitSound(self,{"vj_blboh/leonard/concrete_break2.wav"},80,math.random(50,40))
	end
end
--------------------
function ENT:OnMeleeAttack(status, enemy)
	if status == "PostInit" && self.BLBOH_Erectus_GottaGoFast then
		self.BLBOH_Erectus_GottaGoFast = false
		if self.VJ_IsBeingControlled then
			self.BLBOH_Erectus_PlayerSprintToggleDelay = CurTime() + 1
			self.VJ_TheController:ChatPrint("Sprint ended because of attack!")
			self.VJ_TheController:SendLua("surface.PlaySound('player/suit_denydevice.wav')")
		end
	end
end
--------------------
function ENT:MeleeAttackKnockbackVelocity(hitEnt)
	return self:GetForward() * 150 + self:GetUp() * 250
end
--------------------
-- isn't working
-- function ENT:OnRangeAttack(status, enemy)
	-- if status == "PreInit" then
		-- if self:GetEnemy() != nil && self:IsUnreachable(self:GetEnemy()) && self.AnimTbl_RangeAttack == false then
			-- self.AnimTbl_RangeAttack = ACT_RANGE_ATTACK1
		-- elseif self:GetEnemy() == nil or self:GetEnemy() != nil && !self:IsUnreachable(self:GetEnemy()) && self.AnimTbl_RangeAttack == ACT_RANGE_ATTACK1 then
			-- self.AnimTbl_RangeAttack = false
		-- end
	-- end
-- end
--------------------
function ENT:OnRangeAttackExecute(status, enemy, projectile)
	if status == "PreSpawn" && self.BLBOH_Erectus_ENRAGED then
		projectile.BLBOH_HorrorBall_RageBall = true
	elseif status == "PostSpawn" && self.BLBOH_HasPortal then
		self:BLBOH_RemovePortal()
	end
end
--------------------
function ENT:RangeAttackProjPos(projectile)
	return self:GetAttachment(self:LookupAttachment("chest")).Pos
end
--------------------
function ENT:RangeAttackProjVel(projectile)
	if self:GetEnemy() != nil && self:IsUnreachable(self:GetEnemy()) then
		return VJ.CalculateTrajectory(self, self:GetEnemy(), "Curve", projectile:GetPos(), 0, 1)
	else
		return (self:GetEnemy():GetPos() - self:GetPos()) *0.45 + self:GetUp() * math.random(-200,200) + self:GetRight() * math.random(-200,200)
	end
end
--------------------
function ENT:OnDeath(dmginfo, hitgroup, status)

	if status == "Init" then
		if self.BLBOH_HasPortal && IsValid(self.ErectusLight) then
			self:BLBOH_RemovePortal()
		end
		if self.BLBOH_Erectus_ENRAGED then
			self.EyeSprite1:Fire("Kill", "", 0.1)
			self.EyeSprite2:Fire("Kill", "", 0.1)
			self.RageMouthLight:Fire("Kill", "", 0)
			VJ.EmitSound(self,{"vj_blboh/erectus/enrageend.wav"},100,100)
		end
	elseif status == "Finish" then
		-- now that i think about it, do we actually need this?
		-- local DeathFogEffect = EffectData()
		-- DeathFogEffect:SetOrigin(self:GetPos() + self:GetUp()*25)
		-- DeathFogEffect:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
		-- DeathFogEffect:SetScale(200)
		-- util.Effect("VJ_Blood1",DeathFogEffect)
	end
end
--------------------
function ENT:Controller_Initialize(ply, controlEnt)
	ply:ChatPrint("RELOAD: Print Stamina; JUMP: Toggle Sprint")
	ply:ChatPrint("You have a stamina meter that fills up over time when not sprinting; You need stamina to sprint.")
	-- ply:ChatPrint("You will get notifications when your stamina is full and when it gets emptied.")
	ply:ChatPrint("Melee attacking while sprinting automatically stops the sprint.")
	ply:ChatPrint("You will +ENRAGE at half health; When +ENRAGED you move faster and can spawn portals more often.")
	ply:ChatPrint("While +ENRAGED, you recover stamina slower and it drains faster.")
end
--------------------
function ENT:TranslateActivity(act)
	if act == ACT_RUN && self.BLBOH_Erectus_ENRAGED && self.BLBOH_Erectus_GottaGoFast then
		return ACT_SPRINT
	elseif act == ACT_RUN && !self.BLBOH_Erectus_ENRAGED && !self.BLBOH_Erectus_GottaGoFast then
		return ACT_WALK
	elseif act == ACT_WALK && self.VJ_IsBeingControlled && self.BLBOH_Erectus_GottaGoFast then
		if !self.BLBOH_Erectus_ENRAGED then
			return ACT_RUN
		elseif self.BLBOH_Erectus_ENRAGED then
			return ACT_SPRINT
		end
	end
	return act
end