AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = {"models/vj_blboh/leonard.mdl"}
ENT.StartHealth = 3000
--------------------
ENT.VJ_NPC_Class = {"CLASS_DEMON"}
--------------------
ENT.BloodColor = "Red"
--------------------
ENT.MeleeAttackDamage = 75
ENT.MeleeAttackDamageType = DMG_CRUSH
-- ENT.AnimTbl_MeleeAttack = {"vjseq_attack"}
ENT.MeleeAttackAnimationFaceEnemy = false
ENT.MeleeAttackDistance = 75
ENT.MeleeAttackDamageDistance = 110
ENT.TimeUntilMeleeAttackDamage = false
--------------------
ENT.HasRangeAttack = true
-- ENT.AnimTbl_RangeAttack = {"vjseq_attack_range"}
ENT.RangeAttackAnimationFaceEnemy = false
ENT.RangeDistance = 1000
ENT.RangeToMeleeDistance = 200
ENT.TimeUntilRangeAttackProjectileRelease = false
ENT.NextRangeAttackTime = 10
ENT.NextRangeAttackTime_DoRand = 20
ENT.DisableDefaultRangeAttackCode  = true
--------------------
ENT.DisableFootStepSoundTimer = true
ENT.HasExtraMeleeAttackSounds = true
ENT.SoundTbl_FootStep = {
	"vj_blboh/leonard/step_1.mp3",
	"vj_blboh/leonard/step_2.mp3",
	"vj_blboh/leonard/step_3.mp3",
	"vj_blboh/leonard/step_4.mp3",
	"vj_blboh/leonard/step_5.mp3",
	"vj_blboh/leonard/step_6.mp3"
}
ENT.SoundTbl_Idle = {
	"vj_blboh/leonard/idle1.mp3",
	"vj_blboh/leonard/idle2.mp3"
}
ENT.SoundTbl_Alert = {
	"vj_blboh/leonard/alert1.mp3",
	"vj_blboh/leonard/alert2.mp3",
	"vj_blboh/leonard/alert3.mp3"
}
ENT.SoundTbl_MeleeAttack = {
	"vj_blboh/leonard/impact1.mp3",
	"vj_blboh/leonard/impact2.mp3"
}
ENT.SoundTbl_MeleeAttackExtra = {
	"vj_blboh/leonard/concrete_break2.wav",
	"vj_blboh/leonard/concrete_break3.wav"
}
ENT.SoundTbl_MeleeAttackMiss = {
	"vj_blboh/leonard/impact1.mp3",
	"vj_blboh/leonard/impact2.mp3"
}
ENT.SoundTbl_BeforeRangeAttack = {
	"vj_blboh/leonard/alert1.mp3",
	"vj_blboh/leonard/alert2.mp3",
	"vj_blboh/leonard/alert3.mp3"
}
ENT.FootStepSoundLevel = 80
ENT.AlertSoundLevel = 100
ENT.IdleSoundLevel = 80
ENT.ExtraMeleeAttackSoundLevel = 80
ENT.MeleeAttackMissSoundLevel = 80
ENT.BeforeRangeAttackSoundLevel = 80
ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
--------------------
ENT.BHLCIE_Follower_CurrentMode = 0
/*
0 - Attack Mode
1 - Hiding
*/
ENT.BHLCIE_Follower_HideTime = 0
ENT.BHLCIE_Follower_UnCloaking = false
ENT.BHLCIE_Follower_Cloaking = false
ENT.BHLCIE_Follower_CloakLevel = 256
ENT.BHLCIE_Follower_ResetCloak = false
ENT.BHLCIE_Follower_Smoking = false
ENT.BHLCIE_Follower_SmokeTime = 0
ENT.BHLCIE_Follower_RangeLocation = nil
ENT.LNR_DoorToBreak = nil
ENT.BLBOH_Follower_Spawning = true

