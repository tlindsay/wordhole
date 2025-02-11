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

-- Here's our player sprite declaration. We'll scope it to this file because
-- several functions need to access it.

local playerSprite = nil

-- A function to set up our game environment.

local function myGameSetUp()
	-- Set up the player sprite.
	gfx.setImageDrawMode(gfx.kDrawModeNXOR)
	gfx.setFont(gfx.getFont("bold"))
	gfx.drawTextAligned("Hey there, world!", 200, 120 - 8 / 2, kTextAlignment.center)
end

-- Now we'll call the function above to configure our game.
-- After this runs (it just runs once), nearly everything will be
-- controlled by the OS calling `playdate.update()` 30 times a second.

myGameSetUp()

-- `playdate.update()` is the heart of every Playdate game.
-- This function is called right before every frame is drawn onscreen.
-- Use this function to poll input, run game logic, and move sprites.

function playdate.update()
	if playerSprite == nil then
		return
	end

	-- Poll the d-pad and move our player accordingly.
	-- (There are multiple ways to read the d-pad; this is the simplest.)
	-- Note that it is possible for more than one of these directions
	-- to be pressed at once, if the user is pressing diagonally.

	if playdate.buttonIsPressed(playdate.kButtonUp) then
		playerSprite:moveBy(0, -2)
	end
	if playdate.buttonIsPressed(playdate.kButtonRight) then
		playerSprite:moveBy(2, 0)
	end
	if playdate.buttonIsPressed(playdate.kButtonDown) then
		playerSprite:moveBy(0, 2)
	end
	if playdate.buttonIsPressed(playdate.kButtonLeft) then
		playerSprite:moveBy(-2, 0)
	end

	-- Call the functions below in playdate.update() to draw sprites and keep
	-- timers updated. (We aren't using timers in this example, but in most
	-- average-complexity games, you will.)

	gfx.sprite.update()
	playdate.timer.updateTimers()
end
