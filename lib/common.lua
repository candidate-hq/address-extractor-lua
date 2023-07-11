-- Библиотека с функциями, общими для нескольких модулей

--------INDEPENDENT UTILS----------------------------------------------------------
local function write_output( o_path, o_data )
    local fd, err, status = io.open(o_path, "w")
    if fd then
      status, err = fd:write(o_data)
      if not err then  
        io.close(fd)
      end
    end
    return status, err
  end
  local function read_input( i_path )
    local fd, err, file = io.open(i_path, "r")
    if fd then
      file, err = fd:read("*a")
      if not err then  
        io.close(fd)
      end
    end
    return file, err
  end
  -----------------------------------------------------------------------------------
  return {
    write_output = write_output,
    read_input = read_input,
  }