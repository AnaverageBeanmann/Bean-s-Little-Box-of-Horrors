AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = "models/vj_blboh/horror.mdl"
ENT.StartHealth = 20
ENT.ControllerParams = {
	ThirdP_Offset = Vector(40, 0, -20), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "anim_attachment_head", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(20, 0, 40), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = true, -- Should the bone shrink? Useful if the bone is obscuring the player's view
	FirstP_CameraBoneAng = 0, -- Should the camera's angle be affected by the bone's angle? | 0 = No, 1 = Pitch, 2 = Yaw, 3 = Roll
	FirstP_CameraBoneAng_Offset = 0, -- How much should the camera's angle be rotated by? | Useful for weird bone angles
}
--------------------
ENT.VJ_NPC_Class = {"CLASS_BLBOH"}
ENT.PropInteraction = false
--------------------
-- ENT.BloodColor = VJ.BLOOD_COLOR_OIL
--------------------
ENT.HasDeathCorpse = false
--------------------
ENT.MeleeAttackDamage = 0
ENT.MeleeAttackDistance = 50
ENT.MeleeAttackDamageDistance = 75
ENT.TimeUntilMeleeAttackDamage = false
ENT.DisableMeleeAttackAnimation = true
--------------------
ENT.DisableFootStepSoundTimer = true
ENT.HasBreathSound = false
ENT.SoundTbl_FootStep = {
	"npc/fast_zombie/foot1.wav",
	"npc/fast_zombie/foot2.wav",
	"npc/fast_zombie/foot3.wav",
	"npc/fast_zombie/foot4.wav"
}
ENT.SoundTbl_Breath = "vj_blboh/horror/sjasact_quieter.wav"
ENT.SoundTbl_Alert = "vj_blboh/horror/sjassee.wav"
ENT.SoundTbl_Pain = "vj_blboh/horror/sjaspain.wav"
ENT.SoundTbl_Death = "vj_blboh/horror/sjasdeat.wav"
ENT.NextSoundTime_Breath = VJ.SET(0.35,0.35)
ENT.BreathSoundLevel = 75
ENT.AlertSoundLevel = 80
ENT.PainSoundLevel = 80
ENT.DeathSoundLevel = 80
ENT.MainSoundPitch = 100
--------------------
ENT.BLBOH_DoSpawnSequence = false
ENT.BLBOH_CanDoSpawnSequence = true
ENT.BLBOH_ForceSpawnSequence = false
ENT.BLBOH_SpawnLightLevel = "0"
ENT.BLBOH_SpawnLightBoom = false
ENT.BLBOH_SpawnLightFadeStage = 0
ENT.BLBOH_Horror_FogT = 0
ENT.BLBOH_Horror_Spawning = false
ENT.BLBOH_Horror_AttackMode = true
ENT.BLBOH_Horror_AttackModeDelay = 0
ENT.BLBOH_Horror_PlayerDidAttack = false
ENT.BLBOH_Horror_PlayerDidAttackTimeOverNotice = false
--------------------
function ENT:PreInit()
	if (GetConVar("vj_blboh_spawn_sequences"):GetInt() == 1 && self.BLBOH_CanDoSpawnSequence) or self.BLBOH_ForceSpawnSequence then
		self.BLBOH_DoSpawnSequence = true
	end
