SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "The Shepherd's Gun"
SWEP.Author = "An average Beanmann"
SWEP.Contact = ""
SWEP.Purpose = "A tool for tending to your flock."
SWEP.Instructions = "Pull the trigger."
SWEP.Category = "Bean's Little Box of Horrors"
SWEP.MadeForNPCsOnly = true
SWEP.HoldType = "shotgun"
--------------------
SWEP.WorldModel = "models/vj_blboh/shepherd_gun.mdl"
--------------------
SWEP.NPC_NextPrimaryFire = 2
SWEP.NPC_CustomSpread = 0.2
SWEP.NPC_BulletSpawnAttachment = "0"
SWEP.NPC_HasReloadSound = false
--------------------
SWEP.Primary.DisableBulletCode = true
SWEP.Primary.ClipSize = 1
SWEP.Primary.Sound = {"vj_blboh/shepherd/shoot.mp3"}
SWEP.Primary.DistantSound = {"vj_blboh/shepherd/shoot.mp3"}
SWEP.PrimaryEffects_MuzzleAttachment = "0"
-- SWEP.PrimaryEffects_ShellType = "VJ_Weapon_ShotgunShell1"
SWEP.PrimaryEffects_ShellType = "ShotgunShellEject"
--------------------
SWEP.Reload_TimeUntilAmmoIsSet = 5
--------------------
SWEP.HasDryFireSound = false
--------------------
function SWEP:OnPrimaryAttack(status, statusData)
	if status == "Initial" then
		if CLIENT then return end
		local owner = self:GetOwner()
		local projectile = ents.Create("obj_vj_blboh_shepherd_bullet")
		-- local projectile = ents.Create("obj_vj_flareround")
		local spawnPos = self:GetBulletPos()
		if owner:IsPlayer() then
			projectile:SetPos(owner:GetShootPos())
		else
			projectile:SetPos(spawnPos)
		end
		projectile:SetOwner(owner)
		projectile:Activate()
		projectile:Spawn()
		
		local phys = projectile:GetPhysicsObject()
		if IsValid(phys) then
			if owner.IsVJBaseSNPC then
				phys:SetVelocity(owner:CalculateProjectile("Line", spawnPos, owner:GetAimPosition(owner:GetEnemy(), spawnPos, 1, 1750), 1750))
			elseif owner:IsPlayer() then
				phys:SetVelocity(owner:GetAimVector() * 1750)
			else
				phys:SetVelocity(owner:CalculateProjectile("Line", spawnPos, owner:GetEnemy():GetPos() + owner:GetEnemy():OBBCenter(), 1750))
			end
			projectile:SetAngles(projectile:GetVelocity():GetNormal():Angle())
		end
	end
end