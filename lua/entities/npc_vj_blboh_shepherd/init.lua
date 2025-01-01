AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = {"models/vj_blboh/shepherd.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
-- ENT.StartHealth = 666
ENT.StartHealth = 2000
--------------------
ENT.VJ_NPC_Class = {"CLASS_DEMON"}
--------------------
ENT.SoundTbl_FootStep = {
	"npc/footsteps/hardboot_generic1.wav",
	"npc/footsteps/hardboot_generic2.wav",
	"npc/footsteps/hardboot_generic3.wav",
	"npc/footsteps/hardboot_generic4.wav",
	"npc/footsteps/hardboot_generic5.wav",
	"npc/footsteps/hardboot_generic6.wav",
	"npc/footsteps/hardboot_generic8.wav"
}

ENT.GeneralSoundPitch1 = 100

ENT.FindEnemy_UseSphere = true
ENT.FindEnemy_CanSeeThroughWalls = true

ENT.BHLCIE_Shepherd_Difficulty = 1
-- ENT.BHLCIE_Shepherd_PortalBlockerPos = Vector(0,0,0)


-- ENT.HasHealthRegeneration = true -- Can the NPC regenerate its health?
-- ENT.HealthRegenerationAmount = 1 -- How much should the health increase after every delay?
-- ENT.HealthRegenerationDelay = VJ.SET(0.5, 1) -- How much time until the health increases

ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.AnimTbl_MeleeAttack = {"vjseq_MeleeAttack01", "melee_slice"}
ENT.TimeUntilMeleeAttackDamage = 0.7 -- This counted in seconds | This calculates the time until it hits something
ENT.FootStepTimeRun = 0.25 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walking
ENT.Weapon_StrafeWhileFiring = false -- Should it move randomly while firing a weapon?
ENT.AnimTbl_GrenadeAttack = ACT_RANGE_ATTACK_THROW
ENT.TimeUntilGrenadeIsReleased = 0.87 -- Time until the grenade is released
ENT.GrenadeAttackAttachment = "anim_attachment_RH" -- The attachment that the grenade will spawn at
ENT.AnimTbl_Medic_GiveHealth = "heal" -- Animations is plays when giving health to an ally
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages




ENT.Weapon_NoSpawnMenu = true -- If set to true, the NPC weapon setting in the spawnmenu will not be applied for this SNPC


--------------------
function ENT:PreInit()

	-- self.BHLCIE_Shepherd_Difficulty = GetConVar("hl1_coop_sv_skill"):GetInt()

	if self.BHLCIE_Shepherd_Difficulty == 4 then

		self.BHLCIE_Shepherd_Difficulty = 3

	end

	-- self.StartHealth = self.StartHealth * player.GetCount()

	-- self:SetHealth(self.StartHealth)

end
--------------------
function ENT:Init()

	-- self.StartHealth = self.StartHealth * player.GetCount()
	-- self:SetHealth(self.StartHealth)

	self.SoundTbl_Idle = {""}
	self.SoundTbl_OnPlayerSight = {""}
	self.SoundTbl_Alert = {""}
	self.SoundTbl_BecomeEnemyToPlayer = {""}
	self.SoundTbl_CallForHelp = {""}
	self.SoundTbl_AllyDeath = {""}
	self.SoundTbl_MedicBeforeHeal = {""}
	self.SoundTbl_OnGrenadeSight = {""}
	self.SoundTbl_OnDangerSight = {""}
	self.SoundTbl_OnKilledEnemy = {""}
	self.SoundTbl_Pain = {""}
	self.SoundTbl_Death = {""}

	self.WeaponReload_FindCover = false
	self.MoveOrHideOnDamageByEnemy = false
	self.FindEnemy_UseSphere = true
	self.FindEnemy_CanSeeThroughWalls = true

	self.SoundTbl_RandomHellNoise = {
		"npc/zombie/zombie_voice_idle5.wav",
		"npc/zombie/zombie_voice_idle6.wav",
		"npc/zombie_poison/pz_alert1.wav",
		"npc/zombie_poison/pz_alert2.wav",
		"npc/zombie_poison/pz_call1.wav",
		"npc/zombie_poison/pz_throw2.wav",
		"npc/zombie_poison/pz_throw3.wav",
		"npc/fast_zombie/fz_alert_close1.wav",
		"npc/fast_zombie/fz_alert_far1.wav",
		"npc/fast_zombie/fz_frenzy1.wav",
		"npc/fast_zombie/fz_scream1.wav",
		"npc/antlion_guard/angry1.wav",
		"npc/antlion_guard/angry2.wav",
		"npc/antlion_guard/angry3.wav",
	}

	VJ.EmitSound(self,{"npc/antlion/rumble1.wav"},90,50)
	util.ScreenShake(self:GetPos(), 5, 5, 15, 350)

	self:SetSolid(SOLID_NONE)
	self.HasMeleeAttack = false
	self.GodMode = true
	self.MovementType = VJ_MOVETYPE_STATIONARY
	self.CanTurnWhileStationary = false
	self:SetMaterial("hud/killicons/default")
	self:DrawShadow(false)

	ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))
	ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))
	ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))
	ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))
	ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))
	ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))
	ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))
	ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))

	timer.Simple(3,function() if IsValid(self) then

		ParticleEffectAttach("fire_medium_01_glow",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))

		VJ.EmitSound(self,{"npc/antlion/rumble1.wav"},90,50)

		self.PreLaunchLight = ents.Create("light_dynamic")
		self.PreLaunchLight:SetKeyValue("brightness", "5")
		self.PreLaunchLight:SetKeyValue("distance", "500")
		self.PreLaunchLight:SetLocalPos(self:GetPos())
		self.PreLaunchLight:SetLocalAngles(self:GetAngles())
		self.PreLaunchLight:Fire("Color", "255 0 0 255")
		self.PreLaunchLight:SetParent(self)
		self.PreLaunchLight:Spawn()
		self.PreLaunchLight:Activate()
		self.PreLaunchLight:Fire("SetParentAttachment","chest")
		self.PreLaunchLight:Fire("TurnOn", "", 0)
		self:DeleteOnRemove(self.PreLaunchLight)

		self:Shepherd_PlayHellScream()

		local ChestGlow1 = ents.Create("env_sprite")
		ChestGlow1:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
		ChestGlow1:SetKeyValue("scale", "1.5")
		ChestGlow1:SetKeyValue("rendermode","5")
		ChestGlow1:SetKeyValue("rendercolor","142 0 0 255")
		ChestGlow1:SetKeyValue("spawnflags","1") -- If animated
		ChestGlow1:SetParent(self)
		ChestGlow1:Fire("SetParentAttachment", "chest")
		ChestGlow1:Fire("Kill", "", 13)
		ChestGlow1:Spawn()
		ChestGlow1:Activate()
		self:DeleteOnRemove(ChestGlow1)
		
		local ChestGlow2 = ents.Create("env_sprite")
		ChestGlow2:SetKeyValue("model","sprites/blueflare1.vmt")
		ChestGlow2:SetKeyValue("scale", "1.5")
		ChestGlow2:SetKeyValue("rendermode","5")
		ChestGlow2:SetKeyValue("rendercolor","255 0 0 255")
		ChestGlow2:SetKeyValue("spawnflags","1") -- If animated
		ChestGlow2:SetParent(self)
		ChestGlow2:Fire("SetParentAttachment", "chest")
		ChestGlow2:Fire("Kill", "", 13)
		ChestGlow2:Spawn()
		ChestGlow2:Activate()
		self:DeleteOnRemove(ChestGlow2)
		
		local ChestGlow3 = ents.Create("env_sprite")
		ChestGlow3:SetKeyValue("model","sprites/combineball_glow_black_1.vmt")
		ChestGlow3:SetKeyValue("scale", "1")
		ChestGlow3:SetKeyValue("rendermode","5")
		ChestGlow3:SetKeyValue("rendercolor","255 0 0 255")
		ChestGlow3:SetKeyValue("spawnflags","1") -- If animated
		ChestGlow3:SetParent(self)
		ChestGlow3:Fire("SetParentAttachment", "chest")
		ChestGlow3:Fire("Kill", "", 13)
		ChestGlow3:Spawn()
		ChestGlow3:Activate()
		self:DeleteOnRemove(ChestGlow3)

	end end)

	timer.Simple(6,function() if IsValid(self) then

		self:Shepherd_PlayHellScream()

		VJ.EmitSound(self,{"npc/antlion/rumble1.wav"},90,50)

	end end)

	timer.Simple(9,function() if IsValid(self) then

		self:Shepherd_PlayHellScream()

		VJ.EmitSound(self,{"npc/antlion/rumble1.wav"},90,50)

	end end)

	timer.Simple(11,function() if IsValid(self) then

		self:Shepherd_PlayHellScream()

		VJ.EmitSound(self,{"npc/antlion/rumble1.wav"},90,90)

	end end)

	timer.Simple(13,function() if IsValid(self) then

		VJ.EmitSound(self,{"npc/antlion/rumble1.wav"},90,90)

		self.PreLaunchLight:Fire("Kill", "", 0)

		self.LaunchLight = ents.Create("light_dynamic")
		self.LaunchLight:SetKeyValue("brightness", "7")
		self.LaunchLight:SetKeyValue("distance", "800")
		self.LaunchLight:SetLocalPos(self:GetPos())
		self.LaunchLight:SetLocalAngles(self:GetAngles())
		self.LaunchLight:Fire("Color", "255 0 0 255")
		self.LaunchLight:SetParent(self)
		self.LaunchLight:Spawn()
		self.LaunchLight:Activate()
		self.LaunchLight:Fire("SetParentAttachment","chest")
		self.LaunchLight:Fire("TurnOn", "", 0)
		self:DeleteOnRemove(self.LaunchLight)

		VJ.EmitSound(self,"ambient/explosions/exp"..math.random(1,4)..".wav",100,100)
		VJ.EmitSound(self,"ambient/creatures/town_child_scream1.wav",100,math.random(60,70))
		self:Shepherd_PlayHellScream()

	end end)

	timer.Simple(15,function() if IsValid(self) then

		self.LaunchLight:Fire("Kill", "", 0)
		VJ.EmitSound(self,"ambient/explosions/exp"..math.random(1,4)..".wav",100,100)
		VJ.EmitSound(self,"ambient/explosions/exp"..math.random(1,4)..".wav",85,100)
		VJ.EmitSound(self,"ambient/levels/labs/teleport_postblast_thunder1.wav",100,50)
		VJ.EmitSound(self,"weapons/physcannon/energy_sing_explosion2.wav",100,50)

		VJ.EmitSound(self,"ambient/creatures/town_zombie_call1.wav",100,30)
		VJ.EmitSound(self,"ambient/voices/playground_memory.wav",100,30)
		self:StopParticles()

		ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))

		self.PreLaunchLight = ents.Create("light_dynamic")
		self.PreLaunchLight:SetKeyValue("brightness", "2")
		self.PreLaunchLight:SetKeyValue("distance", "200")
		self.PreLaunchLight:SetLocalPos(self:GetPos())
		self.PreLaunchLight:SetLocalAngles(self:GetAngles())
		self.PreLaunchLight:Fire("Color", "255 0 0 255")
		self.PreLaunchLight:SetParent(self)
		self.PreLaunchLight:Spawn()
		self.PreLaunchLight:Activate()
		self.PreLaunchLight:Fire("SetParentAttachment","crucifix")
		self.PreLaunchLight:Fire("TurnOn", "", 0)
		self:DeleteOnRemove(self.PreLaunchLight)

		self:Shepherd_PlayHellScream()

		local ChestGlow1 = ents.Create("env_sprite")
		ChestGlow1:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
		ChestGlow1:SetKeyValue("scale", "0.1")
		ChestGlow1:SetKeyValue("rendermode","5")
		ChestGlow1:SetKeyValue("rendercolor","142 0 0 255")
		ChestGlow1:SetKeyValue("spawnflags","1") -- If animated
		ChestGlow1:SetParent(self)
		ChestGlow1:Fire("SetParentAttachment", "crucifix")
		ChestGlow1:Spawn()
		ChestGlow1:Activate()
		self:DeleteOnRemove(ChestGlow1)
		
		local ChestGlow2 = ents.Create("env_sprite")
		ChestGlow2:SetKeyValue("model","sprites/blueflare1.vmt")
		ChestGlow2:SetKeyValue("scale", "0.1")
		ChestGlow2:SetKeyValue("rendermode","5")
		ChestGlow2:SetKeyValue("rendercolor","255 0 0 255")
		ChestGlow2:SetKeyValue("spawnflags","1") -- If animated
		ChestGlow2:SetParent(self)
		ChestGlow2:Fire("SetParentAttachment", "crucifix")
		ChestGlow2:Spawn()
		ChestGlow2:Activate()
		self:DeleteOnRemove(ChestGlow2)
		
		local ChestGlow3 = ents.Create("env_sprite")
		ChestGlow3:SetKeyValue("model","sprites/combineball_glow_black_1.vmt")
		ChestGlow3:SetKeyValue("scale", "0.1")
		ChestGlow3:SetKeyValue("rendermode","5")
		ChestGlow3:SetKeyValue("rendercolor","255 0 0 255")
		ChestGlow3:SetKeyValue("spawnflags","1") -- If animated
		ChestGlow3:SetParent(self)
		ChestGlow3:Fire("SetParentAttachment", "crucifix")
		ChestGlow3:Spawn()
		ChestGlow3:Activate()
		self:DeleteOnRemove(ChestGlow3)

		self:Give("weapon_vj_blboh_shepherd_gun")
		self:SetSolid(SOLID_BBOX)
		self.HasMeleeAttack = true
		self.GodMode = false
		self.MovementType = VJ_MOVETYPE_GROUND
		self.CanTurnWhileStationary = true
		self:SetMaterial("")
		self:DrawShadow(true)

		-- preacher1 = ents.Create("npc_bhlcie_preacher")
		-- if IsValid(preacher1) then
			-- preacher1:SetPos(self:GetPos() + self:GetRight() * 40)
			-- preacher1:SetAngles(Angle(0,0,0))
			-- preacher1:Spawn()
		-- end
		-- preacher2 = ents.Create("npc_bhlcie_preacher")
		-- if IsValid(preacher2) then
			-- preacher2:SetPos(self:GetPos() + self:GetRight() * -40)
			-- preacher2:SetAngles(Angle(0,0,0))
			-- preacher2:Spawn()
		-- end
		for k, v in ipairs(ents.FindByClass("player")) do
			v:ScreenFade(1,Color(125,0,0),3,0.1)
		end

		-- if self:Health() > 2000 && (self.BHLCIE_Shepherd_Difficulty != 3 or self.BHLCIE_Shepherd_Difficulty == 3 && GetConVar("hl1_coop_sv_skill"):GetInt() != 4) then
			-- self:SetHealth(2000)
		-- end
		-- if self.BHLCIE_Shepherd_Difficulty == 3 then -- block the exit so you have to kill him
			-- PrintMessage(4,"-= KILL THE SHEPHERD =-")
			-- for k, v in pairs(ents.FindByClass("npc_vj_*")) do -- kill all zombies to give some breathing space
				-- local d = DamageInfo()
				-- d:SetDamage(v:GetMaxHealth())
				-- d:SetAttacker(v)
				-- d:SetDamageType(DMG_BLAST) 
				-- v:TakeDamageInfo(d)
			-- end
			-- self.exitblocker = ents.Create("prop_physics")
			-- if IsValid(self.exitblocker) then
				-- self.exitblocker:SetModel("models/hunter/blocks/cube4x4x4.mdl")
				-- for k, v in pairs(ents.FindByClass("hl1_inf_portal")) do
					-- self.BHLCIE_Shepherd_PortalBlockerPos = v:GetPos()
				-- end
				-- self.exitblocker:SetPos(Vector(self.BHLCIE_Shepherd_PortalBlockerPos))
				-- self.exitblocker:SetPos(Vector(3667.167725, 4418.179199, 64.031250))
				-- self.exitblocker:SetAngles(Angle(0,0,0))
				-- self.exitblocker:Spawn()
				-- self.exitblocker:SetMoveType(MOVETYPE_NONE)
				-- self.exitblocker:SetRenderFX(16)
				-- local thefunny = Color(255, 0, 0, 254)
				-- self.exitblocker:SetColor(thefunny)
				-- self.exitblocker:SetMaterial("models/flesh")
				-- self:DeleteOnRemove(self.exitblocker)
				
				-- ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self.exitblocker,self.exitblocker:LookupAttachment("origin"))
				-- ParticleEffectAttach("smoke_burning_engine_01",PATTACH_POINT_FOLLOW,self.exitblocker,self.exitblocker:LookupAttachment("origin"))
				
			-- end
		-- end

	end end)

