local IsValid = IsValid
local os = os
local util = util

hook.Add( "CalcMainActivity", "BaseAnimations", function( Player, Velocity )
	if not Player.LastOnGround and not Player:OnGround() then
		Player.LastOnGround = true
	end
	if Player:IsOnGround() and Player.LastOnGround then
		Player:AddVCDSequenceToGestureSlot( GESTURE_SLOT_FLINCH, Player:LookupSequence("jump_land"), 0, true )
		Player.LastOnGround = false
	end

	if Player:IsOnGround() and Velocity:Length() > Player:GetRunSpeed() - 10 then
		return ACT_HL2MP_RUN_FAST, -1
	end
end)

local function RenderHook( Object )
	if not Object:IsPlayer() then return end
	if not Object.RenderOverride then
		Object.RenderOverride = function( self )
			if hook.Call("PlayerRender", nil, self ) == nil then
				self:DrawModel()
			end
		end
	end
end

hook.Add("NetworkEntityCreated", "HookOntoPlayerRender", RenderHook )
hook.Add("NetworkEntityCreated", "HookOntoPlayerRender", OnEntityCreated )

function GM:PlayerNoClip()
	return true
end
