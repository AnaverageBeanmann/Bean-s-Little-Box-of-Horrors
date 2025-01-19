AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = {"models/vj_blboh/michael_davies.mdl"}
ENT.StartHealth = 300
--------------------
ENT.VJ_NPC_Class = {"CLASS_DEMON"}
--------------------
ENT.BloodColor = VJ.BLOOD_COLOR_RED
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
ENT.BLBOH_Michael_CurrentMode = 0
-- 0 = Attack Mode
-- 1 = Fleeing
-- 2 = Hiding
ENT.BLBOH_Michael_HideTime = 0 -- how long michael has to hide for before he can re-enter hunt mode
ENT.BLBOH_Michael_PlayedWarnSound = false -- did he already play his warning sound?
ENT.BLBOH_Michael_Search_Patience = 0 -- this drains if he has no enemy; when it hits 0, he'll be able to see where everyone is
ENT.BLBOH_Michael_Search_LostPatient = false -- see above value
ENT.BLBOH_Michael_Hunt_Patience = 1 -- drains while chasing an enemy; if it hits 0, he loses interest and goes into hiding
ENT.BLBOH_Michael_Hunt_LostPatient = false -- gets set to true when michael's bored of a hunt
ENT.BLBOH_Michael_Sprint = false -- sprints after playing his alert sound
ENT.BLBOH_Michael_Killable = false -- YES!! KILL!!!!!
ENT.BLBOH_Michael_Killable_FleesLeft = 2  -- how many times you have to get him to fuck off with your bullets before he actually dies
--------------------
function ENT:PreInit()
	self.BLBOH_Michael_Hunt_Patience = CurTime() + math.random(60,90)
end
--------------------
function ENT:Init()

	-- figure out a spawn sequence for him

	self:SetCollisionBounds(Vector(15, 15, 20), Vector(-15, -15, 0))
	self.BLBOH_Michael_Search_Patience = CurTime() + math.random(5,10)

	if GetConVar("vj_blboh_michael_killable"):GetInt() == 1 then
		self.BLBOH_Michael_Killable = true
	end

	self.BLBOH_Michael_Killable_FleesLeft = GetConVar("vj_blboh_michael_killable_timesneedtofendoff"):GetInt()

	if GetConVar("gamemode"):GetString() == "horde" then -- make sure he's killable in horde
		self.BLBOH_Michael_Killable = true
		self.BLBOH_Michael_Killable_FleesLeft = 0
	end

end
--------------------
function ENT:OnInput(key, activator, caller, data)
	if key == "step" && self.BLBOH_Michael_CurrentMode == 0 then
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
	self.BLBOH_Michael_Hunt_Patience = CurTime() + math.random(60,90)
end
--------------------
function ENT:BLBOH_Michael_GoIntoHiding()

	self.BLBOH_Michael_CurrentMode = 2
	self.BLBOH_Michael_HideTime = CurTime() + math.random(10,60)

	self.SightAngle = 360
	self.FindEnemy_CanSeeThroughWalls = true

	self:SetMaterial("hud/killicons/default")
	self:DrawShadow(false)
	self:RemoveAllDecals()

	self.HasFootStepSound = false

