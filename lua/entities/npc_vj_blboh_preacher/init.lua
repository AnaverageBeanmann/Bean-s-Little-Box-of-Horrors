AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = "models/vj_blboh/preacher.mdl"
ENT.StartHealth = 1000
ENT.ControllerParams = {
	CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(20, 0, -40), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "ValveBiped.Bip01_Head1", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(20, 0, 65), -- i don't know why but FirstP_Bone is just not working at all, so we have to use this as a workaround
	FirstP_ShrinkBone = true, -- Should the bone shrink? Useful if the bone is obscuring the player's view
	FirstP_CameraBoneAng = 0, -- Should the camera's angle be affected by the bone's angle? | 0 = No, 1 = Pitch, 2 = Yaw, 3 = Roll
	FirstP_CameraBoneAng_Offset = 0, -- How much should the camera's angle be rotated by? | Useful for weird bone angles
}
--------------------
ENT.SightAngle = 360
--------------------
ENT.VJ_NPC_Class = {"CLASS_BLBOH"}
--------------------
ENT.BloodColor = VJ.BLOOD_COLOR_RED
--------------------
ENT.HasMeleeAttack = true
-- ENT.MeleeAttackDamage = 10 -- remove this if we're keeping it at 10
ENT.MeleeAttackDamageType = DMG_SONIC
ENT.HasMeleeAttackKnockBack = true
ENT.AnimTbl_MeleeAttack = false
ENT.MeleeAttackDistance = 100
ENT.MeleeAttackAngleRadius = 180
ENT.MeleeAttackDamageDistance = 125
ENT.MeleeAttackDamageAngleRadius = 180
ENT.TimeUntilMeleeAttackDamage = 0
ENT.NextMeleeAttackTime = 1
--------------------
ENT.HasRangeAttack = true
ENT.RangeAttackProjectiles = "obj_vj_blboh_preacher_hellball"
ENT.AnimTbl_RangeAttack = false
ENT.RangeAttackAnimationFaceEnemy = false
ENT.RangeAttackMinDistance = 0
ENT.RangeAttackMaxDistance  = 2000
ENT.RangeAttackAngleRadius = 180
ENT.TimeUntilRangeAttackProjectileRelease = 0.15
ENT.NextRangeAttackTime = VJ.SET(1,5)
--------------------
ENT.HasLeapAttack = true
ENT.AnimTbl_LeapAttack = false
ENT.LeapAttackAnimationFaceEnemy = false
ENT.LeapAttackMinDistance = 0
ENT.LeapAttackMaxDistance  = 1000
ENT.LeapAttackAngleRadius = 180
ENT.TimeUntilLeapAttackDamage = false
ENT.NextLeapAttackTime  = VJ.SET(10,15)
--------------------
ENT.DisableFootStepSoundTimer = true
ENT.HasBreathSound = false
ENT.SoundTbl_FootStep = {
	"npc/fast_zombie/foot1.wav",
	"npc/fast_zombie/foot2.wav",
	"npc/fast_zombie/foot3.wav",
	"npc/fast_zombie/foot4.wav"
} -- replace this with regular zombie footsteps
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
	"ambient/materials/shipgroan4.wav",
	"npc/antlion_guard/frustrated_growl1.wav",
	"npc/antlion_guard/frustrated_growl2.wav",
	"npc/antlion_guard/frustrated_growl3.wav",
	"ambient/levels/streetwar/city_scream3.wav",
	"ambient/levels/streetwar/gunship_distant2.wav",
	"ambient/levels/labs/teleport_weird_voices1.wav",
	"ambient/levels/labs/teleport_weird_voices2.wav",
	"ambient/levels/labs/teleport_winddown1.wav"
}
-- ENT.SoundTbl_Alert = {
	-- "npc/antlion_guard/angry1.wav",
	-- "npc/antlion_guard/angry2.wav",
	-- "npc/antlion_guard/angry3.wav"
	-- "npc/antlion_guard/frustrated_growl1.wav",
	-- "npc/antlion_guard/frustrated_growl2.wav",
	-- "npc/antlion_guard/frustrated_growl3.wav",
	-- "npc/zombie_poison/pz_call1.wav"
-- }
ENT.SoundTbl_Alert = "npc/zombie_poison/pz_call1.wav"
-- ENT.SoundTbl_Pain = {
	-- "npc/antlion_guard/frustrated_growl1.wav",
	-- "npc/antlion_guard/frustrated_growl2.wav",
	-- "npc/antlion_guard/frustrated_growl3.wav",
-- }
ENT.SoundTbl_Death = {
	"npc/stalker/go_alert2.wav",
	"ambient/creatures/town_child_scream1.wav"
}
ENT.NextSoundTime_Breath = VJ.SET(9,9)
ENT.NextSoundTime_Idle = VJ.SET(10,20)
ENT.BreathSoundLevel = 75
ENT.IdleSoundLevel = 80
-- ENT.BeforeRangeAttackSoundLevel = 90
ENT.DeathSoundLevel = 85
ENT.MainSoundPitch = 100
ENT.FootstepSoundPitch = VJ.SET(60, 70)
ENT.IdleSoundPitch = VJ.SET(70, 50)
ENT.AlertSoundPitch = VJ.SET(60, 50)
-- ENT.PainSoundPitch = VJ.SET(70, 80)
ENT.DeathSoundPitch  = VJ.SET(30, 40)
--------------------
ENT.BLBOH_DoSpawnSequence = false
ENT.BLBOH_CanDoSpawnSequence = true
ENT.BLBOH_Preacher_HasPortal = false
ENT.BLBOH_Preacher_Burning = false
ENT.BLBOH_Preacher_BurnTime = CurTime()
ENT.BLBOH_Preacher_FireLoopSoundExists = false
ENT.BLBOH_Preacher_PlayerTeleportCooldownTime = CurTime()
ENT.BLBOH_Preacher_PlayerTeleportCooldownNotif = true
ENT.BLBOH_Preacher_StopSpammingRNoticeTime = CurTime()
-- ENT.BLBOH_Preacher_NextSoundTime = CurTime()
ENT.BLBOH_IsHordeBoss = false
ENT.SoundTbl_Breath = "ambient/atmosphere/noise2.wav"
-- ENT.SoundTbl_SpookySounds = {
	-- "ambient/creatures/town_child_scream1.wav",
	-- "ambient/creatures/town_moan1.wav",
	-- "ambient/creatures/town_muffled_cry1.wav",
	-- "ambient/creatures/town_scared_breathing1.wav",
	-- "ambient/creatures/town_scared_breathing2.wav",
	-- "ambient/creatures/town_scared_sob1.wav",
	-- "ambient/creatures/town_scared_sob2.wav",
	-- "ambient/creatures/town_zombie_call1.wav",
	-- "ambient/voices/playground_memory.wav",
	-- "ambient/atmosphere/cave_hit1.wav",
	-- "ambient/atmosphere/cave_hit2.wav",
	-- "ambient/atmosphere/cave_hit3.wav",
	-- "ambient/atmosphere/cave_hit4.wav",
	-- "ambient/atmosphere/cave_hit5.wav",
	-- "ambient/atmosphere/cave_hit6.wav",
	-- "ambient/atmosphere/city_truckpass1.wav",
	-- "ambient/atmosphere/hole_hit1.wav",
	-- "ambient/atmosphere/hole_hit2.wav",
	-- "ambient/atmosphere/hole_hit3.wav",
	-- "ambient/atmosphere/hole_hit4.wav",
	-- "ambient/atmosphere/hole_hit5.wav",
	-- "ambient/atmosphere/metallic1.wav",
	-- "ambient/atmosphere/metallic2.wav",
	-- "ambient/levels/citadel/datatransfmalevx01.wav",
	-- "ambient/levels/citadel/datatransfmalevx02.wav",
	-- "ambient/levels/citadel/datatransgarbledfmalevx01.wav",
	-- "ambient/levels/citadel/datatransmalevx01.wav",
	-- "ambient/levels/citadel/datatransmalevx02.wav",
	-- "ambient/levels/citadel/strange_talk1.wav",
	-- "ambient/levels/citadel/strange_talk2.wav",
	-- "ambient/levels/citadel/strange_talk3.wav",
	-- "ambient/levels/citadel/strange_talk4.wav",
	-- "ambient/levels/citadel/strange_talk5.wav",
	-- "ambient/levels/citadel/strange_talk6.wav",
	-- "ambient/levels/citadel/strange_talk7.wav",
	-- "ambient/levels/citadel/strange_talk8.wav",
	-- "ambient/levels/citadel/strange_talk9.wav",
	-- "ambient/levels/citadel/strange_talk10.wav",
	-- "ambient/materials/creaking.wav",
	-- "ambient/materials/icegrind1.wav",
	-- "ambient/materials/metal4.wav",
	-- "ambient/materials/metal5.wav",
	-- "ambient/materials/metal9.wav",
	-- "ambient/materials/shipgroan1.wav",
	-- "ambient/materials/shipgroan2.wav",
	-- "ambient/materials/shipgroan3.wav",
	-- "ambient/materials/shipgroan4.wav",
	-- "npc/antlion_guard/frustrated_growl1.wav",
	-- "npc/antlion_guard/frustrated_growl2.wav",
	-- "npc/antlion_guard/frustrated_growl3.wav",
	-- "ambient/levels/streetwar/city_scream3.wav",
	-- "ambient/levels/streetwar/gunship_distant2.wav"
-- }
--------------------
function ENT:BLBOH_Preacher_GivePortal()

	self.BLBOH_Preacher_HasPortal = true

	self.EnemyDetection = true
	self.GodMode = false
	self.MovementType = VJ_MOVETYPE_GROUND
	self.CanTurnWhileStationary = true
	self.HasSounds = true
	self.HasBreathSound = true

	self.PreacherPortalLight = ents.Create("light_dynamic")
	self.PreacherPortalLight:SetKeyValue("brightness", "3")
	self.PreacherPortalLight:SetKeyValue("distance", "350")
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
	PreacherPortalSprite_Glow:SetKeyValue("model","vj_base/sprites/glow.vmt")
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

	if self.BLBOH_IsHordeBoss then
		self.SoundTbl_SoundTrack = {"vj_blboh/horde/SHOW_TIME!.mp3"}
		self.HasSoundTrack = true
		self:StartSoundTrack()
	end

