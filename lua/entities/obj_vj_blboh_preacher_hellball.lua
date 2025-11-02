AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_projectile_base"
ENT.PrintName		= "Preacher Ball"
ENT.Author 			= "An average Beanmann"
ENT.Contact 		= ""
ENT.Information		= "A projectile for Preachers to give them more of an edge."
ENT.Category		= "Bean's Little Box of Horrors"

ENT.Spawnable = false
ENT.AdminOnly = false
--------------------
if CLIENT then
	-- i'm not sure if we actually need these
	-- language.Add("obj_erectus_horrorball", "Horror Ball")
	-- killicon.Add("obj_erectus_horrorball","HUD/killicons/default",Color(255,80,0,255))

	-- language.Add("#obj_erectus_horrorball", "Horror Ball")
	-- killicon.Add("#obj_erectus_horrorball","HUD/killicons/default",Color(255,80,0,255))
	
	function ENT:Draw() self:DrawModel() end
end
if !SERVER then return end
--------------------
ENT.Model = {"models/vj_blboh/shepherd_bullet.mdl"}
ENT.ProjectileType = VJ.PROJ_TYPE_GRAVITY
-- ENT.RemoveDelay = 0.1
--------------------
ENT.DoesDirectDamage = true
ENT.DirectDamage = 10
--------------------
ENT.SoundTbl_Startup = {"weapons/iceaxe/iceaxe_swing1.wav"}
-- ENT.SoundTbl_OnCollide = {
	-- "physics/metal/metal_canister_impact_hard1.wav",
	-- "physics/metal/metal_canister_impact_hard2.wav",
	-- "physics/metal/metal_canister_impact_hard3.wav"
-- }
-- ENT.SoundTbl_OnCollide = {
	-- "weapons/knife/knife_hit1.wav",
	-- "weapons/knife/knife_hit2.wav",
	-- "weapons/knife/knife_hit3.wav",
	-- "weapons/knife/knife_hit4.wav"
-- }
-- ENT.SoundTbl_Startup = "ambient/fire/mtov_flame2.wav"
ENT.SoundTbl_Startup = "vj_blboh/preacher/fireball.ogg"
ENT.SoundTbl_Idle = "ambient/fire/firebig.wav"
-- ENT.SoundTbl_OnCollide = false
ENT.SoundTbl_OnRemove = "ambient/fire/gascan_ignite1.wav"
--------------------
function ENT:Init()
	self:DrawShadow(false)
	self:SetMaterial("hud/killicons/default")
	self:GetPhysicsObject():SetMass(1)
	ParticleEffectAttach("fire_small_01",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("trail"))

	-- self.ErectusLight = ents.Create("light_dynamic")
	-- self.ErectusLight:SetKeyValue("brightness", "5")
	-- self.ErectusLight:SetKeyValue("distance", "150")
	-- self.ErectusLight:SetLocalPos(self:GetPos())
	-- self.ErectusLight:SetLocalAngles(self:GetAngles())
	-- self.ErectusLight:Fire("Color", "100 100 100 255")
	-- self.ErectusLight:SetParent(self)
	-- self.ErectusLight:Spawn()
	-- self.ErectusLight:Activate()
	-- self.ErectusLight:Fire("SetParentAttachment","trail")
	-- self.ErectusLight:Fire("TurnOn", "", 0)
	-- self:DeleteOnRemove(self.ErectusLight)

	self.ErectusChestSprite1 = ents.Create("env_sprite")
	self.ErectusChestSprite1:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
	self.ErectusChestSprite1:SetKeyValue("scale", "1")
	self.ErectusChestSprite1:SetKeyValue("rendermode","5")
	self.ErectusChestSprite1:SetKeyValue("rendercolor","150 0 0 255")
	self.ErectusChestSprite1:SetKeyValue("spawnflags","1") -- If animated
	self.ErectusChestSprite1:SetParent(self)
	self.ErectusChestSprite1:Fire("SetParentAttachment", "trail")
	self.ErectusChestSprite1:Spawn()
	self.ErectusChestSprite1:Activate()
	self:DeleteOnRemove(self.ErectusChestSprite1)
	
	-- self.ErectusChestSprite2 = ents.Create("env_sprite")
	-- self.ErectusChestSprite2:SetKeyValue("model","sprites/blueflare1.vmt")
	-- self.ErectusChestSprite2:SetKeyValue("scale", "0.35")
	-- self.ErectusChestSprite2:SetKeyValue("rendermode","5")
	-- self.ErectusChestSprite2:SetKeyValue("rendercolor","100 100 100 255")
	-- self.ErectusChestSprite2:SetKeyValue("spawnflags","1") -- If animated
	-- self.ErectusChestSprite2:SetParent(self)
	-- self.ErectusChestSprite2:Fire("SetParentAttachment", "trail")
	-- self.ErectusChestSprite2:Spawn()
	-- self.ErectusChestSprite2:Activate()
	-- self:DeleteOnRemove(self.ErectusChestSprite2)
	
	self.ErectusChestSprite3 = ents.Create("env_sprite")
	self.ErectusChestSprite3:SetKeyValue("model","sprites/flare1.vmt")
	self.ErectusChestSprite3:SetKeyValue("scale", "0.5")
	self.ErectusChestSprite3:SetKeyValue("rendermode","5")
	self.ErectusChestSprite3:SetKeyValue("rendercolor","255 93 0 255")
	self.ErectusChestSprite3:SetKeyValue("spawnflags","1") -- If animated
	self.ErectusChestSprite3:SetParent(self)
	self.ErectusChestSprite3:Fire("SetParentAttachment", "trail")
	self.ErectusChestSprite3:Spawn()
	self.ErectusChestSprite3:Activate()
	self:DeleteOnRemove(self.ErectusChestSprite3)
end
--------------------
function ENT:OnDestroy(data, phys)
	effects.BeamRingPoint(self:GetPos(), 0.75, 0, 150, 5, 5, Color(255, 93, 50), {material="sprites/physgbeamb", framerate=20})
	effects.BeamRingPoint(self:GetPos(), 0.75, 0, 75, 5, 5, Color(255, 93, 50), {material="sprites/physgbeamb", framerate=20})
end