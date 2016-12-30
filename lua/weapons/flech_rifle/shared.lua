
// Variables that are used on both client and server

AddCSLuaFile( "shared.lua" )

SWEP.Author			= "Swat Player"
SWEP.Instructions	= "Havoc"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_irifle.mdl"
SWEP.WorldModel			= "models/weapons/w_irifle.mdl"

SWEP.Primary.ClipSize		= 36
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.PrintName			= "Flechette Rifle"			
SWEP.Slot				= 2
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= true


local ShootSound = Sound( "NPC_Hunter.FlechetteShoot" )
local ShootSound2 = Sound( "Weapon_Alyx_Gun.Single" )

/*---------------------------------------------------------
	Reload does nothing
---------------------------------------------------------*/
function SWEP:Reload()

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

	self.Weapon:SetNextPrimaryFire( CurTime() + 0.113225 )

	self:EmitSound( ShootSound )
	self:ShootEffects( self )
	
	// The rest is only done on the server
	if (!SERVER) then return end
	
	local Forward = self.Owner:EyeAngles():Forward()
	
	local ent = ents.Create( "hunter_flechette" )
	if ( ValidEntity( ent ) ) then
			ent:SetPos( self.Owner:GetShootPos() + Forward * 32 )
			ent:SetAngles( self.Owner:EyeAngles() )
		 -- local trail = util.SpriteTrail(ent, 0, Color(0,255,255), false, 0, 25, 2.3, 1/(15+1)*0.5, "sprites/combineball_trail_black_1.vmt")
		-- trail:SetPos( self.Owner:GetShootPos() + Forward * 52 )
		-- trail:SetAngles( self.Owner:EyeAngles() )
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

/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()

	self.Weapon:SetNextSecondaryFire( CurTime() + 7 )

	self:EmitSound( ShootSound2 )
	self:ShootEffects( self )
	
	// The rest is only done on the server
	if (!SERVER) then return end
	
	local Forward = self.Owner:EyeAngles():Forward()
	
	local ent = ents.Create( "hunter_flechette" )
	if ( ValidEntity( ent ) ) then
			ent:SetPos( self.Owner:GetShootPos() + Forward * 52 )
			ent:SetAngles( self.Owner:EyeAngles() )
			local expl = ents.Create( "env_explosion" )
			if ( ValidEntity( expl ) ) then		
			-- local trail = util.SpriteTrail(ent, 0, Color(0,255,255), false, 0, 25, 2, 1/(15+1)*0.5, "sprites/combineball_trail_black_1.vmt")
				-- trail:SetPos( self.Owner:GetShootPos() + Forward * 52 )
				-- trail:SetAngles( self.Owner:EyeAngles() )
				expl:SetPos( self.Owner:GetShootPos() + Forward * 52 )
				expl:SetAngles( self.Owner:EyeAngles() )
				expl:Spawn()
				expl:SetParent(ent)
				expl:Fire("addoutput","spawnflags 4")
				expl:Fire("addoutput","iMagnitude 100")
				expl:Fire("addoutput","iRadiusOverride 230")
				expl:Fire("addoutput","rendermode 5")
				expl:Fire("explode","",2)
				ent:AddEffects( EF_ITEM_BLINK | EF_BRIGHTLIGHT );
				ent:Fire("DispatchEffect","helicoptermegabomb",2)
				ent:Fire("DispatchEffect","rpgshotdown",2)
				ent:Fire("DispatchEffect","thruster_ring",2)
				ent:Fire("DispatchEffect","GaussTracer",2)
				ent:Fire("addoutput","onuser1 entity_flame,kill,,",3)
				ent:Fire("fireuser1")
				-- ent:Fire("DispatchEffect","Watersurfaceexplosion",2)
				expl:SetOwner( self.Owner )
			end
		ent:Spawn()
		ent:SetModel("models/magnusson_device.mdl")
		ent:SetVelocity( Forward * 3000 )
	end
	
	ent:Fire("addoutput","basevelocity 0 0 -150",0.1)
	ent:Fire("addoutput","basevelocity 0 0 -150",0.3)
	ent:Fire("addoutput","basevelocity 0 0 -150",0.5)
	ent:Fire("addoutput","basevelocity 0 0 -150",0.7)
	ent:Fire("addoutput","basevelocity 0 0 -150",1)
	ent:Fire("addoutput","basevelocity 0 0 -150",1.3)
	ent:Fire("addoutput","basevelocity 0 0 -150",1.5)
	ent:Fire("addoutput","basevelocity 0 0 -150",1.7)
	ent:Fire("addoutput","basevelocity 0 0 -150",2)
	ent:Fire("addoutput","basevelocity 0 0 -150",2.3)
	ent:Fire("addoutput","basevelocity 0 0 -150",2.5)
	ent:Fire("addoutput","basevelocity 0 0 -150",2.7)
	ent:Fire("addoutput","basevelocity 0 0 -150",3)
	ent:SetOwner( self.Owner )
	ent:Fire("Break","",2)
util.ScreenShake( ent:GetPos(), 3, 5, 0.7, 100 )
	ParticleEffectAttach("choreo_launch_camjet_1",PATTACH_ABSORIGIN_FOLLOW,ent,0)

timer.Simple(1.7,function() ParticleEffectAttach("Weapon_Combine_Ion_Cannon_Explosion",PATTACH_ABSORIGIN_FOLLOW,ent,0) end)
timer.Simple(1.9,function() ParticleEffectAttach("rock_impact_stalactite",PATTACH_ABSORIGIN_FOLLOW,ent,0) end)
end


/*---------------------------------------------------------
   Name: ShouldDropOnDie
   Desc: Should this weapon be dropped when its owner dies?
---------------------------------------------------------*/
function SWEP:ShouldDropOnDie()
	return false
end

function SWEP:Equip(ply)
	ParticleEffectAttach("Weapon_Combine_Ion_Cannon_Explosion",PATTACH_ABSORIGIN_FOLLOW,ply,0)
end


	