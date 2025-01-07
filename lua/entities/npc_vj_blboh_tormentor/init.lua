AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = "models/vj_blboh/tormentor.mdl"
ENT.StartHealth = 500
ENT.Aerial_AnimTbl_Calm = ACT_IDLE
ENT.Aerial_AnimTbl_Alerted = ACT_WALK
ENT.Aerial_FlyingSpeed_Calm = 100
ENT.Aerial_FlyingSpeed_Alerted = 100
--------------------
ENT.VJ_NPC_Class = {"CLASS_DEMON"}
--------------------
ENT.BloodColor = "Red"
ENT.ConstantlyFaceEnemy = true 
--------------------
ENT.MeleeAttackDamage = 25
ENT.MeleeAttackDamageType = DMG_CLUB
ENT.TimeUntilMeleeAttackDamage = false
ENT.AnimTbl_MeleeAttack = {"vjges_melee"}
--------------------
ENT.HasRangeAttack = true
ENT.TimeUntilRangeAttackProjectileRelease = false
ENT.RangeDistance = 2000
ENT.RangeToMeleeDistance = 200
ENT.NextRangeAttackTime = 3
ENT.NextRangeAttackTime_DoRand = 6
ENT.RangeAttackAnimationStopMovement = false
--------------------
ENT.BLBOH_SpawnLightLevel = "100"
ENT.BLBOH_SpawnLightBoom = false
ENT.BLBOH_SpawnLightFadeStage = 0
-- ====== Sound File Paths ====== --
ENT.DisableFootStepSoundTimer = true

ENT.SoundTbl_Alert = {
	"vj_blboh/tormentor/laugh1.wav",
	"vj_blboh/tormentor/laugh2.wav",
	"vj_blboh/tormentor/laugh3.wav",
	"vj_blboh/tormentor/annihilationiscoming.wav",
	"vj_blboh/tormentor/hereicome.wav",
	"vj_blboh/tormentor/thisisallyourfault.wav",
	"vj_blboh/tormentor/killyou.wav",
	"vj_blboh/tormentor/yoursinsdonotgounnoticed.wav"
}

ENT.SoundTbl_CombatIdle = {
	"vj_blboh/tormentor/laugh1.wav",
	"vj_blboh/tormentor/laugh2.wav",
	"vj_blboh/tormentor/laugh3.wav",
	"vj_blboh/tormentor/annihilationiscoming.wav",
	"vj_blboh/tormentor/giveusmore.wav",
	"vj_blboh/tormentor/terror.wav",
	"vj_blboh/tormentor/thisisallyourfault.wav",
	"vj_blboh/tormentor/yoursinsdonotgounnoticed.wav",
	"vj_blboh/tormentor/youarebleeding.wav",
	"vj_blboh/tormentor/ifeelyourfear.wav",
	"vj_blboh/tormentor/ifeelyourpain.wav",
	"vj_blboh/tormentor/ihateyou.wav",
	"vj_blboh/tormentor/ihearyourcries.wav",
	"vj_blboh/tormentor/youreadisgrace.wav",
	"vj_blboh/tormentor/killyou.wav"
}

ENT.SoundTbl_Pain = {
	"vj_blboh/tormentor/pain1.wav",
	"vj_blboh/tormentor/pain2.wav",
	"vj_blboh/tormentor/pain3.wav",
	"vj_blboh/tormentor/pain4.wav",
	"vj_blboh/tormentor/pain5.wav",
	"vj_blboh/tormentor/pain6.wav",
	"vj_blboh/tormentor/ihateyou.wav"
}

