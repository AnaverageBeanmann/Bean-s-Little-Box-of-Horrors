AddCSLuaFile("shared.lua")
include('shared.lua')
--------------------
ENT.Model = "models/vj_blboh/forlorn.mdl"
ENT.StartHealth = 7
-- ENT.ControllerParams = {
	-- ThirdP_Offset = Vector(30, 0, -60), -- The offset for the controller when the camera is in third person
	-- FirstP_Bone = "Antlion.FangTopL1_Bone", -- If left empty, the base will attempt to calculate a position for first person
	-- FirstP_Offset = Vector(20, 0, 40), -- The offset for the controller when the camera is in first person
	-- FirstP_ShrinkBone = true, -- Should the bone shrink? Useful if the bone is obscuring the player's view
	-- FirstP_CameraBoneAng = 0, -- Should the camera's angle be affected by the bone's angle? | 0 = No, 1 = Pitch, 2 = Yaw, 3 = Roll
	-- FirstP_CameraBoneAng_Offset = 0, -- How much should the camera's angle be rotated by? | Useful for weird bone angles
-- }
--------------------
ENT.VJ_NPC_Class = {"CLASS_BLBOH"}
--------------------
ENT.BloodColor = VJ.BLOOD_COLOR_OIL
--------------------
ENT.HasDeathCorpse = false
--------------------
ENT.MeleeAttackDamage = 15
-- ENT.MeleeAttackDamageType = DMG_CLUB
ENT.MeleeAttackDistance = 60
ENT.MeleeAttackDamageDistance = 40
ENT.TimeUntilMeleeAttackDamage = false
--------------------
ENT.DisableFootStepSoundTimer = true
ENT.HasExtraMeleeAttackSounds = true
ENT.SoundTbl_FootStep = {
	"npc/fast_zombie/foot1.wav",
	"npc/fast_zombie/foot2.wav",
	"npc/fast_zombie/foot3.wav",
	"npc/fast_zombie/foot4.wav"
}
ENT.SoundTbl_MeleeAttackMiss = {
	"npc/zombie/claw_miss1.wav",
	"npc/zombie/claw_miss2.wav"
}
ENT.SoundTbl_Death = "vj_blboh/forlorn/blessingHit.ogg"
ENT.FootstepSoundLevel = 65
ENT.MeleeAttackMissSoundLevel = 60
ENT.MeleeAttackMissSoundPitch = VJ.SET(80,90)
ENT.DeathSoundPitch = VJ.SET(95,105)
--------------------
ENT.BLBOH_DoSpawnSequence = false
ENT.BLBOH_CanDoSpawnSequence = true
ENT.BLBOH_ForceSpawnSequence = false
ENT.BLBOH_SpawnLightLevel = "0"
ENT.BLBOH_SpawnLightBoom = false
ENT.BLBOH_SpawnLightFadeStage = 0
ENT.BLBOH_Forlorn_ScaleDamage = true
--------------------
function ENT:PreInit()
	if (GetConVar("vj_blboh_spawn_sequences"):GetInt() == 1 && self.BLBOH_CanDoSpawnSequence) or self.BLBOH_ForceSpawnSequence then
		self.BLBOH_DoSpawnSequence = true
	end
end
--------------------
-- ohhh fuck i do NOT remember where i got this from uhhhh
-- i think it was one of darkborn's addons??
-- ohgod the coding session for this guy is a complete blur in my memory
function ENT:IsDirtGround(pos)

	local tr = util.TraceLine({
		start = pos,
		endpos = pos -Vector(0,0,40),
		filter = self,
		mask = MASK_NPCWORLDSTATIC
	})
	
	local mat = tr.MatType
	
	return tr.HitWorld && (mat == MAT_SAND || mat == MAT_DIRT || mat == MAT_FOLIAGE || mat == MAT_SLOSH || mat == MAT_GRASS)

