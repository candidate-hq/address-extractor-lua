-- Библиотека функций для разбора html-файлов с сайта ЦИК

local td_p_ed = '[%s\r\n]-'
local td_pat = '<td.-><?b?>?%s*(.-)%s*<?/?b?>?</td>'
local f_tr_pat = '<tr.->%s</tr>'

local fil_pat_1 = ('(.*)<tr.->%s<td.-><nobr><b>&nbsp;</b></nobr></td>%s</tr>'):format(td_p_ed, td_p_ed)
local rpl_pat_1 = '%1'

local function filter_tab(src)
  return isS(src) and src:gsub(fil_pat_1, rpl_pat_1)
end

local function parse_tab(out, src, col_n)
  if not (isT(out) and isS(src)) then return nil end
  local tmp_pat = ""
  for j = 1, col_n or 0 do
    tmp_pat = tmp_pat .. td_p_ed .. td_pat
  end
  tmp_pat = tmp_pat .. td_p_ed
  local tr_pat = f_tr_pat:format(tmp_pat)

  for n, row in iParse(src, tr_pat) do
    set(out, n, row)
  end

  return out
end

return {
  tab = { filter = filter_tab, parse = parse_tab }
}
