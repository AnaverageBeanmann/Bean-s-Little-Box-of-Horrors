AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = "models/vj_blboh/cultist.mdl"
ENT.StartHealth = 100
ENT.ControllerParams = {
	CameraMode = 1,
	ThirdP_Offset = Vector(60, 0, -50),
}
--------------------
ENT.SightAngle = 126
--------------------
ENT.VJ_NPC_Class = {"CLASS_BLBOH"}
--------------------
ENT.BloodColor = VJ.BLOOD_COLOR_RED
--------------------
ENT.MeleeAttackDistance = 35
ENT.MeleeAttackDamageDistance = 60
ENT.TimeUntilMeleeAttackDamage = false
ENT.MeleeAttackBleedEnemy = true
ENT.MeleeAttackBleedEnemyDamage = 1
ENT.MeleeAttackBleedEnemyTime = 0.5
ENT.MeleeAttackBleedEnemyReps = 8
--------------------
ENT.HasRangeAttack = true
-- ENT.RangeAttackEntityToSpawn = "obj_vj_rocket"
ENT.RangeAttackEntityToSpawn = "obj_vj_blboh_cultist_knife_projectile"
ENT.RangeAttackMaxDistance = 350
ENT.RangeAttackMinDistance = 100
ENT.TimeUntilRangeAttackProjectileRelease = false
ENT.NextRangeAttackTime = VJ.SET(3,10)
--------------------
ENT.DisableFootStepSoundTimer = true
ENT.SoundTbl_FootStep = {
	"npc/fast_zombie/foot1.wav",
	"npc/fast_zombie/foot2.wav",
	"npc/fast_zombie/foot3.wav",
	"npc/fast_zombie/foot4.wav"
}
ENT.SoundTbl_Alert = {
	"vj_blboh/cultist/burn_in_hell.mp3",
	"vj_blboh/cultist/destroy_the_child.mp3",
	"vj_blboh/cultist/reap_what_you_sow.mp3",
	"vj_blboh/cultist/swear_by_his_throne.mp3",
	"vj_blboh/cultist/thy_faith_is_weak.mp3",
	"vj_blboh/cultist/we_know_what_you_did.mp3"
}
ENT.SoundTbl_MeleeAttackMiss = {
	"vj_blboh/cultist/knife_slash1.wav",
	"vj_blboh/cultist/knife_slash2.wav"
}
ENT.SoundTbl_BurnScreams = {
	"vj_blboh/cultist/burn_1.mp3",
	"vj_blboh/cultist/burn_2.mp3",
	"vj_blboh/cultist/burn_3.mp3",
	"vj_blboh/cultist/burn_4.mp3"
}
ENT.SoundTbl_Death = "vj_blboh/cultist/death.mp3"
ENT.MainSoundPitch = 100
ENT.DeathSoundPitch = VJ.SET(90,110)
--------------------
ENT.BLBOH_DoSpawnSequence = false
ENT.BLBOH_CanDoSpawnSequence = true
ENT.BLBOH_SpawnLightLevel = "0"
ENT.BLBOH_SpawnLightBoom = false
ENT.BLBOH_SpawnLightFadeStage = 0
ENT.BLBOH_Cultist_Sprinting = false
ENT.BLBOH_Cultist_LongThrows = false
ENT.BLBOH_Cultist_Burning = false
ENT.BLBOH_Cultist_Burning_ScreamTime = 0 -- i'm still annoyed over NextSoundTime_Pain being removed
ENT.BLBOH_Cultist_ThrowToggleCooldown = CurTime()
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

			self.CultistKnifeModel = ents.Create("prop_physics")	
			self.CultistKnifeModel:SetModel("models/vj_blboh/cultist_knife.mdl")
			self.CultistKnifeModel:SetLocalPos(self:GetPos())
			self.CultistKnifeModel:SetLocalAngles(self:GetAngles())			
			self.CultistKnifeModel:SetOwner(self)
			self.CultistKnifeModel:SetParent(self)
			self.CultistKnifeModel:Fire("SetParentAttachmentMaintainOffset","anim_attachment_LH")
			self.CultistKnifeModel:Fire("SetParentAttachment","anim_attachment_RH")
			self.CultistKnifeModel:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
			self.CultistKnifeModel:Spawn()
			self.CultistKnifeModel:Activate()
			self.CultistKnifeModel:SetSolid(SOLID_NONE)
			self.CultistKnifeModel:AddEffects(EF_BONEMERGE)

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

		self.CultistKnifeModel = ents.Create("prop_physics")	
		self.CultistKnifeModel:SetModel("models/vj_blboh/cultist_knife.mdl")
		self.CultistKnifeModel:SetLocalPos(self:GetPos())
		self.CultistKnifeModel:SetLocalAngles(self:GetAngles())			
		self.CultistKnifeModel:SetOwner(self)
		self.CultistKnifeModel:SetParent(self)
		self.CultistKnifeModel:Fire("SetParentAttachmentMaintainOffset","anim_attachment_LH")
		self.CultistKnifeModel:Fire("SetParentAttachment","anim_attachment_RH")
		self.CultistKnifeModel:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
		self.CultistKnifeModel:Spawn()
		self.CultistKnifeModel:Activate()
		self.CultistKnifeModel:SetSolid(SOLID_NONE)
		self.CultistKnifeModel:AddEffects(EF_BONEMERGE)

	end

