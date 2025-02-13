-- Name this file `main.lua`. Your game can use multiple source files if you wish
-- (use the `import "myFilename"` command), but the simplest games can be written
-- with just `main.lua`.

-- You'll want to import these in just about every project you'll work on.

import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

-- Declaring this "gfx" shorthand will make your life easier. Instead of having
-- to preface all graphics calls with "playdate.graphics", just use "gfx."
-- Performance will be slightly enhanced, too.
-- NOTE: Because it's local, you'll have to do it in every .lua source file.

local gfx <const> = playdate.graphics
local display <const> = playdate.display

-- A function to set up our game environment.

local function drawRingText(txt, x, y, rot)
	local l = txt:gsub("%s", ""):len()
	local fontSize = gfx.getFont(gfx.kVariantNormal):getHeight()
	for i = 1, l do
		local c = txt:gsub("%s", ""):sub(i, i)
		local r = 64
		local cx = math.cos(math.rad((360 / l) * (i - 1)) + (i * rot)) * r
		local cy = math.sin(math.rad((360 / l) * (i - 1)) + (i * rot)) * r
		gfx.drawText(c, x + cx - fontSize / 2, y + cy - fontSize / 2)
	end
end

local txt = "HELLO FRIEND"
local function myGameSetUp()
	local w, h = display.getSize()
	local pad = 64
	local x, y, r = w / 2, h / 2, (h / 2) - pad

	local fontAlphaOne <const> = gfx.font.new("fonts/AlphaOne.pft")
	local fontSize <const> = 8
	gfx.setImageDrawMode(gfx.kDrawModeNXOR)
	gfx.setFont(fontAlphaOne)

	-- gfx.drawTextAligned(txt, x, y - (fontSize / 2), kTextAlignment.center)

	drawRingText(txt, x, y, 0)

	-- gfx.drawCircleAtPoint(x, y, r)
end

-- Now we'll call the function above to configure our game.
-- After this runs (it just runs once), nearly everything will be
-- controlled by the OS calling `playdate.update()` 30 times a second.

myGameSetUp()

-- `playdate.update()` is the heart of every Playdate game.
-- This function is called right before every frame is drawn onscreen.
-- Use this function to poll input, run game logic, and move sprites.

function playdate.update()
	playdate.drawFPS(0, 0)
	gfx.clear()

	local w, h = display.getSize()
	local pad = 60
	local x, y, r = w / 2, h / 2, (h / 2) - pad

	local rot = playdate.getCrankPosition()
	drawRingText(txt, x, y, rot)

	-- Call the functions below in playdate.update() to draw sprites and keep
	-- timers updated. (We aren't using timers in this example, but in most
	-- average-complexity games, you will.)

	gfx.sprite.update()
	playdate.timer.updateTimers()
end
