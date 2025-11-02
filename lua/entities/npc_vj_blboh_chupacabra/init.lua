AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = "models/vj_blboh/chupacabra.mdl"
ENT.StartHealth = 300
ENT.HealthRegenParams = {
	Enabled = false,
	Amount = 3,
	Delay = VJ.SET(1, 1),
	ResetOnDmg = false,
}
--------------------
ENT.VJ_NPC_Class = {"CLASS_BLBOH"}
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
ENT.SoundTbl_Breath = "vj_blboh/chupacabra/Audio glitches.ogg"
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
	"vj_blboh/chupacabra/I_have_the_body_of_a_pig.mp3",
	"vj_blboh/chupacabra/Run_run_run.mp3",
	"vj_blboh/chupacabra/Suffer.mp3",
	"vj_blboh/chupacabra/Carnage.mp3",
	"vj_blboh/chupacabra/Worship_me.mp3",
	"vj_blboh/chupacabra/En_nombre_de_jesus.mp3",
	"vj_blboh/chupacabra/Corruption_thou_art_my_father.mp3",
	"vj_blboh/chupacabra/Blood.mp3"
}
ENT.SoundTbl_Flee = {
	"vj_blboh/chupacabra/Father.mp3",
	"vj_blboh/chupacabra/Noooo.mp3",
	"vj_blboh/chupacabra/Aaaaaaaaaaaaaa.mp3",
	"vj_blboh/chupacabra/I_go_unwillingly.mp3",
	"vj_blboh/chupacabra/You_know_nothing.mp3",
	"vj_blboh/chupacabra/Por_la_cruz_invertida.mp3",
	"vj_blboh/chupacabra/La_sangre_de_puta_madre.mp3",
	"vj_blboh/chupacabra/Que_te_cojan_mil_cabras.mp3"
}
ENT.NextSoundTime_Breath = VJ.SET(8,8)
ENT.BreathSoundLevel = 100
ENT.MainSoundPitch = 100
--------------------
ENT.BLBOH_DoSpawnSequence = false
ENT.BLBOH_CanDoSpawnSequence = true
-- ENT.BLBOH_Chupacabra_CurrentMode = 0
-- 0 = Attack Mode
-- 1 = Fleeing
-- 2 = Hiding
ENT.BLBOH_Chupacabra_IsHiding = false
ENT.BLBOH_Chupacabra_HideTime = 0 -- how long chupacabra has to hide for before he can re-enter hunt mode
ENT.BLBOH_Chupacabra_PlayedWarnSound = false -- did he already play his warning sound?
ENT.BLBOH_Chupacabra_Search_Patience = 0 -- this drains if he has no enemy; when it hits 0, he'll be able to see where everyone is
ENT.BLBOH_Chupacabra_Search_LostPatient = false -- see above value
ENT.BLBOH_Chupacabra_Hunt_Patience = 1 -- drains while chasing an enemy; if it hits 0, he loses interest and goes into hiding
ENT.BLBOH_Chupacabra_Hunt_LostPatient = false -- gets set to true when chupacabra's bored of a hunt
ENT.BLBOH_Chupacabra_Sprint = false -- sprints after playing his alert sound
ENT.BLBOH_Chupacabra_Killable = false -- YES!! KILL!!!!!
ENT.BLBOH_Chupacabra_Killable_FleesLeft = 2  -- how many times you have to get him to fuck off with your bullets before he actually dies
ENT.BLBOH_Chupacabra_SpawnCloakLevel = 0
ENT.BLBOH_Chupacabra_CanBeOmnipotent = false
-- ENT.BLBOH_Chupacabra_Spawning = true
--------------------
function ENT:PreInit()
	self.BLBOH_Chupacabra_Hunt_Patience = CurTime() + math.random(60,90)
	if GetConVar("vj_blboh_chupacabra_omniscience"):GetInt() == 1 then
		self.BLBOH_Chupacabra_CanBeOmnipotent = true
	end
	if GetConVar("vj_blboh_spawn_sequences"):GetInt() == 1 && self.BLBOH_CanDoSpawnSequence then
		self.BLBOH_DoSpawnSequence = true
	end
