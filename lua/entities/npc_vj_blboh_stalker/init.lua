AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = "models/vj_blboh/stalker.mdl"
ENT.StartHealth = 25
ENT.ControllerParams = {
	ThirdP_Offset = Vector(60, 15, -60),
	FirstP_Bone = "Bip01_Head1", -- If left empty, the base will attempt to calculate a position for first person
}
--------------------
ENT.VJ_NPC_Class = {"CLASS_BLBOH"}
--------------------
ENT.BloodColor = VJ.BLOOD_COLOR_OIL
--------------------
ENT.HasDeathCorpse = false
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
ENT.SoundTbl_Breath = "player/breathe1.wav"
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
ENT.SoundTbl_Death = {
	"vj_blboh/stalker/Hit1.wav",
	"vj_blboh/stalker/Hit2.wav",
	"vj_blboh/stalker/Hit3.wav",
	"vj_blboh/stalker/Hit4.wav"
}
ENT.NextSoundTime_Breath = VJ.SET(11,11)
ENT.FootstepSoundLevel = 60
ENT.BreathSoundLevel = 60
ENT.MainSoundPitch = 100
ENT.BreathSoundPitch = VJ.SET(65,65)
--------------------
ENT.BLBOH_DoSpawnSequence = false
ENT.BLBOH_CanDoSpawnSequence = true
ENT.BLBOH_Stalker_Cloaked = false
ENT.BLBOH_Stalker_CloakLevel = 0
ENT.BLBOH_Stalker_RenderShadow = false
ENT.BLBOH_Stalker_PlayFootstepSounds = false
ENT.BLBOH_Stalker_CanRun = false
ENT.BLBOH_Stalker_ForceCloakToBeOne = false
ENT.BLBOH_Stalker_RemoveDecals = true
ENT.BLBOH_Stalker_Controller_Cloaking = false
ENT.BLBOH_Stalker_Controller_CloakDelay = 0
--------------------
function ENT:PreInit()
	if GetConVar("vj_blboh_spawn_sequences"):GetInt() == 1 && self.BLBOH_CanDoSpawnSequence then
		self.BLBOH_DoSpawnSequence = true
	end
end
--------------------
function ENT:Init()

	-- figure out how to make it so it stays still and is solid for 3 seconds or so when it spawns
	-- so it'll be easier for people to play as it

	self:AddFlags(FL_NOTARGET)
	self:SetSolid(SOLID_NONE)

	self.BLBOH_Stalker_CloakLevel = 0

	self:SetRenderMode(1)
	self:SetColor(Color(255, 255, 255, 0))
	self:DrawShadow(false)

	-- if IsValid(self) && self:GetCreator() != nil && self:GetCreator():IsPlayer() == true then
	-- if IsValid(self) && self:GetCreator() != nil then
	-- if IsValid(self) && IsValid(self:GetCreator()) then
		-- local TheCreator = self:GetCreator()
		-- if TheCreator:IsPlayer() == false then
			-- self.MovementType = VJ_MOVETYPE_STATIONARY
			-- timer.Simple(3, function() if IsValid(self) then
				-- self.MovementType = VJ_MOVETYPE_GROUND
				-- self:SetSolid(SOLID_NONE)
			-- end end)
		-- else
			-- self:SetSolid(SOLID_NONE)
		-- end
	-- else
		-- self:SetSolid(SOLID_NONE)
	-- end


	-- timer.Simple(0.1,function() if IsValid(self) then
		-- if IsValid(self:GetCreator()) then
			-- self.GodMode = true
			-- self.MovementType = VJ_MOVETYPE_STATIONARY
			-- timer.Simple(2, function() if IsValid(self) then
				-- self.MovementType = VJ_MOVETYPE_GROUND
				-- self:SetSolid(SOLID_NONE)
				-- self.GodMode = false
			-- end end)
		-- else
			-- self:SetSolid(SOLID_NONE)
		-- end
	-- end end)

	timer.Simple(0.1,function() if IsValid(self) then
		if IsValid(self:GetCreator()) && self:GetCreator():GetActiveWeapon():GetClass() == "weapon_vj_controller" then
		-- VJ.EmitSound(self,{"ambient/materials/metal4.wav"},75,math.random(80,110))
			local ent_controller = ents.Create("obj_vj_controller")
			ent_controller.VJCE_Player = self:GetCreator()
			ent_controller:SetControlledNPC(self)
			ent_controller:Spawn()
			ent_controller:StartControlling()
		end
	end end)


	if self.BLBOH_DoSpawnSequence then
		VJ.EmitSound(self,{"ambient/materials/metal4.wav"},75,math.random(80,110))
	end

	timer.Simple(0.15,function() if IsValid(self) then

		self:SetColor(Color(255, 255, 255, 0))

	end end)

