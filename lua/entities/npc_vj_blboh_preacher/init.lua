AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = {"models/vj_blboh/preacher.mdl"}
-- ENT.StartHealth = 200
ENT.StartHealth = 1000
-- ENT.HullType = HULL_HUMAN

ENT.VJ_NPC_Class = {"CLASS_DEMON"}

ENT.BloodColor = "Red"

--------------------
ENT.HasMeleeAttack = true
-- ENT.MeleeAttackDamage = 10 -- change this?
ENT.MeleeAttackDamageType = DMG_CRUSH
ENT.HasMeleeAttackKnockBack = true
ENT.MeleeAttackDistance = 100
ENT.MeleeAttackAngleRadius = 180
ENT.MeleeAttackDamageDistance = 125
ENT.MeleeAttackDamageAngleRadius = 180
ENT.TimeUntilMeleeAttackDamage = 0
ENT.NextMeleeAttackTime = 1
ENT.DisableMeleeAttackAnimation = true
--------------------

ENT.HasRangeAttack = true
-- ENT.RangeAttackEntityToSpawn = "obj_vj_tank_shell"
ENT.RangeAttackEntityToSpawn = "obj_vj_blboh_preacher_hellball"

ENT.AnimTbl_RangeAttack = ACT_RANGE_ATTACK1
ENT.RangeAttackAnimationDelay = 0 -- It will wait certain amount of time before playing the animation
ENT.RangeAttackAnimationFaceEnemy = true -- Should it face the enemy while playing the range attack animation?
ENT.RangeAttackAnimationDecreaseLengthAmount = 0 -- This will decrease the time until starts chasing again. Use it to fix animation pauses until it chases the enemy.
ENT.RangeAttackAnimationStopMovement = true -- Should it stop moving when performing a range attack?
	-- ====== Distance ====== --
ENT.RangeDistance = 2000 -- How far can it range attack?
ENT.RangeToMeleeDistance = 0 -- How close does it have to be until it uses melee?
ENT.RangeAttackAngleRadius = 100 -- What is the attack angle radius? | 100 = In front of the NPC | 180 = All around the NPC
	-- ====== Timer ====== --
	-- Set this to false to make the attack event-based:
ENT.TimeUntilRangeAttackProjectileRelease = 0.15 -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 1 -- How much time until it can use a range attack?
ENT.NextRangeAttackTime_DoRand = 5 -- False = Don't use random time | Number = Picks a random number between the regular timer and this timer
	-- To let the base automatically detect the attack duration, set this to false:
ENT.NextAnyAttackTime_Range = false -- How much time until it can use any attack again? | Counted in Seconds
ENT.NextAnyAttackTime_Range_DoRand = false -- False = Don't use random time | Number = Picks a random number between the regular timer and this timer
ENT.RangeAttackReps = 1 -- How many times does it run the projectile code?
ENT.RangeAttackExtraTimers = nil -- Extra range attack timers, EX: {1, 1.4} | it will run the projectile code after the given amount of seconds
ENT.DisableRangeAttackAnimation = true -- if true, it will disable the animation code

ENT.HasLeapAttack = true
ENT.LeapDistance = 1000
ENT.LeapToMeleeDistance = 0
ENT.TimeUntilLeapAttackDamage = false
-- ENT.TimeUntilLeapAttackVelocity = false
ENT.NextLeapAttackTime = 7
ENT.NextLeapAttackTime_DoRand = 9
ENT.DisableLeapAttackAnimation = true
-- ENT.DisableDefaultLeapAttackDamagecode = true


ENT.BeforeRangeAttackSoundLevel = 90
ENT.DisableFootStepSoundTimer = true

ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
ENT.IdleSoundPitch = VJ_Set(60, 50)
ENT.AlertSoundPitch = VJ_Set(60, 50)
ENT.DeathSoundPitch  = VJ_Set(30, 40)
ENT.BreathSoundLevel = 75
ENT.NextSoundTime_Breath = VJ_Set(2,2)

