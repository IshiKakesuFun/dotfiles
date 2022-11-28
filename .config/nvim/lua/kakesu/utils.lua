local M = {}

M.copy_table = function(t)
  local copy = {}
  if type(t) == "table" then
    for k, v in pairs(t) do
      if type(v) == "table" then
        copy[k] = M.copy_table(v)
      else
        copy[k] = v
      end
    end
  end
  return copy
end

M.merge_table = function(left, right, copy)
  local merged_table = copy and M.copy_table(left) or left
  if type(left) == "table" and type(right) == "table" then
    -- merge the right table with override
    for k, v in pairs(right) do
      if type(v) == "table" and type(merged_table[k] or false) == "table" then
        merged_table[k] = M.merge_table(merged_table[k], v, copy)
      else
        merged_table[k] = v
      end
    end
  end
  return merged_table
end

M.in_array = function(array, value)
  for _, v in ipairs(array) do
    if value == v then
      return true
    end
  end
  return false
end

M.serialize_options = function(tbl)
  local serialized = ""
  local divider = ""
  if type(tbl) == "table" then
    for k, v in pairs(tbl) do
      serialized = serialized .. divider .. k .. ":" .. v
      divider = ","
    end
  end
  return serialized
end

M.serialize_table = function(tt, indent, done)
  done = done or {}
  indent = indent or 0
  if type(tt) == "table" then
    local sb = {}
    for key, value in pairs(tt) do
      table.insert(sb, string.rep(" ", indent)) -- indent it
      if type(value) == "table" and not done[value] then
        done[value] = true
        table.insert(sb, key .. " = {\n");
        table.insert(sb, M.serialize_table(value, indent + 2, done))
        table.insert(sb, string.rep(" ", indent)) -- indent it
        table.insert(sb, "}\n");
      elseif "number" == type(key) then
        table.insert(sb, string.format("\"%s\"\n", tostring(value)))
      else
        table.insert(sb, string.format("%s = \"%s\"\n", tostring(key), tostring(value)))
      end
    end
    return table.concat(sb)
  else
    return tt .. "\n"
  end
end

M.to_string = function(tbl)
  if "nil" == type(tbl) then
    return tostring(nil)
  elseif "table" == type(tbl) then
    return M.serialize_table(tbl)
  elseif "string" == type(tbl) then
    return tbl
  else
    return tostring(tbl)
  end
end

M.concat_path = function(...)
  local arg = { ... }
  local path = ""
  local divider = ""
  for _, dir in ipairs(arg) do
    path = path .. divider .. dir
    divider = PATH_SEPARATOR
  end
  return path
end

M.set_keymap = function(mode, opts, keymaps)
  for _, keymap in ipairs(keymaps) do
    vim.api.nvim_set_keymap(mode, keymap[1], keymap[2], opts)
  end
end

M.set_buf_keymap = function(bufnr, mode, opts, keymaps)
  for _, keymap in ipairs(keymaps) do
    vim.api.nvim_buf_set_keymap(bufnr, mode, keymap[1], keymap[2], opts)
  end
end

M.replace_hex_to_char = function()
  vim.cmd("normal yiw")
  local hex = vim.fn.getreg("0")
  vim.fn.setreg("0", vim.fn.nr2char(hex))
  vim.cmd("normal viwp")
  vim.cmd(vim.api.nvim_replace_termcodes("normal! <esc>", true, true, true))
end

M.replace_char_to_hex = function()
  vim.cmd([[normal vy]])
  local hex = vim.fn.getreg("0")
  vim.fn.setreg("0", "0x" .. vim.fn.printf("%04x", vim.fn.char2nr(hex)))
  vim.cmd("normal vp")
  vim.cmd(vim.api.nvim_replace_termcodes("normal! <esc>", true, true, true))
end

M.yank_hex_to_char = function()
  vim.cmd("normal yiw")
  local hex = vim.fn.getreg('"')
  vim.fn.setreg("0", vim.fn.nr2char(hex))
end

M.yank_char_to_hex = function()
  vim.cmd([[normal yl]])
  local hex = vim.fn.getreg('"')
  vim.fn.setreg("0", "0x" .. vim.fn.printf("%04x", vim.fn.char2nr(hex)))
end

return M
