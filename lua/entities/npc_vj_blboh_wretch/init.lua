AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = "models/vj_blboh/wretch.mdl"
ENT.StartHealth = 200
--------------------
ENT.VJ_NPC_Class = {"CLASS_DEMON"}
ENT.HasPoseParameterLooking = false
--------------------
ENT.BloodColor = "Oil"
-- ENT.BloodColor = VJ.BLOOD_COLOR_OIL
--------------------
ENT.MeleeAttackDamage = 10
ENT.MeleeAttackDamageType = DMG_CLUB
ENT.MeleeAttackDistance = 75
ENT.MeleeAttackDamageDistance = 90
ENT.TimeUntilMeleeAttackDamage = false
--------------------
ENT.DisableFootStepSoundTimer = true
ENT.SoundTbl_FootStep = {"npc/fast_zombie/foot1.wav","npc/fast_zombie/foot2.wav","npc/fast_zombie/foot3.wav","npc/fast_zombie/foot4.wav"}
ENT.SoundTbl_Alert = {
	"vj_blboh/wretch/hurt1.wav",
	"vj_blboh/wretch/hurt2.wav",
	"vj_blboh/wretch/hurt3.wav",
	"vj_blboh/wretch/gargle3.wav"
}
-- ENT.SoundTbl_BeforeMeleeAttack = {
	-- "vj_blboh/wretch/attackfast.wav",
	-- "vj_blboh/wretch/attackfast2.wav"
-- }
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
ENT.SoundTbl_Death = {"vj_blboh/wretch/gargle3.wav"}

-- ENT.GeneralSoundPitch1 = 100
-- ENT.GeneralSoundPitch2 = 100
ENT.BeforeMeleeAttackSoundPitch = VJ.SET(95, 120)
ENT.PainSoundPitch = VJ.SET(80,110)
ENT.DeathSoundPitch = VJ.SET(60, 100)
--------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	if key == "step" && self:GetMaterial() != "hud/killicons/default" then
		VJ.EmitSound(self,self.SoundTbl_FootStep,self.FootStepSoundLevel)
	end
	if key == "attack" then
		self:MeleeAttackCode()
	end
	if key == "land" then
		VJ.EmitSound(self,"physics/body/body_medium_impact_hard"..math.random(1,6)..".wav",65)
	end
end
--------------------
--------------------
function ENT:Init()

	local bloodeffect = EffectData()

	self.MovementType = VJ_MOVETYPE_STATIONARY
	self.DisableFindEnemy = true
	self.HasSounds = false
	self.HasMeleeAttack = false
	self.GodMode = true
	self.CanTurnWhileStationary = false
	self:SetSolid(SOLID_NONE)
	self:SetMaterial("hud/killicons/default")
	self:DrawShadow(false)

	VJ.EmitSound(self,"npc/antlion/muffled_boulder_impact_hard"..math.random(1,2)..".wav",80,math.random(80,110))
		bloodeffect:SetOrigin(self:GetPos() + self:GetUp()*-25)
		bloodeffect:SetScale(25)
		util.Effect("ThumperDust", bloodeffect)
		util.ScreenShake(self:GetPos(), 1, 40, 3, 600)

		bloodeffect:SetOrigin(self:GetPos() + self:GetUp()*-5 + self:GetForward()*25)
		bloodeffect:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
		bloodeffect:SetScale(50)
		util.Effect("VJ_Blood1",bloodeffect)
		bloodeffect:SetOrigin(self:GetPos() + self:GetUp()*-5 + self:GetForward()*-25)
		util.Effect("VJ_Blood1",bloodeffect)
		bloodeffect:SetOrigin(self:GetPos() + self:GetUp()*-5 + self:GetRight()*25)
		util.Effect("VJ_Blood1",bloodeffect)
		bloodeffect:SetOrigin(self:GetPos() + self:GetUp()*-5 + self:GetRight()*-25)
		util.Effect("VJ_Blood1",bloodeffect)
		bloodeffect:SetOrigin(self:GetPos())
		util.Effect("ThumperDust", bloodeffect)

	timer.Simple(1,function() if IsValid(self) then
		VJ.EmitSound(self,"npc/antlion/muffled_boulder_impact_hard"..math.random(1,2)..".wav",80,math.random(80,110))
		bloodeffect:SetOrigin(self:GetPos())
		bloodeffect:SetScale(40)
		util.Effect("ThumperDust", bloodeffect)
		util.ScreenShake(self:GetPos(), 1.5, 40, 3, 600)

		bloodeffect:SetOrigin(self:GetPos() + self:GetUp()*25 + self:GetForward()*25)
		bloodeffect:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
		-- bloodeffect:SetColor(VJ_Color2Byte(Color(205,206,194,255)))
		bloodeffect:SetScale(75)
		util.Effect("VJ_Blood1",bloodeffect)
		bloodeffect:SetOrigin(self:GetPos() + self:GetUp()*25 + self:GetForward()*-25)
		util.Effect("VJ_Blood1",bloodeffect)
		bloodeffect:SetOrigin(self:GetPos() + self:GetUp()*25 + self:GetRight()*25)
		util.Effect("VJ_Blood1",bloodeffect)
		bloodeffect:SetOrigin(self:GetPos() + self:GetUp()*25 + self:GetRight()*-25)
		util.Effect("VJ_Blood1",bloodeffect)
		bloodeffect:SetOrigin(self:GetPos())
		util.Effect("ThumperDust", bloodeffect)

	end end)
	timer.Simple(1.5,function() if IsValid(self) then
		self:VJ_ACT_PLAYACTIVITY({"vjseq_digout"},true,false)
	end end)
	timer.Simple(2,function() if IsValid(self) then
		VJ.EmitSound(self,"physics/concrete/boulder_impact_hard"..math.random(1,4)..".wav",80,math.random(80,110))
		VJ.EmitSound(self,self.SoundTbl_Alert,80)
		util.ScreenShake(self:GetPos(), 2.5, 40, 3, 450)

		bloodeffect:SetOrigin(self:GetPos() + self:GetUp()*25 + self:GetForward()*25)
		bloodeffect:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
		bloodeffect:SetScale(100)
		util.Effect("VJ_Blood1",bloodeffect)
		bloodeffect:SetOrigin(self:GetPos() + self:GetUp()*25 + self:GetForward()*-25)
		util.Effect("VJ_Blood1",bloodeffect)
		bloodeffect:SetOrigin(self:GetPos() + self:GetUp()*25 + self:GetRight()*25)
		util.Effect("VJ_Blood1",bloodeffect)
		bloodeffect:SetOrigin(self:GetPos() + self:GetUp()*25 + self:GetRight()*-25)
		util.Effect("VJ_Blood1",bloodeffect)
		bloodeffect:SetOrigin(self:GetPos())
		util.Effect("ThumperDust", bloodeffect)


	end end)
	timer.Simple(2,function() if IsValid(self) then
		self:SetSolid(SOLID_BBOX)
		self.HasMeleeAttack = true
		self.GodMode = false
		self.MovementType = VJ_MOVETYPE_GROUND
		self.CanTurnWhileStationary = true
		self:SetMaterial("")
		self:DrawShadow(true)
		self.HasSounds = true
		self.DisableFindEnemy = false
	end end)
end