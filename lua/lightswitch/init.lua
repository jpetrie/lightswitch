local lightswitch = {
  options = {
    interval = 1000,
    callback = nil
  }
}

local function update(background)
  -- Avoid redundantly setting the background or invoking the callback.
  if background ~= vim.api.nvim_get_option_value("background", {}) then
    vim.api.nvim_set_option_value("background", background, {})
    if lightswitch.options.callback ~= nil then
      lightswitch.options.callback(background)
    end
  end
end

local function check()
  vim.fn.jobstart("defaults read -g AppleInterfaceStyle", {
    on_exit = function(_, result, _)
      if result == 1 then
        update("light")
      else
        update("dark")
      end
    end
  })
end

function lightswitch.setup(options)
  lightswitch.options = vim.tbl_deep_extend("keep", lightswitch.options, options)

  if vim.fn.has("mac") then
    -- Always check once during setup.
    check()

    -- Subsequent periodic checks only occur if the user has set an appropriate poll interval.
    local interval = lightswitch.options.interval
    if interval > 0 then
      local timer = vim.loop.new_timer()
      timer:start(interval, interval, vim.schedule_wrap(function() check() end))
    end
  end
end

return lightswitch