ENT.BLBOH_Follower_IsHidden = true
ENT.BLBOH_Leonard_Sprint = false
ENT.BLBOH_Leonard_Killable = false
ENT.BLBOH_Leonard_Killable_FleesLeft = 2
--------------------
function ENT:PreInit()
end
--------------------
function ENT:Init()
	self.DisableFindEnemy = true
	self.CanInvestigate = false
	self.GodMode = true
	-- self.MovementType = VJ_MOVETYPE_STATIONARY
	self.CanTurnWhileStationary = false
	self:SetMaterial("hud/killicons/default")
	self:DrawShadow(false)
	self.HasSounds = false
	timer.Simple(0.1,function() if IsValid(self) then
			self:VJ_ACT_PLAYACTIVITY({"vjseq_extra"},"LetAttacks",5,false) -- rename this function and all other instances of it to PlayAnim
	end end)
	-- if GetConVar("vj_BLBOH_Leonard_Killable"):GetInt() == 1 then
		-- self.BLBOH_Leonard_Killable = true
	-- end
	-- self.BLBOH_Leonard_Killable_FleesLeft = GetConVar("vj_BLBOH_Leonard_Killable_timesneedtofendoff"):GetInt()
	if GetConVar("gamemode"):GetString() == "horde" then -- make sure he's killable in horde
		self.BLBOH_Leonard_Killable = true
		self.BLBOH_Leonard_Killable_FleesLeft = 0
	end
end
--------------------
function ENT:BLBOH_Leonard_SpawnFog()
	local bloodeffect = EffectData()
	bloodeffect:SetOrigin(self:GetPos() + self:GetUp()*55 + self:GetForward()*25)
	bloodeffect:SetColor(VJ_Color2Byte(Color(50,0,0,255)))
	bloodeffect:SetScale(150)
	util.Effect("VJ_Blood1",bloodeffect)
	bloodeffect:SetOrigin(self:GetPos() + self:GetUp()*55 + self:GetForward()*-25)
	util.Effect("VJ_Blood1",bloodeffect)
	bloodeffect:SetOrigin(self:GetPos() + self:GetUp()*55 + self:GetRight()*25)
	util.Effect("VJ_Blood1",bloodeffect)
	bloodeffect:SetOrigin(self:GetPos() + self:GetUp()*55 + self:GetRight()*-25)
	util.Effect("VJ_Blood1",bloodeffect)
end
--------------------
function ENT:BLBOH_Leonard_Hide()
	self.BLBOH_Follower_IsHidden = true
	self.BHLCIE_Follower_HideTime = CurTime() + math.random(5,10)
	self.BHLCIE_Follower_CurrentMode = 1
	self:SetHealth(self.StartHealth)
	timer.Simple(0.15, function() if IsValid(self) then
		self:SetHealth(self.StartHealth)
	end end)
	self.DisableFindEnemy = true
	self.CanInvestigate = true
	self.GodMode = false
	self:AddFlags(FL_NOTARGET)
	self.HasMeleeAttack = false
	self.HasRangeAttack = false
	self:BLBOH_Leonard_SpawnFog()
	self:SetMaterial("hud/killicons/default")
	self:DrawShadow(false)
	self.HasSounds = false
	VJ.EmitSound(self,"vj_blboh/preacher/fireball.ogg",70,35)
end
--------------------
function ENT:BLBOH_Leonard_StopHiding()
	self.BLBOH_Follower_IsHidden = false
	self.BHLCIE_Follower_CurrentMode = 0
	self:RemoveFlags(FL_NOTARGET)
	self:BLBOH_Leonard_SpawnFog()
	timer.Simple(0.15, function() if IsValid(self) then
		self:SetMaterial("")
		self:DrawShadow(true)
	end end)
	self.HasSounds = true
	VJ.EmitSound(self,"vj_blboh/preacher/fireball.ogg",70,50)
	VJ.EmitSound(self,"vj_blboh/leonard/idle"..math.random(1,2)..".mp3",80,100)
	timer.Simple(4,function() if IsValid(self) then
		self.DisableFindEnemy = false
		self.CanInvestigate = true
		self.GodMode = false
		self.HasMeleeAttack = true
		self.HasRangeAttack = true
	end end)
