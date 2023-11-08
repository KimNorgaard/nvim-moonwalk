local function syntax(opts)
	local c = opts.colors
	return {
		Comment = { fg = c.fg_soft, italic = true },

		Constant = { fg = c.red },
		String = { fg = c.green },
		Character = { link = 'String' },
		Number = { fg = c.red },
		Boolean = { fg = c.red },
		Float = { fg = c.red },

		Identifier = { fg = c.blue },
		Function = { fg = c.blue_bold },

		Statement = { fg = c.blue_cool },
		Conditional = { fg = c.blue_cool },
		Repeat = { fg = c.blue_cool },
		Label = { fg = c.blue_cool_bold },
		Operator = { fg = c.blue_cool },
		Keyword = { fg = c.blue_cool },
		Exception = { fg = c.gold },

		PreProc = { fg = c.blue_alt },
		Include = { fg = c.blue_alt },
		Define = { fg = c.blue_alt },
		Macro = { fg = c.gold_bold },
		PreCondit = { fg = c.blue_alt_bold },


		Type = { fg = c.purple },
		StorageClass = { fg = c.purple_bold },
		Structure = { fg = c.purple },
		Typedef = { fg = c.purple },

		Special = { fg = c.red_bolder },
		SpecialChar = { fg = c.red_bolder },
		Tag = { fg = c.red_bold },
		Delimiter = { fg = c.fg },
		SpecialComment = { fg = c.red },
		Debug = { fg = c.red },

		Underlined = { fg = c.red_bold },
		Ignore = { fg = c.fg_softer },
		Error = { fg = c.red },
		Todo = { fg = c.green_bold },
	}
end

return syntax
