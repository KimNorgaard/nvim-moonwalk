local M = {}

local C = {
  primary_bold = '#105bd8',
  primary = '#0b3d91',
  fg = '#061f4a',
  fg_bold = '#212121',
  gray = '#5b616b',
  gray_dark = '#323a45',
  gray_light = '#aeb0b5',
  gray_lighter = '#d6d7d9',
  gray_lightest = '#f1f1f1',
  fg_soft = '#494440',
  bg = '#e4e2e0',
  bg2 = '#8ba6ca',
  fg_softer = '#8c8a8a',
  white = '#ffffff',
  alt_bolder = '#02bfe7',
  alt = '#046b99',
  alt_bold = '#00a6d2',
  alt_soft = '#9bdaf1',
  alt_bg = '#e1f3f8',
  red_bolder = '#dd361c',
  red = '#801a17',
  red_bold = '#c22c1f',
  red_soft = '#c4837a',
  red_bg = '#f9e0de',
  gold = '#61330e',
  gold_bold = '#965c12',
  gold_bolder = '#ff9d1e',
  gold_soft = '#f9aa43',
  gold_softer = '#ffc375',
  gold_bg = '#ffebd1',
  green = '#174A24',
  green_bold = '#29783b',
  green_soft = '#4aa564',
  green_softer = '#94bfa2',
  green_bg = '#e7f4e4',
  blue = '#205493',
  blue_bold = '#426b9e',
  blue_bg = '#dce4ef',
  purple_bold = '#6F46C8',
  purple = '#4c2c92',
}

M.default = {
  none = 'NONE',
  bg = C.bg,
  bg2 = C.bg2,
  bg_popup = C.gray_lightest,
  bg_popup_line = C.blue_bg,
  bg_float = C.gray_lightest,
  fg = C.fg,
  fg_bold = C.fg_bold,
  fg_soft = C.fg_soft,
  fg_softer = C.fg_softer,
  fg_softest = C.gray_light,

  white = C.white,
  gray = C.gray,
  gray_dark = C.gray_dark,
  primary_bold = C.primary_bold,
  primary = C.primary,
  alt_bg = C.alt_bg,
  alt = C.alt,
  alt_bold = C.alt_bold,
  alt_bolder = C.alt_bolder,
  alt_soft = C.alt_soft,
  blue_bg = C.blue_bg,
  blue = C.blue,
  blue_bold = C.blue_bold,
  red_bolder = C.red_bolder,
  red_bold = C.red_bold,
  red_soft = C.red_soft,
  red = C.red,
  red_bg = C.red_bg,
  gold_bolder = C.gold_bolder,
  gold_bold = C.gold_bold,
  gold = C.gold,
  gold_soft = C.gold_soft,
  gold_softer = C.gold_softer,
  gold_bg = C.gold_bg,
  green_soft = C.green_soft,
  green_softer = C.green_softer,
  green = C.green,
  green_bold = C.green_bold,
  green_bg = C.green_bg,
  purple_bold = C.purple_bold,
  purple = C.purple,

  diff_add = C.green_bg,
  diff_delete = C.red_bg,
  diff_change = C.green_bg,
  diff_text = C.green_softer,

  search = C.gold_bg,
  inc_search = C.gold_soft,
  visual = C.gold_softer,
  current_line = C.gray_lighter,

  term_black = C.bg,
  term_bright_black = C.gray,

  term_red = C.red,
  term_bright_red = C.red_bolder,

  term_green = C.green,
  term_bright_green = C.green_bold,

  term_yellow = C.gold,
  term_bright_yellow = C.gold_bold,

  term_blue = C.primary,
  term_bright_blue = C.primary_bold,

  term_purple = C.purple,
  term_bright_purple = C.purple_bold,

  term_cyan = C.blue,
  term_bright_cyan = C.blue_bold,

  term_white = C.fg,
  term_bright_white = C.fg_bold,
}

return M
