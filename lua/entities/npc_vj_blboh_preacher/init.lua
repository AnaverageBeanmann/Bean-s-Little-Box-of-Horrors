AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = {"models/vj_blboh/preacher.mdl"}
ENT.StartHealth = 1000
ENT.SightAngle = 360
--------------------
ENT.VJ_NPC_Class = {"CLASS_DEMON"}
--------------------
ENT.BloodColor = VJ.BLOOD_COLOR_RED
--------------------
ENT.HasMeleeAttack = true
-- ENT.MeleeAttackDamage = 10 -- remove this if we're keeping it at 10
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
ENT.RangeAttackEntityToSpawn = "obj_vj_blboh_preacher_hellball"
ENT.RangeAttackAnimationStopMovement = false
ENT.RangeDistance = 2000
ENT.RangeToMeleeDistance = 0
ENT.RangeAttackAngleRadius = 180
ENT.TimeUntilRangeAttackProjectileRelease = 0.15
ENT.NextRangeAttackTime = 1
ENT.NextRangeAttackTime_DoRand = 5
ENT.DisableRangeAttackAnimation = true
--------------------
ENT.HasLeapAttack = true
ENT.LeapDistance = 1000
ENT.LeapToMeleeDistance = 0
ENT.LeapAttackAngleRadius = 180
ENT.TimeUntilLeapAttackDamage = false
ENT.NextLeapAttackTime = 7
ENT.NextLeapAttackTime_DoRand = 9
ENT.DisableLeapAttackAnimation = true
--------------------
-- save this stuff for semper
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
--------------------
ENT.DisableFootStepSoundTimer = true
ENT.HasBreathSound = false
ENT.SoundTbl_FootStep = {
	"npc/fast_zombie/foot1.wav",
	"npc/fast_zombie/foot2.wav",
	"npc/fast_zombie/foot3.wav",
	"npc/fast_zombie/foot4.wav"
} -- replace this with regular zombie footsteps
ENT.SoundTbl_Breath = {"ambient/atmosphere/noise2.wav"}
ENT.SoundTbl_Alert = {
	-- "npc/antlion_guard/angry1.wav",
	-- "npc/antlion_guard/angry2.wav",
	-- "npc/antlion_guard/angry3.wav"
	-- "npc/antlion_guard/frustrated_growl1.wav",
	-- "npc/antlion_guard/frustrated_growl2.wav",
	-- "npc/antlion_guard/frustrated_growl3.wav",
	"npc/zombie_poison/pz_call1.wav"
}
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
	"ambient/atmosphere/cave_hit1.wav",
	"ambient/atmosphere/cave_hit2.wav",
	"ambient/atmosphere/cave_hit3.wav",
	"ambient/atmosphere/cave_hit4.wav",
	"ambient/atmosphere/cave_hit5.wav",
	"ambient/atmosphere/cave_hit6.wav",
	"ambient/atmosphere/city_truckpass1.wav",
	"ambient/atmosphere/hole_hit1.wav",
	"ambient/atmosphere/hole_hit2.wav",
	"ambient/atmosphere/hole_hit3.wav",
	"ambient/atmosphere/hole_hit4.wav",
	"ambient/atmosphere/hole_hit5.wav",
	"ambient/atmosphere/metallic1.wav",
	"ambient/atmosphere/metallic2.wav",
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
	"ambient/materials/creaking.wav",
	"ambient/materials/icegrind1.wav",
	"ambient/materials/metal4.wav",
	"ambient/materials/metal5.wav",
	"ambient/materials/metal9.wav",
	"ambient/materials/shipgroan1.wav",
	"ambient/materials/shipgroan2.wav",
	"ambient/materials/shipgroan3.wav",
	"ambient/materials/shipgroan4.wav"
}
-- ENT.SoundTbl_Pain = {
	-- "npc/antlion_guard/frustrated_growl1.wav",
	-- "npc/antlion_guard/frustrated_growl2.wav",
	-- "npc/antlion_guard/frustrated_growl3.wav",
-- }
ENT.SoundTbl_Death = {"npc/stalker/go_alert2.wav"}
ENT.NextSoundTime_Breath = VJ.SET(2,2)
ENT.NextSoundTime_Idle = VJ.SET(0, 5)
ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
ENT.BreathSoundLevel = 75
ENT.IdleSoundLevel = 80
ENT.BeforeRangeAttackSoundLevel = 90
ENT.IdleSoundPitch = VJ.SET(70, 50)
ENT.AlertSoundPitch = VJ.SET(60, 50)
-- ENT.PainSoundPitch = VJ.SET(70, 80)
ENT.DeathSoundPitch  = VJ.SET(30, 40)
--------------------
ENT.BLBOH_Preacher_Burning = false
--------------------
function ENT:OnInput(key, activator, caller, data)

	if key == "step" then
		VJ.EmitSound(self,self.SoundTbl_FootStep,self.FootStepSoundLevel)
	end

	if key == "attack" then
		self:MeleeAttackCode()
	end

	if key == "emerge" then

		self:RemoveFlags(FL_NOTARGET)
		self:SetMaterial("")
		self:DrawShadow(true)

		local bloodeffect = EffectData()
		bloodeffect:SetOrigin(self:GetPos() + self:GetForward()*-5 + self:GetRight() * 10)
		bloodeffect:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
		bloodeffect:SetScale(100)
		util.Effect("VJ_Blood1",bloodeffect)
		bloodeffect:SetOrigin(self:GetPos() + self:GetForward()*-20 + self:GetRight() * 10)
		util.Effect("VJ_Blood1",bloodeffect)
		bloodeffect:SetOrigin(self:GetPos() + self:GetForward()*-20 + self:GetRight() * -10)
		util.Effect("VJ_Blood1",bloodeffect)
		bloodeffect:SetOrigin(self:GetPos() + self:GetForward()*-50 + self:GetRight() * 10)
		util.Effect("VJ_Blood1",bloodeffect)
		bloodeffect:SetOrigin(self:GetPos() + self:GetForward()*-50 + self:GetRight() * -10)
		util.Effect("VJ_Blood1",bloodeffect)
		-- is this one actually needed?
		-- bloodeffect:SetOrigin(self:GetPos() + self:GetForward()*-5 + self:GetRight() * -10)
		-- util.Effect("VJ_Blood1",bloodeffect)

		VJ.EmitSound(self,"ambient/machines/thumper_dust.wav",70,math.random(95,105))
		VJ.EmitSound(self,{"physics/body/body_medium_break"..math.random(2,4)..".wav"},70,math.random(50,60))
		VJ.EmitSound(self,{"ambient/creatures/town_scared_sob"..math.random(1,2)..".wav"},90,math.random(60,80))

	end

	if key == "give_portal" then
		self:BLBOH_Preacher_GivePortal()
	end

