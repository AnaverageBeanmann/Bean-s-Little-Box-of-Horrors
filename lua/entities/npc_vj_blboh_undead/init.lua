AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = "models/vj_blboh/undead.mdl"
ENT.StartHealth = 100
--------------------
ENT.VJ_NPC_Class = {"CLASS_DEMON"}
--------------------
ENT.BloodColor = "Red"
--------------------
ENT.MeleeAttackDamage = 10
ENT.MeleeAttackDamageType = DMG_CLUB
ENT.TimeUntilMeleeAttackDamage = false
ENT.AnimTbl_MeleeAttack = {"vjges_attackA", "vjges_attackB", "vjges_attackC", "vjges_attackD", "vjges_attackE", "vjges_attackF"}
--ENT.AnimTbl_MeleeAttack = {"vjges_attack1", "vjges_attack2", "vjges_attack3"}
--------------------
ENT.UndeadCount = 2
ENT.NextDamageCheckTime = 0
-- ====== Flinching Code ====== --
ENT.CanFlinch = 1
ENT.FlinchChance = 6
ENT.NextFlinchTime = 3
ENT.HasHitGroupFlinching = true
ENT.HitGroupFlinching_DefaultWhenNotHit = true
ENT.HitGroupFlinching_Values = {
{HitGroup = {HITGROUP_HEAD}, Animation = {"vjges_flinch_head_1","vjges_flinch_head_2","vjges_flinch_head_3"}}, 
{HitGroup = {HITGROUP_STOMACH}, Animation = {"vjges_ep_flinch_chest","vjges_ep_flinch_head"}}, 
{HitGroup = {HITGROUP_CHEST}, Animation = {"vjges_flinch_chest_1","vjges_flinch_chest_2","vjges_flinch_chest_3"}}, 
{HitGroup = {HITGROUP_LEFTARM}, Animation = {"vjges_flinch_leftarm_1","vjges_flinch_leftarm_2","vjges_flinch_leftarm_3","vjges_ep_flinch_leftarm"}}, 
{HitGroup = {HITGROUP_RIGHTARM}, Animation = {"vjges_flinch_rightarm_1","vjges_flinch_rightarm_2","vjges_flinch_rightarm_3","vjges_ep_flinch_rightarm"}}, 
{HitGroup = {HITGROUP_LEFTLEG}, Animation = {"vjseq_ep_flinch_leftLeg"}}, 
{HitGroup = {HITGROUP_RIGHTLEG}, Animation = {"vjseq_ep_flinch_rightLeg"}}
}	
-- ====== Sound File Paths ====== --
ENT.DisableFootStepSoundTimer = true
ENT.SoundTbl_Idle = {
	"vj_blboh/undead/zombie_plain_idle1.wav",
	"vj_blboh/undead/zombie_plain_idle2.wav",
	"vj_blboh/undead/zombie_plain_idle3.wav",
	"vj_blboh/undead/zombie_plain_idle4.wav",
	"vj_blboh/undead/zombie_plain_idle5.wav",
	"vj_blboh/undead/zombie_plain_idle6.wav",
	"vj_blboh/undead/zombie_plain_idle7.wav",
	"vj_blboh/undead/zombie_plain_idle8.wav",
	"vj_blboh/undead/zombie_plain_idle9.wav",
	"vj_blboh/undead/zombie_plain_idle10.wav",
	"vj_blboh/undead/zombie_plain_idle11.wav",
	"vj_blboh/undead/zombie_plain_idle12.wav",
	"vj_blboh/undead/zombie_plain_idle13.wav",
	"vj_blboh/undead/zombie_plain_idle14.wav",
}
ENT.SoundTbl_Alert = {
	"vj_blboh/undead/zombie_plain_alert1.wav",
	"vj_blboh/undead/zombie_plain_alert2.wav",
	"vj_blboh/undead/zombie_plain_alert3.wav",
	"vj_blboh/undead/zombie_plain_alert4.wav"
}
ENT.SoundTbl_BeforeMeleeAttack = {
	"vj_blboh/undead/zombie_plain_attack1.wav",
	"vj_blboh/undead/zombie_plain_attack2.wav",
	"vj_blboh/undead/zombie_plain_attack3.wav",
	"vj_blboh/undead/zombie_plain_attack4.wav",
	"vj_blboh/undead/zombie_plain_attack5.wav",
	"vj_blboh/undead/zombie_plain_attack6.wav"
}
ENT.SoundTbl_Pain = {
	"vj_blboh/undead/zombie_plain_pain1.wav",
	"vj_blboh/undead/zombie_plain_pain2.wav",
	"vj_blboh/undead/zombie_plain_pain3.wav",
	"vj_blboh/undead/zombie_plain_pain4.wav",
	"vj_blboh/undead/zombie_plain_pain5.wav",
	"vj_blboh/undead/zombie_plain_pain6.wav",
	"vj_blboh/undead/zombie_plain_pain7.wav"
}
ENT.SoundTbl_Death = {
	"vj_blboh/undead/zombie_plain_death1.wav",
	"vj_blboh/undead/zombie_plain_death2.wav",
	"vj_blboh/undead/zombie_plain_death3.wav",
	"vj_blboh/undead/zombie_plain_death4.wav",
	"vj_blboh/undead/zombie_plain_death5.wav",
	"vj_blboh/undead/zombie_plain_death6.wav",
	"vj_blboh/undead/zombie_plain_death7.wav",
}
ENT.SoundTbl_MeleeAttack = {
	"npc/zombie/claw_strike1.wav",
	"npc/zombie/claw_strike2.wav",
	"npc/zombie/claw_strike3.wav"
}
ENT.SoundTbl_MeleeAttackMiss = {
	"npc/zombie/claw_miss1.wav",
	"npc/zombie/claw_miss2.wav"
}

