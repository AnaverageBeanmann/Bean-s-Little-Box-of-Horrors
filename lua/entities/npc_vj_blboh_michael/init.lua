AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = {"models/vj_blboh/michael_davies.mdl"}
ENT.StartHealth = 300
--------------------
ENT.VJ_NPC_Class = {"CLASS_DEMON"}
--------------------
ENT.BloodColor = "Red"
-- ENT.BloodColor = VJ.BLOOD_COLOR_RED
--------------------
ENT.MeleeAttackDamage = 25
ENT.AnimTbl_MeleeAttack = {"vjges_s_attack1","vjges_s_attack2","vjges_s_attack3"}
ENT.MeleeAttackDistance = 35
ENT.MeleeAttackDamageDistance = 75
ENT.TimeUntilMeleeAttackDamage = false
--------------------
ENT.DisableFootStepSoundTimer = true
ENT.HasBreathSound = false
ENT.SoundTbl_Breath = "vj_blboh/michael_davies/Audio glitches.ogg"
ENT.SoundTbl_FootStep = {
	"npc/fast_zombie/foot1.wav",
	"npc/fast_zombie/foot2.wav",
	"npc/fast_zombie/foot3.wav",
	"npc/fast_zombie/foot4.wav"
}
ENT.SoundTbl_MeleeAttack = {
	"player/pz/hit/zombie_slice_1.wav",
	"player/pz/hit/zombie_slice_2.wav",
	"player/pz/hit/zombie_slice_3.wav",
	"player/pz/hit/zombie_slice_4.wav",
	"player/pz/hit/zombie_slice_5.wav",
	"player/pz/hit/zombie_slice_6.wav"
}
ENT.SoundTbl_Warn = {
	"vj_blboh/michael_davies/I_have_the_body_of_a_pig.mp3",
	"vj_blboh/michael_davies/Run_run_run.mp3",
	"vj_blboh/michael_davies/Suffer.mp3",
	"vj_blboh/michael_davies/Carnage.mp3",
	"vj_blboh/michael_davies/Worship_me.mp3",
	"vj_blboh/michael_davies/En_nombre_de_jesus.mp3",
	"vj_blboh/michael_davies/Corruption_thou_art_my_father.mp3",
	"vj_blboh/michael_davies/Blood.mp3"
}
ENT.SoundTbl_Flee = {
	"vj_blboh/michael_davies/Father.mp3",
	"vj_blboh/michael_davies/Noooo.mp3",
	"vj_blboh/michael_davies/Aaaaaaaaaaaaaa.mp3",
	"vj_blboh/michael_davies/I_go_unwillingly.mp3",
	"vj_blboh/michael_davies/You_know_nothing.mp3",
	"vj_blboh/michael_davies/Por_la_cruz_invertida.mp3",
	"vj_blboh/michael_davies/La_sangre_de_puta_madre.mp3",
	"vj_blboh/michael_davies/Que_te_cojan_mil_cabras.mp3"
}
ENT.NextSoundTime_Breath = VJ.SET(8,8)
ENT.BreathSoundLevel = 100
ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
--------------------
ENT.BHLCIE_Michael_CurrentMode = 0
/*
0 - Attack Mode
1 - Fleeing
2 - Hiding
*/
ENT.BHLCIE_Michael_HideTime = 0
ENT.BHLCIE_Michael_PlayedWarnSound = false
ENT.BHLCIE_Michael_TimesFendedOff = 1
ENT.BHLCIE_Michael_Patience = 0
ENT.BHLCIE_Michael_LostPatient = false
ENT.BHLCIE_Michael_Difficulty = 1
/*
1 - Easy
2 - Medium
3 - Hard
4 - Very Hard (actually just hard)
*/
ENT.BHLCIE_Michael_Hunt_Patience = 1
ENT.BHLCIE_Michael_Hunt_LostPatient = false
ENT.BHLCIE_Michael_Hide_Patience = 1
ENT.BHLCIE_Michael_Hide_LostPatient = false
ENT.BLBOH_Michael_Sprint = false
--------------------
function ENT:PreInit()
	self.BHLCIE_Michael_Hunt_Patience = CurTime() + math.random(60,90)
end
--------------------
function ENT:Init()
	self.BHLCIE_Michael_Patience = CurTime() + math.random(5,10)
end
--------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	if key == "step" && !self.BHLCIE_Michael_CurrentMode then
		VJ.EmitSound(self,self.SoundTbl_FootStep,self.FootStepSoundLevel)
	end
	if key == "attack" then
		self:MeleeAttackCode()
	end
end
--------------------
function ENT:TranslateActivity(act)
	if act == ACT_RUN && self.BLBOH_Michael_Sprint then
		return ACT_SPRINT
	end
	return act
end
--------------------
function ENT:OnAlert(ent)
	self.BHLCIE_Michael_Hunt_Patience = CurTime() + math.random(60,90)
end
--------------------
function ENT:BLBOH_Michael_GoIntoHiding()
	self.BHLCIE_Michael_CurrentMode = 2
	self.BHLCIE_Michael_HideTime = CurTime() + math.random(10,60)
	self.FindEnemy_CanSeeThroughWalls = true
	self.SightAngle = 360
	self:SetMaterial("hud/killicons/default")
	self:DrawShadow(false)
	self:RemoveAllDecals()
	self.HasFootStepSound = false
