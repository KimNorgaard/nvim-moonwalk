local bit = require 'bit'
local band, rshift = bit.band, bit.rshift

local M = {}

local SA98G = {
  mainTRC = 2.4, -- 2.4 exponent for emulating actual monitor perception
  -- G-4g constants for use with 2.4 exponent
  normBG = 0.56,
  normTXT = 0.57,
  revTXT = 0.62,
  revBG = 0.65,

  -- G-4g Clamps and Scalers
  blkThrs = 0.022,
  blkClmp = 1.414,
  scaleBoW = 1.14,
  scaleWoB = 1.14,
  loBoWoffset = 0.027,
  loWoBoffset = 0.027,
  deltaYmin = 0.0005,
  loClip = 0.1,
}

-- sRGB coefficients
local RGBCO = {
  sRcoX = 0.4124564,
  sGcoX = 0.3575761,
  sBcoX = 0.1804375,

  sRcoY = 0.2126729,
  sGcoY = 0.7151522,
  sBcoY = 0.0721750,

  sRcoZ = 0.0193339,
  sGcoZ = 0.1191920,
  sBcoZ = 0.9503041,
}

function M.rgb(num)
  local r, g, b = rshift(num, 16), band(rshift(num, 8), 0x00ff), band(num, 0x0000ff)
  return { r, g, b }
end

function M.hex2rgb(hex)
  local num = tonumber(hex:sub(2), 16)
  return M.rgb(num)
end

function M.color2rgb(color)
  if type(color) == 'string' and color:sub(1, 1) == '#' then
    return M.hex2rgb(color)
  end
  return M.rgb(color)
end

function M.sRGB2y(rgb)
  local function simple_exp(chan)
    return math.pow(chan / 255.0, SA98G.mainTRC)
  end
  return RGBCO.sRcoY * simple_exp(rgb[1]) + RGBCO.sGcoY * simple_exp(rgb[2]) + RGBCO.sBcoY * simple_exp(rgb[3])
end

-- @ref: https://github.com/Myndex/apca-w3/blob/master/src/apca-w3.js
function M.apca_contrast(txt_y, bg_y)
  local icp = { 0.0, 1.1 }
  if math.min(txt_y, bg_y) < icp[1] or math.max(txt_y, bg_y) > icp[2] then
    return 0.0
  end

  local SAPC = 0.0
  local output_contrast = 0.0

  -- //////////   BLACK SOFT CLAMP   ////////////////////////////////////////
  -- // Soft clamps Y for either color if it is near black.
  txt_y = (txt_y > SA98G.blkThrs) and txt_y or txt_y + math.pow(SA98G.blkThrs - txt_y, SA98G.blkClmp)
  bg_y = (bg_y > SA98G.blkThrs) and bg_y or bg_y + math.pow(SA98G.blkThrs - bg_y, SA98G.blkClmp)

  -- ///// Return 0 Early for extremely low ∆Y
  if math.abs(bg_y - txt_y) < SA98G.deltaYmin then
    return 0.0
  end

  -- //////////   APCA/SAPC CONTRAST - LOW CLIP (W3 LICENSE)  ///////////////
  if bg_y > txt_y then -- For normal polarity, black text on white (BoW)
    -- Calculate the SAPC contrast value and scale
    SAPC = (math.pow(bg_y, SA98G.normBG) - math.pow(txt_y, SA98G.normTXT)) * SA98G.scaleBoW

    -- Low Contrast smooth rollout to prevent polarity reversal
    -- and also a low-clip for very low contrasts
    output_contrast = (SAPC < SA98G.loClip) and 0.0 or SAPC - SA98G.loBoWoffset
  else
    -- For reverse polarity, light text on dark (WoB)
    -- WoB should always return negative value.

    SAPC = (math.pow(bg_y, SA98G.revBG) - math.pow(txt_y, SA98G.revTXT)) * SA98G.scaleWoB

    output_contrast = (SAPC > -SA98G.loClip) and 0.0 or SAPC + SA98G.loWoBoffset
  end

  return output_contrast * 100.0
end

function M.calc_apca(text_color, bg_color)
  local bg_clr = M.color2rgb(bg_color)
  local tx_clr = M.color2rgb(text_color)
  return M.apca_contrast(M.sRGB2y(tx_clr), M.sRGB2y(bg_clr))
end

function M.sRGB2XYZ(rgb)
  for i = 1, 3 do
    local c = rgb[i] / 255.0
    if c > 0.04045 then
      rgb[i] = math.pow((c + 0.055) / 1.055, SA98G.mainTRC)
    else
      rgb[i] = c / 12.92
    end
    rgb[i] = rgb[i] * 100
  end

  local x = RGBCO.sRcoX * rgb[1] + RGBCO.sGcoX * rgb[2] + RGBCO.sBcoX * rgb[3]
  local y = RGBCO.sRcoY * rgb[1] + RGBCO.sGcoY * rgb[2] + RGBCO.sBcoY * rgb[3]
  local z = RGBCO.sRcoZ * rgb[1] + RGBCO.sGcoZ * rgb[2] + RGBCO.sBcoZ * rgb[3]
  return { x, y, z }
end

return M
