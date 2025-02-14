import "CoreLibs/sprites"
local gfx <const> = playdate.graphics

---@class Letter: _Sprite
---@field char: string
---@overload fun(char: string): Letter
Letter = class("Letter").extends(gfx.sprite) or Letter

function Letter:init(char)
	local size = gfx.getTextSize(char)
	local img = gfx.imageWithText(char, size, size)
	Letter.super.init(self, img)
	self:setImageDrawMode(gfx.kDrawModeXOR)
	self.char = char
end
