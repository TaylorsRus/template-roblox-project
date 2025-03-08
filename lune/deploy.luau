local process = require("@lune/process")

print("Syncing assets!")

local sync = process.spawn("asphalt", { "sync" }, {
	stdio = "forward",
})
if not sync.ok then
	process.exit(1)
end

print("Building place file!")

local buildResult = process.spawn("rojo", { "build", "--output", "dev.rbxl" })
if not buildResult.ok then
	warn(buildResult.stderr)
	process.exit(1)
end

print("Deploying!")

local deploymentResult = process.spawn("mantle", { "deploy" }, {
	stdio = "forward",
})
if not deploymentResult.ok then
	warn(deploymentResult.stderr)
	process.exit(1)
end

print("Deployed successfully!")