end
--------------------
function ENT:PreInit()
	if GetConVar("vj_blboh_spawn_sequences"):GetInt() == 1 && self.BLBOH_CanDoSpawnSequence then
		self.BLBOH_DoSpawnSequence = true
	end
end
--------------------
function ENT:Init()

	if self.BLBOH_DoSpawnSequence then
		self:AddFlags(FL_NOTARGET)
		self.EnemyDetection = false
		self.GodMode = true
		self:SetMaterial("hud/killicons/default")
		self:DrawShadow(false)
		self.HasSounds = false

		self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK,0.5)

		-- self.BLBOH_Preacher_NextSoundTime = CurTime() + math.random(5,15)

		timer.Simple(0.5,function() if IsValid(self) then -- can we reduce this?
			if math.random(1,2) == 1 then
				self:PlayAnim({"vjseq_nz_emerge4"},true,false)
				self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK,5)
			else
				self:PlayAnim({"vjseq_nz_emerge5"},true,false)
				self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK,5)
			end
		end end)
	else
		self:BLBOH_Preacher_GivePortal()
		-- self.BLBOH_Preacher_NextSoundTime = CurTime() + math.random(1,10)
	end

end
--------------------
function ENT:OnThinkActive()
	if self.BLBOH_Preacher_Burning && self.BLBOH_Preacher_BurnTime < CurTime() then
		self.BLBOH_Preacher_BurnTime = CurTime() + 0.25
		VJ.ApplyRadiusDamage(self, self, self.BLBOH_Preacher_AOEAttackEnt:GetPos(), 125, 5, DMG_BURN, true, true, {DisableVisibilityCheck=true, Force=8110, UpForce=8110}) -- i think we could increase the damage
	end
	if self.VJ_IsBeingControlled then
		if !self.BLBOH_Preacher_PlayerTeleportCooldownNotif && self.BLBOH_Preacher_PlayerTeleportCooldownTime < CurTime() then
			self.BLBOH_Preacher_PlayerTeleportCooldownNotif = true
			self.VJ_TheController:ChatPrint("Teleport is available.")
			self.VJ_TheController:SendLua("surface.PlaySound('buttons/button15.wav')")
		end
		if self.VJ_TheController:KeyDown(IN_RELOAD) then
			if self.BLBOH_Preacher_PlayerTeleportCooldownTime < CurTime() then
				if self:GetEnemy() != nil && self:GetPos():Distance(self:GetEnemy():GetPos()) < 1000 then

					self.BLBOH_Preacher_TeleportSpotEnt = ents.Create("prop_dynamic")
					self.BLBOH_Preacher_TeleportSpotEnt:SetPos(self:GetEnemy():GetPos())
					self.BLBOH_Preacher_TeleportSpotEnt:SetModel("models/Gibs/HGIBS.mdl")
					self.BLBOH_Preacher_TeleportSpotEnt:Spawn()
					self.BLBOH_Preacher_TeleportSpotEnt:SetMoveType(MOVETYPE_NONE)
					self.BLBOH_Preacher_TeleportSpotEnt:SetSolid(SOLID_NONE)

					self.BLBOH_Preacher_TeleportSpotEnt:SetMaterial("models/debug/debugwhite")
					self.BLBOH_Preacher_TeleportSpotEnt:SetRenderFX( 16 )
					self.BLBOH_Preacher_TeleportSpotEnt:SetRenderMode( RENDERMODE_TRANSCOLOR )
					self.BLBOH_Preacher_TeleportSpotEnt:SetColor(Color(144, 0, 0, 255))

					local myCenterPos = self.BLBOH_Preacher_TeleportSpotEnt:GetPos() + self.BLBOH_Preacher_TeleportSpotEnt:GetUp() * 30 + self.BLBOH_Preacher_TeleportSpotEnt:OBBCenter()
					local tr1 = util.TraceLine({
						start = myCenterPos,
						endpos = myCenterPos + self.BLBOH_Preacher_TeleportSpotEnt:GetForward()*40,
						filter = self.BLBOH_Preacher_TeleportSpotEnt
					})
					local tr2 = util.TraceLine({
						start = myCenterPos,
						endpos = myCenterPos + self.BLBOH_Preacher_TeleportSpotEnt:GetForward()*-40,
						filter = self.BLBOH_Preacher_TeleportSpotEnt
					})
					local tr3 = util.TraceLine({
						start = myCenterPos,
						endpos = myCenterPos + self.BLBOH_Preacher_TeleportSpotEnt:GetRight()*40,
						filter = self.BLBOH_Preacher_TeleportSpotEnt
					})

					local tr4 = util.TraceLine({
						start = myCenterPos,
						endpos = myCenterPos + self.BLBOH_Preacher_TeleportSpotEnt:GetRight()*-40,
						filter = self.BLBOH_Preacher_TeleportSpotEnt
					})
					if !tr1.Hit && !tr2.Hit && !tr3.Hit && !tr4.Hit then
						self.BLBOH_Preacher_PlayerTeleportCooldownTime = CurTime() + 15
						self.BLBOH_Preacher_PlayerTeleportCooldownNotif = false
						self.BLBOH_Preacher_StopSpammingRNoticeTime = CurTime() + 1
						-- self.BLBOH_Preacher_PlayerTeleportCooldownTime = CurTime() + 3 -- testing value

						effects.BeamRingPoint(self.BLBOH_Preacher_TeleportSpotEnt:GetPos()+self.BLBOH_Preacher_TeleportSpotEnt:GetUp()*5, 2, 0, 250, 5, 0, Color(144, 0, 0), {material="sprites/physgbeamb", framerate=20})
						effects.BeamRingPoint(self.BLBOH_Preacher_TeleportSpotEnt:GetPos()+self.BLBOH_Preacher_TeleportSpotEnt:GetUp()*5, 2, 0, 125, 5, 0, Color(144, 0, 0), {material="sprites/physgbeamb", framerate=20})

						util.ScreenShake(self.BLBOH_Preacher_TeleportSpotEnt:GetPos(), 100, 100, 5, 250)

						VJ.EmitSound(self.BLBOH_Preacher_TeleportSpotEnt,{"npc/antlion/rumble1.wav"},70,math.random(70,80))

						-- timer.Simple(0.80,function() if IsValid(self.BLBOH_Preacher_TeleportSpotEnt) then
							-- effects.BeamRingPoint(self.BLBOH_Preacher_TeleportSpotEnt:GetPos()+self.BLBOH_Preacher_TeleportSpotEnt:GetUp()*5, 0.80, 0, 250, 5, 0, Color(199, 47, 25), {material="sprites/physgbeamb", framerate=20})
						-- end end)
						-- timer.Simple(1.60,function() if IsValid(self.BLBOH_Preacher_TeleportSpotEnt) then
							-- effects.BeamRingPoint(self.BLBOH_Preacher_TeleportSpotEnt:GetPos()+self.BLBOH_Preacher_TeleportSpotEnt:GetUp()*5, 0.80, 0, 250, 5, 0, Color(255, 93, 50), {material="sprites/physgbeamb", framerate=20})
						-- end end)

						timer.Simple(2,function()
							if IsValid(self.BLBOH_Preacher_TeleportSpotEnt) then
								if IsValid(self) then
									self:SetPos(self.BLBOH_Preacher_TeleportSpotEnt:GetPos())
									effects.BeamRingPoint(self.BLBOH_Preacher_TeleportSpotEnt:GetPos()+self.BLBOH_Preacher_TeleportSpotEnt:GetUp()*5, 0.5, 0, 250, 5, 0, Color(144, 0, 0), {material="sprites/physgbeamb", framerate=20})
									effects.BeamRingPoint(self.BLBOH_Preacher_TeleportSpotEnt:GetPos()+self.BLBOH_Preacher_TeleportSpotEnt:GetUp()*5, 0.5, 0, 125, 5, 0, Color(144, 0, 0), {material="sprites/physgbeamb", framerate=20})
									util.ScreenShake(self:GetPos(), 50, 40, 1, 300)
									VJ.EmitSound(self,"weapons/physcannon/energy_sing_explosion2.wav",70,75)
								end
								self.BLBOH_Preacher_TeleportSpotEnt:Remove()
							end
						end)
						-- self:GetEnemy():Ignite(5,0)
					else
						self.BLBOH_Preacher_PlayerTeleportCooldownTime = CurTime() + 1
						self.BLBOH_Preacher_StopSpammingRNoticeTime = CurTime() + 1
						local randtpfailmessage = math.random(1,3)
						if randtpfailmessage == 1 then
							self.VJ_TheController:ChatPrint("That's a bad spot, you'd get stuck.")
						elseif randtpfailmessage == 2 then
							self.VJ_TheController:ChatPrint("No, you'd get stuck there.")
						else
							self.VJ_TheController:ChatPrint("Not there, you'd get stuck.")
						end
						self.VJ_TheController:SendLua("surface.PlaySound('buttons/button18.wav')")
						self.BLBOH_Preacher_TeleportSpotEnt:Remove()
					end

				elseif self:GetEnemy() != nil && self:GetPos():Distance(self:GetEnemy():GetPos()) >= 1000 then
					self.BLBOH_Preacher_PlayerTeleportCooldownTime = CurTime() + 1
					self.BLBOH_Preacher_StopSpammingRNoticeTime = CurTime() + 1
					local randtpfailmessage = math.random(1,3)
					if randtpfailmessage == 1 then
						self.VJ_TheController:ChatPrint("That's too far away.")
					elseif randtpfailmessage == 2 then
						self.VJ_TheController:ChatPrint("You can't teleport that far.")
					else
						self.VJ_TheController:ChatPrint("Aim somewhere closer.")
					end
					self.VJ_TheController:SendLua("surface.PlaySound('buttons/button18.wav')")
				elseif self:GetEnemy() == nil then
					self.VJ_TheController:ChatPrint("Something went catastrophically wrong; teleport prevented.")
					self.VJ_TheController:SendLua("surface.PlaySound('vo/k_lab/kl_fiddlesticks.wav')")
				end
			elseif self.BLBOH_Preacher_StopSpammingRNoticeTime < CurTime() then
				self.BLBOH_Preacher_StopSpammingRNoticeTime = CurTime() + 1
				if math.random(1,10) == 1 then
					local randtpfailmessage = math.random(1,3)
					if randtpfailmessage == 1 then
						self.VJ_TheController:ChatPrint("Doing that is pointless.")
					elseif randtpfailmessage == 2 then
						self.VJ_TheController:ChatPrint("Spamming the button won't make the cooldown go down faster.")
					else
						self.VJ_TheController:ChatPrint("That's not going to help.")
					end
				else
					self.VJ_TheController:ChatPrint("Teleport is on cooldown!")
				end
				self.VJ_TheController:SendLua("surface.PlaySound('buttons/button10.wav')")
			end
		end
	end
	-- if self.BLBOH_Preacher_NextSoundTime < CurTime() then
		-- self.BLBOH_Preacher_NextSoundTime = CurTime() + math.random(1,10)
		-- VJ.EmitSound(self, self.SoundTbl_SpookySounds, 80, math.random(50,70))
	-- end
