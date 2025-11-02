AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = "models/vj_blboh/crunatus.mdl"
ENT.StartHealth = 80
-- ENT.ControllerParams = {
	-- CameraMode = 1,
	-- ThirdP_Offset = Vector(60, 0, -50),
-- }
--------------------
ENT.SightAngle = 126
--------------------
ENT.VJ_NPC_Class = {"CLASS_BLBOH"}
--------------------
ENT.BloodColor = VJ.BLOOD_COLOR_RED
ENT.CombatDamageResponse = false
--------------------
-- ENT.MeleeAttackDistance = 35
-- ENT.MeleeAttackDamageDistance = 60
-- ENT.TimeUntilMeleeAttackDamage = false
-- ENT.MeleeAttackBleedEnemy = true
-- ENT.MeleeAttackBleedEnemyDamage = 1
-- ENT.MeleeAttackBleedEnemyTime = 0.5
-- ENT.MeleeAttackBleedEnemyReps = 8
--------------------
ENT.Weapon_IgnoreSpawnMenu = true
-- ENT.Weapon_UnarmedBehavior = true
-- ENT.Weapon_Accuracy = 1.6
ENT.Weapon_CanMoveFire = false
ENT.Weapon_Strafe = false
ENT.Weapon_OcclusionDelay = false
-- ENT.Weapon_MinDistance = 10 -- Min distance it can fire a weapon
-- ENT.Weapon_MaxDistance = 3000 -- Max distance it can fire a weapon
ENT.Weapon_RetreatDistance = 0
-- ENT.Weapon_AimTurnDiff = false -- Weapon aim turning threshold between 0 and 1 | "self.HasPoseParameterLooking" must be set to true!
	-- EXAMPLES: 0.707106781187 = 45 degrees | 0.866025403784 = 30 degrees | 1 = 0 degrees, always turn!
	-- false = Let base decide based on animation set and weapon hold type
	-- ====== Primary Fire ====== --
-- ENT.AnimTbl_WeaponAttack = ACT_RANGE_ATTACK1 -- Animations to play while firing a weapon
-- ENT.AnimTbl_WeaponAttackGesture = ACT_GESTURE_RANGE_ATTACK1 -- Gesture animations to play while firing a weapon | false = Don't play an animation
ENT.Weapon_CanCrouchAttack = false
	-- ====== Secondary Fire ====== --
-- ENT.Weapon_CanSecondaryFire = true -- Can it use a weapon's secondary fire if it's available?
-- ENT.Weapon_SecondaryFireTime = false -- How much time until the secondary fire's projectile is released | false = Base auto calculates the duration
-- ENT.AnimTbl_WeaponAttackSecondary = ACT_RANGE_ATTACK2 -- Animations to play while firing the weapon's secondary attack
	-- ====== Reloading ====== --
-- ENT.Weapon_CanReload = true -- Can it reload weapons?
-- ENT.Weapon_FindCoverOnReload = true -- Should it attempt to find cover before proceeding to reload?
-- ENT.AnimTbl_WeaponReload = ACT_RELOAD
-- ENT.AnimTbl_WeaponReloadCovered = ACT_RELOAD_LOW
-- ENT.DisableWeaponReloadAnimation = false -- Disables the default reload animation code
	-- ====== Weapon Inventory ====== --
	-- Weapons are given on spawn and it will only switch to those if the requirements are met
	-- All are stored in "self.WeaponInventory" with the following keys:
		-- Primary		: Default weapon
		-- AntiArmor	: Enemy is an armored tank/vehicle or a boss
		-- Melee		: Enemy is (very close and the NPC is out of ammo) OR (in melee attack distance) + NPC must have more than 25% health