end
--------------------
function ENT:BLBOH_Stalker_UpdateCloak()

	-- see if this can be optimized at all

	if self.BLBOH_Stalker_Cloaked && self.BLBOH_Stalker_CloakLevel >= 30 && !self.BLBOH_Stalker_ForceCloakToBeOne then
		self.BLBOH_Stalker_CloakLevel = self.BLBOH_Stalker_CloakLevel - 85
	elseif !self.BLBOH_Stalker_Cloaked && self.BLBOH_Stalker_CloakLevel < 255 then
		self.BLBOH_Stalker_CloakLevel = self.BLBOH_Stalker_CloakLevel + 15
	end

	if self.BLBOH_Stalker_CloakLevel < 200 && self.BLBOH_Stalker_RenderShadow then
		self.BLBOH_Stalker_RenderShadow = false
		self.BLBOH_Stalker_CanRun = false
		self:AddFlags(FL_NOTARGET)
		self:SetSolid(SOLID_NONE)
		self:DrawShadow(false)
		self.BLBOH_Stalker_PlayFootstepSounds = false
	elseif self.BLBOH_Stalker_CloakLevel >= 200 && !self.BLBOH_Stalker_RenderShadow then
		self.BLBOH_Stalker_RenderShadow = true
		self.BLBOH_Stalker_CanRun = true
		self.BLBOH_Stalker_RemoveDecals = false
		self:RemoveFlags(FL_NOTARGET)
		self:SetSolid(SOLID_BBOX)
		self:DrawShadow(true)
		self.BLBOH_Stalker_PlayFootstepSounds = true
	end

	if self.BLBOH_Stalker_CloakLevel < 30 && self.BLBOH_Stalker_Cloaked && !self.BLBOH_Stalker_ForceCloakToBeOne then
		self.BLBOH_Stalker_ForceCloakToBeOne = true
		self.BLBOH_Stalker_CloakLevel = 1
	end
	-- can this be an elseif?
	if self.BLBOH_Stalker_CloakLevel > 255 then
		self.BLBOH_Stalker_CloakLevel = 255
	end

	if !self.BLBOH_Stalker_RenderShadow && !self.BLBOH_Stalker_RemoveDecals then
		self.BLBOH_Stalker_RemoveDecals = true
		self:RemoveAllDecals()
	end

	self:SetColor(Color(self.BLBOH_Stalker_CloakLevel, self.BLBOH_Stalker_CloakLevel, self.BLBOH_Stalker_CloakLevel, self.BLBOH_Stalker_CloakLevel))

end
--------------------
function ENT:OnThinkActive()
	-- PrintMessage(4,"Health is "..self:Health().."")
	-- PrintMessage(4,""..self.BLBOH_Stalker_CloakLevel.."")

	self:BLBOH_Stalker_UpdateCloak()

	if self.VJ_IsBeingControlled then
		if self.VJ_TheController:KeyDown(IN_ATTACK2) && self.BLBOH_Stalker_Controller_CloakDelay < CurTime() then
			self.BLBOH_Stalker_Controller_CloakDelay = CurTime() + 1
			if self.BLBOH_Stalker_Cloaked then
				self.BLBOH_Stalker_Cloaked = false
				self.HasMeleeAttack = true
				if self.BLBOH_Stalker_ForceCloakToBeOne then
					self.BLBOH_Stalker_ForceCloakToBeOne = false
				end
			else
				self.BLBOH_Stalker_Cloaked = true
				self.HasMeleeAttack = false
			end
		end
	else
		if !self.HasMeleeAttack then -- incase the stalker was being possessed and they stop possessing it
			-- VJ.EmitSound(self,{"player/survivor/voice/coach/hurtminor07.wav"},75,math.random(80,110)) -- test
			self.HasMeleeAttack = true
		end
		if self:GetEnemy() != nil then
			if !self:Visible(self:GetEnemy()) && self:GetPos():Distance(self:GetEnemy():GetPos()) >= 250 or !(self:GetEnemy():GetForward():Dot((self:GetPos() -self:GetEnemy():GetPos()):GetNormalized()) > math.cos(math.rad(60))) then
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
						if self.BLBOH_Stalker_ForceCloakToBeOne then
							self.BLBOH_Stalker_ForceCloakToBeOne = false
						end
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
end
--------------------
function ENT:OnInput(key, activator, caller, data)
	if key == "step" && self.BLBOH_Stalker_PlayFootstepSounds then
		VJ.EmitSound(self,self.SoundTbl_FootStep,self.FootstepSoundLevel)
	elseif key == "melee" then
		self:MeleeAttackCode()
	end
end
--------------------
function ENT:OnDamaged(dmginfo, hitgroup, status)
	-- take less damage if we're cloaked
	if status == "PreDamage" && !self.BLBOH_Stalker_RenderShadow then
		-- play around with this until it feels right
		-- PrintMessage(4,"yeah")
		dmginfo:ScaleDamage(0.20)
	end
end
--------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
	if status == "Init" then
		local DeathFogEffect = EffectData()
		DeathFogEffect:SetOrigin(self:GetPos() + self:GetUp()*25)
		DeathFogEffect:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
		DeathFogEffect:SetScale(100)
		util.Effect("VJ_Blood1",DeathFogEffect)
		DeathFogEffect:SetOrigin(self:GetPos() + self:GetUp()*50)
		util.Effect("VJ_Blood1",DeathFogEffect)
	end
	-- if status == "Finish" then
		-- self:SetColor(Color(255, 255, 255, 255))
	-- end
end
--------------------
function ENT:Controller_Initialize(ply, controlEnt)
	ply:ChatPrint("MOUSE2: Toggle Cloak")
	ply:ChatPrint("You can't attack or run while cloaked.")
end
--------------------
function ENT:TranslateActivity(act)
	if act == ACT_RUN && !self.BLBOH_Stalker_CanRun then
		return ACT_WALK
	end
	return act
end