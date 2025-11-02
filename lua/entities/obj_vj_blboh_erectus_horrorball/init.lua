ENT.Model = {"models/vj_blboh/shepherd_bullet.mdl"}
ENT.ProjectileType = VJ.PROJ_TYPE_GRAVITY
ENT.SoundTbl_OnCollide = {"vj_blboh/shepherd/bullet_hit_target.mp3"}
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
	self:DrawShadow(false)
	self:SetMaterial("hud/killicons/default")
end
--------------------
function ENT:OnThink()
	local bloodeffect = EffectData()
	bloodeffect:SetOrigin(self:GetPos())
	bloodeffect:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
	bloodeffect:SetScale(100)
	util.Effect("VJ_Blood1",bloodeffect)
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
	VJ_EmitSound(self,{"npc/horror/sjasact.wav"},90,math.random(40,50))
	local bloodeffect = EffectData()
	bloodeffect:SetOrigin(self:GetPos() + self:GetUp()*40)
	bloodeffect:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
	bloodeffect:SetScale(200)
	util.Effect("VJ_Blood1",bloodeffect)
	local horror = ents.Create("npc_vj_blboh_horror")
	if IsValid(horror) then
		horror:SetPos(self:GetPos())
		horror:SetAngles(Angle(0,0,0))
		horror:Spawn()
		timer.Simple(5, function() if IsValid(horror) then
			local d = DamageInfo()
			d:SetDamage(horror:GetMaxHealth())
			d:SetAttacker(horror)
			d:SetDamageType(DMG_BLAST) 
			horror:TakeDamageInfo(d)
		end end)
	end
end
--------------------