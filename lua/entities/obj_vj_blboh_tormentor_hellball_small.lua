AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_projectile_base"
ENT.PrintName		= "Tormentor Ball"
ENT.Author 			= "Warkin"
ENT.Contact 		= ""
ENT.Information		= "A projectile for Tormentors to give them more of an edge."
ENT.Category		= "Bean's Little Box of Horrors"

ENT.Spawnable = false
ENT.AdminOnly = false
--------------------
if CLIENT then
	function ENT:Draw() self:DrawModel() end
end
if !SERVER then return end
--------------------
ENT.Model = {"models/vj_blboh/shepherd_bullet.mdl"}
ENT.ProjectileType = VJ.PROJ_TYPE_GRAVITY

ENT.Track_Enemy = NULL
ENT.Track_Position = defVec
--------------------
ENT.DoesDirectDamage = true
ENT.DirectDamage = 5
--------------------
ENT.SoundTbl_Startup = "vj_blboh/preacher/fireball.ogg"
ENT.SoundTbl_Idle = "ambient/fire/firebig.wav"
ENT.SoundTbl_OnRemove = "ambient/fire/gascan_ignite1.wav"
ENT.StartupSoundPitch = VJ.SET(100, 110)
ENT.IdleSoundPitch = VJ.SET(100, 110)
ENT.OnRemoveSoundPitch = VJ.SET(100, 110)
--------------------
function ENT:Init()
	self:DrawShadow(false)
	self:SetMaterial("hud/killicons/default")
	self:GetPhysicsObject():SetMass(1)
	ParticleEffectAttach("fire_small_01",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("trail"))

	self.ErectusChestSprite1 = ents.Create("env_sprite")
	self.ErectusChestSprite1:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
	self.ErectusChestSprite1:SetKeyValue("scale", "0.75")
	self.ErectusChestSprite1:SetKeyValue("rendermode","5")
	self.ErectusChestSprite1:SetKeyValue("rendercolor","255 95 0 255")
	self.ErectusChestSprite1:SetKeyValue("spawnflags","1") -- If animated
	self.ErectusChestSprite1:SetParent(self)
	self.ErectusChestSprite1:Fire("SetParentAttachment", "trail")
	self.ErectusChestSprite1:Spawn()
	self.ErectusChestSprite1:Activate()
	self:DeleteOnRemove(self.ErectusChestSprite1)

	self.ErectusChestSprite3 = ents.Create("env_sprite")
	self.ErectusChestSprite3:SetKeyValue("model","sprites/flare1.vmt")
	self.ErectusChestSprite3:SetKeyValue("scale", "0.25")
	self.ErectusChestSprite3:SetKeyValue("rendermode","5")
	self.ErectusChestSprite3:SetKeyValue("rendercolor","255 95 0 255")
	self.ErectusChestSprite3:SetKeyValue("spawnflags","1") -- If animated
	self.ErectusChestSprite3:SetParent(self)
	self.ErectusChestSprite3:Fire("SetParentAttachment", "trail")
	self.ErectusChestSprite3:Spawn()
	self.ErectusChestSprite3:Activate()
	self:DeleteOnRemove(self.ErectusChestSprite3)
	
	self.PreLaunchLight = ents.Create("light_dynamic")
	self.PreLaunchLight:SetKeyValue("brightness", "1")
	self.PreLaunchLight:SetKeyValue("distance", "250")
	self.PreLaunchLight:SetLocalPos(self:GetPos())
	self.PreLaunchLight:SetLocalAngles(self:GetAngles())
	self.PreLaunchLight:Fire("Color", "255 95 0 255")
	self.PreLaunchLight:SetParent(self)
	self.PreLaunchLight:Spawn()
	self.PreLaunchLight:Activate()
	self.PreLaunchLight:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(self.PreLaunchLight)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDestroy(data, phys)
	effects.BeamRingPoint(self:GetPos(), 0.75, 0, 75, 5, 5, Color(255, 95, 0), {material="sprites/physgbeamb", framerate=20})
end