end
--------------------
function ENT:BLBOH_Preacher_GivePortal()

	self.DisableFindEnemy = false
	self.GodMode = false
	self.MovementType = VJ_MOVETYPE_GROUND
	self.CanTurnWhileStationary = true
	self.HasSounds = true
	-- self.HasBreathSound = true -- don't think we need this

	self.PreacherPortalLight = ents.Create("light_dynamic")
	self.PreacherPortalLight:SetKeyValue("brightness", "1")
	self.PreacherPortalLight:SetKeyValue("distance", "750")
	self.PreacherPortalLight:SetLocalPos(self:GetPos())
	self.PreacherPortalLight:SetLocalAngles(self:GetAngles())
	self.PreacherPortalLight:Fire("Color", "255 0 0 255")
	self.PreacherPortalLight:SetParent(self)
	self.PreacherPortalLight:Spawn()
	self.PreacherPortalLight:Activate()
	self.PreacherPortalLight:Fire("SetParentAttachment","headportal")
	self.PreacherPortalLight:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(self.PreacherPortalLight)

	local PreacherPortalSprite_Flare = ents.Create("env_sprite")
	PreacherPortalSprite_Flare:SetKeyValue("model","sprites/flare1.vmt")
	PreacherPortalSprite_Flare:SetKeyValue("scale", "0.5")
	PreacherPortalSprite_Flare:SetKeyValue("rendermode","5")
	PreacherPortalSprite_Flare:SetKeyValue("rendercolor","142 0 0 255")
	PreacherPortalSprite_Flare:SetKeyValue("spawnflags","1") -- If animated
	PreacherPortalSprite_Flare:SetParent(self)
	PreacherPortalSprite_Flare:Fire("SetParentAttachment", "headportal")
	PreacherPortalSprite_Flare:Spawn()
	PreacherPortalSprite_Flare:Activate()
	self:DeleteOnRemove(PreacherPortalSprite_Flare)

	local PreacherPortalSprite_Iris = ents.Create("env_sprite")
	PreacherPortalSprite_Iris:SetKeyValue("model","sprites/flare1.vmt")
	PreacherPortalSprite_Iris:SetKeyValue("scale", "0.25")
	PreacherPortalSprite_Iris:SetKeyValue("rendermode","5")
	PreacherPortalSprite_Iris:SetKeyValue("rendercolor","255 155 155 255")
	PreacherPortalSprite_Iris:SetKeyValue("spawnflags","1") -- If animated
	PreacherPortalSprite_Iris:SetParent(self)
	PreacherPortalSprite_Iris:Fire("SetParentAttachment", "headportal")
	PreacherPortalSprite_Iris:Spawn()
	PreacherPortalSprite_Iris:Activate()
	self:DeleteOnRemove(PreacherPortalSprite_Iris)

	local PreacherPortalSprite_VortRing = ents.Create("env_sprite")
	PreacherPortalSprite_VortRing:SetKeyValue("model","sprites/vortring1.vmt")
	PreacherPortalSprite_VortRing:SetKeyValue("scale", "0.3")
	PreacherPortalSprite_VortRing:SetKeyValue("rendermode","5")
	PreacherPortalSprite_VortRing:SetKeyValue("rendercolor","142 142 142 255")
	PreacherPortalSprite_VortRing:SetKeyValue("spawnflags","1") -- If animated
	PreacherPortalSprite_VortRing:SetParent(self)
	PreacherPortalSprite_VortRing:Fire("SetParentAttachment", "headportal")
	PreacherPortalSprite_VortRing:Spawn()
	PreacherPortalSprite_VortRing:Activate()
	self:DeleteOnRemove(PreacherPortalSprite_VortRing)

	local PreacherPortalSprite_Glow = ents.Create("env_sprite")
	PreacherPortalSprite_Glow:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
	PreacherPortalSprite_Glow:SetKeyValue("scale", "0.5")
	PreacherPortalSprite_Glow:SetKeyValue("rendermode","5")
	PreacherPortalSprite_Glow:SetKeyValue("rendercolor","142 0 0 255")
	PreacherPortalSprite_Glow:SetKeyValue("spawnflags","1") -- If animated
	PreacherPortalSprite_Glow:SetParent(self)
	PreacherPortalSprite_Glow:Fire("SetParentAttachment", "headportal2")
	PreacherPortalSprite_Glow:Spawn()
	PreacherPortalSprite_Glow:Activate()
	self:DeleteOnRemove(PreacherPortalSprite_Glow)

	ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))

	VJ.EmitSound(self,"ambient/alarms/warningbell1.wav",80,math.random(40,50))
	VJ.EmitSound(self,"ambient/machines/thumper_dust.wav",70,math.random(95,105))
	VJ.EmitSound(self,"ambient/voices/squeal1.wav",70,math.random(50,60))