end
--------------------
function ENT:Init()
	if self.BLBOH_DoSpawnSequence then
		self.EnemyDetection = false
		self.CanInvestigate = false
		self:AddFlags(FL_NOTARGET)
		self.GodMode = true
		self:SetMaterial("hud/killicons/default")
		self:DrawShadow(false)
		self.HasSounds = false
		timer.Simple(0.01, function() if IsValid(self) then
			if self:IsDirtGround(self:GetPos()) then
				local DeathFogEffect = EffectData()
				DeathFogEffect:SetOrigin(self:GetPos() + self:GetForward() * 15)
				DeathFogEffect:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
				DeathFogEffect:SetScale(100)
				util.Effect("VJ_Blood1",DeathFogEffect)
				DeathFogEffect:SetOrigin(self:GetPos() + self:GetForward() * -15)
				util.Effect("VJ_Blood1",DeathFogEffect)
				DeathFogEffect:SetOrigin(self:GetPos() + self:GetRight() * 15)
				util.Effect("VJ_Blood1",DeathFogEffect)
				DeathFogEffect:SetOrigin(self:GetPos() + self:GetRight() * -15)
				util.Effect("VJ_Blood1",DeathFogEffect)
				timer.Simple(1, function() if IsValid(self) then
					DeathFogEffect:SetOrigin(self:GetPos() + self:GetForward() * 15)
					util.Effect("VJ_Blood1",DeathFogEffect)
					DeathFogEffect:SetOrigin(self:GetPos() + self:GetForward() * -15)
					util.Effect("VJ_Blood1",DeathFogEffect)
					DeathFogEffect:SetOrigin(self:GetPos() + self:GetRight() * 15)
					util.Effect("VJ_Blood1",DeathFogEffect)
					DeathFogEffect:SetOrigin(self:GetPos() + self:GetRight() * -15)
					util.Effect("VJ_Blood1",DeathFogEffect)
				end end)
				local randdirtintro = math.random(1,3)
				if randdirtintro == 1 then
					self:PlayAnim("vjseq_spawn_dirt1", true, 5)
				elseif randdirtintro == 2 then
					self:PlayAnim("vjseq_spawn_dirt2", true, 6)
				else
					self:PlayAnim("vjseq_spawn_dirt3", true, 8)
				end
				VJ.EmitSound(self,"ambient/machines/thumper_dust.wav",70,math.random(95,105))

				self.EnemyDetection = true
				self.CanInvestigate = true
				self:RemoveFlags(FL_NOTARGET)
				self.GodMode = false
				self:SetMaterial("")
				self:DrawShadow(true)
				self.HasSounds = true
				-- self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK,5)

			else
				self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK,1.75)
				VJ.EmitSound(self,"vj_blboh/forlorn/spawn.ogg",75,math.random(95,105))

				self.BLBOH_Horror_Spawning = true

				-- self.SpawnLight = ents.Create("light_dynamic")
				-- self.SpawnLight:SetKeyValue("brightness", "7.5")
				-- self.SpawnLight:SetKeyValue("distance", "0")
				-- self.SpawnLight:SetLocalPos(self:GetPos())
				-- self.SpawnLight:SetLocalAngles(self:GetAngles())
				-- self.SpawnLight:Fire("Color", "140 140 140 255")
				-- self.SpawnLight:SetParent(self)
				-- self.SpawnLight:Spawn()
				-- self.SpawnLight:Activate()
				-- self.SpawnLight:Fire("SetParentAttachment","chest")
				-- self.SpawnLight:Fire("TurnOn", "", 0)
				-- self:DeleteOnRemove(self.SpawnLight)

				self.SpawnPortalSprite1 = ents.Create("env_sprite")
				self.SpawnPortalSprite1:SetKeyValue("model","vj_base/sprites/glow.vmt")
				self.SpawnPortalSprite1:SetKeyValue("scale", "0.75")
				self.SpawnPortalSprite1:SetKeyValue("rendermode","5")
				self.SpawnPortalSprite1:SetKeyValue("rendercolor","50 50 50 255")
				self.SpawnPortalSprite1:SetKeyValue("spawnflags","1") -- If animated
				self.SpawnPortalSprite1:SetParent(self)
				self.SpawnPortalSprite1:Fire("SetParentAttachment", "chest")
				self.SpawnPortalSprite1:Fire("Kill", "", 13)
				self.SpawnPortalSprite1:Spawn()
				self.SpawnPortalSprite1:Activate()
				self:DeleteOnRemove(self.SpawnPortalSprite1)

				timer.Simple(0.5,function() if IsValid(self) then

					self.SpawnPortalSprite2 = ents.Create("env_sprite")
					self.SpawnPortalSprite2:SetKeyValue("model","sprites/vj_blboh/blueflare1.vmt")
					self.SpawnPortalSprite2:SetKeyValue("scale", "0.8")
					self.SpawnPortalSprite2:SetKeyValue("rendermode","5")
					self.SpawnPortalSprite2:SetKeyValue("rendercolor","50 50 50 255")
					self.SpawnPortalSprite2:SetKeyValue("spawnflags","1") -- If animated
					self.SpawnPortalSprite2:SetParent(self)
					self.SpawnPortalSprite2:Fire("SetParentAttachment", "chest")
					self.SpawnPortalSprite2:Fire("Kill", "", 13)
					self.SpawnPortalSprite2:Spawn()
					self.SpawnPortalSprite2:Activate()
					self:DeleteOnRemove(self.SpawnPortalSprite2)

				end end)

				timer.Simple(1.75, function() if IsValid(self) then
					-- if math.random(1,2) == 1 then
						-- self:PlayAnim("vjseq_spawn1", true, 5)
					-- else
						-- self:PlayAnim("vjseq_spawn2", true, 5)
					-- end
					self.EnemyDetection = true
					self.CanInvestigate = true
					self:RemoveFlags(FL_NOTARGET)
					self.GodMode = false
					self:SetMaterial("")
					self:DrawShadow(true)
					self.HasSounds = true

					self.BLBOH_SpawnLightBoom = true

					self.SpawnPortalSprite1:Fire("Kill", "", 0)
					self.SpawnPortalSprite2:Fire("Kill", "", 0)

					effects.BeamRingPoint(self:GetPos() + self:GetUp() * 20, 0.5, 0, 25, 5, 0, Color(35, 35, 35), {material="sprites/physgbeamb", framerate=20})
					effects.BeamRingPoint(self:GetPos() + self:GetUp() * 40, 0.5, 0, 50, 5, 0, Color(35, 35, 35), {material="sprites/physgbeamb", framerate=20})
					effects.BeamRingPoint(self:GetPos() + self:GetUp() * 60, 0.5, 0, 25, 5, 0, Color(35, 35, 35), {material="sprites/physgbeamb", framerate=20})

					local DeathFogEffect = EffectData()
					DeathFogEffect:SetOrigin(self:GetPos() + self:GetUp()*20)
					DeathFogEffect:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
					DeathFogEffect:SetScale(50)
					util.Effect("VJ_Blood1",DeathFogEffect)
					DeathFogEffect:SetOrigin(self:GetPos() + self:GetUp()*40)
					util.Effect("VJ_Blood1",DeathFogEffect)
					DeathFogEffect:SetOrigin(self:GetPos() + self:GetUp()*60)
					util.Effect("VJ_Blood1",DeathFogEffect)

					VJ.EmitSound(self,"ambient/machines/thumper_dust.wav",65,math.random(70,80))

				end end)
			end
		end end)
	end