end
--------------------
function ENT:BLBOH_Chupacabra_DigEffects(playanim)

	-- PrintMessage(4,"it snew")
	if playanim == "Yeah" then
		self:PlayAnim({"vjseq_slumprise_b"},true,false)
	end

	VJ.EmitSound(self,{"vj_blboh/undead/spawn_dirt_0"..math.random(0,1)..".wav"},80,math.random(90,110))

	local bloodeffect = EffectData()
	bloodeffect:SetOrigin(self:GetPos() + self:GetForward() * 25 + self:GetUp()*15)
	bloodeffect:SetColor(VJ_Color2Byte(Color(25,0,0,255)))
	bloodeffect:SetScale(125)
	util.Effect("VJ_Blood1",bloodeffect)
	bloodeffect:SetOrigin(self:GetPos() + self:GetForward() * -25 + self:GetUp()*15)
	util.Effect("VJ_Blood1",bloodeffect)
	bloodeffect:SetOrigin(self:GetPos() + self:GetRight() * 25 + self:GetUp()*15)
	util.Effect("VJ_Blood1",bloodeffect)
	bloodeffect:SetOrigin(self:GetPos() + self:GetRight() * -25 + self:GetUp()*15)
	util.Effect("VJ_Blood1",bloodeffect)

end
--------------------
function ENT:Init()

	self:CapabilitiesRemove(bit.bor(CAP_ANIMATEDFACE))
	self:CapabilitiesRemove(CAP_MOVE_CLIMB) -- he gets stuck when he tries climbing so this is disabled until i figure out how to fix it

	self.EnemyDetection = false
	self.CanInvestigate = false
	self.CanReceiveOrders = false
	self:AddFlags(FL_NOTARGET)
	self.GodMode = true
	self.HasSounds = false

	self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK,5)

	self:SetRenderMode(1)
	self:SetColor(Color(255, 255, 255, 0))
	self:DrawShadow(false)
	VJ.EmitSound(self,{"vj_blboh/chupacabra/Demonic ambience.mp3"},90,100)
	VJ.EmitSound(self,{"vj_blboh/chupacabra/Demonic ambience.mp3"},90,100)

	timer.Simple(5,function() if IsValid(self) then

		self:PlayAnim({"vjseq_slumprise_b"},true,false)
		VJ.EmitSound(self,{"vj_blboh/undead/spawn_dirt_0"..math.random(0,1)..".wav"},80,math.random(90,110))

		-- self.BLBOH_Chupacabra_Spawning = false
		self:SetColor(Color(255, 255, 255, 255))

		self.EnemyDetection = true
		self.CanInvestigate = true
		self.CanReceiveOrders = true
		self:RemoveFlags(FL_NOTARGET)
		self.GodMode = false
		self:DrawShadow(true)
		self.HasSounds = true

		self:BLBOH_Chupacabra_DigEffects("Nah")

	end end)

	self:SetCollisionBounds(Vector(15, 15, 20), Vector(-15, -15, 0))
	self.BLBOH_Chupacabra_Search_Patience = CurTime() + math.random(5,10)


	-- there's a better way to check this but i don't know what it is off the top of my head
	-- check the gmod wiki later
	-- should we also change this to just be a "if we're not in sandbox" check?
	if GetConVar("gamemode"):GetString() == "horde" then -- make sure he's killable in horde
		self.BLBOH_Chupacabra_Killable = true
		self.BLBOH_Chupacabra_Killable_FleesLeft = 0
	else
		if GetConVar("vj_blboh_chupacabra_killable"):GetInt() == 1 then
			self.BLBOH_Chupacabra_Killable = true
		end
		self.BLBOH_Chupacabra_Killable_FleesLeft = GetConVar("vj_blboh_chupacabra_killable_timesneedtofendoff"):GetInt()
	end

end
--------------------
function ENT:BLBOH_Chupacabra_GoIntoHiding()

	-- self.BLBOH_Chupacabra_CurrentMode = 2
	self.BLBOH_Chupacabra_IsHiding = true
	self.BLBOH_Chupacabra_HideTime = CurTime() + math.random(10,60)
	-- self.BLBOH_Chupacabra_Sprint = false

	self.HealthRegenParams = {
		Enabled = true,
		Amount = 3,
		Delay = VJ.SET(1, 1),
		ResetOnDmg = false,
	}

	-- self:CapabilitiesRemove(CAP_MOVE_CLIMB)

	self.SightAngle = 360
	self.EnemyXRayDetection = true
	self:SetSolid(SOLID_NONE)
	self:AddFlags(FL_NOTARGET)

	self:SetMaterial("hud/killicons/default")
	self:DrawShadow(false)
	-- self:RemoveAllDecals()

	VJ.EmitSound(self,self.SoundTbl_Flee,100,100)
	self.HasBreathSound = false	
	VJ.STOPSOUND(self.CurrentBreathSound)

	-- self.GodMode = true
	self.Behavior = VJ_BEHAVIOR_PASSIVE
	self.HasFootstepSounds = false

	self:BLBOH_Chupacabra_DigEffects("Yeah")

