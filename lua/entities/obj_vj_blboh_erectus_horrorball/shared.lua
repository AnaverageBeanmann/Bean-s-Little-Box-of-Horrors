AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_projectile_base"
ENT.PrintName		= "Horror Ball"
ENT.Author 			= "An average Beanmann"
ENT.Contact 		= ""
ENT.Information		= "Projectile Erecti shoot; summons a Horror apon impact"
ENT.Category		= "Bean's Little Box of Horrors"

ENT.Spawnable = false
ENT.AdminOnly = false
--------------------
if CLIENT then
	language.Add("obj_erectus_horrorball", "Horror Ball")
	killicon.Add("obj_erectus_horrorball","HUD/killicons/default",Color(255,80,0,255))

	language.Add("#obj_erectus_horrorball", "Horror Ball")
	killicon.Add("#obj_erectus_horrorball","HUD/killicons/default",Color(255,80,0,255))
	
	function ENT:Draw() self:DrawModel() end
end