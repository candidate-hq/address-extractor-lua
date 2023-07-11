-- Модуль/библиотека с самыми часто используемыми функциями
--------VARIABLES------------------------------------------------------------------
local __mode_v = { __mode = "v" }
--------INDEPENDENT UTILS----------------------------------------------------------
function d(x) return unpack(x) end

function l(x) return setmetatable(x, __mode_v) end

pG, nG = "[%w%p%s\b\f\n\r\t\v]", "[^%w%p%s\b\f\n\r\t\v]"
toS, toN = tostring, tonumber
NaN, Inf = 0 / 0, math.huge
function isNorS(x) return toN(x) or isS(x) end

function isNaN(x) return isN(x) and x ~= x or nil end

function toB(x) if toS(x) == "false" then return false elseif toS(x) == "true" then return true else return x end end

function isN(x) return type(x) == "number" and x or nil end

function isU(x) return type(x) == "userdata" and x or nil end

function isB(x) return type(x) == "boolean" or nil end

function isF(x) return type(x) == "function" and x or nil end

function isS(x) return type(x) == "string" and x or nil end

function isT(x) return type(x) == "table" and x or nil end

function isL(x) return isT(x) and (x[1] ~= nil and x[#x] ~= nil or next(x) == nil) and x or nil end

function cst(x) return toN(x) or not isB(toB(x)) and x or toB(x) end

function typeControlInit(ctrl_f, def_val) return isF(ctrl_f) and function(x) return ctrl_f(x) or def_val end end

function quan(...) return select("#", ...) end

function set(z, x, y) z[x] = y return z end

function pSet(z, x, y) return x ~= nil and isT(z) and set(z, x, y) or nil end

function null() return nil end

function noop(...) return ... end

local function gc_st(x) return isT(x) and isF(x.__call) or nil end

local function get_call(x) return isF(x) or gc_st(x) or gc_st(getmetatable(x)) or nil end

function call(continue, ...) return (get_call(continue) or noop)(...) end

function run(x, continue, ...) return call(continue, x, ...) end

function cmp(x, ...) if x then return call(...) end end

function trm(x, ...) if x then return call(...) end return end

function vrf(x, y, ...) if x then return y, ... else return ... end end

function insert(z, ...) return isT(z) and table.insert(z, ...) or true and z end

function sort(z, ...) return isT(z) and table.sort(z, ...) or true and z end

function fill(z, x, y) return set(z, x, isT(z[x]) or {}) and insert(z[x], y) and true end

function mem() return toN(collectgarbage("count")) or 0 end

function loop_index(z) return pSet(z, "__index", function(_, x) return x and z[x] or nil end) or nil end

local function blur_st(v, m) return set(m, "__index", m["__index"] or v) and
      set(m, "__metatable", m["__metatable"] or v) or nil
end

local function blur_im(m) return isT(m) and set(m, "__call", m["__call"] or function() return m end) or nil end

function metalink(v, m) return blur_st(isT(v) or {}, blur_im(m) or {}) end

function null() return nil end

local function nEmT_st(x) return isT(x) and next(x) and true or nil end

function nEmT(x) return nEmT_st(x) or nEmT_st(isT(x) and getmetatable(x)) or nil end

function nEmL(x) return isL(x) and next(x) and true or nil end

function nEmS(x) return isS(x) and #x > 0 or nil end

local function itp_vrf(n, v) return trm(nEmL(v), noop, (n or 0) + 1, v) end

local function itp_cst(z) for k, v in pairs(z) do set(z, k, cst(v)) end return z end

local function itp_st(iter) return isF(iter) and function(_, n) return itp_vrf(n, itp_cst { iter() }) end or null end

function iParse(data, pattern) return itp_st(isS(data) and isS(pattern) and data:gmatch(pattern)) end
