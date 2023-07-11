require "core"
local fl = require "lib.fl"

local uik_path = "source/cik_data/uik3432_2018"
local fd = io.open(uik_path, "r")
local file = fd:read("*a")
io.close(fd)

local pattern_1 = '.*(<table.->.-Наименование избирательной комиссии.-</table>)'
local pattern_2 = '.*(<table.->.-Число действительных .-бюллетеней.-</table>)'

local tab1 = fl.tab.parse({}, file:match(pattern_1), 2)
local tab2 = fl.tab.parse({}, fl.tab.filter(file:match(pattern_2)), 3)

local choice_com_name = (tab1 and tab1[1][2] or ''):gsub('УИК №', '')
for n, row in pairs(tab2) do
  print(choice_com_name, row[3], '', row[1], row[2]) --"N =", n,
end

-- Щербинка
-- http://www.vybory.izbirkom.ru/region/izbirkom?action=show&vrn=4774134374860&region=77&prver=0&pronetvd=null
-- http://www.vybory.izbirkom.ru/region/izbirkom?action=show&vrn=4774134176492&region=77&prver=0&pronetvd=null
