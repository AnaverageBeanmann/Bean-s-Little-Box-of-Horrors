AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_projectile_base"
ENT.PrintName		= "Horror Ball"
ENT.Author 			= "An average Beanmann"
ENT.Contact 		= ""
ENT.Information		= "Projectile Erecti shoot; summons a Horror apon impact"
ENT.Category		= "Bean's Little Box of Horrors"

ENT.Spawnable = false
ENT.AdminOnly = false
--------------------
if CLIENT then
	language.Add("obj_erectus_horrorball", "Horror Ball")
	killicon.Add("obj_erectus_horrorball","HUD/killicons/default",Color(255,80,0,255))

	language.Add("#obj_erectus_horrorball", "Horror Ball")
	killicon.Add("#obj_erectus_horrorball","HUD/killicons/default",Color(255,80,0,255))
	
	function ENT:Draw() self:DrawModel() end
end
if !SERVER then return end
--------------------
ENT.Model = {"models/vj_blboh/shepherd_bullet.mdl"}
ENT.ProjectileType = VJ.PROJ_TYPE_GRAVITY
ENT.SoundTbl_OnCollide = {"vj_blboh/shepherd/bullet_hit_target.mp3"}
--------------------
ENT.BLBOH_HorrorBall_GuyToSpawn = "npc_vj_blboh_horror"
--------------------
-- function ENT:CustomPhysicsObjectOnInitialize(phys)
	-- phys:Wake()
	-- phys:SetMass(1)
	-- phys:SetBuoyancyRatio(0)
	-- phys:EnableDrag(true)
	-- phys:EnableGravity(true)
-- end
--------------------
function ENT:Init()
	if math.random(1,3) == 1 then
		self.BLBOH_HorrorBall_GuyToSpawn = "npc_vj_blboh_wretch"
	end
	self:DrawShadow(false)
	self:SetMaterial("hud/killicons/default")
	self:GetPhysicsObject():EnableGravity(true)


	self.ErectusLight = ents.Create("light_dynamic")
	self.ErectusLight:SetKeyValue("brightness", "5")
	self.ErectusLight:SetKeyValue("distance", "150")
	self.ErectusLight:SetLocalPos(self:GetPos())
	self.ErectusLight:SetLocalAngles(self:GetAngles())
	self.ErectusLight:Fire("Color", "100 100 100 255")
	self.ErectusLight:SetParent(self)
	self.ErectusLight:Spawn()
	self.ErectusLight:Activate()
	self.ErectusLight:Fire("SetParentAttachment","trail")
	self.ErectusLight:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(self.ErectusLight)

	self.ErectusChestSprite1 = ents.Create("env_sprite")
	self.ErectusChestSprite1:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
	self.ErectusChestSprite1:SetKeyValue("scale", "0.35")
	self.ErectusChestSprite1:SetKeyValue("rendermode","5")
	self.ErectusChestSprite1:SetKeyValue("rendercolor","100 100 100 255")
	self.ErectusChestSprite1:SetKeyValue("spawnflags","1") -- If animated
	self.ErectusChestSprite1:SetParent(self)
	self.ErectusChestSprite1:Fire("SetParentAttachment", "trail")
	self.ErectusChestSprite1:Spawn()
	self.ErectusChestSprite1:Activate()
	self:DeleteOnRemove(self.ErectusChestSprite1)
	
	self.ErectusChestSprite2 = ents.Create("env_sprite")
	self.ErectusChestSprite2:SetKeyValue("model","sprites/blueflare1.vmt")
	self.ErectusChestSprite2:SetKeyValue("scale", "0.35")
	self.ErectusChestSprite2:SetKeyValue("rendermode","5")
	self.ErectusChestSprite2:SetKeyValue("rendercolor","100 100 100 255")
	self.ErectusChestSprite2:SetKeyValue("spawnflags","1") -- If animated
	self.ErectusChestSprite2:SetParent(self)
	self.ErectusChestSprite2:Fire("SetParentAttachment", "trail")
	self.ErectusChestSprite2:Spawn()
	self.ErectusChestSprite2:Activate()
	self:DeleteOnRemove(self.ErectusChestSprite2)
	
	self.ErectusChestSprite3 = ents.Create("env_sprite")
	self.ErectusChestSprite3:SetKeyValue("model","sprites/combineball_glow_black_1.vmt")
	self.ErectusChestSprite3:SetKeyValue("scale", "0.35")
	self.ErectusChestSprite3:SetKeyValue("rendermode","5")
	self.ErectusChestSprite3:SetKeyValue("rendercolor","255 0 0 255")
	self.ErectusChestSprite3:SetKeyValue("spawnflags","1") -- If animated
	self.ErectusChestSprite3:SetParent(self)
	self.ErectusChestSprite3:Fire("SetParentAttachment", "trail")
	self.ErectusChestSprite3:Spawn()
	self.ErectusChestSprite3:Activate()
	self:DeleteOnRemove(self.ErectusChestSprite3)

end
--------------------
function ENT:OnThink()
	-- local bloodeffect = EffectData()
	-- bloodeffect:SetOrigin(self:GetPos())
	-- bloodeffect:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
	-- bloodeffect:SetScale(50)
	-- util.Effect("VJ_Blood1",bloodeffect)
	-- timer.Simple(0.25, function() if IsValid(self) then
		-- local bloodeffect = EffectData()
		-- bloodeffect:SetOrigin(self:GetPos())
		-- bloodeffect:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
		-- bloodeffect:SetScale(100)
		-- util.Effect("VJ_Blood1",bloodeffect)
	-- end end)
end
--------------------
-- function ENT:CustomOnCollideWithoutRemove(data, phys)
	-- timer.Simple(0.001,function() if IsValid(self) then
		-- self:Remove(self)
	-- end end)
-- end -- Return false to disable the base functions from running
--------------------
function ENT:CustomOnRemove()
	-- VJ_EmitSound(self,{"npc/horror/sjasact.wav"},90,math.random(40,50))
	local bloodeffect = EffectData()
	bloodeffect:SetOrigin(self:GetPos() + self:GetUp()*60)
	bloodeffect:SetColor(VJ_Color2Byte(Color(140,140,140,255)))
	bloodeffect:SetScale(100)
	util.Effect("VJ_Blood1",bloodeffect)
	local horror = ents.Create(self.BLBOH_HorrorBall_GuyToSpawn)
	if IsValid(horror) then
		horror:SetPos(self:GetPos())
		horror:SetAngles(Angle(0,0,0))
		horror:Spawn()
		timer.Simple(20, function() if IsValid(horror) then
			local d = DamageInfo()
			d:SetDamage(horror:GetMaxHealth())
			d:SetAttacker(horror)
			d:SetDamageType(DMG_BLAST) 
			horror:TakeDamageInfo(d)
		end end)
	end
end
--------------------