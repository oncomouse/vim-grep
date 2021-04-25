# oncomouse's Grep plugin

Based on [romainl's discussion of `:Grep`](https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3) but with async support in Neovim.

## Usage

* `:Grep` / `:LGrep` -- Search using `&grepprg` (I recommend ripgrep or silversearcher) for the provided pattern.

The plugin will also open the relevant list (quickfix or location) when the command is complete.
