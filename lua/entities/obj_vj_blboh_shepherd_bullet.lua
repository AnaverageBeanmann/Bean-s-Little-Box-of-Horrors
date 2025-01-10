AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_projectile_base"
ENT.PrintName		= "Shepherd's Bullet"
ENT.Author 			= "DrVrej, modified by An average Beanmann"
ENT.Contact 		= ""
ENT.Information		= "bullet"
ENT.Category		= "Bean's Little Box of Horrors"

ENT.Spawnable = false
ENT.AdminOnly = false
--------------------
if CLIENT then
	-- do we need this?
	-- language.Add("obj_shepherd_bullet", "Shepherd's Bullet")
	-- killicon.Add("obj_shepherd_bullet","HUD/killicons/default",Color(255,80,0,255))

	-- language.Add("#obj_shepherd_bullet", "Shepherd's Bullet")
	-- killicon.Add("#obj_shepherd_bullet","HUD/killicons/default",Color(255,80,0,255))
	
	function ENT:Draw() self:DrawModel() end
end
--------------------
if !SERVER then return end
ENT.Model = {"models/vj_blboh/shepherd_bullet.mdl"}
--------------------
ENT.DoesDirectDamage = true
ENT.DirectDamage = 50
ENT.DirectDamageType = DMG_BULLET
--------------------
ENT.SoundTbl_OnCollide = {"vj_blboh/shepherd/bullet_hit.mp3"}
--------------------
function ENT:Init()
	self:GetPhysicsObject():EnableGravity(false)
	self:GetPhysicsObject():EnableDrag(false)
	self:GetPhysicsObject():SetMass(1)
	util.SpriteTrail(self,1,Color(255,255,0),false,3,0,0.1,1,"trails/smoke")
	-- phys:SetBuoyancyRatio(0)
end
--------------------
function ENT:OnDealDamage(data, phys, hitEnts)
	if hitEnts != false then
		self.HasOnCollideSounds = false
		VJ.EmitSound(self,"vj_blboh/shepherd/bullet_hit_target.mp3",70,100)
	end
end