ENT.SoundTbl_FootStep = {"npc/fast_zombie/foot1.wav","npc/fast_zombie/foot2.wav","npc/fast_zombie/foot3.wav","npc/fast_zombie/foot4.wav"}
ENT.SoundTbl_Breath = {"ambient/atmosphere/noise2.wav"}
ENT.SoundTbl_Alert = {"npc/zombie_poison/pz_call1.wav"}
ENT.SoundTbl_Idle = {
	"ambient/creatures/town_child_scream1.wav",
	"ambient/creatures/town_moan1.wav",
	"ambient/creatures/town_muffled_cry1.wav",
	"ambient/creatures/town_scared_breathing1.wav",
	"ambient/creatures/town_scared_breathing2.wav",
	"ambient/creatures/town_scared_sob1.wav",
	"ambient/creatures/town_scared_sob2.wav",
	"ambient/creatures/town_zombie_call1.wav",
	"ambient/voices/playground_memory.wav",
	"ambient/levels/citadel/datatransfmalevx01.wav",
	"ambient/levels/citadel/datatransfmalevx02.wav",
	"ambient/levels/citadel/datatransgarbledfmalevx01.wav",
	"ambient/levels/citadel/datatransmalevx01.wav",
	"ambient/levels/citadel/datatransmalevx02.wav",
	"ambient/levels/citadel/strange_talk1.wav",
	"ambient/levels/citadel/strange_talk2.wav",
	"ambient/levels/citadel/strange_talk3.wav",
	"ambient/levels/citadel/strange_talk4.wav",
	"ambient/levels/citadel/strange_talk5.wav",
	"ambient/levels/citadel/strange_talk6.wav",
	"ambient/levels/citadel/strange_talk7.wav",
	"ambient/levels/citadel/strange_talk8.wav",
	"ambient/levels/citadel/strange_talk9.wav",
	"ambient/levels/citadel/strange_talk10.wav",
	-- "vo/citadel/br_youneedme.wav",
	-- "vo/citadel/al_bitofit.wav",
	-- "vo/citadel/al_thatshim.wav",
	-- "vo/citadel/al_wonderwhere.wav",
	-- "vo/citadel/al_thereheis.wav",
	-- "vo/citadel/br_failing11.wav",
	-- "vo/citadel/br_laugh01.wav",
	-- "vo/citadel/br_oheli07.wav",
	-- "vo/citadel/br_oheli08.wav",
	-- "vo/citadel/br_youfool.wav",
	-- "vo/citadel/eli_goodgod.wav",
	-- "vo/citadel/eli_mygirl.wav",
	-- "vo/citadel/eli_notobreen.wav",
	-- "vo/citadel/eli_save.wav",
	-- "vo/citadel/gman_exit02.wav",
	-- "vo/eli_lab/mo_gowithalyx01.wav",
	-- "vo/canals/arrest_stop.wav",
	-- "vo/canals/arrest_helpme.wav",
	-- "vo/canals/premassacre.wav",
	-- "vo/trainyard/wife_canttake.wav",
	-- "vo/trainyard/wife_end.wav",
	-- "vo/trainyard/wife_please.wav",
	-- "vo/trainyard/wife_whattodo.wav",
	-- "vo/trainyard/husb_think.wav",
	-- "vo/trainyard/husb_okay.wav",
	-- "vo/trainyard/husb_dontworry.wav",
	-- "vo/trainyard/husb_allright.wav",
	-- "vo/trainyard/cit_window_look.wav",
	-- "vo/trainyard/cit_water.wav",
	-- "vo/trainyard/cit_pacing.wav",
	-- "vo/trainyard/cit_nerve.wav",
	-- "vo/trainyard/cit_drunk.wav",
	-- "vo/trainyard/male01/cit_bench01.wav",
	-- "vo/trainyard/male01/cit_bench02.wav",
	-- "vo/trainyard/male01/cit_bench03.wav",
	-- "vo/trainyard/male01/cit_bench04.wav",
	-- "vo/npc/male01/runforyourlife01.wav",
	-- "vo/npc/male01/runforyourlife02.wav",
	-- "vo/npc/male01/runforyourlife03.wav",
	-- "vo/npc/male01/no01.wav",
	-- "vo/npc/male01/no02.wav",
	-- "vo/npc/male01/moan01.wav",
	-- "vo/npc/male01/moan02.wav",
	-- "vo/npc/male01/moan03.wav",
	-- "vo/npc/male01/moan04.wav",
	-- "vo/npc/male01/moan05.wav",
	-- "vo/npc/male01/heretohelp01.wav",
	-- "vo/npc/male01/heretohelp02.wav",
}
ENT.SoundTbl_BeforeRangeAttack = "vj_blboh/preacher/fireball.ogg"
ENT.SoundTbl_Death = {
	"npc/stalker/go_alert2.wav"
}