ENT.SoundTbl_Death = {
	"vj_blboh/tormentor/death1.wav",
	"vj_blboh/tormentor/death2.wav",
	"vj_blboh/tormentor/death3.wav",
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

ENT.SoundTbl_Breath = {
	"ambient/voices/crying_loop1.wav",
}

ENT.IdleSoundPitch = VJ.SET(40, 80)
ENT.IdleSoundLevel = 75

ENT.AlertSoundLevel = 85
ENT.CombatIdleSoundLevel = 85
ENT.PainSoundLevel = 85
ENT.DeathSoundLevel = 85
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "attack" then
		self:MeleeAttackCode()
	end
	if key == "range" then
		self:RangeAttackCode()
		self:StopParticles()
	end
	if key == "range2" then
		self:RangeAttackCode()
	end
	if key == "fireball" then
		ParticleEffectAttach("fire_small_01",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("anim_attachment_RH"))
		ParticleEffectAttach("fire_small_01",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("anim_attachment_LH"))
		VJ.EmitSound(self, "ambient/fire/gascan_ignite1.wav", 80, math.random(80,100))
	end
	if key == "fireball2" then
		ParticleEffectAttach("fire_small_01",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("anim_attachment_RH"))
		VJ.EmitSound(self, "ambient/fire/gascan_ignite1.wav", 80, math.random(90,110))
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackProjSpawnPos(projectile)
	return self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomRangeAttackCode_AfterProjectileSpawn(projectile)
	local enemy = self:GetEnemy()
	projectile.Track_Enemy = enemy
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
	self.HasSounds = false
	util.ScreenShake(self:GetPos(), 5, 5, 5, 450)
	self:SetSolid(SOLID_NONE)
	self.HasMeleeAttack = false
	self.GodMode = true
	self.MovementType = VJ_MOVETYPE_STATIONARY
	self.CanTurnWhileStationary = false
	self:SetMaterial("hud/killicons/default")
	self:DrawShadow(false)
	self.DisableFindEnemy = true

	ParticleEffectAttach("fire_medium_01",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))

	VJ.EmitSound(self,{"ambient/fire/ignite.wav"},75,math.random(70,80))

	self.PreLaunchLight = ents.Create("light_dynamic")
	self.PreLaunchLight:SetKeyValue("brightness", "7.5")
	self.PreLaunchLight:SetKeyValue("distance", "0")
	self.PreLaunchLight:SetLocalPos(self:GetPos())
	self.PreLaunchLight:SetLocalAngles(self:GetAngles())
	self.PreLaunchLight:Fire("Color", "255 95 0 255")
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
	self.ChestGlow1:SetKeyValue("rendercolor","255 95 0 255")
	self.ChestGlow1:SetKeyValue("spawnflags","1") -- If animated
	self.ChestGlow1:SetParent(self)
	self.ChestGlow1:Fire("SetParentAttachment", "chest")
	self.ChestGlow1:Fire("Kill", "", 13)
	self.ChestGlow1:Spawn()
	self.ChestGlow1:Activate()
	self:DeleteOnRemove(self.ChestGlow1)

	timer.Simple(1,function() if IsValid(self) then
		self.ChestGlow2 = ents.Create("env_sprite")
		self.ChestGlow2:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
		self.ChestGlow2:SetKeyValue("scale", "0.5")
		self.ChestGlow2:SetKeyValue("rendermode","5")
		self.ChestGlow2:SetKeyValue("rendercolor","255 0 0 255")
		self.ChestGlow2:SetKeyValue("spawnflags","1") -- If animated
		self.ChestGlow2:SetParent(self)
		self.ChestGlow2:Fire("SetParentAttachment", "chest")
		self.ChestGlow2:Fire("Kill", "", 13)
		self.ChestGlow2:Spawn()
		self.ChestGlow2:Activate()
		self:DeleteOnRemove(self.ChestGlow2)
	end end)

	timer.Simple(2,function() if IsValid(self) then
		timer.Simple(0.1,function() if IsValid(self) then
			self.ChestGlow1:Fire("Kill", "", 0)
		end end)
		timer.Simple(0.3,function() if IsValid(self) then
			self.ChestGlow2:Fire("Kill", "", 0)
		end end)
		VJ.EmitSound(self,"ambient/fire/mtov_flame2.wav",80,math.random(80,100))
		VJ.EmitSound(self,"ambient/explosions/exp"..math.random(1,4)..".wav",80,math.random(90,110))
		VJ.EmitSound(self,"ambient/outro/thunder0"..math.random(1,7)..".wav",70,math.random(70,90))
		util.ScreenShake(self:GetPos(), 10, 5, 2.5, 300)
		self:StopParticles()
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
	end end)
	timer.Simple(5,function() if IsValid(self) then
		self.PreLaunchLight:Fire("Kill", "", 0)
	end end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThinkActive()
    local enemy = self:GetEnemy()
    if IsValid(enemy) then
        if self:WaterLevel() >= 3 or self:IsUnreachable(enemy) == true or (enemy:IsPlayer() && enemy:GetMoveType() == MOVETYPE_NOCLIP) then
            if self.MovementType == VJ_MOVETYPE_GROUND then
                self:DoChangeMovementType(VJ_MOVETYPE_AERIAL)
            end
        else
            self:DoChangeMovementType(VJ_MOVETYPE_GROUND)
        end
    end
	if IsValid(self.PreLaunchLight) then
		self.PreLaunchLight:SetKeyValue("distance", self.BLBOH_SpawnLightLevel)
		if !self.BLBOH_SpawnLightBoom then
			self.BLBOH_SpawnLightLevel = self.BLBOH_SpawnLightLevel + 1.0
		end
		if self.BLBOH_SpawnLightBoom then
			if self.BLBOH_SpawnLightFadeStage == 1 then
				self.BLBOH_SpawnLightLevel = self.BLBOH_SpawnLightLevel + 1.0
			elseif self.BLBOH_SpawnLightFadeStage == 2 then
				self.BLBOH_SpawnLightLevel = self.BLBOH_SpawnLightLevel - 7.5
			end
			self.BLBOH_SpawnLightFadeStage = 1
			timer.Simple(0.25,function() if IsValid(self) && self.BLBOH_SpawnLightFadeStage != 2 then
				self.BLBOH_SpawnLightFadeStage = 2
			end end)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleRangeAttacks() 
	local random_attack = math.random(1,3)
	
	if random_attack == 1 then
		self.RangeAttackEntityToSpawn = "obj_vj_blboh_tormentor_hellball"
		self.AnimTbl_RangeAttack = {"vjges_attack"}
	else
		self.RangeAttackEntityToSpawn = "obj_vj_blboh_tormentor_hellball_small"
		self.AnimTbl_RangeAttack = {"vjges_attack2"}
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/