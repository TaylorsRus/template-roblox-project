local process = require("@lune/process")
local task = require("@lune/task")

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

print("Build successful!\nLaunching studio...\nCTRL-C To cancel...")

local launch = process.spawn("Invoke-Item", { "./dev.rbxl" }, {
	shell = "powershell",
})
if not launch.ok then
	process.exit(1)
end

while true do
	task.wait(1000000000)
end