end
--------------------
function ENT:OnInput(key, activator, caller, data)

	if key == "step" then
		VJ.EmitSound(self,self.SoundTbl_FootStep,self.FootstepSoundLevel)
	-- elseif key == "attack" then
		-- self:MeleeAttackCode()
	elseif key == "emerge" then
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
	elseif key == "give_portal" && !self.BLBOH_Preacher_HasPortal then
		self:BLBOH_Preacher_GivePortal()
	end

end
--------------------
function ENT:OnMeleeAttack(status, enemy)
	if status == "PostInit" then
		local MeleeBlastDust = EffectData()
		MeleeBlastDust:SetOrigin(self:GetPos())
		MeleeBlastDust:SetScale(50)
		util.Effect("ThumperDust", MeleeBlastDust)

		effects.BeamRingPoint(self:GetPos(), 0.75, 0, 300, 5, 5, Color(127, 0, 0), {material="sprites/physgbeamb", framerate=20})
		effects.BeamRingPoint(self:GetPos(), 0.75, 0, 150, 5, 5, Color(127, 0, 0), {material="sprites/physgbeamb", framerate=20})

		util.ScreenShake(self:GetPos(), 50, 40, 1, 300)

		VJ.EmitSound(self,"weapons/physcannon/energy_sing_explosion2.wav",70,75)
	end