end
--------------------
function ENT:Init()

	self:SetCollisionGroup(20)
	self:SetRenderMode( RENDERMODE_TRANSCOLOR )
	self:SetColor(Color(255,255,255,100))
	self:SetRenderFX(16)
	self:DrawShadow(false)

	if self.BLBOH_DoSpawnSequence then

		self.EnemyDetection = false
		self.CanInvestigate = false
		self:AddFlags(FL_NOTARGET)
		self.GodMode = true
		self:SetMaterial("hud/killicons/default")
		self:DrawShadow(false)
		self.HasSounds = false
		self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK,2)

		self.BLBOH_Horror_Spawning = true

		self.SpawnLight = ents.Create("light_dynamic")
		self.SpawnLight:SetKeyValue("brightness", "7.5")
		self.SpawnLight:SetKeyValue("distance", "0")
		self.SpawnLight:SetLocalPos(self:GetPos())
		self.SpawnLight:SetLocalAngles(self:GetAngles())
		self.SpawnLight:Fire("Color", "140 140 140 255")
		self.SpawnLight:SetParent(self)
		self.SpawnLight:Spawn()
		self.SpawnLight:Activate()
		self.SpawnLight:Fire("SetParentAttachment","chest")
		self.SpawnLight:Fire("TurnOn", "", 0)
		self:DeleteOnRemove(self.SpawnLight)

		self.SpawnPortalSprite1 = ents.Create("env_sprite")
		self.SpawnPortalSprite1:SetKeyValue("model","vj_base/sprites/glow.vmt")
		self.SpawnPortalSprite1:SetKeyValue("scale", "1.5")
		self.SpawnPortalSprite1:SetKeyValue("rendermode","5")
		self.SpawnPortalSprite1:SetKeyValue("rendercolor","140 140 140 255")
		self.SpawnPortalSprite1:SetKeyValue("spawnflags","1") -- If animated
		self.SpawnPortalSprite1:SetParent(self)
		self.SpawnPortalSprite1:Fire("SetParentAttachment", "forward")
		self.SpawnPortalSprite1:Fire("Kill", "", 13)
		self.SpawnPortalSprite1:Spawn()
		self.SpawnPortalSprite1:Activate()
		self:DeleteOnRemove(self.SpawnPortalSprite1)

		VJ.EmitSound(self,"vj_blboh/horror/spawn.wav",80,math.random(95,105))

		timer.Simple(0.5,function() if IsValid(self) then

			self.SpawnPortalSprite2 = ents.Create("env_sprite")
			self.SpawnPortalSprite2:SetKeyValue("model","sprites/vj_blboh/blueflare1.vmt")
			self.SpawnPortalSprite2:SetKeyValue("scale", "1.5")
			self.SpawnPortalSprite2:SetKeyValue("rendermode","5")
			self.SpawnPortalSprite2:SetKeyValue("rendercolor","140 140 140 255")
			self.SpawnPortalSprite2:SetKeyValue("spawnflags","1") -- If animated
			self.SpawnPortalSprite2:SetParent(self)
			self.SpawnPortalSprite2:Fire("SetParentAttachment", "forward")
			self.SpawnPortalSprite2:Fire("Kill", "", 13)
			self.SpawnPortalSprite2:Spawn()
			self.SpawnPortalSprite2:Activate()
			self:DeleteOnRemove(self.SpawnPortalSprite2)

		end end)

		timer.Simple(1.3,function() if IsValid(self) then

			self.EnemyDetection = true
			self.CanInvestigate = true
			self:RemoveFlags(FL_NOTARGET)
			self.GodMode = false
			self:SetMaterial("")
			self:DrawShadow(true)
			self.HasSounds = true

			self.BLBOH_SpawnLightBoom = true

			self.SpawnPortalSprite1:Fire("Kill", "", 0)
			self.SpawnPortalSprite2:Fire("Kill", "", 0)

			effects.BeamRingPoint(self:GetPos() + self:GetUp() * 20 + self:GetRight() * 6, 0.5, 0, 80, 5, 0, Color(255, 255, 255), {material="sprites/physgbeamb", framerate=20})
			effects.BeamRingPoint(self:GetPos() + self:GetUp() * 40 + self:GetRight() * 5, 0.5, 0, 100, 5, 0, Color(255, 255, 255), {material="sprites/physgbeamb", framerate=20})
			effects.BeamRingPoint(self:GetPos() + self:GetUp() * 60 + self:GetRight() * 3, 0.5, 0, 80, 5, 0, Color(255, 255, 255), {material="sprites/physgbeamb", framerate=20})

			VJ.EmitSound(self,"ambient/machines/thumper_dust.wav",80,math.random(95,105))

		end end)

	end

end
--------------------
function ENT:BLBOH_Horror_ToggleAttackMode(togglemode)
	if togglemode == "Activate" then
	self:SetSolid(SOLID_BBOX)
	self:RemoveFlags(FL_NOTARGET)
				self.BLBOH_Horror_AttackMode = true
		-- PrintMessage(4,"Attack Mode Activated")
		VJ.EmitSound(self,"vj_blboh/horror/sjassee.wav",self.AlertSoundLevel)
		timer.Simple(1, function() if IsValid(self) && self.BLBOH_Horror_AttackMode then
			self.HasMeleeAttack = true
		end end)
		self:SetColor(Color(255,255,255,100))
		self:SetRenderFX(16)
		
		local DeathCloud = EffectData()
		DeathCloud:SetOrigin(self:GetAttachment(self:LookupAttachment("forward")).Pos)
		DeathCloud:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
		DeathCloud:SetScale(200)
		util.Effect("VJ_Blood1",DeathCloud)

	elseif togglemode == "Deactivate" then
	self:SetSolid(SOLID_NONE)
	self:AddFlags(FL_NOTARGET)
				self.BLBOH_Horror_AttackMode = false
		-- PrintMessage(4,"Attack Mode Deactivated")
		if self.BLBOH_Horror_PlayerDidAttack then
			VJ.EmitSound(self,"vj_blboh/horror/sjasatta.wav",self.DeathSoundLevel)
		else
			VJ.EmitSound(self,"vj_blboh/horror/sjaspain.wav",self.PainSoundLevel)
		end
		self.HasMeleeAttack = false
		self:SetColor(Color(255,255,255,0))
		self:SetRenderFX(0)


		local DeathCloud = EffectData()
		DeathCloud:SetOrigin(self:GetAttachment(self:LookupAttachment("forward")).Pos)
		DeathCloud:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
		DeathCloud:SetScale(200)
		util.Effect("VJ_Blood1",DeathCloud)

	end
