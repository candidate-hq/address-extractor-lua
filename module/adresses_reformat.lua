-- Модуль переформатирования адресов из pdf-постановления совета депутатов в формат, подходящий для вноса в таблицу округов и/или проверки на сайте domreestr.ru
--------MODULES--------------------------------------------------------------------
require "core"
local reformat = require "lib.reformat"
local common = require "lib.common"
--------VARIABLES------------------------------------------------------------------
local out_path = "output/adresses_reformat.txt"
-----------------------------------------------------------------------------------
local function main(addreses, city)
  if isT(addreses) then

    -- Раскомментировать строки (ниже) для удаления из вывода адресов округа с соответствующим номером:
    -- addreses[1] = nil
    -- addreses[2] = nil
    -- addreses[3] = nil
    -- addreses[4] = nil
    -- addreses[5] = nil

    -- Переформатирование в вид для вноса в таблицу округов
    local table_addreses = reformat.for_excel_table({}, addreses)
    -- Переформатирование в вид для скрипта проверки на сайте domreestr.ru
    local domr_addreses = reformat.for_domreestr_search({}, table_addreses, city)

    
    -- В зависимости от необходимости раскомментировать строки ниже:
    
    -- Печать в файл out_path адресов в формате для вноса в таблицу округов
    local status, err = common.write_output( out_path, table_addreses )
    
    -- Печать в файл out_path адресов в формате для скрипта проверки на сайте domreestr.ru
    -- local status, err = common.write_output( out_path, domr_addreses )
    
    print(status, err or '')
  end
end

return main(
  -- Источник данных для переформатирования:
  require "source.adresses_scherbinka", 'г. Москва, г. Щербинка, '
)


-- request_text = 'https://domreestr.ru/search/?q=Москва%2C+' + street + '.%2C+' + str(house)

-- https://github.com/evilmucedin/moscowElections2019
