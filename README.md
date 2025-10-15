# Lightswitch
Lightswitch is a Neovim plugin that automatically adjusts the value of `background` to match the macOS appearance theme.
It has no effect on non-macOS systems.

Lightswitch polls once at setup time, and then regularly in the background at a controllable interval. During a poll, if
Lightswitch detects that the OS appearance theme is different from the value of `background`, it will set `background`
accordingly.

## Installation
Install via your plugin manager of choice. For example, via [`lazy.nvim`](https://github.com/folke/lazy.nvim):

```lua
{
  "jpetrie/lightswitch",
  opts = {
    -- The interval, in milliseconds, between polling attempts. 0 prevents
    -- periodic polling, limiting Lightswitch to just the initial setup
    -- check. The default value is 1000.
    interval = 1000,
  }
}
```

## Rationale
Neovim [natively supports background updates in response to OS theme changes](https://github.com/neovim/neovim/pull/31350),
which should render plugins like Lightswitch unneccessary. However, due to [an issue with the implementation](https://github.com/neovim/neovim/issues/32109),
there can be a visible flicker when Neovim starts as the background detection resolves after Neovim has rendered at
least once. This can be alleviated by manually setting `background` in `init.vim`, although doing so disables the
built-in detection of OS theme changes. Lightswitch and similar plugins re-enable that functionality.