-- ENT.SoundTbl_Idle = false
-- ENT.SoundTbl_CombatIdle = false
-- ENT.SoundTbl_Alert = false
-- ENT.SoundTbl_BeforeLeapAttack = false
-- ENT.SoundTbl_Pain = false
-- ENT.SoundTbl_Death = false




ENT.HasBreathSound = false

ENT.BHLCIE_Preacher_Burning = false
--------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	if key == "step" then
		VJ.EmitSound(self,self.SoundTbl_FootStep,self.FootStepSoundLevel)
	end
	if key == "attack" then
		self:MeleeAttackCode()
	end
	if key == "emerge" then
		-- VJ.EmitSound(self,{"vj_blboh/preacher/dirtintro"..math.random(1,2)..".wav"},80,math.random(95,105))
		VJ.EmitSound(self,"ambient/machines/thumper_dust.wav",70,math.random(95,105))
		VJ.EmitSound(self,{"physics/body/body_medium_break"..math.random(2,4)..".wav"},70,math.random(50,60))
		VJ.EmitSound(self,{"ambient/creatures/town_scared_sob"..math.random(1,2)..".wav"},90,math.random(60,80))
		self:DrawShadow(true)
		self:SetMaterial("")
		local bloodeffect = EffectData()
		bloodeffect:SetOrigin(self:GetPos() + self:GetForward()*-5 + self:GetRight() * 10)
		bloodeffect:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
		bloodeffect:SetScale(100)
		util.Effect("VJ_Blood1",bloodeffect)
		bloodeffect:SetOrigin(self:GetPos() + self:GetForward()*-20 + self:GetRight() * 10)
		util.Effect("VJ_Blood1",bloodeffect)
		bloodeffect:SetOrigin(self:GetPos() + self:GetForward()*-5 + self:GetRight() * -10)
		util.Effect("VJ_Blood1",bloodeffect)
		bloodeffect:SetOrigin(self:GetPos() + self:GetForward()*-20 + self:GetRight() * -10)
		util.Effect("VJ_Blood1",bloodeffect)
		bloodeffect:SetOrigin(self:GetPos() + self:GetForward()*-50 + self:GetRight() * 10)
		util.Effect("VJ_Blood1",bloodeffect)
		bloodeffect:SetOrigin(self:GetPos() + self:GetForward()*-50 + self:GetRight() * -10)
		util.Effect("VJ_Blood1",bloodeffect)
	end
	if key == "give_portal" then
		self:BLBOH_Preacher_GivePortal()
	end

