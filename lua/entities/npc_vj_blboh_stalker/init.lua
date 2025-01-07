AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = {"models/vj_blboh/stalker.mdl"}
ENT.StartHealth = 25
--------------------
ENT.VJ_NPC_Class = {"CLASS_DEMON"}
--------------------
ENT.BloodColor = VJ.BLOOD_COLOR_OIL
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
-- experiment with giving it more sounds
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
ENT.SoundTbl_Death = {"npc/cultist/death.mp3"}
ENT.NextSoundTime_Breath = VJ.SET(11,11)
ENT.FootStepSoundLevel = 60
ENT.BreathSoundLevel = 50
ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
ENT.BreathSoundPitch = VJ.SET(65,65)
--------------------
ENT.BLBOH_Stalker_Cloaked = false
ENT.BLBOH_Stalker_CloakLevel = 0
ENT.BLBOH_Stalker_RenderShadow = false
ENT.BLBOH_Stalker_PlayFootstepSounds = false
ENT.BLBOH_Stalker_CanRun = false
--------------------
function ENT:Init()

	self:AddFlags(FL_NOTARGET)
	self:SetSolid(SOLID_NONE)

	self.BLBOH_Stalker_CloakLevel = 0

	self:SetRenderMode(1)
	self:SetColor(Color(255, 255, 255, 0))
	self:DrawShadow(false)

	VJ.EmitSound(self,{"ambient/materials/metal4.wav"},75,math.random(80,110))

	timer.Simple(0.15,function() if IsValid(self) then


		self:SetColor(Color(255, 255, 255, 0))

	end end)

end
--------------------
function ENT:OnInput(key, activator, caller, data)

	if key == "step" && self.BLBOH_Stalker_PlayFootstepSounds then
		VJ.EmitSound(self,self.SoundTbl_FootStep,self.FootStepSoundLevel)
	end

	if key == "melee" then
		self:MeleeAttackCode()
	end

end
--------------------
function ENT:TranslateActivity(act)
	if act == ACT_RUN && !self.BLBOH_Stalker_CanRun then
		return ACT_WALK
	end
	return act
end
--------------------
function ENT:BLBOH_Stalker_UpdateCloak()

	-- see if this can be optimized at all

	if self.BLBOH_Stalker_Cloaked && self.BLBOH_Stalker_CloakLevel >= 30 then
		self.BLBOH_Stalker_CloakLevel = self.BLBOH_Stalker_CloakLevel - 85
	end

	if !self.BLBOH_Stalker_Cloaked && self.BLBOH_Stalker_CloakLevel <= 255 then
		self.BLBOH_Stalker_CloakLevel = self.BLBOH_Stalker_CloakLevel + 15
	end

	if self.BLBOH_Stalker_CloakLevel < 200 && self.BLBOH_Stalker_RenderShadow then

		self.BLBOH_Stalker_RenderShadow = false
		self.BLBOH_Stalker_CanRun = false
		self:AddFlags(FL_NOTARGET)
		self:SetSolid(SOLID_NONE)
		self:DrawShadow(false)
		self.BLBOH_Stalker_PlayFootstepSounds = false

	end

	if self.BLBOH_Stalker_CloakLevel >= 200 && !self.BLBOH_Stalker_RenderShadow then

		self.BLBOH_Stalker_RenderShadow = true
		self.BLBOH_Stalker_CanRun = true
		self:RemoveFlags(FL_NOTARGET)
		self:SetSolid(SOLID_BBOX)
		self:DrawShadow(true)
		self.BLBOH_Stalker_PlayFootstepSounds = true

	end

	if self.BLBOH_Stalker_CloakLevel < 1 then

		self.BLBOH_Stalker_CloakLevel = 1

	end

	if self.BLBOH_Stalker_CloakLevel > 255 then

		self.BLBOH_Stalker_CloakLevel = 255

	end

	if !self.BLBOH_Stalker_RenderShadow then

		self:RemoveAllDecals()

	end

	self:SetColor(Color(self.BLBOH_Stalker_CloakLevel, self.BLBOH_Stalker_CloakLevel, self.BLBOH_Stalker_CloakLevel, self.BLBOH_Stalker_CloakLevel))

end
--------------------
function ENT:OnThinkActive()

	-- PrintMessage(4,"Health is "..self:Health().."")
	-- PrintMessage(4,""..self.BLBOH_Stalker_CloakLevel.."")

	self:BLBOH_Stalker_UpdateCloak()

	if self:GetEnemy() != nil then

		local enemydist = self:GetPos():Distance(self:GetEnemy():GetPos()) -- distance check

		if !self:Visible(self:GetEnemy()) && enemydist >= 250 or !(self:GetEnemy():GetForward():Dot((self:GetPos() -self:GetEnemy():GetPos()):GetNormalized()) > math.cos(math.rad(60))) then
		-- this check will pass if one of two scenarios are true
		-- Scenario A: we can't see our current enemy AND they are far enough away
		-- Scenario B: our current enemy is not looking at us

			if self.BLBOH_Stalker_Cloaked then

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

					self.BLBOH_Stalker_Cloaked = false

				end

			end

		else

			if !self.BLBOH_Stalker_Cloaked then

				self.BLBOH_Stalker_Cloaked = true

			end

		end

	else

		if !self.BLBOH_Stalker_Cloaked then

			self.BLBOH_Stalker_Cloaked = true

		end

	end

end
--------------------
function ENT:OnDamaged(dmginfo, hitgroup, status)
	if !self.BLBOH_Stalker_RenderShadow then
		dmginfo:ScaleDamage(0.2) -- increase it?
	end
end
--------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
	if status == "Finish" then
		self:SetColor(Color(255, 255, 255, 255))
	end
end
--------------------