end
--------------------
function ENT:Init()

	self:AddFlags(FL_NOTARGET)
	self.DisableFindEnemy = true
	self.GodMode = true
	self.MovementType = VJ_MOVETYPE_STATIONARY
	self.CanTurnWhileStationary = false
	self:SetMaterial("hud/killicons/default")
	self:DrawShadow(false)
	self.HasSounds = false

	timer.Simple(0.5,function() if IsValid(self) then -- can we reduce this?
		if math.random(1,2) == 1 then
			self:VJ_ACT_PLAYACTIVITY({"vjseq_nz_emerge4"},true,false)
		else
			self:VJ_ACT_PLAYACTIVITY({"vjseq_nz_emerge5"},true,false)
		end
	end end)

end
--------------------
function ENT:OnThinkActive()
	if self.BLBOH_Preacher_Burning then
		VJ.ApplyRadiusDamage(self, self, self.AreaAttackTargetEnt:GetPos(), 125, 1, DMG_BURN, true, true, {DisableVisibilityCheck=true, Force=8110, UpForce=8110}) -- i think we could increase the damage
	end
end
--------------------
function ENT:CustomOnMeleeAttack_AfterStartTimer(seed)

	local MeleeBlastDust = EffectData()
	MeleeBlastDust:SetOrigin(self:GetPos())
	MeleeBlastDust:SetScale(50)
	util.Effect("ThumperDust", MeleeBlastDust)

	effects.BeamRingPoint(self:GetPos(), 0.75, 0, 300, 5, 5, Color(127, 0, 0), {material="sprites/physgbeamb", framerate=20})
	effects.BeamRingPoint(self:GetPos(), 0.75, 0, 150, 5, 5, Color(127, 0, 0), {material="sprites/physgbeamb", framerate=20})

	util.ScreenShake(self:GetPos(), 50, 40, 1, 300)

	VJ.EmitSound(self,"weapons/physcannon/energy_sing_explosion2.wav",70,75)

