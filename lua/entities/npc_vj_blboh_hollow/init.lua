AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = "models/vj_blboh/hollow.mdl"
ENT.StartHealth = 300
--------------------
ENT.VJ_NPC_Class = {"CLASS_DEMON"}
ENT.DisableWandering = true
--------------------
ENT.BloodColor = "None"
--------------------
ENT.MeleeAttackDamage = 20
ENT.MeleeAttackDamageType = DMG_DISSOLVE
ENT.SoundTbl_MeleeAttack = false
--------------------
ENT.DisableFootStepSoundTimer = true
--------------------
ENT.SoundTbl_MeleeAttack = {"ambient/voices/squeal1.wav"}
ENT.SoundTbl_Breath = {"ambient/levels/citadel/datatransfmalevx02.wav"}
ENT.SoundTbl_Death = {"ambient/voices/squeal1.wav"}
ENT.MeleeAttackSoundPitch = VJ.SET(100, 100)
ENT.BreathSoundLevel = 70
ENT.DeathSoundPitch = VJ.SET(50, 50)
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "step" then
		VJ.EmitSound(self, "ambient/outro/messagepacket01.wav", 75, 100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
	self.HasSounds = false
	util.ScreenShake(self:GetPos(), 5, 5, 5, 350)
	self:SetSolid(SOLID_NONE)
	self.HasMeleeAttack = false
	self.GodMode = true
	self.MovementType = VJ_MOVETYPE_STATIONARY
	self.CanTurnWhileStationary = false
	self:SetMaterial("hud/killicons/default")
	self:DrawShadow(false)
	self.DisableFindEnemy = true

	VJ.EmitSound(self,{"ambient/outro/messagepacket02.wav"},65,100)

	self.ChestGlow1 = ents.Create("env_sprite")
	self.ChestGlow1:SetKeyValue("model","particle/warp1_warp.vmt")
	self.ChestGlow1:SetKeyValue("scale", "0.25")
	self.ChestGlow1:SetKeyValue("rendermode","5")
	self.ChestGlow1:SetKeyValue("rendercolor","255 255 255 255")
	self.ChestGlow1:SetKeyValue("spawnflags","1") -- If animated
	self.ChestGlow1:SetParent(self)
	self.ChestGlow1:Fire("SetParentAttachment", "chest")
	self.ChestGlow1:Fire("Kill", "", 13)
	self.ChestGlow1:Spawn()
	self.ChestGlow1:Activate()
	self:DeleteOnRemove(self.ChestGlow1)

	timer.Simple(2.0,function() if IsValid(self) then
		util.ScreenShake(self:GetPos(), 7.5, 5, 4, 400)
		VJ.EmitSound(self,{"ambient/outro/messagepacket02.wav"},70,100)
		self.ChestGlow2 = ents.Create("env_sprite")
		self.ChestGlow2:SetKeyValue("model","particle/warp1_warp.vmt")
		self.ChestGlow2:SetKeyValue("scale", "0.4")
		self.ChestGlow2:SetKeyValue("rendermode","5")
		self.ChestGlow2:SetKeyValue("rendercolor","255 255 255 255")
		self.ChestGlow2:SetKeyValue("spawnflags","1") -- If animated
		self.ChestGlow2:SetParent(self)
		self.ChestGlow2:Fire("SetParentAttachment", "chest")
		self.ChestGlow2:Fire("Kill", "", 13)
		self.ChestGlow2:Spawn()
		self.ChestGlow2:Activate()
		self:DeleteOnRemove(self.ChestGlow2)
		self.ChestGlow1:Fire("Kill", "", 0)
	end end)

	timer.Simple(4.0,function() if IsValid(self) then
		self.ChestGlow3 = ents.Create("env_sprite")
		self.ChestGlow3:SetKeyValue("model","particle/warp1_warp.vmt")
		self.ChestGlow3:SetKeyValue("scale", "0.5")
		self.ChestGlow3:SetKeyValue("rendermode","5")
		self.ChestGlow3:SetKeyValue("rendercolor","255 255 255 255")
		self.ChestGlow3:SetKeyValue("spawnflags","1") -- If animated
		self.ChestGlow3:SetParent(self)
		self.ChestGlow3:Fire("SetParentAttachment", "chest")
		self.ChestGlow3:Fire("Kill", "", 13)
		self.ChestGlow3:Spawn()
		self.ChestGlow3:Activate()
		self:DeleteOnRemove(self.ChestGlow3)
		self.ChestGlow2:Fire("Kill", "", 0)
		VJ.EmitSound(self,{"ambient/outro/messagepacket02.wav"},75,100)
		VJ.EmitSound(self,{"ambient/levels/citadel/portal_beam_shoot5.wav"},80,100)
		util.ScreenShake(self:GetPos(), 10, 5, 2.5, 450)
		self:SetSolid(SOLID_BBOX)
		self.HasMeleeAttack = true
		self.GodMode = false
		self.MovementType = VJ_MOVETYPE_GROUND
		self.CanTurnWhileStationary = true
		self:SetMaterial("")
		self:DrawShadow(true)
		self.HasSounds = true
		timer.Simple(0.5,function() if IsValid(self) then
			self.ChestGlow3:Fire("Kill", "", 0)	
			self.HasMeleeAttack = true
			self.GodMode = false
			self.MovementType = VJ_MOVETYPE_GROUND
			self.CanTurnWhileStationary = true
			self.DisableFindEnemy = false
		end end)
	end end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnCreateDeathCorpse(dmginfo, hitgroup, corpseEnt)
	corpseEnt:Dissolve()
end