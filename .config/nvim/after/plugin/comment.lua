--------------------------------------------------------------------------------
-- https://github.com/numToStr/Comment.nvim
--------------------------------------------------------------------------------
-- import plugin safely
local status, comment = pcall(require, "Comment")
if not status then
	return
end
-- call plugin setup
comment.setup()
