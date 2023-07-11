-- Библиотека с функциями переформатирования данных

local function fds_process(out, block, prefix)
  if isS(block) then
    for row in block:gmatch('(.-)\n') do
      if row:find('Округ №') then
        insert(out, row)
      else
        local line = (prefix ..
            row:gsub('(..-) улица,', 'ул. %1'):gsub('^Улица', 'Ул.'):gsub('^улица', 'Ул.'):gsub('^Квартал'
              , 'тер. квартал'):gsub(',? дом', ', д.'))
        --:gsub(',', '%%2C'):gsub(' ', '+'):gsub('/', '%%2F')
        insert(out, ("'%s',"):format(line))
      end
    end
  end
  return out
end

local function for_domreestr_search(out, data, prefix)
  -- local prefix = 'г. Москва, г. Щербинка, '
  local sh_prefix = isS(prefix) or ''
  if isT(out) then
    if isT(data) then
      for n, row in pairs(data) do
        insert(out, "Округ №" .. n)
        fds_process(out, row, sh_prefix)
      end
    elseif isS(data) then
      fds_process(out, data, sh_prefix)
    end
  end
  return out and table.concat(out, "\n")
end

local function fet_process(out, row)
  if isS(row) then
    for street, houses in row:gmatch('%s*(.-)%s*:%s*(.-)%s*[%.;]\n') do
      local st_rpl = street:gsub('ул. (..*)', '%1 улица'):gsub('Ул. (..*)', '%1 улица'):gsub('тер. квартал'
        , 'Квартал')
      local h_rpl = houses:gsub('%s*корп%.?%s*', 'к')
      for hn in (h_rpl .. ','):gmatch('([%d/\\АаБбВвКк]*),') do
        insert(out, st_rpl .. ", дом " .. hn)
      end
    end
  end
  return out
end

local function for_excel_table(out, data)
  if isT(out) then
    if isT(data) then
      for n, row in pairs(data) do
        insert(out, "Округ №" .. n)
        fet_process(out, row)
      end
    elseif isS(data) then
      fet_process(out, data)
    end
  end
  return out and table.concat(out, "\n")
end

return {
  for_domreestr_search = for_domreestr_search,
  for_excel_table = for_excel_table,
}
