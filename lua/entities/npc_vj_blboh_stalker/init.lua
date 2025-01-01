AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = {"models/vj_blboh/stalker.mdl"}
ENT.StartHealth = 50
--------------------
ENT.VJ_NPC_Class = {"CLASS_DEMON"}
--------------------
ENT.BloodColor = "Oil"
-- ENT.BloodColor = VJ.BLOOD_COLOR_OIL
--------------------
ENT.MeleeAttackDamage = 15
ENT.AnimTbl_MeleeAttack = {"vjges_attack1","vjges_attack2","vjges_attack3"}
ENT.MeleeAttackDistance = 45
ENT.MeleeAttackDamageDistance = 70
ENT.TimeUntilMeleeAttackDamage = false
--------------------
ENT.DisableFootStepSoundTimer = true
--------------------
ENT.SoundTbl_FootStep = {
	"npc/stalker/stalker_footstep_left1.wav",
	"npc/stalker/stalker_footstep_left2.wav",
	"npc/stalker/stalker_footstep_right1.wav",
	"npc/stalker/stalker_footstep_right2.wav"
}
ENT.SoundTbl_Breath = {"player/breathe1.wav"}
-- ENT.SoundTbl_Alert = {"ambient/materials/metal4.wav"}
ENT.SoundTbl_MeleeAttack = {
	"weapons/knife/knife_hit1.wav",
	"weapons/knife/knife_hit2.wav",
	"weapons/knife/knife_hit3.wav",
	"weapons/knife/knife_hit4.wav"
}
ENT.SoundTbl_MeleeAttackMiss = {
	"weapons/knife/knife_slash1.wav",
	"weapons/knife/knife_slash2.wav"
}
ENT.SoundTbl_Death = {
	"npc/cultist/death.mp3"
}
ENT.NextSoundTime_Breath = VJ.SET(11,11)
ENT.FootStepSoundLevel = 60
ENT.BreathSoundLevel = 50
ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
ENT.BreathSoundPitch = VJ.SET(65,65)
--------------------
ENT.BHLCIE_Stalker_Cloaked = false
ENT.BHLCIE_Stalker_CloakLevel = 0
ENT.BHLCIE_Stalker_RenderShadow = false
ENT.BHLCIE_Stalker_PlayFootstepSounds = false
ENT.BHLCIE_Stalker_CanRun = false
--------------------
function ENT:Init()
	VJ.EmitSound(self,{"ambient/materials/metal4.wav"},75,math.random(80,110))
	self:SetColor(Color(255, 255, 255, 0))
	self:SetRenderMode(1)
	self:DrawShadow(false)
	self:SetSolid(SOLID_NONE)
	self.GodMode = true
	self:AddFlags(FL_NOTARGET)
	timer.Simple(0.15,function() if IsValid(self) then
		self:SetColor(Color(255, 255, 255, 0))
		self.BHLCIE_Stalker_CloakLevel = 0
	end end)
end
--------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	if key == "step" && self.BHLCIE_Stalker_PlayFootstepSounds then
		VJ.EmitSound(self,self.SoundTbl_FootStep,self.FootStepSoundLevel)
	end
	if key == "melee" then
		self:MeleeAttackCode()
	end
end
--------------------
function ENT:TranslateActivity(act)
	if act == ACT_RUN && !self.BHLCIE_Stalker_CanRun then
		return ACT_WALK
	end
	return act
end
--------------------
function ENT:BLHOB_UpdateCloak()
	if self.BHLCIE_Stalker_Cloaked && self.BHLCIE_Stalker_CloakLevel >= 30 then
		self.BHLCIE_Stalker_CloakLevel = self.BHLCIE_Stalker_CloakLevel - 85
		-- self.BHLCIE_Stalker_CloakLevel = self.BHLCIE_Stalker_CloakLevel - 15
		-- self.BHLCIE_Stalker_CloakLevel = self.BHLCIE_Stalker_CloakLevel - 15
	end
	if !self.BHLCIE_Stalker_Cloaked && self.BHLCIE_Stalker_CloakLevel <= 255 then
		self.BHLCIE_Stalker_CloakLevel = self.BHLCIE_Stalker_CloakLevel + 15
	end
	if self.BHLCIE_Stalker_CloakLevel < 200 && self.BHLCIE_Stalker_RenderShadow then
		self.BHLCIE_Stalker_RenderShadow = false
		self:DrawShadow(false)
		self.BHLCIE_Stalker_PlayFootstepSounds = false
		self:SetSolid(SOLID_NONE)
		self.GodMode = true
		self.BHLCIE_Stalker_CanRun = false
		self:AddFlags(FL_NOTARGET)
	end
	if self.BHLCIE_Stalker_CloakLevel >= 200 && !self.BHLCIE_Stalker_RenderShadow then
		self.BHLCIE_Stalker_RenderShadow = true
		self:DrawShadow(true)
		self.BHLCIE_Stalker_PlayFootstepSounds = true
		self:SetSolid(SOLID_BBOX)
		self.GodMode = false
		self.BHLCIE_Stalker_CanRun = true
		self:RemoveFlags(FL_NOTARGET)
	end
	if self.BHLCIE_Stalker_CloakLevel < 1 then
		self.BHLCIE_Stalker_CloakLevel = 1
	end
	if self.BHLCIE_Stalker_CloakLevel > 255 then
		self.BHLCIE_Stalker_CloakLevel = 255
	end
	self:SetColor(Color(self.BHLCIE_Stalker_CloakLevel, self.BHLCIE_Stalker_CloakLevel, self.BHLCIE_Stalker_CloakLevel, self.BHLCIE_Stalker_CloakLevel))
end
--------------------
function ENT:OnThinkActive()

	-- PrintMessage(4,""..self.BHLCIE_Stalker_CloakLevel.."")

	self:BLHOB_UpdateCloak()

	if self:GetEnemy() != nil then
		local enemydist = self:GetPos():Distance(self:GetEnemy():GetPos()) -- distance check
		if !self:Visible(self:GetEnemy()) && enemydist >= 250 or !(self:GetEnemy():GetForward():Dot((self:GetPos() -self:GetEnemy():GetPos()):GetNormalized()) > math.cos(math.rad(60))) then
		-- move on if either
		-- A: we can't see our enemy and they're far enough
		-- or
		-- B: our enemy isn't looking at us
			if self.BHLCIE_Stalker_Cloaked then
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
				if
					-- these tracers are checks to make sure we're not in something
					!tr1.Hit
					&&
					!tr2.Hit
					&&
					!tr3.Hit
					&&
					!tr4.Hit
				then
					self.BHLCIE_Stalker_Cloaked = false
					self:RemoveAllDecals()
				end
			end
		else
			if !self.BHLCIE_Stalker_Cloaked then
				self.BHLCIE_Stalker_Cloaked = true
				self:RemoveAllDecals()
			end
		end
	else
		if !self.BHLCIE_Stalker_Cloaked then
			self.BHLCIE_Stalker_Cloaked = true
			self:RemoveAllDecals()
		end
	end


end
--------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
	if status == "Finish" then
		self:SetColor(Color(255, 255, 255, 255))
	end
end
--------------------