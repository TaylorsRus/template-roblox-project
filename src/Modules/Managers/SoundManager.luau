local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")

--Hardcoded so may not be strictly accurate.
type Members = {
	--Data
	Name: string?,

	-- if we had read only modifiers then we wouldn't need to do this, but this stems from a requirement for invariancy
	Parent: (Instance | BasePart | MeshPart | Part | Folder | SoundService)?,

	--Behaviour
	PlayOnRemove: boolean?,

	--Asset
	SoundId: string?,

	--Emitter
	RollOffMaxDistance: number?,
	RollOffMinDistance: number?,
	RollOffMode: Enum.RollOffMode?,

	--Playback
	Looped: boolean?,
	PlaybackRegionsEnabled: boolean?,
	PlaybackSpeed: number?,
	Playing: boolean?,
	TimePosition: number?,
	Volume: number?,

	--Regions
	LoopRegion: NumberRange?,
	PlaybackRegion: NumberRange?,

	--Routing
	SoundGroup: SoundGroup?,

	--Callbacks
	OnEnded: () -> ()?,
}

type Data = {
	CleanUp: boolean?,
	FadeIn: number?,
	FadeOut: number?,

	[string]: never,
} & Members

local SoundManager = {}

local function ApplyProperties(sound: Sound, data: Data)
	if data.Playing then warn("SoundManager - Call Play() or Stop() instead of setting the Playing property.") end

	--Data
	sound.Name = data.Name or sound.Name
	sound.Parent = data.Parent or sound.Parent

	--Behaviour
	sound.PlayOnRemove = data.PlayOnRemove or sound.PlayOnRemove

	--Asset
	sound.SoundId = data.SoundId or sound.SoundId

	--Emitter
	sound.RollOffMaxDistance = data.RollOffMaxDistance or sound.RollOffMaxDistance
	sound.RollOffMinDistance = data.RollOffMinDistance or sound.RollOffMinDistance
	sound.RollOffMode = data.RollOffMode or sound.RollOffMode

	--Playback
	sound.Looped = data.Looped or sound.Looped
	sound.PlaybackRegionsEnabled = data.PlaybackRegionsEnabled or sound.PlaybackRegionsEnabled
	sound.PlaybackSpeed = data.PlaybackSpeed or sound.PlaybackSpeed
	sound.Playing = data.Playing or sound.Playing
	sound.TimePosition = data.TimePosition or sound.TimePosition
	sound.Volume = data.Volume or sound.Volume

	--Regions
	sound.LoopRegion = data.LoopRegion or sound.LoopRegion
	sound.PlaybackRegion = data.PlaybackRegion or sound.PlaybackRegion

	--Routing
	sound.SoundGroup = data.SoundGroup or sound.SoundGroup
end

local function ProcessSound(reference: Sound, data: Data)
	local sound = reference:Clone()

	ApplyProperties(sound, data)
	sound.Ended:Once(function()
		if data.OnEnded then task.defer(data.OnEnded) end
		if data.CleanUp ~= false then sound:Destroy() end
	end)

	if data.FadeIn then
		local cachedVolume = sound.Volume
		sound.Volume = 0

		local fadeIn = TweenService:Create(sound, TweenInfo.new(data.FadeIn), { Volume = cachedVolume })
		fadeIn:Play()
	end
	if data.FadeOut then task.delay(sound.TimeLength - data.FadeOut, function() TweenService:Create(sound, TweenInfo.new(data.FadeOut), { Volume = 0 }):Play() end) end

	sound.Parent = if data.Parent then data.Parent else SoundService
	sound:Play()

	return sound
end

function SoundManager.Play(reference: Sound, data: Data?): Sound return ProcessSound(reference, data or {}) end

function SoundManager.PlayRandom(references: { Sound }, data: Data?) return ProcessSound(references[math.random(1, #references)], data or {}) end

return SoundManager
