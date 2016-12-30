
// Variables that are used on both client and server

AddCSLuaFile( "shared.lua" )

SWEP.Author			= "Flubadoo"
SWEP.Purpose	= "Precison counts"
SWEP.Instructions = ""
SWEP.Spawnable			= false
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_atgun.mdl"
SWEP.WorldModel			= "models/jaanus/atgun.mdl"

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.PrintName			= "Flechette Sniper Rifle"			
SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= true

local ShootSound = Sound( "NPC_Hunter.FlechetteShoot" )

Zoom = 0

/*---------------------------------------------------------
	Reload does nothing
---------------------------------------------------------*/
function SWEP:Reload()
	self.Weapon:DefaultReload( ACT_VM_RELOAD );
end

/*---------------------------------------------------------
   Think does nothing
---------------------------------------------------------*/
function SWEP:Think()	
end


/*---------------------------------------------------------
	PrimaryAttack
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 1 )
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self:EmitSound( ShootSound )
	self:ShootEffects( self )
	
	// The rest is only done on the server
	if (!SERVER) then return end
	
	self:TakePrimaryAmmo( 0 )
	
	local x
	for x = 1, 15 do
		local r1 = math.random(-20, 20) / 10000
		local r2 = math.random(-20, 20) / 10000
		local r3 = math.random(-20, 20) / 10000
		local Forward = self.Owner:EyeAngles():Forward()
		
		local ent = ents.Create( "hunter_flechette" )
		if ( ValidEntity( ent ) ) then
				ent:SetPos( self.Owner:GetShootPos() + Forward * 32 )
				ent:SetAngles( self.Owner:EyeAngles() )
			ent:Spawn()
			ent:SetVelocity( Forward * 3000 )
		end
	ent:Fire("addoutput","basevelocity 0 0 -30",0.1)
	ent:Fire("addoutput","basevelocity 0 0 -30",0.3)
	ent:Fire("addoutput","basevelocity 0 0 -30",0.5)
	ent:Fire("addoutput","basevelocity 0 0 -30",0.7)
	ent:Fire("addoutput","basevelocity 0 0 -30",1)
	ent:Fire("addoutput","basevelocity 0 0 -30",1.3)
	ent:Fire("addoutput","basevelocity 0 0 -30",1.5)
	ent:Fire("addoutput","basevelocity 0 0 -30",1.7)
	ent:Fire("addoutput","basevelocity 0 0 -30",2)
	ent:Fire("addoutput","basevelocity 0 0 -30",2.3)
	ent:Fire("addoutput","basevelocity 0 0 -30",2.5)
	ent:Fire("addoutput","basevelocity 0 0 -30",2.7)
	ent:Fire("addoutput","basevelocity 0 0 -30",3)
	-- ent:AddEffects( EF_ITEM_BLINK | EF_BRIGHTLIGHT );
	ent:SetOwner( self.Owner )
	util.ScreenShake( ent:GetPos(), 2, 2, 0.7, 100 )
	ParticleEffectAttach("larvae_glow_extract",PATTACH_ABSORIGIN_FOLLOW,ent,0)
	timer.Simple(2.7,function() ParticleEffectAttach("striderbuster_explode_dummy_core",PATTACH_ABSORIGIN_FOLLOW,ent,0) end)
	end
end


/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()

	if(Zoom == 0) then
		if(SERVER) then
			self.Owner:SetFOV( 25, 0.25 )
		end
		self:EmitSound("Weapon_AR2.Special1")
		Zoom = 1
	else
		if(SERVER) then
			self.Owner:SetFOV( 0, 0.25 )
		end
		self:EmitSound("Weapon_AR2.Special2")
		Zoom = 0
	end

end

/*---------------------------------------------------------
   Name: ShouldDropOnDie
   Desc: Should this weapon be dropped when its owner dies?
---------------------------------------------------------*/
function SWEP:ShouldDropOnDie()
	return true
end

function SWEP:Equip(ply)
	ParticleEffectAttach("Weapon_Combine_Ion_Cannon_Explosion",PATTACH_ABSORIGIN_FOLLOW,ply,0)
end
