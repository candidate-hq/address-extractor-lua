require "core"

local reformat = require "lib.reformat"

local function main(addreses, city)
  if isT(addreses) then
    addreses[1] = nil
    addreses[2] = nil
    addreses[3] = nil
    addreses[4] = nil
    addreses[5] = nil

    local exc_addreses = reformat.for_excel_table({}, addreses)
    local domr_addreses = reformat.for_domreestr_search({}, exc_addreses, city)

    local out_path = "output/main.txt"
    local fd = io.open(out_path, "w")
    if fd then
      -- print(fd:write(exc_addreses))
      print(fd:write(domr_addreses))

      io.close(fd)
    end
  end
end

return main(
  require "source.adresses_scherbinka", 'г. Москва, г. Щербинка, '
)

-- require "module.cik_voice_load"

-- request_text = 'https://domreestr.ru/search/?q=Москва%2C+' + street + '.%2C+' + str(house)

-- https://github.com/evilmucedin/moscowElections2019

-- http://vybory.izbirkom.ru/region/izbirkom