end
--------------------
function ENT:OnThinkActive()

	-- PrintMessage(4,""..self:GetSolid().."")

	if IsValid(self.SpawnLight) then
		self.SpawnLight:SetKeyValue("distance", self.BLBOH_SpawnLightLevel)
		if !self.BLBOH_SpawnLightBoom then
			self.BLBOH_SpawnLightLevel = self.BLBOH_SpawnLightLevel + 2.5
		else
			if self.BLBOH_SpawnLightFadeStage == 1 then
				self.BLBOH_SpawnLightLevel = self.BLBOH_SpawnLightLevel + 2.5
			elseif self.BLBOH_SpawnLightFadeStage == 2 then
				self.BLBOH_SpawnLightLevel = self.BLBOH_SpawnLightLevel - 10
			else
				self.BLBOH_SpawnLightLevel = self.BLBOH_SpawnLightLevel + 30
			end
			timer.Simple(0.25,function() if IsValid(self) && self.BLBOH_SpawnLightFadeStage != 1 then
				self.BLBOH_SpawnLightFadeStage = 1
			end end)
			timer.Simple(0.26,function() if IsValid(self) && self.BLBOH_SpawnLightFadeStage != 2 then
				self.BLBOH_SpawnLightFadeStage = 2
				self.BLBOH_Horror_Spawning = false
			end end)
		end
	end

	if self.VJ_IsBeingControlled then
		if self.BLBOH_Horror_AttackModeDelay < CurTime() && self.BLBOH_Horror_PlayerDidAttack && !self.BLBOH_Horror_PlayerDidAttackTimeOverNotice then
			self.BLBOH_Horror_PlayerDidAttackTimeOverNotice = true
			self.BLBOH_Horror_PlayerDidAttack = false
			self.VJ_TheController:ChatPrint("Attack cooldown is over!") -- thank you to roach for giving me this
			-- self.VJ_TheController:SendLua("surface.PlaySound('vj_blboh/shepherd/shoot.mp3')")
			self.VJ_TheController:SendLua("surface.PlaySound('buttons/blip1.wav')")
		end
		if self.VJ_TheController:KeyDown(IN_ATTACK2) && self.BLBOH_Horror_AttackModeDelay < CurTime() then
			self.BLBOH_Horror_AttackModeDelay = CurTime() + 1
			if !self.BLBOH_Horror_AttackMode then
				self:BLBOH_Horror_ToggleAttackMode("Activate")
			else
				self:BLBOH_Horror_ToggleAttackMode("Deactivate")
			end
		end
	end
	-- fog timer ran out, not spawning, has a valid enemy, can see the enemy, and the enemy is within 500 units
	if
		self.BLBOH_Horror_FogT < CurTime() &&
		!self.BLBOH_Horror_Spawning &&
		(
			(
				self.VJ_IsBeingControlled &&
				self.BLBOH_Horror_AttackMode
			)
			or
			!self.VJ_IsBeingControlled &&
			(IsValid(self:GetEnemy()) && self:Visible(self:GetEnemy()) && self:GetPos():Distance(self:GetEnemy():GetPos()) <= 500 )
		) then
		self.BLBOH_Horror_FogT = CurTime() + 0.35
		local bloodeffect = EffectData()
		bloodeffect:SetOrigin(self:GetAttachment(self:LookupAttachment("forward")).Pos)
		bloodeffect:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
		bloodeffect:SetScale(100)
		util.Effect("VJ_Blood1",bloodeffect)
	end

	if self.VJ_IsBeingControlled then
		if !self.HasBreathSound && self.BLBOH_Horror_AttackMode then
			self.HasBreathSound = true
		elseif self.HasBreathSound && !self.BLBOH_Horror_AttackMode then
			self.HasBreathSound = false
		end
	else
		if self:GetEnemy() != nil && !self.HasBreathSound && self:GetActivity() == ACT_RUN then
			self.HasBreathSound = true
		elseif self:GetEnemy() == nil && self.HasBreathSound then
			self.HasBreathSound = false
		end
	end

