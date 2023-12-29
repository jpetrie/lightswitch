# Lightswitch
Lightswitch is a Neovim plugin that automatically adjusts the value of `background` to match the macOS appearance theme.
It has no effect on non-macOS systems.

Lightswitch polls once at startup, and then regularly in the background at a controllable interval. During a poll, if
Lightswitch detects that the OS appearance theme is different from the value of `background`, it will set `background`
accordingly.

## Installation

Install via your plugin manager of choice. For example, via [`lazy.nvim`](https://github.com/folke/lazy.nvim):

```lua
{
  "jpetrie/lightswitch",
  opts = {
    -- See below for options.
  }
}
```

## Configuration

The `interval` option, measured in milliseconds, represents how often Lightswitch will check the state of the
appearance theme. If it is negative or zero, Lightswitch will only perform the initial startup poll.

The `callback` option is a function that will be invoked after Lightswitch has changed the value of `background`.
The new value of `background` will be passed to the function as a string.