end
--------------------
function ENT:Shepherd_PlayHellScream()
	effects.BeamRingPoint(self:GetPos(), 0.80, 0, 175, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
	VJ.EmitSound(self,"ambient/fire/ignite.wav",75,math.random(45,70))
	VJ.EmitSound(self,self.SoundTbl_RandomHellNoise,80,math.random(50,90))
	util.ScreenShake(self:GetPos(), 50, 5, 3, 750)
end
--------------------
function ENT:OnThinkActive()
	if self.BHLCIE_Shepherd_Difficulty == 3 then -- block the exit so you have to kill him
		for k, v in pairs(ents.FindByClass("npc_vj_*")) do -- kill all zombies to give some breathing space
			local d = DamageInfo()
			d:SetDamage(v:GetMaxHealth())
			d:SetAttacker(v)
			d:SetDamageType(DMG_BLAST) 
			v:TakeDamageInfo(d)
		end
	end
end
--------------------
function ENT:SetAnimationTranslations(wepHoldType)
	self.BaseClass.SetAnimationTranslations(self, wepHoldType)
	if wepHoldType == "crossbow" or wepHoldType == "shotgun" then
		self.AnimationTranslations[ACT_RELOAD] = ACT_RELOAD_SMG1
		
		self.AnimationTranslations[ACT_IDLE] = ACT_IDLE
		self.AnimationTranslations[ACT_IDLE_ANGRY] = ACT_IDLE_ANGRY
		
		self.AnimationTranslations[ACT_WALK] = ACT_WALK_RIFLE
		self.AnimationTranslations[ACT_WALK_AIM] = ACT_WALK_AIM_RIFLE
		
		self.AnimationTranslations[ACT_RUN] = ACT_RUN_RIFLE
		self.AnimationTranslations[ACT_RUN_AIM] = ACT_RUN_AIM_RIFLE
		self.CanCrouchOnWeaponAttack = false -- It shouldn't crouch when using a shotgun or crossbow hold types!
	else
		self.CanCrouchOnWeaponAttack = true
	end
end
--------------------
-- function ENT:CustomOnInitialKilled(dmginfo, hitgroup)
function ENT:OnDeath(dmginfo, hitgroup, status)
	if status == "Initial" then
		for k, v in pairs(ents.FindByClass("npc_bhlcie_*")) do -- kill all demons to give some breathing space
			if v:GetClass() != "npc_bhlcie_shepherd" then
				local d = DamageInfo()
				d:SetDamage(v:GetMaxHealth())
				d:SetAttacker(v)
				d:SetDamageType(DMG_BLAST) 
				v:TakeDamageInfo(d)
			end
		end
		for k, v in pairs(ents.FindByClass("npc_vj_*")) do -- kill all zombies to give some breathing space
			local d = DamageInfo()
			d:SetDamage(v:GetMaxHealth())
			d:SetAttacker(v)
			d:SetDamageType(DMG_BLAST) 
			v:TakeDamageInfo(d)
		end
		for k, v in ipairs(ents.FindByClass("player")) do
			v:ScreenFade(1,Color(125,0,0),10,0.1)
		end
		VJ.EmitSound(self,{"npc/stalker/go_alert2.wav"},0,25)
	end
end -- Ran the moment the NPC dies!
--------------------