end
--------------------
function ENT:OnThinkActive()

	if self.BHLCIE_Michael_CurrentMode == 0 then -- we're hunting!
		if !self.BHLCIE_Michael_PlayedWarnSound && self:GetEnemy() != nil && self:Visible(self:GetEnemy()) then -- check if we haven't played our warning sound and we have a valid and visible enemy
			-- play the warning sound
			self.BHLCIE_Michael_PlayedWarnSound = true
			self.BHLCIE_Michael_Hunt_Patience = CurTime() + math.random(15,30)
			self.BLBOH_Michael_Sprint = true
			self.FindEnemy_CanSeeThroughWalls = false
			self.SightAngle = 156
			VJ.EmitSound(self,self.SoundTbl_Warn,100,100)
			self.HasBreathSound = true
		end
		if self.BHLCIE_Michael_Patience < CurTime() && !self.BHLCIE_Michael_LostPatient && !self.BHLCIE_Michael_PlayedWarnSound then -- if our patience counter has hit 0 and we haven't lost our patience..
			-- lose patience. michael is now omnipotenent
			self.BHLCIE_Michael_LostPatient = true
			self.FindEnemy_CanSeeThroughWalls = true
			self.SightAngle = 360
		end
		if self.IsValid(self:GetEnemy()) && self.BHLCIE_Michael_Hunt_Patience < CurTime() && !self.BHLCIE_Michael_Hunt_LostPatient then
			-- michael's bored of this hunt and goes away for now
			self.BHLCIE_Michael_Hunt_LostPatient = true
			self:Michael_Flee()
		end
	end

	if self.BHLCIE_Michael_CurrentMode == 1 then -- we're fleeing
		if self:GetEnemy() != nil then -- check if we have a valid enemy
			local enemydist = self:GetPos():Distance(self:GetEnemy():GetPos()) -- distance check
			if !self:Visible(self:GetEnemy()) && enemydist >= 250 or !(self:GetEnemy():GetForward():Dot((self:GetPos() -self:GetEnemy():GetPos()):GetNormalized()) > math.cos(math.rad(60))) then
			-- if we can't see our current enemy and they're far enough..
				-- go into hiding
				self:BLBOH_Michael_GoIntoHiding()
			end
		end
		if self:GetEnemy() == nil then -- if we have no valid enemy then..
			self:BLBOH_Michael_GoIntoHiding()
		end
	end

	if self.BHLCIE_Michael_CurrentMode == 2 then -- we're hiding
		if self.BHLCIE_Michael_HideTime < CurTime() then -- if our hide time check hits 0 then..
			if IsValid(self:GetEnemy()) then -- if we have a valid enemy..
				local enemydist = self:GetPos():Distance(self:GetEnemy():GetPos()) -- distance check
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
					self:GetEnemy() != nil -- another valid enemy check?
						&&
					(
						!self:Visible(self:GetEnemy())
							or
						enemydist >= 500
							or
						!(self:GetEnemy():GetForward():Dot((self:GetPos() -self:GetEnemy():GetPos()):GetNormalized()) > math.cos(math.rad(60)))
					)
					-- can't see them, they're far enough, or they're not looking at us
						&&
					!tr1.Hit
					&&
					!tr2.Hit
					&&
					!tr3.Hit
					&&
					!tr4.Hit
					-- check to make sure we're not inside anything
				then

					-- go on the hunt!

					self.BHLCIE_Michael_CurrentMode = 0
					self.BHLCIE_Michael_Hunt_Patience = CurTime() + math.random(60,90)
					self.BHLCIE_Michael_Patience = CurTime() + math.random(5,10)
					self.BHLCIE_Michael_Hunt_LostPatient = false
					self.BHLCIE_Michael_LostPatient = false
					self.BHLCIE_Michael_PlayedWarnSound = false
					self.Behavior = VJ_BEHAVIOR_AGGRESSIVE
					self.FindEnemy_CanSeeThroughWalls = false
					self.SightAngle = 156
					self.GodMode = false
					self:SetSolid(SOLID_BBOX)
					self.HasFootStepSound = true
					self:SetMaterial(nil)
					self:DrawShadow(true)
					self:SetRenderFX(0)
					self:SetColor(Color(255, 255, 255, 255))
					self:RemoveAllDecals()
					self:ResetEnemy(true)
				end
			else
				-- we didn't meet the requirements, keep hiding
				self.BHLCIE_Michael_HideTime = CurTime() + 3
			end
		end
	end
end
--------------------
function ENT:Michael_Flee()

	-- flee!
	self:SetRenderFX(16)
	VJ.EmitSound(self,self.SoundTbl_Flee,100,100)
	self.HasBreathSound = false
	VJ.STOPSOUND(self.CurrentBreathSound)

	self:SetHealth(self.StartHealth)
	self.GodMode = true
	timer.Simple(0.15, function() if IsValid(self) then
		self:SetHealth(self.StartHealth)
	end end)
	self.BHLCIE_Michael_TimesFendedOff = self.BHLCIE_Michael_TimesFendedOff - 0.15
	self:SetHealth(self.StartHealth * self.BHLCIE_Michael_TimesFendedOff)

	if self:Health() > 750 then
		self:SetHealth(750)
	end

	-- PrintMessage(4,"DEBUG: Michael's health is now "..self:Health().."")

	self.BHLCIE_Michael_CurrentMode = 1
	self.BLBOH_Michael_Sprint = false
	self.Behavior = VJ_BEHAVIOR_PASSIVE
	self.SightAngle = 360
	self:SetSolid(SOLID_NONE)

	-- self:SetRenderFX(15)
	local thefunny = Color(200, 200, 200, 200)
	self:SetColor(thefunny)
	self:SetMaterial("models/wireframe")

end
--------------------
function ENT:OnDamaged(dmginfo, hitgroup, status)
	if status == "PreDamage" then
		if (self:Health() - dmginfo:GetDamage()) <= 0 && self.Dead == false then -- if we take lethal damage then..
			dmginfo:ScaleDamage(0) -- to avoid him actually dying
			self:Michael_Flee()
		end
	end
end