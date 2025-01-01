AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_projectile_base"
ENT.PrintName		= "Shepherd's Bullet"
ENT.Author 			= "DrVrej, modified by An average Beanmann"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Information		= "Projectiles for my addons"
ENT.Category		= "Bean's Half-Life Coop Infected Expansions"

ENT.Spawnable = false
ENT.AdminOnly = false
--------------------
if CLIENT then
	language.Add("obj_shepherd_bullet", "Shepherd's Bullet")
	killicon.Add("obj_shepherd_bullet","HUD/killicons/default",Color(255,80,0,255))

	language.Add("#obj_shepherd_bullet", "Shepherd's Bullet")
	killicon.Add("#obj_shepherd_bullet","HUD/killicons/default",Color(255,80,0,255))
	
	function ENT:Draw() self:DrawModel() end
end
--------------------
if !SERVER then return end
ENT.Model = {"models/vj_blboh/shepherd_bullet.mdl"}

ENT.DoesDirectDamage = true -- Should it do a direct damage when it hits something?
-- ENT.DirectDamage = 20 -- How much damage should it do when it hits something
ENT.DirectDamage = 50 -- How much damage should it do when it hits something
ENT.DirectDamageType = DMG_BULLET

ENT.SoundTbl_OnCollide = {"npc/shepherd/bullet_hit.mp3"}

-- ENT.ProjectileType = VJ.PROJ_TYPE_LINEAR 
-- ENT.BHLCIE_Shepherd_Difficulty = 1
--------------------
function ENT:Init()

	util.SpriteTrail(self,1,Color(255,255,0),false,3,0,0.1,1,"trails/smoke")

	-- self.BHLCIE_Shepherd_Difficulty = GetConVar("hl1_coop_sv_skill"):GetInt()
	-- if self.BHLCIE_Shepherd_Difficulty == 3 then
		-- self.DirectDamage = 70
	-- elseif self.BHLCIE_Shepherd_Difficulty == 2 then
		-- self.DirectDamage = 50
	-- end

end
--------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	phys:SetMass(1)
	phys:SetBuoyancyRatio(0)
	phys:EnableDrag(false)
	phys:EnableGravity(false)
end
--------------------
-- function ENT:CustomOnCollideWithoutRemove(data, phys)
	-- timer.Simple(0.001,function() if IsValid(self) then
		-- self:Remove(self)
	-- end end)
-- end -- Return false to disable the base functions from running
--------------------
-- function ENT:CustomOnDoDamage_Direct(data, phys, hitEnt)
function ENT:OnDealDamage(data, phys, hitEnts)
	VJ_EmitSound(hitEnt,"npc/shepherd/bullet_hit_target.mp3",60,100)
end -- "hitEnts" = Table of entities damage or false if it hit nothing