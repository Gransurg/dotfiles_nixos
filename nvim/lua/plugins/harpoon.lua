-- helper function for harpoon in telescope integration
local function toggle_telescope(harpoon_files)
	-- required lazily so loading this spec file doesn't pull telescope in at startup
	local themes = require("telescope.themes")
	local conf = require("telescope.config").values

	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end
	local opts = themes.get_ivy({
		prompt_title = "Working List",
	})

	require("telescope.pickers")
		.new(opts, {
			finder = require("telescope.finders").new_table({
				results = file_paths,
			}),
			previewer = conf.file_previewer(opts),
			sorter = conf.generic_sorter(opts),
		})
		:find()
end

return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("harpoon"):setup()
	end,
	keys = {
		{
			"<leader>h",
			function()
				require("harpoon"):list():add()
			end,
			desc = "Harpoon add file",
		},
		{
			"<leader>H",
			function()
				local harpoon = require("harpoon")
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end,
			desc = "Harpoon quick menu",
		},
		{
			"<leader>1",
			function()
				require("harpoon"):list():select(1)
			end,
			desc = "Harpoon to file 1",
		},
		{
			"<leader>2",
			function()
				require("harpoon"):list():select(2)
			end,
			desc = "Harpoon to file 2",
		},
		{
			"<leader>3",
			function()
				require("harpoon"):list():select(3)
			end,
			desc = "Harpoon to file 3",
		},
		{
			"<leader>4",
			function()
				require("harpoon"):list():select(4)
			end,
			desc = "Harpoon to file 4",
		},
		{
			"<leader>5",
			function()
				require("harpoon"):list():select(5)
			end,
			desc = "Harpoon to file 5",
		},
		{
			"<leader>fl",
			function()
				toggle_telescope(require("harpoon"):list())
			end,
			desc = "Open Telescope Harpoon List",
		},
		{
			"<C-p>",
			function()
				require("harpoon"):list():prev()
			end,
			desc = "Harpoon prev",
		},
		{
			"<C-n>",
			function()
				require("harpoon"):list():next()
			end,
			desc = "Harpoon next",
		},
	},
}