end
--------------------
function ENT:OnInput(key, activator, caller, data)
	if key == "step" && self.BLBOH_Horror_AttackMode then
		VJ.EmitSound(self,self.SoundTbl_FootStep,self.FootstepSoundLevel)
	end
end
--------------------
function ENT:OnMeleeAttack(status, enemy)

	if status == "PreInit" then

		for _, v in ipairs(ents.FindInSphere(self:GetPos(), 100)) do
			-- if v:IsPlayer() and v:Alive() and !self.VJ_TheController then
			if v:IsPlayer() and v:Alive() then
				v:ScreenFade(1,Color(0,0,0),5,1.5)
			elseif v.IsVJBaseSNPC and v.CanFlinch then
				local OldFlinchChance = v.FlinchChance
				v.FlinchChance = 1
				-- v:Flinch(dmginfo, hitgroup)
				timer.Simple(0.1, function() if IsValid(v) then
					v.FlinchChance = OldFlinchChance
				end end)
			end
		end

		VJ.ApplyRadiusDamage(self, self, self:GetPos(), 100, 10, DMG_PHYSGUN, true, true, {DisableVisibilityCheck=true, Force=8110})

		effects.BeamRingPoint(self:GetPos()+ self:GetUp()*45, 0.5, 0, 125, 5, 0, Color(50, 50, 50), {material="sprites/physgbeamb", framerate=20})
		effects.BeamRingPoint(self:GetPos()+ self:GetUp()*30, 0.5, 0, 175, 5, 0, Color(50, 50, 50), {material="sprites/physgbeamb", framerate=20})
		effects.BeamRingPoint(self:GetPos()+ self:GetUp()*15, 0.5, 0, 125, 5, 0, Color(50, 50, 50), {material="sprites/physgbeamb", framerate=20})

		util.ScreenShake(self:GetPos(), 5, 5, 1, 350)

		VJ.EmitSound(self,"weapons/physcannon/energy_sing_explosion2.wav",90,math.random(110,125))

		if self.VJ_IsBeingControlled then
			self.BLBOH_Horror_PlayerDidAttackTimeOverNotice = false
			self.BLBOH_Horror_PlayerDidAttack = true
			self.BLBOH_Horror_AttackModeDelay = CurTime() + 7
			self:BLBOH_Horror_ToggleAttackMode("Deactivate")
		else
			self.SoundTbl_Death = "vj_blboh/horror/sjasatta.wav"
			local d = DamageInfo()
			d:SetDamage(self:GetMaxHealth() + 1)
			d:SetAttacker(self)
			d:SetDamageType(DMG_BLAST)
			self:TakeDamageInfo(d) -- this bit is causing an error in horde
		end

	end

end
--------------------
function ENT:OnDamaged(dmginfo, hitgroup, status)
	if status == "PreDamage" && !self.BLBOH_Horror_AttackMode then
		dmginfo:ScaleDamage(0)
		if dmginfo:GetInflictor():GetClass() == "entityflame" && dmginfo:GetAttacker():GetClass() == "entityflame" then
			self:Extinguish()
		end
	end
end
--------------------
function ENT:OnDeath(dmginfo, hitgroup, status)

	if status == "Init" then

		local DeathCloud = EffectData()
		DeathCloud:SetOrigin(self:GetAttachment(self:LookupAttachment("forward")).Pos)
		DeathCloud:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
		DeathCloud:SetScale(200)
		util.Effect("VJ_Blood1",DeathCloud)

	end

end
--------------------
function ENT:Controller_Initialize(ply, controlEnt)
	self:BLBOH_Horror_ToggleAttackMode("Deactivate")
	ply:ChatPrint("MOUSE2: Toggle Attack Mode")
	ply:ChatPrint("When not in attack mode, you'll be silent and invisible but you can't attack.")
	ply:ChatPrint("When you enter attack mode, you have to wait 1 second before you can attack.")
	ply:ChatPrint("When you attack, you'll exit attack mode and can re-enter it after a bit.")
end
--------------------
function ENT:TranslateActivity(act)
	if act == ACT_WALK then
		return ACT_RUN
	end
	return act
end