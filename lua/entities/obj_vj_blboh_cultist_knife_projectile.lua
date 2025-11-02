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
	function ENT:Draw() self:DrawModel() end
end
if !SERVER then return end
--------------------
ENT.Model = "models/vj_blboh/cultist_knife.mdl"
--------------------
ENT.DoesDirectDamage = true
ENT.DirectDamage = 10
--------------------
ENT.SoundTbl_Startup = "weapons/iceaxe/iceaxe_swing1.wav"
ENT.SoundTbl_OnCollide = {
	"physics/metal/weapon_impact_hard1.wav",
	"physics/metal/weapon_impact_hard2.wav",
	"physics/metal/weapon_impact_hard3.wav"
}
--------------------
ENT.BLBOH_LongRangedKnife = false
--------------------
function ENT:PreInit()
	if self.BLBOH_LongRangedKnife then
		self.ProjectileType = VJ.PROJ_TYPE_GRAVITY
	end
end
--------------------
function ENT:Init()
	self:GetPhysicsObject():AddAngleVelocity(Vector(0,250,0))
	if self.BLBOH_LongRangedKnife then
		-- PrintMessage(4,"This is a long-range knife.")
		self:GetPhysicsObject():EnableGravity(true)
	else
		-- PrintMessage(4,"This is a short-range knife.")
		timer.Simple(0.25, function() if IsValid(self) then
			self:GetPhysicsObject():EnableGravity(true)
		end end)
	end
end
--------------------
function ENT:OnDealDamage(data, phys, hitEnts)
	if hitEnts != false then
		-- why didn't we think of this method before?
		self.SoundTbl_OnCollide = {
			"vj_blboh/cultist/knife_hit1.wav",
			"vj_blboh/cultist/knife_hit2.wav",
			"vj_blboh/cultist/knife_hit3.wav",
			"vj_blboh/cultist/knife_hit4.wav"
		}
		-- self.HasOnCollideSounds = false
		-- VJ.EmitSound(self,"weapons/knife/knife_hit"..math.random(1,4)..".wav",70,100)
	end
end
--------------------