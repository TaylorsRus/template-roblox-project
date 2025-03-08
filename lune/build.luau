local process = require("@lune/process")

local sync = process.spawn("asphalt", { "sync" }, {
	stdio = "forward",
})
if not sync.ok then
	process.exit(1)
end

local build = process.spawn("rojo", { "build", "--output", "dev.rbxl" }, {
	stdio = "forward",
})
if not build.ok then
	process.exit(1)
end