end
--------------------
function ENT:MeleeAttackKnockbackVelocity(hitEnt)
	return self:GetForward() * math.random(450, 550) + self:GetUp() * 300 -- tweak this and do experiments
end
--------------------
function ENT:RangeAttackProjPos(projectile)
	return self:GetAttachment(self:LookupAttachment("headportal")).Pos
end
--------------------
function ENT:RangeAttackProjVel(projectile)
	if IsValid(projectile:GetPhysicsObject()) && projectile:GetPhysicsObject():IsGravityEnabled() && IsValid(self:GetEnemy()) && self:GetPos():Distance(self:GetEnemy():GetPos()) < 300 then
		return VJ.CalculateTrajectory(self, self:GetEnemy(), "Line", projectile:GetPos(), 1, 1000)
	elseif IsValid(projectile:GetPhysicsObject()) && projectile:GetPhysicsObject():IsGravityEnabled() then
		return VJ.CalculateTrajectory(self, self:GetEnemy(), "Curve", projectile:GetPos(), 1, 5)
	end
end
--------------------
function ENT:OnLeapAttack(status, enemy)
	if status == "Init" then
		if !IsValid(self:GetEnemy()) or (!self.VJ_IsBeingControlled && !self:GetEnemy():IsOnGround()) then return end
		-- if !IsValid(self:GetEnemy()) then return end
		-- if !self:GetEnemy():IsOnGround() then return end

		self.BLBOH_Preacher_AOEAttackEnt = ents.Create("prop_dynamic")

		if IsValid(self.BLBOH_Preacher_AOEAttackEnt) then

			self.BLBOH_Preacher_AOEAttackEnt:SetPos(self:GetEnemy():GetPos())
			self.BLBOH_Preacher_AOEAttackEnt:SetModel("models/Gibs/HGIBS.mdl")
			self.BLBOH_Preacher_AOEAttackEnt:Spawn()
			self.BLBOH_Preacher_AOEAttackEnt:SetMoveType(MOVETYPE_NONE)
			self.BLBOH_Preacher_AOEAttackEnt:SetSolid(SOLID_NONE)

			self.BLBOH_Preacher_AOEAttackEnt:SetMaterial("models/debug/debugwhite")
			self.BLBOH_Preacher_AOEAttackEnt:SetRenderFX( 16 )
			self.BLBOH_Preacher_AOEAttackEnt:SetRenderMode( RENDERMODE_TRANSCOLOR )
			self.BLBOH_Preacher_AOEAttackEnt:SetColor(Color(255, 93, 0, 255))

			effects.BeamRingPoint(self.BLBOH_Preacher_AOEAttackEnt:GetPos()+self.BLBOH_Preacher_AOEAttackEnt:GetUp()*5, 0.80, 0, 250, 5, 0, Color(144, 0, 0), {material="sprites/physgbeamb", framerate=20})

			util.ScreenShake(self.BLBOH_Preacher_AOEAttackEnt:GetPos(), 100, 100, 5, 250)

			VJ.EmitSound(self.BLBOH_Preacher_AOEAttackEnt,{"npc/antlion/rumble1.wav"},70,math.random(100,90))

			timer.Simple(0.80,function() if IsValid(self.BLBOH_Preacher_AOEAttackEnt) then

				effects.BeamRingPoint(self.BLBOH_Preacher_AOEAttackEnt:GetPos()+self.BLBOH_Preacher_AOEAttackEnt:GetUp()*5, 0.80, 0, 250, 5, 0, Color(199, 47, 25), {material="sprites/physgbeamb", framerate=20})

			end end)

			timer.Simple(1.60,function() if IsValid(self.BLBOH_Preacher_AOEAttackEnt) then

				effects.BeamRingPoint(self.BLBOH_Preacher_AOEAttackEnt:GetPos()+self.BLBOH_Preacher_AOEAttackEnt:GetUp()*5, 0.80, 0, 250, 5, 0, Color(255, 93, 50), {material="sprites/physgbeamb", framerate=20})

			end end)

			timer.Simple(2.5,function() if IsValid(self.BLBOH_Preacher_AOEAttackEnt) then

				if IsValid(self) && !self.Dead then

					self.BLBOH_Preacher_Burning = true

					util.ScreenShake(self.BLBOH_Preacher_AOEAttackEnt:GetPos(), 175, 200, 5, 500)

					for _, v in ipairs(ents.FindInSphere(self.BLBOH_Preacher_AOEAttackEnt:GetPos(), 100)) do
						if v:IsPlayer() and v:Alive() then -- make this also affect npcs, nextbots, and props
							v:SetLocalVelocity(v:GetVelocity()+Vector(0,0,500))
						end
					end

					ParticleEffectAttach("fire_large_01",PATTACH_POINT_FOLLOW,self.BLBOH_Preacher_AOEAttackEnt,self.BLBOH_Preacher_AOEAttackEnt:LookupAttachment("origin"))
					ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self.BLBOH_Preacher_AOEAttackEnt,self.BLBOH_Preacher_AOEAttackEnt:LookupAttachment("origin"))

					ParticleEffect("strider_impale_ground",self.BLBOH_Preacher_AOEAttackEnt:GetPos(),Angle(0,0,0),nil)
					ParticleEffect("strider_cannon_impact",self.BLBOH_Preacher_AOEAttackEnt:GetPos(),Angle(0,0,0),nil)

					self.BLBOH_Preacher_AOEAttackEnt.FireLight = ents.Create("light_dynamic")
					self.BLBOH_Preacher_AOEAttackEnt.FireLight:SetKeyValue("brightness", "5")
					self.BLBOH_Preacher_AOEAttackEnt.FireLight:SetKeyValue("distance", "300")
					self.BLBOH_Preacher_AOEAttackEnt.FireLight:SetLocalPos(self.BLBOH_Preacher_AOEAttackEnt:GetPos() + self.BLBOH_Preacher_AOEAttackEnt:GetUp()*100)
					self.BLBOH_Preacher_AOEAttackEnt.FireLight:SetLocalAngles(self.BLBOH_Preacher_AOEAttackEnt:GetAngles())
					self.BLBOH_Preacher_AOEAttackEnt.FireLight:Fire("Color", "255 100 0 255")
					self.BLBOH_Preacher_AOEAttackEnt.FireLight:SetParent(self.BLBOH_Preacher_AOEAttackEnt)
					self.BLBOH_Preacher_AOEAttackEnt.FireLight:Spawn()
					self.BLBOH_Preacher_AOEAttackEnt.FireLight:Activate()
					self.BLBOH_Preacher_AOEAttackEnt.FireLight:Fire("TurnOn", "", 0)
					self.BLBOH_Preacher_AOEAttackEnt:DeleteOnRemove(self.BLBOH_Preacher_AOEAttackEnt.FireLight)

					local effectData = EffectData()
					effectData:SetOrigin(self.BLBOH_Preacher_AOEAttackEnt:GetPos())
					effectData:SetScale(250)
					util.Effect("ThumperDust", effectData)

					VJ.EmitSound(self.BLBOH_Preacher_AOEAttackEnt,"ambient/fire/ignite.wav",100,math.random(100,90))
					VJ.EmitSound(self.BLBOH_Preacher_AOEAttackEnt,"ambient/machines/thumper_dust.wav",100,math.random(100,90))
					VJ.EmitSound(self.BLBOH_Preacher_AOEAttackEnt,"vj_blboh/preacher/concrete_break"..math.random(2,3)..".wav",100,math.random(100,90))

					self.BLBOH_Preacher_AOEAttackEnt_FireLoopSound = CreateSound(self.BLBOH_Preacher_AOEAttackEnt,"ambient/fire/fire_big_loop1.wav")
					self.BLBOH_Preacher_AOEAttackEnt_FireLoopSound:SetSoundLevel(80)
					self.BLBOH_Preacher_AOEAttackEnt_FireLoopSound:Play()
					self.BLBOH_Preacher_FireLoopSoundExists = true

					timer.Simple(5,function() if IsValid(self.BLBOH_Preacher_AOEAttackEnt) then

						self.BLBOH_Preacher_Burning = false
						self.BLBOH_Preacher_AOEAttackEnt:StopParticles()
						self.BLBOH_Preacher_AOEAttackEnt_FireLoopSound:Stop()
						self.BLBOH_Preacher_FireLoopSoundExists = false
						VJ.EmitSound(self.BLBOH_Preacher_AOEAttackEnt,"ambient/fire/mtov_flame2.wav",75,math.random(100,90))
						self.BLBOH_Preacher_AOEAttackEnt:Remove()

					end end)

				else

					-- VJ.EmitSound(self.BLBOH_Preacher_AOEAttackEnt,"ambient/fire/mtov_flame2.wav",75,math.random(100,90))
					self.BLBOH_Preacher_AOEAttackEnt:Remove()

				end

			end end)

		end
	elseif status == "Jump" then
		-- return
		-- local ene = self:GetEnemy()
		return ((self:GetEnemy():GetPos() + self:GetEnemy():OBBCenter()) - (self:GetPos() + self:OBBCenter())):GetNormal() * 0 + self:GetForward() * 0 + self:GetUp() * 0
	end