end
--------------------
function ENT:OnThink()

	-- see if we can turn this into an elseif
	if !self.AttackType then
		if !self:IsOnFire() && self.BLBOH_Cultist_Burning then
			self.BLBOH_Cultist_Burning = false
			self.Behavior = VJ_BEHAVIOR_AGGRESSIVE
			self.EnemyDetection = true
			self.CanReceiveOrders = true
			self:CapabilitiesAdd(CAP_MOVE_JUMP)
			self:CapabilitiesAdd(CAP_MOVE_CLIMB)
			self.HasAlertSounds = true
			self:StopMoving(false)
		elseif self:IsOnFire() && !self.BLBOH_Cultist_Burning then
			self.BLBOH_Cultist_Burning = true
			self.Behavior = VJ_BEHAVIOR_PASSIVE
			self.EnemyDetection = false
			self.CanReceiveOrders = false
			self:CapabilitiesRemove(CAP_MOVE_JUMP)
			self:CapabilitiesRemove(CAP_MOVE_CLIMB)
			self.HasAlertSounds = false
		end
	end

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

	-- PrintMessage(4,""..self:GetSequence().."")
	-- if self.BLBOH_Cultist_LongThrows then
		-- PrintMessage(4,"Long Throws: Enabled")
	-- else
		-- PrintMessage(4,"Long Throws: Disabled")
	-- end

	-- if self.BLBOH_Cultist_Burning then
		-- PrintMessage(4,"We're on fire!")
	-- else
		-- PrintMessage(4,"We're NOT on fire!")
	-- end

	if self:GetEnemy() == nil && self.BLBOH_Cultist_LongThrows && !self.AttackType then
		self.BLBOH_Cultist_LongThrows = false
		self.AnimTbl_RangeAttack = ACT_RANGE_ATTACK1
		self.RangeAttackMaxDistance  = 350
	end

	if self:GetEnemy() == nil then return end

	if self.VJ_IsBeingControlled then
		if self.VJ_TheController:KeyDown(IN_RELOAD) && !self.BLBOH_Cultist_LongThrows && !self.AttackType && self.BLBOH_Cultist_ThrowToggleCooldown < CurTime() then -- can't reach our enemy, start throwing knives from farther away
			self.BLBOH_Cultist_LongThrows = true
			self.AnimTbl_RangeAttack = ACT_RANGE_ATTACK2
			self.RangeAttackMaxDistance  = 1500
			self.BLBOH_Cultist_ThrowToggleCooldown = CurTime() + 1
			self.VJ_TheController:ChatPrint("Using Long Throws.")
			self.VJ_TheController:SendLua("surface.PlaySound('ui/buttonrollover.wav')")
		elseif self.VJ_TheController:KeyDown(IN_RELOAD) && self.BLBOH_Cultist_LongThrows && !self.AttackType && self.BLBOH_Cultist_ThrowToggleCooldown < CurTime() then
			self.BLBOH_Cultist_LongThrows = false
			self.AnimTbl_RangeAttack = ACT_RANGE_ATTACK1
			self.RangeAttackMaxDistance  = 350
			self.BLBOH_Cultist_ThrowToggleCooldown = CurTime() + 1
			self.VJ_TheController:ChatPrint("Using Short Throws.")
			self.VJ_TheController:SendLua("surface.PlaySound('ui/buttonrollover.wav')")
		end
	else
		if self:IsUnreachable(self:GetEnemy()) && !self.BLBOH_Cultist_LongThrows && !self.AttackType then -- can't reach our enemy, start throwing knives from farther away
			self.BLBOH_Cultist_LongThrows = true
			self.AnimTbl_RangeAttack = ACT_RANGE_ATTACK2
			self.RangeAttackMaxDistance  = 1500
		elseif !self:IsUnreachable(self:GetEnemy()) && self.BLBOH_Cultist_LongThrows && !self.AttackType then
			self.BLBOH_Cultist_LongThrows = false
			self.AnimTbl_RangeAttack = ACT_RANGE_ATTACK1
			self.RangeAttackMaxDistance  = 350
		end
	end


	-- see about making it work like this
		-- enemy is too far for too long, cultist starts sprinting
		-- cultist keeps sprinting until it's close enough, then starts running
	if !self.BLBOH_Cultist_Sprinting && self:GetPos():Distance(self:GetEnemy():GetPos()) >= 300 then -- enemy is too far, start sprinting
		self.BLBOH_Cultist_Sprinting = true
	elseif self.BLBOH_Cultist_Sprinting && self:GetPos():Distance(self:GetEnemy():GetPos()) < 300 then -- go back to running since we're close enough
		self.BLBOH_Cultist_Sprinting = false
	end