end
--------------------
function ENT:OnThink()
	-- if self.BLBOH_Chupacabra_Spawning then
		-- self.BLBOH_Chupacabra_SpawnCloakLevel = self.BLBOH_Chupacabra_SpawnCloakLevel + 3.5
		-- self:SetColor(Color(255, 255, 255, self.BLBOH_Chupacabra_SpawnCloakLevel))
	-- end
end
--------------------
function ENT:OnThinkActive()

	-- this feels really messy, see if we can optimize this at all
	-- if self.BLBOH_Chupacabra_CurrentMode == 0 then -- we're hunting!
	if !self.BLBOH_Chupacabra_IsHiding then -- we're hunting!
		-- check if we haven't played our warning sound and we have a valid and visible enemy
		if self:GetEnemy() != nil && self:Visible(self:GetEnemy()) && !self.BLBOH_Chupacabra_PlayedWarnSound then
			-- play the warning sound
			self.BLBOH_Chupacabra_PlayedWarnSound = true
			self.BLBOH_Chupacabra_Hunt_Patience = CurTime() + math.random(15,30)
			self.BLBOH_Chupacabra_Sprint = true
			self.SightAngle = 156
			self.EnemyXRayDetection = false
			self.HasBreathSound = true
			VJ.EmitSound(self,self.SoundTbl_Warn,100,100)
		elseif self:GetEnemy() == nil && !self.Alerted && self.BLBOH_Chupacabra_PlayedWarnSound then
			self.BLBOH_Chupacabra_PlayedWarnSound = false
			self.BLBOH_Chupacabra_Sprint = false
			self.HasBreathSound = false
			VJ.STOPSOUND(self.CurrentBreathSound)
		end
		-- if our patience counter has hit 0 and we haven't lost our patience..
		if self.BLBOH_Chupacabra_Search_Patience < CurTime() && !self.BLBOH_Chupacabra_Search_LostPatient && !self.BLBOH_Chupacabra_PlayedWarnSound && self.BLBOH_Chupacabra_CanBeOmnipotent then
			-- lose patience. chupacabra is now omnipotenent
			self.BLBOH_Chupacabra_Search_LostPatient = true
			self.SightAngle = 360
			self.EnemyXRayDetection = true
		end
		-- we have a valid enemy, our hunt patience has run out, and we haven't lost our hunt patience
		if self:IsValid(self:GetEnemy()) && self.BLBOH_Chupacabra_Hunt_Patience < CurTime() && !self.BLBOH_Chupacabra_Hunt_LostPatient then
			-- chupacabra's bored of this hunt and goes away for now
			self.BLBOH_Chupacabra_Hunt_LostPatient = true
			self:BLBOH_Chupacabra_GoIntoHiding()
		end
		-- randomly slightly extend the hunt time if he's close enough
		if self:GetEnemy() != nil && self:GetPos():Distance(self:GetEnemy():GetPos()) <= 150 && math.random(1,10) == 1 then
			self.BLBOH_Chupacabra_Hunt_Patience = CurTime() + math.random(1,3)
		end
	-- elseif self.BLBOH_Chupacabra_CurrentMode == 1 then -- we're fleeing
		-- if self:GetEnemy() != nil then -- check if we have a valid enemy
			-- if we can't see our current enemy and they're far enough OR they're not looking at us
			-- if !self:Visible(self:GetEnemy()) && self:GetPos():Distance(self:GetEnemy():GetPos()) >= 250 or !(self:GetEnemy():GetForward():Dot((self:GetPos() -self:GetEnemy():GetPos()):GetNormalized()) > math.cos(math.rad(60))) then
				-- go into hiding
				-- self:BLBOH_Chupacabra_GoIntoHiding()
			-- end
		-- end
		-- i think we can replace this if with an else
		-- if self:GetEnemy() == nil then -- if we have no valid enemy then..
			-- self:BLBOH_Chupacabra_GoIntoHiding()
		-- end
	-- elseif self.BLBOH_Chupacabra_CurrentMode == 2 then -- we're hiding
	elseif self.BLBOH_Chupacabra_IsHiding then -- we're hiding
		self:RemoveAllDecals()
		if self.BLBOH_Chupacabra_HideTime < CurTime() then -- if our hide time check hits 0 then..
			if IsValid(self:GetEnemy()) then -- if we have a valid enemy..
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
					(!self:Visible(self:GetEnemy()) or self:GetPos():Distance(self:GetEnemy():GetPos()) >= 500 && !(self:GetEnemy():GetForward():Dot((self:GetPos() - self:GetEnemy():GetPos()):GetNormalized()) > math.cos(math.rad(60)))) &&
					-- tracer checks to make sure we're not inside anything
					!tr1.Hit && !tr2.Hit && !tr3.Hit && !tr4.Hit
				then
					-- go on the hunt!
					self.BLBOH_Chupacabra_IsHiding = false
					self.BLBOH_Chupacabra_Hunt_Patience = CurTime() + math.random(60,90)
					self.BLBOH_Chupacabra_Search_Patience = CurTime() + math.random(5,10)
					self.BLBOH_Chupacabra_Hunt_LostPatient = false
					self.BLBOH_Chupacabra_Search_LostPatient = false
					self.BLBOH_Chupacabra_PlayedWarnSound = false

					self:RemoveFlags(FL_NOTARGET)
					-- self:CapabilitiesAdd(CAP_MOVE_CLIMB)

					self.HealthRegenParams = {
						Enabled = false,
						Amount = 3,
						Delay = VJ.SET(1, 1),
						ResetOnDmg = false,
					}

					self.Behavior = VJ_BEHAVIOR_AGGRESSIVE
					self.SightAngle = 156
					self.EnemyXRayDetection  = false
					self.GodMode = false
					self:SetSolid(SOLID_BBOX)
					self:ResetEnemy(true)

					self:SetRenderFX(0)
					self:SetMaterial(nil)
					self:DrawShadow(true)
					self:SetColor(Color(255, 255, 255, 255))
					self:RemoveAllDecals()

					self.HasFootstepSounds = true

					self:BLBOH_Chupacabra_DigEffects("Yeah")

				end
			else
				-- we didn't meet the requirements, keep hiding
				self.BLBOH_Chupacabra_HideTime = CurTime() + 3
			end
		end
	end
