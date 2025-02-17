-- Name this file `main.lua`. Your game can use multiple source files if you wish
-- (use the `import "myFilename"` command), but the simplest games can be written
-- with just `main.lua`.

-- You'll want to import these in just about every project you'll work on.

import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/ui"
import "CoreLibs/timer"

import "./math"
import "./letter"

-- Declaring this "gfx" shorthand will make your life easier. Instead of having
-- to preface all graphics calls with "playdate.graphics", just use "gfx."
-- Performance will be slightly enhanced, too.
-- NOTE: Because it's local, you'll have to do it in every .lua source file.

local gfx <const> = playdate.graphics
local display <const> = playdate.display
local fontAlphaOne <const> = gfx.font.new("fonts/AlphaOne.pft")
local fontSize <const> = 8
local w, h = display.getSize()
local centerX, centerY = w / 2, h / 2
local r = 96

---@type table<Ring>
local rings = {}
local function myGameSetUp()
	gfx.setImageDrawMode(gfx.kDrawModeInverted)
	gfx.setFont(fontAlphaOne)
	rings = {
		Ring("abcdefghjkmnopqrstuvwxyz", r),
		Ring("patricklindsay", r * 2 / 3),
		Ring("patrick", r / 3)
	}
end

myGameSetUp()

function playdate.update()
	gfx.clear()
	playdate.drawFPS(0, 0)

	if playdate.isCrankDocked() then
		playdate.ui.crankIndicator:draw()
	end

	local crankPosition = playdate.getCrankPosition() - 90
	for _, ring in pairs(rings) do
		ring:draw(crankPosition)
	end

	gfx.sprite.update()
	playdate.timer.updateTimers()
end
