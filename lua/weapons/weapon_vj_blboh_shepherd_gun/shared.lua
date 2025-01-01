SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "The Shepherd's Gun"
SWEP.Author = "An average Beanmann"
SWEP.Purpose = "A tool for tending to your flock."
SWEP.Instructions = "Pull the trigger."
SWEP.Category = "Bean's Little Box of Horrors"
SWEP.MadeForNPCsOnly = true
SWEP.HoldType = "shotgun"
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel = "models/vj_blboh/shepherd_gun.mdl"
	-- NPC Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.NPC_NextPrimaryFire = 2 -- Next time it can use primary fire
SWEP.NPC_CustomSpread = 0.2 -- This is added on top of the custom spread that's set inside the SNPC! | Starting from 1: Closer to 0 = better accuracy, Farther than 1 = worse accuracy
SWEP.NPC_BulletSpawnAttachment = "0" -- The attachment that the bullet spawns on, leave empty for base to decide!
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.DisableBulletCode	= true -- The bullet won't spawn, this can be used when creating a projectile-based weapon
SWEP.Primary.ClipSize = 1 -- Max amount of bullets per clip
SWEP.Primary.Sound = {"npc/shepherd/shoot.mp3"}
SWEP.Primary.DistantSound = {"npc/shepherd/shoot.mp3"}
SWEP.Primary.DistantSoundVolume	= 0.7 -- Distant sound volume
SWEP.PrimaryEffects_ShellType = "VJ_Weapon_ShotgunShell1"
SWEP.Reload_TimeUntilAmmoIsSet = 5

SWEP.HasDryFireSound = false
SWEP.NPC_HasReloadSound = false

SWEP.BHLCIE_Shepherd_Difficulty = 1
SWEP.BHLCIE_Shepherd_BulletSpeed = 500
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Init()
	-- self.BHLCIE_Shepherd_Difficulty = GetConVar("hl1_coop_sv_skill"):GetInt()
	-- if self.BHLCIE_Shepherd_Difficulty == 3 then
		-- self.BHLCIE_Shepherd_BulletSpeed = 1500
	-- elseif self.BHLCIE_Shepherd_Difficulty == 2 then
		-- self.BHLCIE_Shepherd_BulletSpeed = 1000
	-- end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnPrimaryAttack(status, statusData)
	if status "Initial" then
		if CLIENT then return end
		local proj = ents.Create("obj_shepherd_bullet")
		local ply_Ang = self:GetOwner():GetAimVector():Angle()
		local ply_Pos = self:GetOwner():GetShootPos()
		if self:GetOwner():IsPlayer() then proj:SetPos(ply_Pos) else proj:SetPos(self:GetNW2Vector("VJ_CurBulletPos")) end
		if self:GetOwner():IsPlayer() then proj:SetAngles(ply_Ang) else proj:SetAngles(self:GetOwner():GetAngles()) end
		proj:SetOwner(self:GetOwner())
		proj:Activate()
		proj:Spawn()
		
		local phys = proj:GetPhysicsObject()
		if IsValid(phys) then
			if self:GetOwner():IsPlayer() then
				phys:SetVelocity(self:GetOwner():GetAimVector() * self.BHLCIE_Shepherd_BulletSpeed)
			else
				phys:SetVelocity(self:GetOwner():CalculateProjectile("Line", self:GetNW2Vector("VJ_CurBulletPos"), self:GetOwner():GetEnemy():GetPos() + self:GetOwner():GetEnemy():OBBCenter(), self.BHLCIE_Shepherd_BulletSpeed))
			end
		end
	end
end