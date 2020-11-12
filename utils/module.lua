local modules = {}
function module(rsc, path)
    if path == nil then -- shortcut for vrp, can omit the resource parameter
      path = rsc
      rsc = "esx"
    end
  
    local key = rsc..path
  
    local module = modules[key]
    if module then -- cached module
      return module
    else
      local code = LoadResourceFile(rsc, path..".lua")
      if code then
        local f,err = load(code, rsc.."/"..path..".lua")
        if f then
          local ok, res = xpcall(f, debug.traceback)
          if ok then
            modules[key] = res
            return res
          else
            error("error loading module "..rsc.."/"..path..":"..res)
          end
        else
          error("error parsing module "..rsc.."/"..path..":"..debug.traceback(err))
        end
      else
        error("resource file "..rsc.."/"..path..".lua not found")
      end
    end
end

return modules