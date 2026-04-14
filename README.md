# Lightswitch
Lightswitch is a Neovim plugin that automatically adjusts the value of `background` to match the macOS appearance theme.
It has no effect on non-macOS systems.

Lightswitch polls once at setup time, and then regularly in the background at a controllable interval. During a poll, if
Lightswitch detects that the OS appearance theme is different from the value of `background`, it will set `background`
accordingly.

## Installation
Install Lightswitch using your plugin management solution of choice. Installation using Neovim 0.12's built-in plugin
manager looks like:

```lua
vim.pack.add({"https://github.com/jpetrie/lightswitch"})
```

Lightswitch must be activated by calling `setup()` (for example, in your `vimrc`). `setup()` accepts a table of options.
Unspecified options default to the values shown below:

```lua
require("lightswitch").setup({
  -- The interval in milliseconds between polling attempts. A value of zero
  -- prevents periodic polling, limiting Lightswitch to just the initial
  -- startup check.
  interval = 1000,
})
```

## Rationale
Neovim [natively supports background updates in response to OS theme changes](https://github.com/neovim/neovim/pull/31350),
which should render plugins like Lightswitch unneccessary. However, due to [an issue with the implementation](https://github.com/neovim/neovim/issues/32109),
there can be a visible flicker when Neovim starts as the background detection resolves after Neovim has rendered at
least once. This can be alleviated by manually setting `background` in `init.vim`, although doing so disables the
built-in detection of OS theme changes. Lightswitch and similar plugins re-enable that functionality.