end
--------------------
function ENT:OnThinkActive()

	if self.BLBOH_Michael_CurrentMode == 0 then -- we're hunting!

		if !self.Alerted && self.BLBOH_Michael_PlayedWarnSound then

			self.BLBOH_Michael_PlayedWarnSound = false
			self.BLBOH_Michael_Sprint = false

			self.HasBreathSound = false

			VJ.STOPSOUND(self.CurrentBreathSound)

		end

		-- check if we haven't played our warning sound and we have a valid and visible enemy
		if !self.BLBOH_Michael_PlayedWarnSound && self:GetEnemy() != nil && self:Visible(self:GetEnemy()) then

			-- play the warning sound
			self.BLBOH_Michael_PlayedWarnSound = true
			self.BLBOH_Michael_Hunt_Patience = CurTime() + math.random(15,30)
			self.BLBOH_Michael_Sprint = true

			self.SightAngle = 156
			self.FindEnemy_CanSeeThroughWalls = false

			self.HasBreathSound = true
			VJ.EmitSound(self,self.SoundTbl_Warn,100,100)

		end

		-- if our patience counter has hit 0 and we haven't lost our patience..
		if self.BLBOH_Michael_Search_Patience < CurTime() && !self.BLBOH_Michael_Search_LostPatient && !self.BLBOH_Michael_PlayedWarnSound then

			-- lose patience. michael is now omnipotenent
			self.BLBOH_Michael_Search_LostPatient = true
			self.SightAngle = 360
			self.FindEnemy_CanSeeThroughWalls = true

		end

		-- we have a valid enemy, our hunt patience has run out, and we haven't lost our hunt patience
		if self.IsValid(self:GetEnemy()) && self.BLBOH_Michael_Hunt_Patience < CurTime() && !self.BLBOH_Michael_Hunt_LostPatient then

			-- michael's bored of this hunt and goes away for now
			self.BLBOH_Michael_Hunt_LostPatient = true
			self:Michael_Flee()

		end

		if self:GetEnemy() != nil && self:GetPos():Distance(self:GetEnemy():GetPos()) <= 150 then

			if math.random(1,10) == 1 then

				self.BLBOH_Michael_Hunt_Patience = self.BLBOH_Michael_Hunt_Patience + math.random(1,3)

			end

		end

	end

	if self.BLBOH_Michael_CurrentMode == 1 then -- we're fleeing

		if self:GetEnemy() != nil then -- check if we have a valid enemy

			local enemydist = self:GetPos():Distance(self:GetEnemy():GetPos()) -- distance check

			-- if we can't see our current enemy and they're far enough..
			if !self:Visible(self:GetEnemy()) && enemydist >= 250 or !(self:GetEnemy():GetForward():Dot((self:GetPos() -self:GetEnemy():GetPos()):GetNormalized()) > math.cos(math.rad(60))) then

				-- go into hiding
				self:BLBOH_Michael_GoIntoHiding()

			end

		end

		-- i think we can replace this if with an else
		if self:GetEnemy() == nil then -- if we have no valid enemy then..

			self:BLBOH_Michael_GoIntoHiding()

		end

	end

	if self.BLBOH_Michael_CurrentMode == 2 then -- we're hiding

		if self.BLBOH_Michael_HideTime < CurTime() then -- if our hide time check hits 0 then..

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
					-- we have a valid enemy
					self:GetEnemy() != nil &&
					-- we can't see the enemy OR they're farther than 500 units and not looking at us
					(!self:Visible(self:GetEnemy()) or enemydist >= 500 && !(self:GetEnemy():GetForward():Dot((self:GetPos() - self:GetEnemy():GetPos()):GetNormalized()) > math.cos(math.rad(60)))) &&
					-- tracer checks to make sure we're not inside anything
					!tr1.Hit && !tr2.Hit && !tr3.Hit && !tr4.Hit

				then

					-- go on the hunt!

					self.BLBOH_Michael_CurrentMode = 0
					self.BLBOH_Michael_Hunt_Patience = CurTime() + math.random(60,90)
					self.BLBOH_Michael_Search_Patience = CurTime() + math.random(5,10)
					self.BLBOH_Michael_Hunt_LostPatient = false
					self.BLBOH_Michael_Search_LostPatient = false
					self.BLBOH_Michael_PlayedWarnSound = false

					self.Behavior = VJ_BEHAVIOR_AGGRESSIVE
					self.SightAngle = 156
					self.FindEnemy_CanSeeThroughWalls = false
					self.GodMode = false
					self:SetSolid(SOLID_BBOX)
					self:ResetEnemy(true)

					self:SetRenderFX(0)
					self:SetMaterial(nil)
					self:DrawShadow(true)
					self:SetColor(Color(255, 255, 255, 255))
					self:RemoveAllDecals()

					self.HasFootStepSound = true

				end

			else

				-- we didn't meet the requirements, keep hiding
				self.BLBOH_Michael_HideTime = CurTime() + 3

			end

		end

	end

end
--------------------
function ENT:Michael_Flee()

	-- add something so that if he does this from losing hunt patience then it's more clear that's the reason

	-- flee!
	self.BLBOH_Michael_CurrentMode = 1
	self.BLBOH_Michael_Sprint = false

	self.GodMode = true
	self:SetHealth(self.StartHealth)

	self.Behavior = VJ_BEHAVIOR_PASSIVE

	self.SightAngle = 360
	self.FindEnemy_CanSeeThroughWalls = true

	self:SetSolid(SOLID_NONE)

	self:SetMaterial("models/wireframe")
	self:SetColor(Color(200, 200, 200, 200))
	self:SetRenderFX(16)

	VJ.EmitSound(self,self.SoundTbl_Flee,100,100)

	self.HasBreathSound = false
	VJ.STOPSOUND(self.CurrentBreathSound)

	timer.Simple(0.15, function() if IsValid(self) then -- not sure why this is here to be honest; might be a precaution?

		self:SetHealth(self.StartHealth)

	end end)

end
--------------------
function ENT:OnDamaged(dmginfo, hitgroup, status)
	if status == "PreDamage" then
		if self.BLBOH_Michael_CurrentMode == 0 then
			self.BLBOH_Michael_Hunt_Patience = self.BLBOH_Michael_Hunt_Patience + math.random(1,3)
		end
		if (self:Health() - dmginfo:GetDamage()) <= 0 && self.Dead == false then -- if we take lethal damage then..
			if self.BLBOH_Michael_Killable_FleesLeft > 0 or !self.BLBOH_Michael_Killable then -- might have to change this to a "is above 0" check
				dmginfo:ScaleDamage(0) -- to avoid him actually dying
				self:Michael_Flee()
			end
			if self.BLBOH_Michael_Killable then
				self.BLBOH_Michael_Killable_FleesLeft = self.BLBOH_Michael_Killable_FleesLeft - 1
			end
			-- PrintMessage(4,"Michael has "..self.BLBOH_Michael_Killable_FleesLeft.." spare flee chances.")
		end
	end
end
--------------------
function ENT:OnCreateDeathCorpse(dmginfo, hitgroup, corpseEnt)
	VJ.EmitSound(self,"vj_blboh/shepherd/bullet_hit_target.mp3",70,100)
	VJ.EmitSound(self,"vj_blboh/shepherd/bullet_hit_target.mp3",70,100)
	timer.Simple(1, function() if IsValid(corpseEnt) then
		if math.random(1,10) == 1 then
			VJ.EmitSound(corpseEnt,"vj_blboh/michael_davies/Wretch2.mp3",80,100)
		else
			VJ.EmitSound(corpseEnt,"vj_blboh/michael_davies/Mortis.mp3",80,100)
			-- VJ.EmitSound(corpseEnt,"vj_blboh/michael_davies/Mortis.mp3",70,100)
		end
	end end)
end
--------------------
