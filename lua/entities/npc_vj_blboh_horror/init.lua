AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = {"models/vj_blboh/horror.mdl"}
ENT.EntitiesToNoCollide = {"npc_vj_blboh_cultist","npc_vj_blboh_wretch","npc_vj_blboh_erectus"}
ENT.StartHealth = 20
--------------------
ENT.VJ_NPC_Class = {"CLASS_DEMON"}
--------------------
ENT.BloodColor = "Oil"
-- ENT.BloodColor = VJ.BLOOD_COLOR_OIL
--------------------
ENT.MeleeAttackDamage = 0
-- ENT.AnimTbl_MeleeAttack = {"vjseq_BR2_Attack"}
ENT.MeleeAttackDistance = 50
ENT.MeleeAttackDamageDistance = 75
ENT.TimeUntilMeleeAttackDamage = false
ENT.DisableMeleeAttackAnimation = true
--------------------
-- ENT.AnimTbl_Walk = {ACT_RUN}
--------------------
ENT.DisableFootStepSoundTimer = true
--------------------
ENT.HasDeathRagdoll = false
--------------------
ENT.BreathSoundLevel = 75
ENT.AlertSoundLevel = 90
ENT.PainSoundLevel = 90
ENT.DeathSoundLevel = 90
--------------------
ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
--------------------
ENT.SoundTbl_FootStep = {
	"npc/fast_zombie/foot1.wav",
	"npc/fast_zombie/foot2.wav",
	"npc/fast_zombie/foot3.wav",
	"npc/fast_zombie/foot4.wav"
}
ENT.SoundTbl_Breath = {"vj_blboh/horror/sjasact.wav"}
ENT.SoundTbl_Alert = {"vj_blboh/horror/sjassee.wav"}
ENT.SoundTbl_Pain = {"vj_blboh/horror/sjaspain.wav"}
ENT.SoundTbl_Death = {"vj_blboh/horror/sjasdeat.wav"}
ENT.HasBreathSound = false
--------------------
ENT.NextSoundTime_Breath = VJ.SET(0.35,0.35)
--------------------
ENT.BLBOH_Horror_FogT = 0
ENT.BLBOH_Horror_Spawning = true
ENT.BLBOH_SpawnLightLevel = "0"
ENT.BLBOH_SpawnLightBoom = false
ENT.BLBOH_SpawnLightFadeStage = 0

-- ENT.CanInvestigate = false
--------------------
function ENT:Init()
	self:SetRenderFX(16)

	-- have a white portal grow larger and larger like the cultists
	-- also play a reversed scream loop that stops when the horror appears

	self.MovementType = VJ_MOVETYPE_STATIONARY
	self.DisableFindEnemy = true
	self.HasSounds = false
	self.HasMeleeAttack = false
	self.GodMode = true
	self.CanTurnWhileStationary = false
	self:SetSolid(SOLID_NONE)
	self:SetMaterial("hud/killicons/default")
	self:DrawShadow(false)
	self.BLBOH_Horror_Spawning = true


	self.PreLaunchLight = ents.Create("light_dynamic")
	self.PreLaunchLight:SetKeyValue("brightness", "7.5")
	self.PreLaunchLight:SetKeyValue("distance", "0")
	self.PreLaunchLight:SetLocalPos(self:GetPos())
	self.PreLaunchLight:SetLocalAngles(self:GetAngles())
	self.PreLaunchLight:Fire("Color", "140 140 140 255")
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
	self.ChestGlow1:SetKeyValue("rendercolor","140 140 140 255")
	self.ChestGlow1:SetKeyValue("spawnflags","1") -- If animated
	self.ChestGlow1:SetParent(self)
	self.ChestGlow1:Fire("SetParentAttachment", "forward")
	self.ChestGlow1:Fire("Kill", "", 13)
	self.ChestGlow1:Spawn()
	self.ChestGlow1:Activate()
	self:DeleteOnRemove(self.ChestGlow1)

	VJ.EmitSound(self,"vj_blboh/horror/spawn.wav",80,math.random(95,105))


	timer.Simple(0.5,function() if IsValid(self) then
		self.ChestGlow2 = ents.Create("env_sprite")
		self.ChestGlow2:SetKeyValue("model","sprites/blueflare1.vmt")
		self.ChestGlow2:SetKeyValue("scale", "1.5")
		self.ChestGlow2:SetKeyValue("rendermode","5")
		self.ChestGlow2:SetKeyValue("rendercolor","140 140 140 255")
		self.ChestGlow2:SetKeyValue("spawnflags","1") -- If animated
		self.ChestGlow2:SetParent(self)
		self.ChestGlow2:Fire("SetParentAttachment", "forward")
		self.ChestGlow2:Fire("Kill", "", 13)
		self.ChestGlow2:Spawn()
		self.ChestGlow2:Activate()
		self:DeleteOnRemove(self.ChestGlow2)
	end end)

	timer.Simple(1.3,function() if IsValid(self) then
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
		self.ChestGlow1:Fire("Kill", "", 0)
		self.ChestGlow2:Fire("Kill", "", 0)
		effects.BeamRingPoint(self:GetPos() + self:GetUp() * 20 + self:GetRight() * 6, 0.5, 0, 80, 5, 0, Color(255, 255, 255), {material="sprites/physgbeamb", framerate=20})
		effects.BeamRingPoint(self:GetPos() + self:GetUp() * 40 + self:GetRight() * 5, 0.5, 0, 100, 5, 0, Color(255, 255, 255), {material="sprites/physgbeamb", framerate=20})
		effects.BeamRingPoint(self:GetPos() + self:GetUp() * 60 + self:GetRight() * 3, 0.5, 0, 80, 5, 0, Color(255, 255, 255), {material="sprites/physgbeamb", framerate=20})
		VJ.EmitSound(self,"ambient/machines/thumper_dust.wav",80,math.random(95,105))
	end end)