end
--------------------
function ENT:OnInput(key, activator, caller, data)
	if key == "step" then
		VJ.EmitSound(self,self.SoundTbl_FootStep,self.FootstepSoundLevel)
		-- self:PlayFootstepSound(customSD) -- see if this works
		-- self:PlayFootstepSound() -- why is it like this again?
	elseif key == "attack" then
		if self:GetSequence() == 20 then -- stab
			self.MeleeAttackDamage = 15
			self.MeleeAttackBleedEnemyChance = 1
			self.SoundTbl_MeleeAttack = {"vj_blboh/cultist/knife_stab.wav"}
		else -- slash
			self.MeleeAttackDamage = 10
			self.MeleeAttackBleedEnemyChance = 3
			self.SoundTbl_MeleeAttack = {
				"vj_blboh/cultist/knife_hit1.wav",
				"vj_blboh/cultist/knife_hit2.wav",
				"vj_blboh/cultist/knife_hit3.wav",
				"vj_blboh/cultist/knife_hit4.wav"
			}
		end
		self:ExecuteMeleeAttack(isPropAttack)
	elseif key == "throw_left" then
		self:ExecuteRangeAttack()
		if IsValid(self.CultistThrowingKnifeModel) then
			self.CultistThrowingKnifeModel:Remove()
		end
	elseif key == "throw_right" then
		self:ExecuteRangeAttack()
		if IsValid(self.CultistKnifeModel) then
			self.CultistKnifeModel:Remove()
		end
	elseif key == "pull_knife_left" then
		VJ.EmitSound(self,{"weapons/knife/knife_deploy1.wav"},70,math.random(97,103))
		self.CultistThrowingKnifeModel = ents.Create("prop_physics")	
		self.CultistThrowingKnifeModel:SetModel("models/vj_blboh/cultist_knife_left.mdl")
		self.CultistThrowingKnifeModel:SetLocalPos(self:GetPos())
		self.CultistThrowingKnifeModel:SetLocalAngles(self:GetAngles())			
		self.CultistThrowingKnifeModel:SetOwner(self)
		self.CultistThrowingKnifeModel:SetParent(self)
		self.CultistThrowingKnifeModel:Fire("SetParentAttachmentMaintainOffset","anim_attachment_RH")
		self.CultistThrowingKnifeModel:Fire("SetParentAttachment","anim_attachment_LH")
		self.CultistThrowingKnifeModel:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
		self.CultistThrowingKnifeModel:Spawn()
		self.CultistThrowingKnifeModel:Activate()
		self.CultistThrowingKnifeModel:SetSolid(SOLID_NONE)
		-- self.CultistThrowingKnifeModel:AddEffects(EF_BONEMERGE)
	elseif key == "pull_knife_right" then
		VJ.EmitSound(self,{"weapons/knife/knife_deploy1.wav"},80,100)
		self.CultistKnifeModel = ents.Create("prop_physics")	
		self.CultistKnifeModel:SetModel("models/vj_blboh/cultist_knife.mdl")
		self.CultistKnifeModel:SetLocalPos(self:GetPos())
		self.CultistKnifeModel:SetLocalAngles(self:GetAngles())			
		self.CultistKnifeModel:SetOwner(self)
		self.CultistKnifeModel:SetParent(self)
		self.CultistKnifeModel:Fire("SetParentAttachmentMaintainOffset","anim_attachment_LH")
		self.CultistKnifeModel:Fire("SetParentAttachment","anim_attachment_RH")
		self.CultistKnifeModel:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
		self.CultistKnifeModel:Spawn()
		self.CultistKnifeModel:Activate()
		self.CultistKnifeModel:SetSolid(SOLID_NONE)
		self.CultistKnifeModel:AddEffects(EF_BONEMERGE)
	end
