-- Модуль разбора html-файлов с результатами голосования с сайта ЦИК
--------MODULES--------------------------------------------------------------------
require "core"
local fl = require "lib.fl"
local common = require "lib.common"
--------VARIABLES------------------------------------------------------------------
local out_path = "output/cik_voice_load.txt"

local pattern_1 = '.*(<table.->.-Наименование избирательной комиссии.-</table>)'
local pattern_2 = '.*(<table.->.-Число действительных .-бюллетеней.-</table>)'
-----------------------------------------------------------------------------------
local function main(out, input_path)
  if isS(input_path) then
    local file, err = common.read_input(input_path)
    if isS(file) then
      local tab1 = fl.tab.parse({}, file:match(pattern_1), 2)
      local tab2 = fl.tab.parse({}, fl.tab.filter(file:match(pattern_2)), 3)
      
      local choice_com_name = (tab1 and tab1[1][2] or ''):gsub('УИК №', '')
      if isT(tab2) then
        for _, row in pairs(tab2) do
          insert(out, ('%s\t%s\t\t%s\t%s\t'):format(choice_com_name, row[3], row[1], row[2]))
        end
      end
      
      local status, err = common.write_output( out_path, (table.concat(out,'\n') ) )
      print(status, err or '')
    end
  end
end

return main( {},
  
  -- Путь до html-файла с сайта ЦИК
  "source/cik_data/uik3432_2018"
)

-- Щербинка
-- http://www.vybory.izbirkom.ru/region/izbirkom?action=show&vrn=4774134374860&region=77&prver=0&pronetvd=null
-- http://www.vybory.izbirkom.ru/region/izbirkom?action=show&vrn=4774134176492&region=77&prver=0&pronetvd=null

-- http://vybory.izbirkom.ru/region/izbirkom