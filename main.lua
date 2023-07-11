require "core"

local reformat = require "lib.reformat"

local function main(addreses)
  if isT(addreses) then
    addreses[1] = nil
    addreses[2] = nil
    addreses[3] = nil
    -- addreses[4] = nil
    addreses[5] = nil

    local city = 'г. Москва, г. Щербинка, '
    local exc_addreses = reformat.for_excel_table({}, addreses)
    local domr_addreses = reformat.for_domreestr_search({}, exc_addreses, city)

    -- print(exc_addreses)
    print(domr_addreses)
  end
end

return main(require "source.adresses_scherbinka")

-- require "module.cik_voice_load"

-- request_text = 'https://domreestr.ru/search/?q=Москва%2C+' + street + '.%2C+' + str(house)

-- https://github.com/evilmucedin/moscowElections2019

-- http://vybory.izbirkom.ru/region/izbirkom