end
--------------------
function ENT:BLBOH_Preacher_GivePortal()
	self.PreLaunchLight = ents.Create("light_dynamic")
	self.PreLaunchLight:SetKeyValue("brightness", "1")
	self.PreLaunchLight:SetKeyValue("distance", "750")
	self.PreLaunchLight:SetLocalPos(self:GetPos())
	self.PreLaunchLight:SetLocalAngles(self:GetAngles())
	self.PreLaunchLight:Fire("Color", "255 0 0 255")
	self.PreLaunchLight:SetParent(self)
	self.PreLaunchLight:Spawn()
	self.PreLaunchLight:Activate()
	self.PreLaunchLight:Fire("SetParentAttachment","headportal")
	self.PreLaunchLight:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(self.PreLaunchLight)

	local Sprite_Flare1 = ents.Create("env_sprite")
	Sprite_Flare1:SetKeyValue("model","sprites/flare1.vmt")
	Sprite_Flare1:SetKeyValue("scale", "0.5")
	Sprite_Flare1:SetKeyValue("rendermode","5")
	Sprite_Flare1:SetKeyValue("rendercolor","142 0 0 255")
	Sprite_Flare1:SetKeyValue("spawnflags","1") -- If animated
	Sprite_Flare1:SetParent(self)
	Sprite_Flare1:Fire("SetParentAttachment", "headportal")
	Sprite_Flare1:Spawn()
	Sprite_Flare1:Activate()
	self:DeleteOnRemove(Sprite_Flare1)

	local Sprite_Flare1_Iris = ents.Create("env_sprite")
	Sprite_Flare1_Iris:SetKeyValue("model","sprites/flare1.vmt")
	Sprite_Flare1_Iris:SetKeyValue("scale", "0.25")
	Sprite_Flare1_Iris:SetKeyValue("rendermode","5")
	Sprite_Flare1_Iris:SetKeyValue("rendercolor","255 155 155 255")
	Sprite_Flare1_Iris:SetKeyValue("spawnflags","1") -- If animated
	Sprite_Flare1_Iris:SetParent(self)
	Sprite_Flare1_Iris:Fire("SetParentAttachment", "headportal")
	Sprite_Flare1_Iris:Spawn()
	Sprite_Flare1_Iris:Activate()
	self:DeleteOnRemove(Sprite_Flare1_Iris)

	local Sprite_Vortring1 = ents.Create("env_sprite")
	Sprite_Vortring1:SetKeyValue("model","sprites/vortring1.vmt")
	Sprite_Vortring1:SetKeyValue("scale", "0.3")
	Sprite_Vortring1:SetKeyValue("rendermode","5")
	Sprite_Vortring1:SetKeyValue("rendercolor","142 142 142 255")
	Sprite_Vortring1:SetKeyValue("spawnflags","1") -- If animated
	Sprite_Vortring1:SetParent(self)
	Sprite_Vortring1:Fire("SetParentAttachment", "headportal")
	Sprite_Vortring1:Spawn()
	Sprite_Vortring1:Activate()
	self:DeleteOnRemove(Sprite_Vortring1)

	local Sprite_Glow1 = ents.Create("env_sprite")
	Sprite_Glow1:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
	Sprite_Glow1:SetKeyValue("scale", "0.5")
	Sprite_Glow1:SetKeyValue("rendermode","5")
	Sprite_Glow1:SetKeyValue("rendercolor","142 0 0 255")
	Sprite_Glow1:SetKeyValue("spawnflags","1") -- If animated
	Sprite_Glow1:SetParent(self)
	Sprite_Glow1:Fire("SetParentAttachment", "headportal2")
	Sprite_Glow1:Spawn()
	Sprite_Glow1:Activate()
	self:DeleteOnRemove(Sprite_Glow1)

	ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))

			VJ.EmitSound(self,{"ambient/alarms/warningbell1.wav"},80,math.random(40,50))
			VJ.EmitSound(self,"ambient/machines/thumper_dust.wav",70,math.random(95,105))
			VJ.EmitSound(self,"ambient/voices/squeal1.wav",70,math.random(50,60))
			-- VJ.EmitSound(self,{"ambient/levels/labs/teleport_postblast_thunder1.wav"},80,math.random(70,80))
			-- VJ.EmitSound(self,{"weapons/physcannon/energy_sing_explosion2.wav"},80,math.random(70,80))
	self.HasBreathSound = true

	self.DisableFindEnemy = false
	self.GodMode = false
	self.MovementType = VJ_MOVETYPE_GROUND
	self.CanTurnWhileStationary = true
	self:SetSolid(SOLID_BBOX)
	self.HasSounds = true
		-- self:DrawShadow(true)

	-- local ChestGlow2 = ents.Create("env_sprite")
	-- ChestGlow2:SetKeyValue("model","sprites/blueflare1.vmt")
	-- ChestGlow2:SetKeyValue("scale", "0.25")
	-- ChestGlow2:SetKeyValue("rendermode","5")
	-- ChestGlow2:SetKeyValue("rendercolor","255 0 0 255")
	-- ChestGlow2:SetKeyValue("spawnflags","1") -- If animated
	-- ChestGlow2:SetParent(self)
	-- ChestGlow2:Fire("SetParentAttachment", "headportal")
	-- ChestGlow2:Spawn()
	-- ChestGlow2:Activate()
	-- self:DeleteOnRemove(ChestGlow2)
	
	-- local Sprite_Combineball_Glow_Black_1 = ents.Create("env_sprite")
	-- Sprite_Combineball_Glow_Black_1:SetKeyValue("model","sprites/combineball_glow_black_1.vmt")
	-- Sprite_Combineball_Glow_Black_1:SetKeyValue("scale", "1")
	-- Sprite_Combineball_Glow_Black_1:SetKeyValue("rendermode","5")
	-- Sprite_Combineball_Glow_Black_1:SetKeyValue("rendercolor","255 0 0 255")
	-- Sprite_Combineball_Glow_Black_1:SetKeyValue("spawnflags","1") -- If animated
	-- Sprite_Combineball_Glow_Black_1:SetParent(self)
	-- Sprite_Combineball_Glow_Black_1:Fire("SetParentAttachment", "headportal")
	-- Sprite_Combineball_Glow_Black_1:Spawn()
	-- Sprite_Combineball_Glow_Black_1:Activate()
	-- self:DeleteOnRemove(Sprite_Combineball_Glow_Black_1)

