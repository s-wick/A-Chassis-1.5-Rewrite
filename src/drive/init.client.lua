--[[
	   ___  _____
	  / _ |/ ___/	pointclouded | NVNA
	 / __ / /__
	/_/ |_\___/ 		  LuaInt | NVNA
	
    Rewritten by SW_TK

	*I assume you know what you're doing if you're gonna change something here.* ]]
--

-- local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Types = require(script.Types)

-- local Player = Players.LocalPlayer
-- local Mouse = Player:GetMouse()

local Interface: Types.Interface = script.Parent :: Types.Interface
local Values: Types.Values = Interface.Values :: Types.Values

-- For the sake of familiarity, these variable names are left unchanged
local car: Types.Car = Interface.Car.Value :: Types.Car
local _Tune: Types.Tune = require(car["A-Chassis Tune"]) :: Types.Tune

local IsOn: boolean = _Tune.AutoStart and (_Tune.Engine or _Tune.Electric)
local ControlsOpen: boolean = false

local function inputHandler(input: InputObject, gameProcessedEvent: boolean) end

local function heartbeat(deltaTime: number)
	IsOn = Interface.IsOn.Value
	ControlsOpen = Interface.ControlsOpen.Value
end

local function childRemovedFromDriveSeat(child: Instance)
	if child.Name == "SeatWeld" and child:IsA("Weld") then
		Interface:Destroy()
	end
end

local function loop()
	-- while task.wait(0.0667) do
	--     --Automatic Transmission
	--     if _TMode == "Auto" then
	--         Auto()
	--     end

	--     --Flip
	--     if _Tune.AutoFlip then
	--         Flip()
	--     end
	-- end
end

local function init()
	Interface.IsOn.Value = IsOn

	UserInputService.InputBegan:Connect(inputHandler)
	UserInputService.InputChanged:Connect(inputHandler)
	UserInputService.InputEnded:Connect(inputHandler)

	RunService.Heartbeat:Connect(heartbeat)
	car.DriveSeat.ChildRemoved:Connect(childRemovedFromDriveSeat)

	task.spawn(loop)

	local version: string = require(car["A-Chassis Tune"].README) :: string
	print(`AC6C V{version} Loaded, Update {script.Parent.Version.Value}`)
end

init()
