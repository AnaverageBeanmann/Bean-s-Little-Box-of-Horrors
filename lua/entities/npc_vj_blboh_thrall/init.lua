AddCSLuaFile("shared.lua")
include('shared.lua')
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.Model = {"models/vj_bhlcie/demons/thrall.mdl"}
ENT.StartHealth = 100
ENT.HullType = HULL_HUMAN

ENT.VJ_NPC_Class = {"CLASS_ZOMBIE","CLASS_DEMON"}

ENT.BloodColor = "Red"

ENT.AlwaysWander = true

ENT.MeleeAttackDamage = 10
ENT.MeleeAttackDistance = 35
ENT.MeleeAttackDamageDistance = 60
ENT.TimeUntilMeleeAttackDamage = false

ENT.FindEnemy_UseSphere = true
ENT.FindEnemy_CanSeeThroughWalls = true

ENT.DisableFootStepSoundTimer = true

ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100

ENT.SoundTbl_FootStep = {"npc/fast_zombie/foot1.wav","npc/fast_zombie/foot2.wav","npc/fast_zombie/foot3.wav","npc/fast_zombie/foot4.wav"}
ENT.SoundTbl_Alert = {
	"npc/thrall/chaos_reigns.mp3",
	"npc/thrall/i_know_not_what_i_do.mp3",
	"npc/thrall/we_are_many.mp3"
}
ENT.SoundTbl_MeleeAttack = {
	"physics/body/body_medium_impact_hard1.wav",
	"physics/body/body_medium_impact_hard2.wav",
	"physics/body/body_medium_impact_hard3.wav",
	"physics/body/body_medium_impact_hard4.wav",
	"physics/body/body_medium_impact_hard5.wav",
	"physics/body/body_medium_impact_hard6.wav"
}
ENT.SoundTbl_Death = {
	"npc/thrall/bless_you_child.mp3",
	"npc/thrall/i_had_no_choice.mp3",
	"npc/thrall/please_no.mp3",
	"npc/thrall/the_holy_man.mp3"
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	if key == "step" then
		VJ_EmitSound(self,self.SoundTbl_FootStep,self.FootStepSoundLevel)
	end
	if key == "attack" then
		self:MeleeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_Miss()
	self.PlayingAttackAnimation = false
	self:StopAttacks(false)
	self.vACT_StopAttacks = false	
end
---------------------------------------------------------------------------------------------------------------------------------------------