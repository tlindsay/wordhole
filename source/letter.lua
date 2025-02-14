import "CoreLibs/sprites"
local gfx <const> = playdate.graphics

---@class Letter: _Sprite
---@field private char string
---@overload fun(char: string): Letter
Letter = class("Letter").extends(gfx.sprite) or Letter

function Letter:init(char)
	local size = gfx.getTextSize(char)
	local img = gfx.imageWithText(char, size, size)
	Letter.super.init(self, img)
	self:setImageDrawMode(gfx.kDrawModeXOR)
	self.char = char
	self:setScale(1.25)
end

function Letter:getChar()
	return self.char
end

---@class Ring
---@field private letters table<Letter>
---@field private radius integer
---@overload fun(text: string, radius: integer): Ring
---@fun
Ring = class("Ring").extends(Object) or Ring

function Ring:init(text, radius)
	Ring.super.init(self)
	self.letters = {}
	self.radius = radius
	local letters = text:gsub("%s", ""):upper()
	for i = 1, #letters do
		local l = Letter(letters:sub(i, i))
		table.insert(self.letters, l)
		l:add()
	end
end

---@param rotation number
function Ring:draw(rotation)
	local centerX, centerY = playdate.display.getSize()
	centerX /= 2
	centerY /= 2
	for i, sp in ipairs(self.letters) do
		local rot = math.rad(rotation + (360 / #self.letters * i))
		local x, y = math.cos(rot) * self.radius, math.sin(rot) * self.radius
		sp:moveTo(centerX + x, centerY + y)
	end
end
