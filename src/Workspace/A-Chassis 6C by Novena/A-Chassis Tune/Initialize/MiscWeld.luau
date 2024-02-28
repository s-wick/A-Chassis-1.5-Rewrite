local car = script.Parent.Parent.Parent
local misc = car:WaitForChild("Misc")

-- Welding functions between two parts
-- @param part1: Part1 (parent of weld)
-- @param part2: Part2
-- @param weldType: WeldType, default is "Weld", can be "Motor"
-- @param motorVelocity: MotorVelocity if type is "Motor"
-- @return weld: Weld instance created
local function MakeWeld(part1, part2, weldType, motorVelocity)
    if weldType == nil then
        weldType = "Weld"
    end

    local weld = Instance.new(weldType, part1)
    weld.Part0 = part1
    weld.Part1 = part2
    weld.C0 = part1.CFrame:inverse() * part1.CFrame     -- CFrame.new(0,0,0) * CFrame.Angles(0,0,0)?
    weld.C1 = part2.CFrame:inverse() * part1.CFrame

    if weldType == "Motor" and motorVelocity ~= nil then
        weld.MaxVelocity = motorVelocity
    end

    return weld
end

-- Welding function between a model and a part
-- @param a: Model
-- @param b: MainPart
local function ModelWeld(model, part)

    if model:IsA("BasePart") then
        MakeWeld(part, model, "Weld")

    elseif model:IsA("Model") then
        for i, v in pairs(model:GetChildren()) do
            ModelWeld(v, part)
            
        end
    end
end

---------------------------
--[[
	--Main anchor point is the DriveSeat <car.DriveSeat>	
	
	Usage:
    MakeWeld(Part1,Part2,WeldType*,MotorVelocity**) *default is "Weld"  **Applies to Motor welds only
    ModelWeld(Model,MainPart)
	Example:
    MakeWeld(car.DriveSeat,misc.PassengerSeat)
    MakeWeld(car.DriveSeat,misc.SteeringWheel,"Motor",.2)
    ModelWeld(car.DriveSeat,misc.Door)
    ]]

-- Weld stuff here

-- Slightly tilts character back in the seat
car.DriveSeat.ChildAdded:connect(function(child)
    if child.Name == "SeatWeld" and child:IsA("Weld") and game.Players:GetPlayerFromCharacter(child.Part1.Parent) ~= nil then
        child.C0 = CFrame.new(0, -.5, 0) * CFrame.fromEulerAnglesXYZ(-(math.pi / 2), 0, 0) *
                       CFrame.Angles(math.rad(13), 0, 0)
    end
end)

---------------------------


return true