-- ENT.WeaponInventory_AntiArmorList = false -- Anti-armor weapons to give on spawn | Can be table or string
-- ENT.WeaponInventory_MeleeList = false -- Melee weapons to give on spawn | Can be table or string
--------------------
-- ENT.DisableFootStepSoundTimer = true
ENT.SoundTbl_FootStep = {
	"npc/fast_zombie/foot1.wav",
	"npc/fast_zombie/foot2.wav",
	"npc/fast_zombie/foot3.wav",
	"npc/fast_zombie/foot4.wav"
}
ENT.SoundTbl_Alert = "vj_blboh/crunatus/SPOT.WAV"
-- ENT.SoundTbl_Alert = {
	-- "vj_blboh/crunatus/burn_in_hell.mp3",
	-- "vj_blboh/cultist/destroy_the_child.mp3",
	-- "vj_blboh/cultist/reap_what_you_sow.mp3",
	-- "vj_blboh/cultist/swear_by_his_throne.mp3",
	-- "vj_blboh/cultist/thy_faith_is_weak.mp3",
	-- "vj_blboh/cultist/we_know_what_you_did.mp3"
-- }
ENT.SoundTbl_CombatIdle = {
	"vj_blboh/crunatus/ROM1.WAV",
	"vj_blboh/crunatus/ROM2.WAV",
	"vj_blboh/crunatus/ROM3.WAV",
	"vj_blboh/crunatus/ROM4.WAV",
	"vj_blboh/crunatus/ROM5.WAV",
	"vj_blboh/crunatus/GLO1.WAV",
	"vj_blboh/crunatus/GLO2.WAV",
	"vj_blboh/crunatus/GLO3.WAV",
	"vj_blboh/crunatus/GLO4.WAV"
}
-- ENT.SoundTbl_MeleeAttackMiss = {
	-- "vj_blboh/cultist/knife_slash1.wav",
	-- "vj_blboh/cultist/knife_slash2.wav"
-- }
ENT.SoundTbl_Pain = {
	"vj_blboh/crunatus/PAN1.WAV",
	"vj_blboh/crunatus/PAN2.WAV",
	"vj_blboh/crunatus/PAN3.WAV",
	"vj_blboh/crunatus/PAN4.WAV",
	"vj_blboh/crunatus/PAN5.WAV",
	"vj_blboh/crunatus/PAN6.WAV"
}
ENT.SoundTbl_BurnScreams = {
	"vj_blboh/crunatus/FIR1.wav",
	"vj_blboh/crunatus/FIR2.wav",
	"vj_blboh/crunatus/FIR3.wav"
}
ENT.SoundTbl_Death = {
	"vj_blboh/crunatus/DIE1.wav",
	"vj_blboh/crunatus/DIE2.wav",
	"vj_blboh/crunatus/DIE3.wav"
}
ENT.MainSoundPitch = 100
-- ENT.DeathSoundPitch = VJ.SET(90,110)
--------------------
ENT.BLBOH_DoSpawnSequence = false
ENT.BLBOH_CanDoSpawnSequence = true
ENT.BLBOH_SpawnLightLevel = "0"
ENT.BLBOH_SpawnLightBoom = false
ENT.BLBOH_SpawnLightFadeStage = 0
ENT.BLBOH_Crunatus_Burning = false
ENT.BLBOH_Crunatus_Burning_ScreamTime = 0 -- i'm still annoyed over NextSoundTime_Pain being removed
ENT.BLBOH_Crunatus_ThrowToggleCooldown = CurTime()
ENT.BLBOH_Crunatus_Burning = false
ENT.BLBOH_Crunatus_NextBurnAnimTime = CurTime()
--------------------
function ENT:PreInit()
	-- if you're wondering why i'm doing it this way it's so you can manually make sure they won't do the spawn sequence
	-- it's how i'm doing it with the map sweepers faction
	if GetConVar("vj_blboh_spawn_sequences"):GetInt() == 1 && self.BLBOH_CanDoSpawnSequence && GetConVar("ai_disabled"):GetInt() == 0 then
		self.BLBOH_DoSpawnSequence = true
	end