end
--------------------
function ENT:OnRangeAttack(status, enemy)
	if status == "PreInit" && !self:OnGround() then
		return true -- no throwing knives in the air in the halls
	end
end
--------------------
function ENT:OnRangeAttackExecute(status, enemy, projectile)
	if status == "PreSpawn" && self.BLBOH_Cultist_LongThrows then
		projectile.BLBOH_LongRangedKnife = true
	end
end
--------------------
function ENT:RangeAttackProjPos(projectile)
	if self.BLBOH_Cultist_LongThrows then
		return self:GetPos() + self:GetUp() * 80 + self:GetForward() * -10 + self:GetRight() * 10
	else
		return self:GetPos() + self:GetUp() * 40 + self:GetRight() * -5
	end
end
--------------------
function ENT:RangeAttackProjVel(projectile)

	-- return (self:GetEnemy():GetPos() - self:GetPos()) * 2.5 + self:GetUp() * math.random(100,150) + self:GetRight() * math.random(-0,0) + (self:GetEnemy():GetVelocity() * 1)

	-- reduce the amount of prediction on this
	-- local phys = projectile:GetPhysicsObject()
	-- if IsValid(phys) && phys:IsGravityEnabled() then
		-- return VJ.CalculateTrajectory(self, self:GetEnemy(), "Line", projectile:GetPos(), 0.5, 1000)
		if self.BLBOH_Cultist_LongThrows then
			return VJ.CalculateTrajectory(self, self:GetEnemy(), "Curve", projectile:GetPos(), 0.2, 0)
		else
			return VJ.CalculateTrajectory(self, self:GetEnemy(), "Line", projectile:GetPos(), 0.65, 1000)
		end
	-- end

end
--------------------
function ENT:OnDamaged(dmginfo, hitgroup, status)
	if status == "PreDamage" then
		if self.BLBOH_Cultist_Burning && self.BLBOH_Cultist_Burning_ScreamTime < CurTime() then
			self.BLBOH_Cultist_Burning_ScreamTime = CurTime() + math.random(2,3)
			self.CurrentFireScreamSound = VJ.CreateSound(self,self.SoundTbl_BurnScreams,85)
		end
		if (dmginfo:GetDamageType() == DMG_BURN || dmginfo:GetDamageType() == DMG_SLOWBURN) && !self.BLBOH_Cultist_Burning then
			self:Ignite(60,0)
		end
		-- see if we can merge these into an elseif
		if dmginfo:GetInflictor():GetClass() == "entityflame" && dmginfo:GetAttacker():GetClass() == "entityflame" then
			dmginfo:ScaleDamage(2)
		end
	end
end
--------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
	if status == "Init" && self.BLBOH_Cultist_Burning then
		VJ.STOPSOUND(self.CurrentFireScreamSound)
		self.SoundTbl_Death = "vj_blboh/cultist/death_burned.mp3"
	end
	-- see if we can merge these into an elseif
	if status == "Finish" then
		-- self:SetBodygroup(1,1)
		-- self:SetBodygroup(2,1)
		if IsValid(self.CultistKnifeModel) then
			self:CreateGibEntity("prop_physics",self.CultistKnifeModel:GetModel(),{Pos=self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos,Ang=self:GetAngles()})
		end
		if IsValid(self.CultistThrowingKnifeModel) then
			self:CreateGibEntity("prop_physics",self.CultistKnifeModel:GetModel(),{Pos=self:GetAttachment(self:LookupAttachment("anim_attachment_LH")).Pos,Ang=self:GetAngles()})
		end
	end
end
--------------------
function ENT:Controller_Initialize(ply, controlEnt)
	ply:ChatPrint("RELOAD: Toggle Throw Type")
end
--------------------
function ENT:TranslateActivity(act)
	if self.BLBOH_Cultist_Burning then
		if act == ACT_IDLE then
			return ACT_IDLE_ON_FIRE
		elseif act == ACT_WALK then
			return ACT_WALK_ON_FIRE
		elseif act == ACT_RUN then
			return ACT_RUN_ON_FIRE
		end
	end
	-- see if this can be merged into an elseif
	if act == ACT_RUN && self.BLBOH_Cultist_Sprinting then
		return ACT_SPRINT
	end
	return act
end