end
--------------------
function ENT:Init()

	self.DisableFindEnemy = true
	self.GodMode = true
	self.MovementType = VJ_MOVETYPE_STATIONARY
	self.CanTurnWhileStationary = false
	self:SetSolid(SOLID_NONE)
	self:SetMaterial("hud/killicons/default")
	self:DrawShadow(false)
	self.HasSounds = false

	-- VJ.EmitSound(self,{"npc/antlion/rumble1.wav"},90,70)

	-- VJ.EmitSound(self,{"ambient/levels/citadel/weaponstrip1_adpcm.wav"},80,math.random(95,105))
	timer.Simple(0.5,function() if IsValid(self) then
		if math.random(1,2) == 1 then
			self:VJ_ACT_PLAYACTIVITY({"vjseq_nz_emerge4"},true,false)
		else
			self:VJ_ACT_PLAYACTIVITY({"vjseq_nz_emerge5"},true,false)
		end
	end end)

end
--------------------
function ENT:TranslateActivity(act)
	-- if act == ACT_IDLE then
		-- return ACT_IDLE_ON_FIRE
	-- end
	-- if act == ACT_WALK || act == ACT_RUN then
		-- return ACT_WALK_ON_FIRE
	-- end
	return act
end
--------------------
function ENT:OnThinkActive()
	if self.BHLCIE_Preacher_Burning then
		VJ.ApplyRadiusDamage(self, self, self.dummyEnt:GetPos(), 125, 1, DMG_BURN, true, true, {DisableVisibilityCheck=true, Force=8110, UpForce=8110})
	end
end
--------------------
function ENT:CustomOnMeleeAttack_AfterStartTimer(seed)
	effects.BeamRingPoint(self:GetPos(), 0.75, 0, 300, 5, 5, Color(127, 0, 0), {material="sprites/physgbeamb", framerate=20})
	effects.BeamRingPoint(self:GetPos(), 0.75, 0, 150, 5, 5, Color(127, 0, 0), {material="sprites/physgbeamb", framerate=20})
	local meleeattackdust = EffectData()
	meleeattackdust:SetOrigin(self:GetPos())
	meleeattackdust:SetScale(50)
	util.Effect("ThumperDust", meleeattackdust)
	util.ScreenShake(self:GetPos(), 50, 40, 1, 300)
	VJ.EmitSound(self,"weapons/physcannon/energy_sing_explosion2.wav",70,75)