end
--------------------
function ENT:Init()

	self:CapabilitiesRemove(bit.bor(CAP_ANIMATEDFACE)) -- do we need this bit.bor crap?

	-- self:SetBodygroup(1,1)
	-- self:SetBodygroup(2,1)
	-- if math.random(1,5) == 1 then -- eyeglows
		-- self:SetBodygroup(1,0)
		-- self:SetBodygroup(2,0)
	-- end

	if math.random(1,3) == 1 then -- skull trinket 1 (chest)
		self:SetBodygroup(6,1)
	end

	if math.random(1,3) == 1 then -- skull trinket 2 (belt)
		self:SetBodygroup(7,1)
	end

	if self.BLBOH_DoSpawnSequence then

		self.EnemyDetection = false
		self.CanInvestigate = false
		self.CanReceiveOrders = false
		self:AddFlags(FL_NOTARGET)
		self.GodMode = true
		self:SetMaterial("hud/killicons/default")
		self:DrawShadow(false)
		self.HasSounds = false

		self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK,2)

		self.SpawnLight = ents.Create("light_dynamic")
		self.SpawnLight:SetKeyValue("brightness", "7.5")
		self.SpawnLight:SetKeyValue("distance", "0")
		self.SpawnLight:SetLocalPos(self:GetPos())
		self.SpawnLight:SetLocalAngles(self:GetAngles())
		self.SpawnLight:Fire("Color", "255 0 0 255")
		self.SpawnLight:SetParent(self)
		self.SpawnLight:Spawn()
		self.SpawnLight:Activate()
		self.SpawnLight:Fire("SetParentAttachment","portal")
		self.SpawnLight:Fire("TurnOn", "", 0)
		self:DeleteOnRemove(self.SpawnLight)

		self.SpawnSprite1 = ents.Create("env_sprite")
		self.SpawnSprite1:SetKeyValue("model","vj_base/sprites/glow.vmt")
		self.SpawnSprite1:SetKeyValue("scale", "1.5")
		self.SpawnSprite1:SetKeyValue("rendermode","5")
		self.SpawnSprite1:SetKeyValue("rendercolor","142 0 0 255")
		self.SpawnSprite1:SetKeyValue("spawnflags","1") -- If animated
		self.SpawnSprite1:SetParent(self)
		self.SpawnSprite1:Fire("SetParentAttachment", "portal")
		self.SpawnSprite1:Fire("Kill", "", 13)
		self.SpawnSprite1:Spawn()
		self.SpawnSprite1:Activate()
		self:DeleteOnRemove(self.SpawnSprite1)

		ParticleEffectAttach("fire_medium_01_glow",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))

		util.ScreenShake(self:GetPos(), 5, 5, 5, 450)

		VJ.EmitSound(self,{"npc/antlion/rumble1.wav"},75,math.random(150,175))

		timer.Simple(1,function() if IsValid(self) then

			self.SpawnSprite2 = ents.Create("env_sprite")
			self.SpawnSprite2:SetKeyValue("model","sprites/blueflare1.vmt")
			self.SpawnSprite2:SetKeyValue("scale", "1.5")
			self.SpawnSprite2:SetKeyValue("rendermode","5")
			self.SpawnSprite2:SetKeyValue("rendercolor","255 0 0 255")
			self.SpawnSprite2:SetKeyValue("spawnflags","1") -- If animated
			self.SpawnSprite2:SetParent(self)
			self.SpawnSprite2:Fire("SetParentAttachment", "portal")
			self.SpawnSprite2:Fire("Kill", "", 13)
			self.SpawnSprite2:Spawn()
			self.SpawnSprite2:Activate()
			self:DeleteOnRemove(self.SpawnSprite2)

		end end)

		timer.Simple(1.6,function() if IsValid(self) then

			self.EnemyDetection = true
			self.CanInvestigate = true
			self.CanReceiveOrders = true
			self:RemoveFlags(FL_NOTARGET)
			self.GodMode = false
			self:SetMaterial("")
			self:DrawShadow(true)
			self.HasSounds = true

			self.BLBOH_SpawnLightBoom = true
			self:Give("weapon_vj_blboh_doublebarrel")

			self:StopParticles()
			effects.BeamRingPoint(self:GetPos() + self:GetUp() * 20, 0.5, 0, 40, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
			effects.BeamRingPoint(self:GetPos() + self:GetUp() * 40, 0.5, 0, 60, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
			effects.BeamRingPoint(self:GetPos() + self:GetUp() * 60, 0.5, 0, 40, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
			util.ScreenShake(self:GetPos(), 10, 5, 2.5, 300)

			VJ.EmitSound(self,"ambient/explosions/exp"..math.random(1,4)..".wav",80,100)
			VJ.EmitSound(self,"ambient/explosions/exp"..math.random(1,4)..".wav",80,100)
			VJ.EmitSound(self,"weapons/physcannon/energy_sing_explosion2.wav",70,75)

			timer.Simple(0.1,function() if IsValid(self) then
				self.SpawnSprite1:Fire("Kill", "", 0)
			end end)

			timer.Simple(0.3,function() if IsValid(self) then
				self.SpawnSprite2:Fire("Kill", "", 0)
			end end)

		end end)

		timer.Simple(4,function() if IsValid(self) then
			self.SpawnLight:Fire("Kill", "", 0)
		end end)

	else

		self:Give("weapon_vj_blboh_doublebarrel")

	end

end
--------------------
function ENT:OnThink()

	-- see if we can turn this into an elseif
	-- if !self.AttackType then
		-- if !self:IsOnFire() && self.BLBOH_Crunatus_Burning then
			-- self.BLBOH_Crunatus_Burning = false
			-- self.Behavior = VJ_BEHAVIOR_AGGRESSIVE
			-- self.EnemyDetection = true
			-- self.CanReceiveOrders = true
			-- self:CapabilitiesAdd(CAP_MOVE_JUMP)
			-- self:CapabilitiesAdd(CAP_MOVE_CLIMB)
			-- self.HasAlertSounds = true
			-- self:StopMoving(false)
		-- elseif self:IsOnFire() && !self.BLBOH_Crunatus_Burning then
			-- self.BLBOH_Crunatus_Burning = true
			-- self.Behavior = VJ_BEHAVIOR_PASSIVE
			-- self.EnemyDetection = false
			-- self.CanReceiveOrders = false
			-- self:CapabilitiesRemove(CAP_MOVE_JUMP)
			-- self:CapabilitiesRemove(CAP_MOVE_CLIMB)
			-- self.HasAlertSounds = false
		-- end
	-- end

	if IsValid(self.SpawnLight) then
		self.SpawnLight:SetKeyValue("distance", self.BLBOH_SpawnLightLevel)
		if !self.BLBOH_SpawnLightBoom then
			self.BLBOH_SpawnLightLevel = self.BLBOH_SpawnLightLevel + 2.5
		end
		if self.BLBOH_SpawnLightBoom then
			if self.BLBOH_SpawnLightFadeStage == 1 then
				self.BLBOH_SpawnLightLevel = self.BLBOH_SpawnLightLevel + 2.5
			elseif self.BLBOH_SpawnLightFadeStage == 2 then
				self.BLBOH_SpawnLightLevel = self.BLBOH_SpawnLightLevel - 7.5
			else
				self.BLBOH_SpawnLightLevel = self.BLBOH_SpawnLightLevel + 15
			end
			timer.Simple(0.25,function() if IsValid(self) && self.BLBOH_SpawnLightFadeStage != 1 then
				self.BLBOH_SpawnLightFadeStage = 1
			end end)
			timer.Simple(0.5,function() if IsValid(self) && self.BLBOH_SpawnLightFadeStage != 2 then
				self.BLBOH_SpawnLightFadeStage = 2
			end end)
		end
	end

end
--------------------
function ENT:OnThinkActive()

	-- if self.BLBOH_Crunatus_LongThrows then
		-- PrintMessage(4,"Long Throws: Enabled")
	-- else
		-- PrintMessage(4,"Long Throws: Disabled")
	-- end

	-- if self.BLBOH_Crunatus_Burning then
		-- PrintMessage(4,"We're on fire!")
	-- else
		-- PrintMessage(4,"We're NOT on fire!")
	-- end

	if self:IsOnFire() && !self.BLBOH_Crunatus_Burning then
		self.BLBOH_Crunatus_Burning = true
		self.SoundTbl_Pain_Backup = self.SoundTbl_Pain
		self.SoundTbl_Pain = self.SoundTbl_BurnScreams
		self.ConstantlyFaceEnemy_IfVisible = false
		self.CombatDamageResponse = false
	elseif self.BLBOH_Crunatus_Burning && !self:IsOnFire() then
		self.BLBOH_Crunatus_Burning = false
		self.SoundTbl_Pain = self.SoundTbl_Pain_Backup
		self.ConstantlyFaceEnemy_IfVisible = true
		self.CombatDamageResponse = true
	end
	if self.BLBOH_Crunatus_Burning && self.BLBOH_Crunatus_NextBurnAnimTime < CurTime() then
		self.BLBOH_Crunatus_NextBurnAnimTime = CurTime() + 4
		self:StopMoving(true)
		self:PlayAnim("vjseq_fire_idle", true, 4, false)
	end

end
--------------------
function ENT:OnInput(key, activator, caller, data)
	if key == "step" then
		VJ.EmitSound(self,self.SoundTbl_FootStep,self.FootstepSoundLevel)
		-- self:PlayFootstepSound(customSD) -- see if this works
		-- self:PlayFootstepSound() -- why is it like this again?
	elseif key == "attack" then
		self:ExecuteMeleeAttack(isPropAttack)
	elseif key == "throw" then
		self:ExecuteGrenadeAttack(customEnt, disableOwner, landDir)
	end
end
--------------------
-- see if there's a function like this for grenades
-- function ENT:OnRangeAttack(status, enemy)
	-- if status == "PreInit" && !self:OnGround() then
		-- return true -- no throwing knives in the air in the halls
	-- end
-- end
--------------------
-- function ENT:RangeAttackProjPos(projectile)
	-- return self:GetPos() + self:GetUp() * 40 + self:GetRight() * -5
-- end
--------------------
function ENT:OnDamaged(dmginfo, hitgroup, status)
	if status == "PreDamage" then
		-- if self.BLBOH_Crunatus_Burning && self.BLBOH_Crunatus_Burning_ScreamTime < CurTime() then
			-- self.BLBOH_Crunatus_Burning_ScreamTime = CurTime() + math.random(2,3)
			-- self.CurrentFireScreamSound = VJ.CreateSound(self,self.SoundTbl_BurnScreams,85)
		-- end
		if (dmginfo:GetDamageType() == DMG_BURN || dmginfo:GetDamageType() == DMG_SLOWBURN) && !self.BLBOH_Crunatus_Burning then
			self:Ignite(60,0)
		end
		-- see if we can merge these into an elseif
		if dmginfo:GetInflictor():GetClass() == "entityflame" && dmginfo:GetAttacker():GetClass() == "entityflame" then
			dmginfo:ScaleDamage(3)
			if self.HasImpactSounds then
				self.HasImpactSounds = false
				timer.Simple(0.001,function() if IsValid(self) then
					self.HasImpactSounds = true
				end end)
			end
		end
	end
end
--------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
	if status == "Init" && self.BLBOH_Crunatus_Burning then
		VJ.STOPSOUND(self.CurrentFireScreamSound)
	-- see if we can merge these into an elseif
	elseif status == "Finish" then
		self:SetBodygroup(1,1)
		self:SetBodygroup(2,1)
	end
end
--------------------
-- function ENT:TranslateActivity(act)
	-- if self.BLBOH_Crunatus_Burning then
		-- if act == ACT_IDLE then
			-- return ACT_IDLE_ON_FIRE
		-- elseif act == ACT_WALK then
			-- return ACT_WALK_ON_FIRE
		-- elseif act == ACT_RUN then
			-- return ACT_RUN_ON_FIRE
		-- end
	-- end
	-- see if this can be merged into an elseif
	-- if act == ACT_RUN && self.BLBOH_Crunatus_Sprinting then
		-- return ACT_SPRINT
	-- end
	-- return act
-- end