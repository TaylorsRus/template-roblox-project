local _Asphalt = require(script.Parent._asphalt)

local function _create(ContentId: string): Decal
	local decal = Instance.new("Decal")
	decal.Texture = ContentId
	return decal
end

local Decals = {}
return Decals
