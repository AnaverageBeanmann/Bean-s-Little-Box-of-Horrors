AddCSLuaFile()

SWEP.Base 						= "weapon_vj_base"
SWEP.PrintName					= "Double-Barrel"
SWEP.Author 					= "An average Beanmann"
SWEP.Contact					= "https://steamcommunity.com/id/TakeTheBeansIDontCare/"
SWEP.Category					= "Bean's Little Box of Horrors"
SWEP.MadeForNPCsOnly 			= true
SWEP.HoldType 					= "shotgun"
-------------------
SWEP.WorldModel					= "models/vj_blboh/crunatus_shotgun.mdl"
-------------------
SWEP.NPC_NextPrimaryFire = 2
SWEP.NPC_CustomSpread = 1.5
-------------------
SWEP.Primary.Damage = 5
SWEP.Primary.NumberOfShots = 8
-- SWEP.Primary.TracerType = "Tracer" -- Tracer type (Examples: AR2)
SWEP.Primary.TakeAmmo = 0
SWEP.Primary.Ammo = "Buckshot"
SWEP.Primary.ClipSize = 2
	-- ====== Sounds ====== --
SWEP.Primary.Sound = {
	"vj_blboh/crunatus/ATT1.WAV",
	"vj_blboh/crunatus/ATT2.WAV"
}
SWEP.Primary.SoundLevel = 90
SWEP.Primary.SoundPitch	= VJ.SET(90, 110)
SWEP.Primary.SoundVolume = 1
	-- ====== Effects ====== --
SWEP.PrimaryEffects_MuzzleFlash = true
SWEP.PrimaryEffects_MuzzleParticles = {"vj_rifle_full"}
SWEP.PrimaryEffects_MuzzleParticlesAsOne = false -- Should all the particles spawn together instead of picking only one?
SWEP.PrimaryEffects_MuzzleAttachment = "muzzle_flash"
SWEP.PrimaryEffects_SpawnShells = false
SWEP.PrimaryEffects_SpawnDynamicLight = true
SWEP.PrimaryEffects_DynamicLightBrightness = 4
SWEP.PrimaryEffects_DynamicLightDistance = 120
SWEP.PrimaryEffects_DynamicLightColor = Color(255, 150, 60)