end
--------------------
function ENT:MeleeAttackKnockbackVelocity(hitEnt)
	return self:GetForward() * math.random(450, 550) + self:GetUp() * 300 -- tweak this and do experiments
end
--------------------
function ENT:RangeAttackProjSpawnPos(projectile)
	return self:GetAttachment(self:LookupAttachment("headportal")).Pos
end
--------------------
function ENT:RangeAttackProjVelocity(projectile)
	local phys = projectile:GetPhysicsObject()
	if IsValid(phys) && phys:IsGravityEnabled() then
		return VJ.CalculateTrajectory(self, self:GetEnemy(), "Curve", projectile:GetPos(), 1, 5)
	end
end
--------------------
function ENT:CustomOnLeapAttack_BeforeStartTimer(seed)

	if !IsValid(self:GetEnemy()) || !self:GetEnemy():IsOnGround() then return end -- don't run this if we have no valid enemy or they're not grounded
	-- if !IsValid(self:GetEnemy()) then return end
	-- if !self:GetEnemy():IsOnGround() then return end

	self.AreaAttackTargetEnt = ents.Create("prop_dynamic")

	if IsValid(self.AreaAttackTargetEnt) then

		self.AreaAttackTargetEnt:SetPos(self:GetEnemy():GetPos())
		self.AreaAttackTargetEnt:SetModel("models/Gibs/HGIBS.mdl")
		self.AreaAttackTargetEnt:Spawn()
		self.AreaAttackTargetEnt:SetMoveType(MOVETYPE_NONE)
		self.AreaAttackTargetEnt:SetSolid(SOLID_NONE)

		self.AreaAttackTargetEnt:SetMaterial("models/debug/debugwhite")
		self.AreaAttackTargetEnt:SetRenderFX( 16 )
		self.AreaAttackTargetEnt:SetRenderMode( RENDERMODE_TRANSCOLOR )
		self.AreaAttackTargetEnt:SetColor(Color(255, 93, 0, 255))

		effects.BeamRingPoint(self.AreaAttackTargetEnt:GetPos()+self.AreaAttackTargetEnt:GetUp()*5, 0.80, 0, 250, 5, 0, Color(144, 0, 0), {material="sprites/physgbeamb", framerate=20})

		util.ScreenShake(self.AreaAttackTargetEnt:GetPos(), 100, 100, 5, 250)

		VJ.EmitSound(self.AreaAttackTargetEnt,{"npc/antlion/rumble1.wav"},70,math.random(100,90))

		timer.Simple(0.80,function() if IsValid(self.AreaAttackTargetEnt) then

			effects.BeamRingPoint(self.AreaAttackTargetEnt:GetPos()+self.AreaAttackTargetEnt:GetUp()*5, 0.80, 0, 250, 5, 0, Color(199, 47, 25), {material="sprites/physgbeamb", framerate=20})

		end end)

		timer.Simple(1.60,function() if IsValid(self.AreaAttackTargetEnt) then

			effects.BeamRingPoint(self.AreaAttackTargetEnt:GetPos()+self.AreaAttackTargetEnt:GetUp()*5, 0.80, 0, 250, 5, 0, Color(255, 93, 50), {material="sprites/physgbeamb", framerate=20})

		end end)

		timer.Simple(2.5,function() if IsValid(self.AreaAttackTargetEnt) then

			if IsValid(self) && !self.Dead then

				self.BLBOH_Preacher_Burning = true

				util.ScreenShake(self.AreaAttackTargetEnt:GetPos(), 175, 200, 5, 500)

				for _, v in ipairs(ents.FindInSphere(self.AreaAttackTargetEnt:GetPos(), 175)) do
					if v:IsPlayer() and v:Alive() then -- make this also affect npcs, nextbots, and props
						v:SetLocalVelocity(v:GetVelocity()+Vector(0,0,500))
					end
				end

				ParticleEffectAttach("fire_large_01",PATTACH_POINT_FOLLOW,self.AreaAttackTargetEnt,self.AreaAttackTargetEnt:LookupAttachment("origin"))

				ParticleEffect("strider_impale_ground",self.AreaAttackTargetEnt:GetPos(),Angle(0,0,0),nil)
				ParticleEffect("strider_cannon_impact",self.AreaAttackTargetEnt:GetPos(),Angle(0,0,0),nil)

				self.AreaAttackTargetEnt.FireLight = ents.Create("light_dynamic")
				self.AreaAttackTargetEnt.FireLight:SetKeyValue("brightness", "5")
				self.AreaAttackTargetEnt.FireLight:SetKeyValue("distance", "1000")
				self.AreaAttackTargetEnt.FireLight:SetLocalPos(self.AreaAttackTargetEnt:GetPos())
				self.AreaAttackTargetEnt.FireLight:SetLocalAngles(self.AreaAttackTargetEnt:GetAngles())
				self.AreaAttackTargetEnt.FireLight:Fire("Color", "255 93 50 255")
				self.AreaAttackTargetEnt.FireLight:SetParent(self.AreaAttackTargetEnt)
				self.AreaAttackTargetEnt.FireLight:Spawn()
				self.AreaAttackTargetEnt.FireLight:Activate()
				self.AreaAttackTargetEnt.FireLight:Fire("TurnOn", "", 0)
				self.AreaAttackTargetEnt:DeleteOnRemove(self.AreaAttackTargetEnt.FireLight)

				local effectData = EffectData()
				effectData:SetOrigin(self.AreaAttackTargetEnt:GetPos())
				effectData:SetScale(250)
				util.Effect("ThumperDust", effectData)

				VJ.EmitSound(self.AreaAttackTargetEnt,"ambient/fire/ignite.wav",100,math.random(100,90))
				VJ.EmitSound(self.AreaAttackTargetEnt,"ambient/machines/thumper_dust.wav",100,math.random(100,90))
				VJ.EmitSound(self.AreaAttackTargetEnt,"npc/follower/concrete_break"..math.random(2,3)..".wav",100,math.random(100,90))

				timer.Simple(1,function() if IsValid(self.AreaAttackTargetEnt) then

					self.BLBOH_Preacher_Burning = false
					self.AreaAttackTargetEnt:StopParticles()
					self.AreaAttackTargetEnt:Remove()

				end end)

			else

				self.AreaAttackTargetEnt:StopParticles()
				self.AreaAttackTargetEnt:Remove()

			end

		end end)

	end