ENT.FootSteps = {
	[MAT_ANTLION] = {
		"physics/flesh/flesh_impact_hard1.wav",
		"physics/flesh/flesh_impact_hard2.wav",
		"physics/flesh/flesh_impact_hard3.wav",
		"physics/flesh/flesh_impact_hard4.wav",
		"physics/flesh/flesh_impact_hard5.wav",
		"physics/flesh/flesh_impact_hard6.wav",
	},
	[MAT_BLOODYFLESH] = {
		"physics/flesh/flesh_impact_hard1.wav",
		"physics/flesh/flesh_impact_hard2.wav",
		"physics/flesh/flesh_impact_hard3.wav",
		"physics/flesh/flesh_impact_hard4.wav",
		"physics/flesh/flesh_impact_hard5.wav",
		"physics/flesh/flesh_impact_hard6.wav",
	},
	[MAT_CONCRETE] = {
		"player/footsteps/concrete1.wav",
		"player/footsteps/concrete2.wav",
		"player/footsteps/concrete3.wav",
		"player/footsteps/concrete4.wav",
	},
	[MAT_DIRT] = {
		"player/footsteps/dirt1.wav",
		"player/footsteps/dirt2.wav",
		"player/footsteps/dirt3.wav",
		"player/footsteps/dirt4.wav",
	},
	[MAT_FLESH] = {
		"physics/flesh/flesh_impact_hard1.wav",
		"physics/flesh/flesh_impact_hard2.wav",
		"physics/flesh/flesh_impact_hard3.wav",
		"physics/flesh/flesh_impact_hard4.wav",
		"physics/flesh/flesh_impact_hard5.wav",
		"physics/flesh/flesh_impact_hard6.wav",
	},
	[MAT_GRATE] = {
		"player/footsteps/metalgrate1.wav",
		"player/footsteps/metalgrate2.wav",
		"player/footsteps/metalgrate3.wav",
		"player/footsteps/metalgrate4.wav",
	},
	[MAT_ALIENFLESH] = {
		"physics/flesh/flesh_impact_hard1.wav",
		"physics/flesh/flesh_impact_hard2.wav",
		"physics/flesh/flesh_impact_hard3.wav",
		"physics/flesh/flesh_impact_hard4.wav",
		"physics/flesh/flesh_impact_hard5.wav",
		"physics/flesh/flesh_impact_hard6.wav",
	},
	[74] = { -- Snow
		"player/footsteps/sand1.wav",
		"player/footsteps/sand2.wav",
		"player/footsteps/sand3.wav",
		"player/footsteps/sand4.wav",
	},
	[MAT_PLASTIC] = {
		"physics/plaster/drywall_footstep1.wav",
		"physics/plaster/drywall_footstep2.wav",
		"physics/plaster/drywall_footstep3.wav",
		"physics/plaster/drywall_footstep4.wav",
	},
	[MAT_METAL] = {
		"player/footsteps/metal1.wav",
		"player/footsteps/metal2.wav",
		"player/footsteps/metal3.wav",
		"player/footsteps/metal4.wav",
	},
	[MAT_SAND] = {
		"player/footsteps/sand1.wav",
		"player/footsteps/sand2.wav",
		"player/footsteps/sand3.wav",
		"player/footsteps/sand4.wav",
	},
	[MAT_FOLIAGE] = {
		"player/footsteps/grass1.wav",
		"player/footsteps/grass2.wav",
		"player/footsteps/grass3.wav",
		"player/footsteps/grass4.wav",
	},
	[MAT_COMPUTER] = {
		"physics/plaster/drywall_footstep1.wav",
		"physics/plaster/drywall_footstep2.wav",
		"physics/plaster/drywall_footstep3.wav",
		"physics/plaster/drywall_footstep4.wav",
	},
	[MAT_SLOSH] = {
		"player/footsteps/slosh1.wav",
		"player/footsteps/slosh2.wav",
		"player/footsteps/slosh3.wav",
		"player/footsteps/slosh4.wav",
	},
	[MAT_TILE] = {
		"player/footsteps/tile1.wav",
		"player/footsteps/tile2.wav",
		"player/footsteps/tile3.wav",
		"player/footsteps/tile4.wav",
	},
	[85] = { -- Grass
		"player/footsteps/grass1.wav",
		"player/footsteps/grass2.wav",
		"player/footsteps/grass3.wav",
		"player/footsteps/grass4.wav",
	},
	[MAT_VENT] = {
		"player/footsteps/duct1.wav",
		"player/footsteps/duct2.wav",
		"player/footsteps/duct3.wav",
		"player/footsteps/duct4.wav",
	},
	[MAT_WOOD] = {
		"player/footsteps/wood1.wav",
		"player/footsteps/wood2.wav",
		"player/footsteps/wood3.wav",
		"player/footsteps/wood4.wav",
		"player/footsteps/woodpanel1.wav",
		"player/footsteps/woodpanel2.wav",
		"player/footsteps/woodpanel3.wav",
		"player/footsteps/woodpanel4.wav",
	},
	[MAT_GLASS] = {
		"physics/glass/glass_sheet_step1.wav",
		"physics/glass/glass_sheet_step2.wav",
		"physics/glass/glass_sheet_step3.wav",
		"physics/glass/glass_sheet_step4.wav",
	}
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "step" then
		self:FootStepSoundCode()
	end
	if key == "attack" then
		self:MeleeAttackCode()
	end
	if key == "body" then
		VJ.EmitSound(self, "physics/body/body_medium_impact_soft"..math.random(1,7)..".wav", 75, 100)
    end	
	if key == "slide" then
		VJ_EmitSound(self, "npc/zombie/foot_slide"..math.random(1,3)..".wav", 70, math.random(90,100))
    end	
end
---------------------------------------------------------------------------------------------------------------------------------------------
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
	self:AddFlags(FL_NOTARGET)
	
	timer.Simple(0.1,function() if IsValid(self) then
		self:VJ_ACT_PLAYACTIVITY({"vjseq_emerge1","vjseq_emerge2"},true,false)
		VJ.EmitSound(self,"vj_blboh/undead/spawn_dirt_0"..math.random(0,1)..".wav",80,math.random(80,100))
		ParticleEffect("strider_impale_ground",self:GetPos(),self:GetAngles(),self)
	end end)
	
	timer.Simple(0.2,function() if IsValid(self) then
		self:SetSolid(SOLID_BBOX)
		self:SetMaterial("")
		self:DrawShadow(true)
	end end)

	timer.Simple(1.0,function() if IsValid(self) then
		VJ.EmitSound(self,"vj_blboh/undead/spawn_moan_"..math.random(1,5)..".wav",70)
	end end)

	timer.Simple(4.5,function() if IsValid(self) then
		self.HasMeleeAttack = true
		self.GodMode = false
		self.MovementType = VJ_MOVETYPE_GROUND
		self.CanTurnWhileStationary = true
		self.DisableFindEnemy = false
		self.HasSounds = true
		self:RemoveFlags(FL_NOTARGET)
	end end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDamaged(dmginfo, hitgroup, status) 
	if self.UndeadCount > 0 && self.NextDamageCheckTime < CurTime() then
		if math.random(1,5) == 1 then
			self:SummonUndead()
			self.NextDamageCheckTime = CurTime() + 10
		else
			self.NextDamageCheckTime = CurTime() + 5
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SummonUndead()
    
	self.Undead = "npc_vj_blboh_undead"
	
	self.UndeadCount = self.UndeadCount -1
	
	local tr = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() + self:GetForward() * math.Rand(-250, 250) + self:GetRight() * math.Rand(-250, 250) + self:GetUp() * 50,
		filter = {self},
		mask = MASK_ALL,
	})
	local spawnpos = tr.HitPos + tr.HitNormal*300
	local ally = ents.Create(self.Undead)
	ally:SetPos(spawnpos)
	ally:SetAngles(self:GetAngles())
	ally:Spawn()
	ally:Activate()
	ally.undeadCount = 1
	ally.VJ_NPC_Class = self.VJ_NPC_Class
	return ally
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnFootStepSound()
	if !self:IsOnGround() then return end
	local tr = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() +Vector(0,0,-150),
		filter = {self}
	})
	if tr.Hit && self.FootSteps[tr.MatType] then
		VJ_EmitSound(self,VJ_PICK(self.FootSteps[tr.MatType]),self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	end
	if self:WaterLevel() > 0 && self:WaterLevel() < 3 then
		VJ_EmitSound(self,"player/footsteps/wade" .. math.random(1,8) .. ".wav",self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FootStepSoundCode(CustomTbl)
	if self.HasSounds == false or self.HasFootStepSound == false or self.MovementType == VJ_MOVETYPE_STATIONARY then return end
	if self:IsOnGround() && self:GetGroundEntity() != NULL then
		if self.DisableFootStepSoundTimer == true then
			self:CustomOnFootStepSound()
			return
		elseif self:IsMoving() && CurTime() > self.FootStepT then
			self:CustomOnFootStepSound()
			local CurSched = self.CurrentSchedule
			if self.DisableFootStepOnRun == false && ((VJ_HasValue(self.AnimTbl_Run,self:GetMovementActivity())) or (CurSched != nil  && CurSched.IsMovingTask_Run == true)) /*(VJ_HasValue(VJ_RunActivites,self:GetMovementActivity()) or VJ_HasValue(self.CustomRunActivites,self:GetMovementActivity()))*/ then
				self:CustomOnFootStepSound_Run()
				self.FootStepT = CurTime() + self.FootStepTimeRun
				return
			elseif self.DisableFootStepOnWalk == false && (VJ_HasValue(self.AnimTbl_Walk,self:GetMovementActivity()) or (CurSched != nil  && CurSched.IsMovingTask_Walk == true)) /*(VJ_HasValue(VJ_WalkActivites,self:GetMovementActivity()) or VJ_HasValue(self.CustomWalkActivites,self:GetMovementActivity()))*/ then
				self:CustomOnFootStepSound_Walk()
				self.FootStepT = CurTime() + self.FootStepTimeWalk
				return
			end
		end
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/