end
--------------------
function ENT:OnInput(key, activator, caller, data)
	if key == "step" then
		if self.BHLCIE_Follower_CurrentMode == 0 then
			VJ.EmitSound(self,self.SoundTbl_FootStep,self.FootStepSoundLevel)
			util.ScreenShake(self:GetPos(), 1, 5, 1, 350)
		end
	end
	if key == "attack" then
		self:MeleeAttackCode()
		if IsValid(self.LNR_DoorToBreak) then
			local doorDmg = self.MeleeAttackDamage
			local door = self.LNR_DoorToBreak
			if door.DoorHealth == nil then
				door.DoorHealth = 1 - doorDmg
			elseif door.DoorHealth <= 0 then
				-- VJ_EmitSound(self,self.SoundTbl_MeleeAttackMiss,self.MeleeAttackMissSoundLevel,self:VJ_DecideSoundPitch(self.MeleeAttackMissSoundPitch.a,self.MeleeAttackMissSoundPitch.b))
			return -- To prevent door props making a duplication when it shouldn't
			else
				door.DoorHealth = door.DoorHealth - 100
			end
			if
				door:GetClass() == "prop_door_rotating" or
				door:GetClass() == "func_door_rotating" or
				door:GetClass() == "prop_door_dynamic"
			then
				door:EmitSound("ambient/materials/door_hit1.wav",75,100)
				ParticleEffect("door_pound_core",door:GetPos(),door:GetAngles(),nil)
				if door:GetClass() == "prop_door_rotating" then
					local doorgib = ents.Create("prop_physics")
					doorgib:SetPos(door:GetPos())
					doorgib:SetAngles(door:GetAngles())
					doorgib:SetModel(door:GetModel())
					doorgib:SetSkin(door:GetSkin())
					doorgib:SetBodygroup(1,door:GetBodygroup(1))
					doorgib:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
					doorgib:SetSolid(SOLID_NONE)
					doorgib:Spawn()
					doorgib:GetPhysicsObject():ApplyForceCenter(self:GetForward()*15000)
					SafeRemoveEntityDelayed(doorgib,30)
					door:Remove()
				end
				if door:GetClass() == "func_door_rotating" then
					local doorgibs = ents.Create("prop_dynamic")
					doorgibs:SetPos(door:GetPos())
					doorgibs:SetModel("models/props_c17/FurnitureDresser001a.mdl")
					doorgibs:Spawn()
					doorgibs:TakeDamage(9999)
					doorgibs:Fire("break")		
					door:Remove()
				end
			end
		end
	end
	if key == "attack_shockwave" then
		local pos = self:LocalToWorld(Vector(70,4,0))
		VJ.ApplyRadiusDamage(self, self, pos, 100, 20, DMG_CRUSH, true, true, {DisableVisibilityCheck=true, Force=8110})
		util.ScreenShake(self:GetPos(), 100, 200, 3, 500)
		for _, v in ipairs(ents.FindInSphere(pos, 100)) do
			if v:IsPlayer() and v:Alive() then
				v:SetLocalVelocity(v:GetVelocity()+Vector(0,0,350))
			end
		end
		ParticleEffect("strider_impale_ground",pos,Angle(0,0,0),nil)
		ParticleEffect("strider_cannon_impact",pos,Angle(0,0,0),nil)
		VJ.EmitSound(self,{"ambient/machines/thumper_dust.wav"},100,math.random(100,90))
		local effectData = EffectData()
		-- effectData:SetOrigin(self:GetPos()+self:GetForward()*90+self:GetRight()*8)
		effectData:SetOrigin(pos)
		effectData:SetScale(200)
		util.Effect("ThumperDust", effectData)
		effects.BeamRingPoint(pos, 0.80, 0, 200, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
		if IsValid(self.dummyEnt) then
			VJ.ApplyRadiusDamage(self, self, self.dummyEnt:GetPos(), 175, 40, DMG_CRUSH, true, true, {DisableVisibilityCheck=true, Force=8110, UpForce=8110})
			util.ScreenShake(self.dummyEnt:GetPos(), 175, 200, 3, 500)
			for _, v in ipairs(ents.FindInSphere(self.dummyEnt:GetPos(), 175)) do
				if v:IsPlayer() and v:Alive() then
					v:SetLocalVelocity(v:GetVelocity()+Vector(0,0,500))
				end
			end
			ParticleEffect("strider_impale_ground",self.dummyEnt:GetPos(),Angle(0,0,0),nil)
			ParticleEffect("strider_cannon_impact",self.dummyEnt:GetPos(),Angle(0,0,0),nil)
			VJ.EmitSound(self.dummyEnt,{"ambient/machines/thumper_dust.wav"},100,math.random(100,90))
			VJ.EmitSound(self.dummyEnt,{"vj_blboh/leonard/concrete_break"..math.random(2,3)..".wav"},100,math.random(100,90))
			local effectData = EffectData()
			effectData:SetOrigin(self.dummyEnt:GetPos())
			effectData:SetScale(250)
			util.Effect("ThumperDust", effectData)
			self.dummyEnt:Remove()
		end
	end
	if key == "follower_raise" then
		VJ.EmitSound(self,"vj_blboh/leonard/raiseweapon"..math.random(1,4)..".mp3",75)
	end
	if key == "follower_woosh" then
		VJ.EmitSound(self,"vj_blboh/leonard/swing"..math.random(1,4)..".mp3",75)
	end
	if key == "follower_requip" then
		VJ.EmitSound(self,"vj_blboh/leonard/lowerweapon"..math.random(1,4)..".mp3",75)
	end
	if key == "follower_rumble" then
	end
	if key == "whoosh" then
		VJ.EmitSound(self,"physics/nearmiss/whoosh_huge2.wav",75)
	end
	if key == "follower_shhh" then
		if self.BLBOH_Follower_IsHidden then
			self:BLBOH_Leonard_StopHiding()
			return
		end
		if !self.BLBOH_Follower_IsHidden then
			self:BLBOH_Leonard_Hide()
			return
		end
		
		-- if self.BLBOH_Follower_Spawning then
			-- VJ.EmitSound(self,"vj_blboh/preacher/fireball.ogg",70,50)
			-- self.BLBOH_Follower_Spawning = false
			-- self:SetColor(Color(255, 255, 255, 0))
			-- self:BLBOH_Leonard_SpawnFog()
			-- timer.Simple(0.1,function() if IsValid(self) then
				-- self.BHLCIE_Follower_UnCloaking = true
			-- end end)
			-- timer.Simple(5,function() if IsValid(self) then
				-- self.DisableFindEnemy = false
				-- self.CanInvestigate = true
				-- self.GodMode = false
				-- self.MovementType = VJ_MOVETYPE_GROUND
				-- self.CanTurnWhileStationary = true
			-- end end)
			-- VJ.EmitSound(self,"vj_blboh/leonard/idle"..math.random(1,2)..".mp3",80,100)
		-- end
		-- if self.BHLCIE_Follower_Cloaking then
			-- self:BLBOH_Leonard_SpawnFog()
			-- VJ.EmitSound(self,"vj_blboh/preacher/fireball.ogg",70,30)

			-- timer.Simple(5,function() if IsValid(self) then
				-- self.DisableFindEnemy = false
				-- self.CanInvestigate = true
				-- self.GodMode = false
				-- self.MovementType = VJ_MOVETYPE_GROUND
				-- self.CanTurnWhileStationary = true
			-- end end)
			-- self.BHLCIE_Follower_ResetCloak = false
			-- self:DrawShadow(false)
			-- self:SetSolid(SOLID_NONE)
			-- self.HasMeleeAttack = false
			-- self.HasRangeAttack = false
			-- self.HasSounds = false
			-- self.Behavior = VJ_BEHAVIOR_PASSIVE
			-- self:AddFlags(FL_NOTARGET)
			-- self:SetHealth(self.StartHealth)
			-- self.GodMode = true
			-- timer.Simple(0.1, function() if IsValid(self) then
				-- self:SetColor(Color(255, 255, 255, 1))
			-- end end)
			-- timer.Simple(0.15, function() if IsValid(self) then
				-- self:SetHealth(self.StartHealth)
			-- end end)
			-- timer.Simple(5,function() if IsValid(self) then
				-- self.BHLCIE_Follower_HideTime = CurTime() + math.random(5,10)
				-- self.BHLCIE_Follower_CurrentMode = 1
			-- end end)
		-- end
		-- if self.BHLCIE_Follower_UnCloaking then
		-- VJ.EmitSound(self,"vo/k_lab/kl_ahhhh.wav",0,100)
			-- self:BLBOH_Leonard_SpawnFog()
		-- end
	end
end
--------------------
function ENT:TranslateActivity(act)
	-- have him sprint when you're too far and run when you're close enough
	-- if act == ACT_IDLE then
		-- return ACT_IDLE_ON_FIRE
	-- end
	-- if act == ACT_WALK || act == ACT_RUN then
		-- return ACT_WALK_ON_FIRE
	-- end
	if act == ACT_RUN && self.BLBOH_Leonard_Sprint then
		return ACT_SPRINT
	end
	return act
end
--------------------
function ENT:OnThink()

	-- make it so he sprints if you're close enough
	-- also make it so he can't do range attacks on non-grounded enemies

	-- if self.BHLCIE_Follower_UnCloaking == true then
		-- if !self.BHLCIE_Follower_ResetCloak then
			-- self.BHLCIE_Follower_ResetCloak = true
			-- self.BHLCIE_Follower_CloakLevel = 0
			-- self:SetRenderMode( RENDERMODE_TRANSCOLOR )
			-- self:SetMaterial("")
		-- end
		-- self.BHLCIE_Follower_CloakLevel = self.BHLCIE_Follower_CloakLevel + 50
		-- self:SetColor(Color(255, 255, 255, self.BHLCIE_Follower_CloakLevel))
		-- if self.BHLCIE_Follower_CloakLevel >= 255 then
			-- self.BHLCIE_Follower_UnCloaking = false
			-- self:SetColor(Color(255, 255, 255, 255))
			-- self:DrawShadow(true)
			-- self.HasSounds = true
			-- self:SetSolid(SOLID_BBOX)
		-- end
	-- end

	-- if self.BHLCIE_Follower_Cloaking == true then
		-- if !self.BHLCIE_Follower_ResetCloak then
			-- self.BHLCIE_Follower_ResetCloak = true
			-- self.BHLCIE_Follower_CloakLevel = 255
			-- self:SetRenderMode( RENDERMODE_TRANSCOLOR )
		-- end
		-- self.BHLCIE_Follower_CloakLevel = self.BHLCIE_Follower_CloakLevel - 5
		-- self:SetColor(Color(255, 255, 255, self.BHLCIE_Follower_CloakLevel))
		-- if self.BHLCIE_Follower_CloakLevel <= 0 then
			-- self.BHLCIE_Follower_Cloaking = false
			-- self:SetColor(Color(255, 255, 255, 0))
			-- self:DrawShadow(false)
			-- self.HasSounds = false
		-- end
	-- end

	if
		-- add bbohg convar for this
		-- GetConVar("VJ_TOTU_LNR_BreakDoors"):GetInt() == 0 or
		self.Dead or
		self.DeathAnimationCodeRan or
		self.Flinching or
		-- there's probably a better way to do this
		self.MeleeAttacking or
		self.RangeAttacking
	then
		self.LNR_DoorToBreak = NULL
	return end

	-- if VJ_AnimationExists(self,ACT_OPEN_DOOR) then
		if !IsValid(self.LNR_DoorToBreak) then
			if ((!self.VJ_IsBeingControlled) or (self.VJ_IsBeingControlled && self.VJ_TheController:KeyDown(IN_DUCK))) then
				for _,v in pairs(ents.FindInSphere(self:GetPos(),100)) do
					if v:GetClass() == "func_door_rotating" && v:Visible(self) then self.LNR_DoorToBreak = v end
					if v:GetClass() == "prop_door_dynamic" && !v.ToTU_DynamDoor_Broken && v:Visible(self) then self.LNR_DoorToBreak = v end
					if v:GetClass() == "prop_door_rotating" && v:Visible(self) then
						local anim = string.lower(v:GetSequenceName(v:GetSequence()))
						if string.find(anim,"idle") or string.find(anim,"open") then
							self.LNR_DoorToBreak = v
							break
						end
					end
				end
			end
		else
		    if self.PlayingAttackAnimation or !self.LNR_DoorToBreak:Visible(self) then self.LNR_DoorToBreak = NULL return end
			if self:GetActivity() != ACT_MELEE_ATTACK1 then
				local ang = self:GetAngles()
				self:SetAngles(Angle(ang.x,(self.LNR_DoorToBreak:GetPos() -self:GetPos()):Angle().y,ang.z))
				self:VJ_ACT_PLAYACTIVITY(ACT_MELEE_ATTACK1,true,false,false)
			end
		end
	-- end

	if self:GetEnemy() == nil then return end
	if !self.BLBOH_Leonard_Sprint && self:GetPos():Distance(self:GetEnemy():GetPos()) <= 300 then -- enemy is close enough, start sprinting
		self.BLBOH_Leonard_Sprint = true
	end
	if self.BLBOH_Leonard_Sprint && self:GetPos():Distance(self:GetEnemy():GetPos()) > 300 then -- go back to running since we're now too far
		self.BLBOH_Leonard_Sprint = false
	end

end
--------------------
function ENT:OnThinkActive()
	if self.BHLCIE_Follower_CurrentMode == 1 && self.BHLCIE_Follower_HideTime < CurTime() then -- we're hiding
		self.BHLCIE_Follower_CurrentMode = 0
			self:VJ_ACT_PLAYACTIVITY({"vjseq_extra"},"LetAttacks",5,false) -- rename this function and all other instances of it to PlayAnim
	end
end
--------------------
function ENT:CustomOnRangeAttack_BeforeStartTimer(seed)
	if !IsValid(self:GetEnemy()) then return end
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
		self.dummyEnt:SetColor(Color(255, 0, 0, 255))
		effects.BeamRingPoint(self.dummyEnt:GetPos()+self.dummyEnt:GetUp()*5, 0.80, 0, 200, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
		timer.Simple(0.80,function() if IsValid(self.dummyEnt) then
			effects.BeamRingPoint(self.dummyEnt:GetPos()+self.dummyEnt:GetUp()*5, 0.80, 0, 200, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
		end end)
		timer.Simple(1.60,function() if IsValid(self.dummyEnt) then
			effects.BeamRingPoint(self.dummyEnt:GetPos()+self.dummyEnt:GetUp()*5, 0.80, 0, 200, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
		end end)
		VJ.EmitSound(self.dummyEnt,{"npc/antlion/rumble1.wav"},70,math.random(150,175))
		util.ScreenShake(self.dummyEnt:GetPos(), 100, 100, 5, 250)
	end
	timer.Simple(5,function() if IsValid(self.dummyEnt) then
		self.dummyEnt:StopParticles()
		self.dummyEnt:Remove()
	end end)
end
--------------------
function ENT:OnDamaged(dmginfo, hitgroup, status)
	if status == "PreDamage" then
		if (self:Health() - dmginfo:GetDamage()) <= 0 && self.Dead == false then -- if we take lethal damage then..
			if self.BLBOH_Leonard_Killable_FleesLeft > 0 or !self.BLBOH_Leonard_Killable then -- might have to change this to a "is above 0" check
				dmginfo:ScaleDamage(0) -- to avoid him actually dying
				self.GodMode = true
				self:VJ_ACT_PLAYACTIVITY({"vjseq_extra"},"LetAttacks",5,false) -- rename this function and all other instances of it to PlayAnim
			end
			if self.BLBOH_Leonard_Killable then
				self.BLBOH_Leonard_Killable_FleesLeft = self.BLBOH_Leonard_Killable_FleesLeft - 1
			end
		end
	end
end
--------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
	if status == "Finish" then
		if IsValid(self.dummyEnt) then
			self.dummyEnt:StopParticles()
			self.dummyEnt:Remove()
		end
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