end
--------------------
function ENT:OnThinkActive()
	-- if IsValid(self.SpawnLight) then
		-- self.SpawnLight:SetKeyValue("distance", self.BLBOH_SpawnLightLevel)
		-- if !self.BLBOH_SpawnLightBoom then
			-- self.BLBOH_SpawnLightLevel = self.BLBOH_SpawnLightLevel + 2.5
		-- else
			-- if self.BLBOH_SpawnLightFadeStage == 1 then
				-- self.BLBOH_SpawnLightLevel = self.BLBOH_SpawnLightLevel + 2.5
			-- elseif self.BLBOH_SpawnLightFadeStage == 2 then
				-- self.BLBOH_SpawnLightLevel = self.BLBOH_SpawnLightLevel - 3
			-- else
				-- self.BLBOH_SpawnLightLevel = self.BLBOH_SpawnLightLevel + 5
			-- end
			-- timer.Simple(0.25,function() if IsValid(self) && self.BLBOH_SpawnLightFadeStage != 1 then
				-- self.BLBOH_SpawnLightFadeStage = 1
			-- end end)
			-- timer.Simple(0.26,function() if IsValid(self) && self.BLBOH_SpawnLightFadeStage != 2 then
				-- self.BLBOH_SpawnLightFadeStage = 2
				-- self.BLBOH_Horror_Spawning = false
			-- end end)
		-- end
	-- end
end
--------------------
function ENT:OnDamaged(dmginfo, hitgroup, status)
	if status == "PreDamage" && self.BLBOH_Forlorn_ScaleDamage then
		dmginfo:SetDamage(1)
	end
end
--------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
	if status == "Init" then
		local DeathFogEffect = EffectData()
		DeathFogEffect:SetOrigin(self:GetPos() + self:GetUp()*20)
		DeathFogEffect:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
		DeathFogEffect:SetScale(75)
		util.Effect("VJ_Blood1",DeathFogEffect)
		DeathFogEffect:SetOrigin(self:GetPos() + self:GetUp()*40)
		util.Effect("VJ_Blood1",DeathFogEffect)
		DeathFogEffect:SetOrigin(self:GetPos() + self:GetUp()*60)
		util.Effect("VJ_Blood1",DeathFogEffect)
	end
	-- if status == "Finish" then
		-- self:SetColor(Color(255, 255, 255, 255))
	-- end
end
--------------------
function ENT:OnInput(key, activator, caller, data)
	if key == "step" && self:GetMaterial() != "hud/killicons/default" then
		VJ.EmitSound(self,self.SoundTbl_FootStep,self.FootstepSoundLevel)
	elseif key == "melee" then
		self:MeleeAttackCode()
	elseif key == "ranged" then
		self:RangeAttackCode()
	end
end
--------------------
-- function ENT:Controller_Initialize(ply, controlEnt)
	-- ply:ChatPrint("MOUSE2: Dig")
	-- ply:ChatPrint("Digging puts you underground, making you slow and harmless, but immune to threats and you gain slow health regen")
	-- ply:ChatPrint("Click Mouse2 while underground to come back up to the surface.")
	-- ply:ChatPrint("JUMP + LEFT/RIGHT: Dodge")
	-- ply:ChatPrint("Hold JUMP and then press LEFT or Right to dodge in that direction.")
	-- ply:ChatPrint("RELOAD: Growl")
	-- timer.Simple(0.1, function() if IsValid(self) then
		-- self.BLBOH_Wretch_TauntCooldown = CurTime() - 15
		-- self.BLBOH_Wretch_DodgeCooldown = CurTime() - 15
	-- end end)
-- end
--------------------
-- function ENT:TranslateActivity(act)
	-- if act == ACT_RUN && self.BLBOH_Wretch_Underground then
		-- return ACT_WALK
	-- end
	-- return act
-- end