end
--------------------
function ENT:OnInput(key, activator, caller, data)
	if key == "step" && !self.BLBOH_Chupacabra_IsHiding then
		VJ.EmitSound(self,self.SoundTbl_FootStep,self.FootStepSoundLevel)
	elseif key == "attack" then
		self:MeleeAttackCode()
	end
end
--------------------
function ENT:OnAlert(ent)
	self.BLBOH_Chupacabra_Hunt_Patience = CurTime() + math.random(60,90)
end
--------------------
function ENT:OnDamaged(dmginfo, hitgroup, status)
	if status == "PreDamage" then
		-- if self.BLBOH_Chupacabra_CurrentMode == 0 then
		if !self.BLBOH_Chupacabra_IsHiding then
			self.BLBOH_Chupacabra_Hunt_Patience = CurTime() + math.random(1,3)
		elseif self.BLBOH_Chupacabra_IsHiding then
			dmginfo:ScaleDamage(0) -- to avoid him actually dying
		end
		if (self:Health() - dmginfo:GetDamage()) <= 0 && self.Dead == false then -- if we take lethal damage then..
			if self.BLBOH_Chupacabra_Killable_FleesLeft > 0 or !self.BLBOH_Chupacabra_Killable then -- might have to change this to a "is above 0" check
				-- PrintMessage(4,"test")
				dmginfo:ScaleDamage(0) -- to avoid him actually dying
				dmginfo:ScaleDamage(0) -- to avoid him actually dying
				self.GodMode = true
				self:BLBOH_Chupacabra_GoIntoHiding()
			end
			if self.BLBOH_Chupacabra_Killable then
				self.BLBOH_Chupacabra_Killable_FleesLeft = self.BLBOH_Chupacabra_Killable_FleesLeft - 1
			end
			-- PrintMessage(4,"Chupacabra has "..self.BLBOH_Chupacabra_Killable_FleesLeft.." spare flee chances.")
		end
	end
end
--------------------
function ENT:OnCreateDeathCorpse(dmginfo, hitgroup, corpse)
	VJ.EmitSound(self,"vj_blboh/shepherd/bullet_hit_target.mp3",70,100)
	VJ.EmitSound(self,"vj_blboh/shepherd/bullet_hit_target.mp3",70,100)
	timer.Simple(1, function() if IsValid(corpse) then
		if math.random(1,10) == 1 then
			VJ.EmitSound(corpse,"vj_blboh/chupacabra/Wretch2.mp3",80,100)
		else
			VJ.EmitSound(corpse,"vj_blboh/chupacabra/Mortis.mp3",80,100)
			-- VJ.EmitSound(corpse,"vj_blboh/chupacabra/Mortis.mp3",70,100)
		end
	end end)
end
--------------------
function ENT:TranslateActivity(act)
	if act == ACT_RUN && self.BLBOH_Chupacabra_Sprint then
		return ACT_SPRINT
	end
	return act
end