end
--------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	if key == "step" then
		VJ.EmitSound(self,self.SoundTbl_FootStep,self.FootStepSoundLevel)
	end
end
--------------------
function ENT:TranslateActivity(act)
	if act == ACT_WALK then
		return ACT_RUN
	end
	return act
end
--------------------
function ENT:OnThinkActive()


	if IsValid(self.PreLaunchLight) then
		self.PreLaunchLight:SetKeyValue("distance", self.BLBOH_SpawnLightLevel)
		if !self.BLBOH_SpawnLightBoom then
			self.BLBOH_SpawnLightLevel = self.BLBOH_SpawnLightLevel + 2.5
		end
		if self.BLBOH_SpawnLightBoom then
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

	if self.BLBOH_Horror_FogT < CurTime() && !self.BLBOH_Horror_Spawning && (IsValid(self:GetEnemy()) && self:Visible(self:GetEnemy()) && self:GetPos():Distance(self:GetEnemy():GetPos()) <= 500 ) then
	-- if self.BLBOH_Horror_FogT < CurTime() then
		local bloodeffect = EffectData()
		bloodeffect:SetOrigin(self:GetAttachment(self:LookupAttachment("forward")).Pos)
		bloodeffect:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
		bloodeffect:SetScale(100)
		util.Effect("VJ_Blood1",bloodeffect)
		self.BLBOH_Horror_FogT = CurTime() + 0.35
	end
	if self:GetEnemy() != nil && !self.HasBreathSound && self:GetActivity() == ACT_RUN then
		self.HasBreathSound = true
	end
	if self:GetEnemy() == nil && self.HasBreathSound then
		self.HasBreathSound = false
	end
end
--------------------
function ENT:CustomOnMeleeAttack_BeforeStartTimer(seed)
	effects.BeamRingPoint(self:GetPos()+ self:GetUp()*45, 0.5, 0, 125, 5, 0, Color(50, 50, 50), {material="sprites/physgbeamb", framerate=20})
	effects.BeamRingPoint(self:GetPos()+ self:GetUp()*30, 0.5, 0, 175, 5, 0, Color(50, 50, 50), {material="sprites/physgbeamb", framerate=20})
	effects.BeamRingPoint(self:GetPos()+ self:GetUp()*15, 0.5, 0, 125, 5, 0, Color(50, 50, 50), {material="sprites/physgbeamb", framerate=20})
	VJ.EmitSound(self,"weapons/physcannon/energy_sing_explosion2.wav",90,math.random(110,125))
	util.ScreenShake(self:GetPos(), 5, 5, 1, 350)
-- function VJ.ApplyRadiusDamage(attacker, inflictor, startPos, dmgRadius, dmgMax, dmgType, ignoreInnocents, realisticRadius, extraOptions, customFunc)
	VJ.ApplyRadiusDamage(self, self, self:GetPos(), 100, 10, DMG_PHYSGUN, true, true, {DisableVisibilityCheck=true, Force=8110})
	for _, v in ipairs(ents.FindInSphere(self:GetPos(), 100)) do
		if v:IsPlayer() and v:Alive() then
			v:ScreenFade(1,Color(0,0,0),5,1.5)
		end
	end
	self.SoundTbl_Death = {"vj_blboh/horror/sjasatta.wav"}
	local d = DamageInfo()
	d:SetDamage(self:GetMaxHealth() + 1)
	d:SetAttacker(self)
	d:SetDamageType(DMG_BLAST) 
	self:TakeDamageInfo(d)
end
--------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
	if status == "Initial" then
		local bloodeffect = EffectData()
		bloodeffect:SetOrigin(self:GetAttachment(self:LookupAttachment("forward")).Pos)
		bloodeffect:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
		bloodeffect:SetScale(200)
		util.Effect("VJ_Blood1",bloodeffect)
	end
	if status == "Finish" then
	end
end
--------------------