end
--------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
	if status == "Finish" then
		if IsValid(self.BLBOH_Preacher_AOEAttackEnt) then
			self.BLBOH_Preacher_AOEAttackEnt:StopParticles()
			if self.BLBOH_Preacher_FireLoopSoundExists then
				self.BLBOH_Preacher_AOEAttackEnt_FireLoopSound:Stop()
			end
			self.BLBOH_Preacher_AOEAttackEnt:Remove()
		end
		if IsValid(self.BLBOH_Preacher_TeleportSpotEnt) then
			self.BLBOH_Preacher_TeleportSpotEnt:Remove()
		end
		effects.BeamRingPoint(self:GetPos()+self:GetUp()*70+self:GetForward()*10, 0.80, 0, 75, 5, 0, Color(255, 0, 0), {material="sprites/smoke", framerate=20})
		effects.BeamRingPoint(self:GetPos()+self:GetUp()*60+self:GetForward()*10, 0.80, 0, 100, 5, 0, Color(255, 75, 0), {material="sprites/smoke", framerate=20})
		effects.BeamRingPoint(self:GetPos()+self:GetUp()*50+self:GetForward()*10, 0.80, 0, 75, 5, 0, Color(255, 0, 0), {material="sprites/smoke", framerate=20})
		
		-- local effectData = EffectData()
		-- effectData:SetOrigin(self:GetPos()+self:GetUp()*50)
		-- effectData:SetScale(200)
		-- effectData:SetColor(VJ_Color2Byte(Color(0,0,0,255)))
		-- util.Effect("VJ_Dust_Small", effectData)
		local effectData = EffectData()
		effectData:SetOrigin(self:GetAttachment(self:LookupAttachment("headportal")).Pos)
		effectData:SetScale(75)
		effectData:SetColor(VJ_Color2Byte(Color(175,0,0,255)))
		util.Effect("VJ_Blood1", effectData)
		effectData:SetScale(35)
		effectData:SetColor(VJ_Color2Byte(Color(175,75,0,255)))
		util.Effect("VJ_Blood1", effectData)

		VJ.EmitSound(self,{"ambient/levels/labs/teleport_postblast_thunder1.wav"},100,math.random(125,70))
	end
end
--------------------
function ENT:CustomOnRemove()
	if IsValid(self.BLBOH_Preacher_AOEAttackEnt) then
		self.BLBOH_Preacher_AOEAttackEnt:StopParticles()
		if self.BLBOH_Preacher_FireLoopSoundExists then
			self.BLBOH_Preacher_AOEAttackEnt_FireLoopSound:Stop()
		end
		VJ.EmitSound(self.BLBOH_Preacher_AOEAttackEnt,"ambient/fire/mtov_flame2.wav",75,math.random(100,90))
		self.BLBOH_Preacher_AOEAttackEnt:Remove()
	end
	if IsValid(self.BLBOH_Preacher_TeleportSpotEnt) then
		self.BLBOH_Preacher_TeleportSpotEnt:Remove()
	end
end
--------------------
function ENT:Controller_Initialize(ply, controlEnt)
	ply:ChatPrint("JUMP: Fire Burst")
	ply:ChatPrint("Creates a temporary patch of fire where you're aiming.")
	ply:ChatPrint("RELOAD: Teleport")
	ply:ChatPrint("Teleport has a cooldown of 15 seconds.")
end
--------------------