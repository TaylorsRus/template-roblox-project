local _Asphalt = require(script.Parent._asphalt)

local function _create(ContentId: string): Animation
	local Animation = Instance.new("Animation")
	Animation.AnimationId = ContentId
	return Animation
end

local Animations = {}
return Animations
