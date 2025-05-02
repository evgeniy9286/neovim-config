--return {
--	"navarasu/onedark.nvim",
--	config = function()
--	require("onedark").setup({
--	transparent = true,
--})
--require("onedark").load()
--end,
--}

return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
}
