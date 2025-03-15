local _Asphalt = require(script.Parent._asphalt)

local function _create(
	ContentId: string,
	Properties: {
		RollOffMinDistance: number?,
		RollOffMaxDistance: number?,
		RollOffMode: Enum.RollOffMode?,
		Looped: boolean?,
		PlaybackSpeed: number?,
		Volume: number?,
	}?
): Sound
	local Sound = Instance.new("Sound")
	Sound.SoundId = ContentId

	if Properties then
		Sound.RollOffMinDistance = Properties.RollOffMinDistance or 10
		Sound.RollOffMaxDistance = Properties.RollOffMaxDistance or 100
		Sound.RollOffMode = Properties.RollOffMode or Enum.RollOffMode.InverseTapered
		Sound.Looped = Properties.Looped or false
		Sound.PlaybackSpeed = Properties.PlaybackSpeed or 1
		Sound.Volume = Properties.Volume or 0.5
	end
	return Sound
end

local Sounds = {}
return Sounds
