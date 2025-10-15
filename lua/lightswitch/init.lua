local M = {
  --- @class (exact) lightswitch.Options
  --- @field interval number The number of milliseconds between appearance checks.
  options = {
    interval = 1000,
  },
}

local function update(background)
  if background ~= vim.api.nvim_get_option_value("background", {}) then
    vim.api.nvim_set_option_value("background", background, {})
  end
end

local function check()
  local command = {"defaults", "read", "-g", "AppleInterfaceStyle"}
  vim.system(command, {}, function(result)
    if result.code == 1 then
      vim.schedule(function() update("light") end)
    else
      vim.schedule(function() update("dark") end)
    end
  end)
end

--- @param options lightswitch.Options
M.setup = function(options)
  vim.validate("options", options, "table")
  M.options = vim.tbl_deep_extend("keep", options, M.options)

  vim.validate("options.interval", M.options.interval, "number")
  vim.validate("options.interval", M.options.interval, function(v) return v >= 0 end, "number >= 0")
  if vim.fn.has("mac") ~= 0 then
    -- Always check once during setup.
    check()

    -- Subsequent periodic checks only occur if the user has set an appropriate poll interval.
    local interval = M.options.interval
    if interval > 0 then
      local timer = vim.uv.new_timer()
      if timer ~= nil then
        timer:start(interval, interval, vim.schedule_wrap(check))
      else
        vim.notify("Lightswitch: Could not create a poll timer. Polling will be disabled.", vim.log.levels.ERROR)
      end
    end
  end
end

return M