end
--------------------
function ENT:MeleeAttackKnockbackVelocity(hitEnt)
	return self:GetForward() * math.random(450, 550) + self:GetUp() * 300 -- tweak this and do experiments
end
--------------------
function ENT:RangeAttackProjSpawnPos(projectile)
	return self:GetAttachment(self:LookupAttachment("headportal")).Pos -- Attachment example
	-- return self:GetPos() + self:GetUp() * 20
end
--------------------
function ENT:RangeAttackProjVelocity(projectile)
	-- Use curve if the projectile has physics, otherwise use a simple line
	-- NOTE: Recommended to replace with your own trajectory and values as this is only here as examples and as a backup
	local phys = projectile:GetPhysicsObject()
	if IsValid(phys) && phys:IsGravityEnabled() then
		return VJ.CalculateTrajectory(self, self:GetEnemy(), "Curve", projectile:GetPos(), 1, 5)
	end
	-- return VJ.CalculateTrajectory(self, self:GetEnemy(), "Line", projectile:GetPos(), 1, 1500)
end
--------------------
function ENT:CustomOnLeapAttack_BeforeStartTimer(seed)

	if !IsValid(self:GetEnemy()) then return end -- don't run this if we have no valid enemy or they're not grounded
	if !self:GetEnemy():IsOnGround() then return end 
	self.dummyEnt = ents.Create("prop_dynamic")

	if IsValid(self.dummyEnt) then

		self.dummyEnt:SetPos(self:GetEnemy():GetPos())
		self.dummyEnt:SetModel("models/Gibs/HGIBS.mdl")
		self.dummyEnt:Spawn()
		self.dummyEnt:SetMoveType(MOVETYPE_NONE)
		self.dummyEnt:SetSolid(SOLID_NONE)

		self.dummyEnt:SetMaterial("models/debug/debugwhite")
		self.dummyEnt:SetRenderFX( 16 )
		self.dummyEnt:SetRenderMode( RENDERMODE_TRANSCOLOR )
		self.dummyEnt:SetColor(Color(255, 93, 0, 255))

		effects.BeamRingPoint(self.dummyEnt:GetPos()+self.dummyEnt:GetUp()*5, 0.80, 0, 250, 5, 0, Color(144, 0, 0), {material="sprites/physgbeamb", framerate=20})

		timer.Simple(0.80,function() if IsValid(self.dummyEnt) then
			effects.BeamRingPoint(self.dummyEnt:GetPos()+self.dummyEnt:GetUp()*5, 0.80, 0, 250, 5, 0, Color(199, 47, 25), {material="sprites/physgbeamb", framerate=20})
		end end)

		timer.Simple(1.60,function() if IsValid(self.dummyEnt) then
			effects.BeamRingPoint(self.dummyEnt:GetPos()+self.dummyEnt:GetUp()*5, 0.80, 0, 250, 5, 0, Color(255, 93, 50), {material="sprites/physgbeamb", framerate=20})
		end end)

		util.ScreenShake(self.dummyEnt:GetPos(), 100, 100, 5, 250)

		VJ.EmitSound(self.dummyEnt,{"npc/antlion/rumble1.wav"},70,math.random(100,90))

		timer.Simple(2.5,function() if IsValid(self.dummyEnt) then
			if IsValid(self) && !self.Dead then
				self.BHLCIE_Preacher_Burning = true
				util.ScreenShake(self.dummyEnt:GetPos(), 175, 200, 5, 500)
				for _, v in ipairs(ents.FindInSphere(self.dummyEnt:GetPos(), 175)) do
					if v:IsPlayer() and v:Alive() then
						v:SetLocalVelocity(v:GetVelocity()+Vector(0,0,500))
					end
				end
				ParticleEffect("strider_impale_ground",self.dummyEnt:GetPos(),Angle(0,0,0),nil)
				ParticleEffect("strider_cannon_impact",self.dummyEnt:GetPos(),Angle(0,0,0),nil)
				ParticleEffectAttach("fire_large_01",PATTACH_POINT_FOLLOW,self.dummyEnt,self.dummyEnt:LookupAttachment("origin"))

				self.dummyEnt.PreLaunchLight = ents.Create("light_dynamic")
				self.dummyEnt.PreLaunchLight:SetKeyValue("brightness", "5")
				self.dummyEnt.PreLaunchLight:SetKeyValue("distance", "1000")
				self.dummyEnt.PreLaunchLight:SetLocalPos(self.dummyEnt:GetPos())
				self.dummyEnt.PreLaunchLight:SetLocalAngles(self.dummyEnt:GetAngles())
				self.dummyEnt.PreLaunchLight:Fire("Color", "255 93 50 255")
				self.dummyEnt.PreLaunchLight:SetParent(self.dummyEnt)
				self.dummyEnt.PreLaunchLight:Spawn()
				self.dummyEnt.PreLaunchLight:Activate()
				self.dummyEnt.PreLaunchLight:Fire("TurnOn", "", 0)
				self.dummyEnt:DeleteOnRemove(self.dummyEnt.PreLaunchLight)

				local effectData = EffectData()
				effectData:SetOrigin(self.dummyEnt:GetPos())
				effectData:SetScale(250)
				util.Effect("ThumperDust", effectData)

				VJ.EmitSound(self.dummyEnt,{"ambient/fire/ignite.wav"},100,math.random(100,90))
				VJ.EmitSound(self.dummyEnt,{"ambient/machines/thumper_dust.wav"},100,math.random(100,90))
				VJ.EmitSound(self.dummyEnt,{"npc/follower/concrete_break"..math.random(2,3)..".wav"},100,math.random(100,90))
				
				timer.Simple(1,function() if IsValid(self.dummyEnt) then
					self.BHLCIE_Preacher_Burning = false
					self.dummyEnt:StopParticles()
					self.dummyEnt:Remove()
				end end)
			else
				self.dummyEnt:StopParticles()
				self.dummyEnt:Remove()
			end
		end end)
	end
