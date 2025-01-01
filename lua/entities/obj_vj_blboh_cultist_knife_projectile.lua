AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_projectile_base"
ENT.PrintName		= "Cultist Knife"
ENT.Author 			= "An average Beanmann"
ENT.Contact 		= ""
ENT.Information		= "A projectile for Cultists to give them more of an edge."
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
ENT.Model = "models/vj_blboh/cultist_knife.mdl"
ENT.ProjectileType = VJ.PROJ_TYPE_GRAVITY
--------------------
ENT.DoesDirectDamage = true
ENT.DirectDamage = 10
--------------------
ENT.SoundTbl_Startup = {"weapons/iceaxe/iceaxe_swing1.wav"}
ENT.SoundTbl_OnCollide = {
	"physics/metal/metal_canister_impact_hard1.wav",
	"physics/metal/metal_canister_impact_hard2.wav",
	"physics/metal/metal_canister_impact_hard3.wav"
}
-- ENT.SoundTbl_OnCollide = {
	-- "weapons/knife/knife_hit1.wav",
	-- "weapons/knife/knife_hit2.wav",
	-- "weapons/knife/knife_hit3.wav",
	-- "weapons/knife/knife_hit4.wav"
-- }
--------------------
function ENT:Init()
	self:GetPhysicsObject():EnableGravity(true)
	self:GetPhysicsObject():SetMass(1)
	self:GetPhysicsObject():AddAngleVelocity(Vector(math.random(-500,500),math.random(-500,500),math.random(-500,500)))
end
--------------------
function ENT:OnDealDamage(data, phys, hitEnts)
	if hitEnts != false then
		self.HasOnCollideSounds = false -- Should it play a sound when it collides something?
		-- self:EmitSound("vo/k_lab/kl_ahhhh.wav",0,math.random(95,105))
		VJ.EmitSound(self,"weapons/knife/knife_hit"..math.random(1,4)..".wav",70,100)
	end
end
--------------------
-- function ENT:OnDestroy(data, phys)
-- end
-- function ENT:DeathEffects(data,phys)
	-- self:EmitSound("vo/k_lab/kl_ahhhh.wav",0,math.random(95,105))
-- end