end
--------------------
function ENT:GetLeapAttackVelocity()
	local ene = self:GetEnemy()
	return ((ene:GetPos() + ene:OBBCenter()) - (self:GetPos() + self:OBBCenter())):GetNormal() * 0 + self:GetForward() * 0 + self:GetUp() * 0
end
--------------------
function ENT:OnDeath(dmginfo, hitgroup, status)

	if status == "Finish" then

		if IsValid(self.AreaAttackTargetEnt) then

			self.AreaAttackTargetEnt:StopParticles()
			self.AreaAttackTargetEnt:Remove()

		end

		effects.BeamRingPoint(self:GetPos()+self:GetUp()*60, 0.80, 0, 75, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
		effects.BeamRingPoint(self:GetPos()+self:GetUp()*50, 0.80, 0, 100, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
		effects.BeamRingPoint(self:GetPos()+self:GetUp()*40, 0.80, 0, 75, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})

		VJ.EmitSound(self,{"ambient/levels/labs/teleport_postblast_thunder1.wav"},100,math.random(125,70))

	end

end
--------------------
function ENT:CustomOnRemove()

	if IsValid(self.AreaAttackTargetEnt) then

		self.AreaAttackTargetEnt:StopParticles()
		self.AreaAttackTargetEnt:Remove()

	end

end
--------------------