end
--------------------
function ENT:GetLeapAttackVelocity()
	local ene = self:GetEnemy()
	-- return VJ.CalculateTrajectory(self, ene, "Curve", self:GetPos() + self:OBBCenter(), ene:GetPos() + ene:OBBCenter(), 1)
	
	-- Classic velocity, useful for more straight line type of jumps
	return ((ene:GetPos() + ene:OBBCenter()) - (self:GetPos() + self:OBBCenter())):GetNormal() * 0 + self:GetForward() * 0 + self:GetUp() * 0
end
--------------------

function ENT:OnDamaged(dmginfo, hitgroup, status)
	if status == "PreDamage" then
		if hitgroup != HITGROUP_HEAD then
			dmginfo:ScaleDamage(0.10)
		end
	end
end
--------------------
-- function ENT:CustomOnDeath_BeforeCorpseSpawned(dmginfo, hitgroup)
function ENT:OnDeath(dmginfo, hitgroup, status)
	if status == "Finish" then
		if IsValid(self.dummyEnt) then
			self.dummyEnt:StopParticles()
			self.dummyEnt:Remove()
		end
		VJ.EmitSound(self,{"ambient/levels/labs/teleport_postblast_thunder1.wav"},100,math.random(125,70))
		effects.BeamRingPoint(self:GetPos()+self:GetUp()*60, 0.80, 0, 75, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
		effects.BeamRingPoint(self:GetPos()+self:GetUp()*50, 0.80, 0, 100, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
		effects.BeamRingPoint(self:GetPos()+self:GetUp()*40, 0.80, 0, 75, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
	end
end
--------------------
function ENT:CustomOnRemove()
	if IsValid(self.dummyEnt) then
		self.dummyEnt:StopParticles()
		self.dummyEnt:Remove()
	end
end
--------------------