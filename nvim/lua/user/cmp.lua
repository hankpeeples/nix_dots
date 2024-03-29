local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

require("luasnip/loaders/from_vscode").lazy_load()

-- local tn = require("cmp_tabnine.config")
-- tn:setup({
-- 	max_lines = 1000,
-- 	max_num_results = 5,
-- 	sort = true,
-- 	run_on_every_keystroke = true,
-- 	-- snippet_placeholder = '..',
-- 	ignored_file_types = {
-- 		-- default is not to ignore
-- 		-- uncomment to ignore in lua:
-- 		-- lua = true
-- 	},
-- 	-- show_prediction_strength = true
-- })

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local kind_icons = {
	Text = " (Text)",
	Method = " (Method)",
	Function = " (Function)",
	Constructor = " (Constructor)",
	Field = " (Field)",
	Variable = " (Variable)",
	Class = " (Class)",
	Interface = " (Interface)",
	Module = " (Module)",
	Property = " (Property)",
	Unit = " (Unit)",
	Value = " (Value)",
	Enum = " (Enum)",
	Keyword = " (Keyword)",
	Snippet = "",
	Color = " (Color)",
	File = " (File)",
	Reference = " (Reference)",
	Folder = "",
	EnumMember = " (EnumMember)",
	Constant = " (Constant)",
	Struct = " ﳤ (Struct)",
	Event = " (Event)",
	Operator = " (Operator)",
	TypeParameter = " (TypeParameter)",
}

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},

	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	}),
	formatting = {
		format = function(entry, item)
			item.kind = kind_icons[item.kind]
			if entry.source.name == "cmp_tabnine" then
				item.kind = ""
				if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
					item.kind = " (" .. entry.completion_item.data.detail .. " )"
				end
			end
			item.menu = ({
				buffer = "[Buffer]",
				cmp_tabnine = "[T9]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[NLUA]",
				treesitter = "[TS]",
				path = "[Path]",
				luasnip = "[Snippet]",
			})[entry.source.name]
			return item
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		-- { name = "cmp_tabnine" },
		{ name = "treesitter" },
		{ name = "buffer" },
		{ name = "path" },
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	experimental = {
		ghost_text = true,
	},
})
