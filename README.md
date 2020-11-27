# supercollider-h4x-nvim
SuperCollider hacks for nvim written in lean Lua

These make use of a range of command line tools in conjunction with NeoVim's built in terminal to create a bunch of useful convenience functions and features for working with [SuperCollider](https://supercollider.github.io/) code as well as doing development work for SuperCollider (including help files, cpp code and plugins).

This plugin is meant to be a companion to [David Grantrom's scnvim plugin](https://github.com/davidgranstrom/scnvim)

# Requirements

Nvim >= 0.5

## Dependencies

Run `:checkhealth` to see if you fullfill the depencies.

- [fzf.vim](https://github.com/junegunn/fzf.vim) or [skim.vim](https://github.com/lotabout/skim.vim)
- [scnvim](https://github.com/davidgranstrom/scnvim)
- [schelp-watch](https://github.com/elgiano/schelp-watch) 
- [cookiecutter](https://cookiecutter.readthedocs.io/en/1.7.2/installation.html)

# Usage

To use these functions you need to call the setup function. This can be done in a number of ways, but perhaps the simplest is to add this to your `init.vim`:

```vimscript
autocmd filetype supercollider,scnvim,scdoc,supercollider.help lua require'supercollider-h4x'.setup()
```

# Available commands

![new plugin](/assets/newplugin.gif)

`:SCNewPlugin`

Create a plugin project using [this cookiecutter template](https://github.com/supercollider/cookiecutter-supercollider-plugin)

This will open up a terminal with a questionnaire. Answering the questions will generate and populate a new plugin project.

Requires [cookiecutter](https://cookiecutter.readthedocs.io/en/1.7.2/installation.html)

![new quark](/assets/newquark.gif)

`:SCNewQuark`

Create a Quark project using [this cookiecutter template](https://github.com/madskjeldgaard/cookiecutter-quark)

This will open up a terminal with a questionnaire. Answering the questions will generate and populate a new quark project.

Requires [cookiecutter](https://cookiecutter.readthedocs.io/en/1.7.2/installation.html)

![fuzzy help](/assets/fuzzyhelp.gif)

`:SCNVIMFuzzyHelp`

Use fuzzy finding (fzf / skim) to search for help

Requires [scnvim](https://github.com/davidgranstrom/scnvim) and either [fzf.vim](https://github.com/junegunn/fzf.vim) or [skim.vim](https://github.com/lotabout/skim.vim)

![fuzzy def](/assets/fuzzydef.gif)

`:SCNvimFuzzyDef`

Use fuzzy finding (fzf / skim) to search for definitions

Requires [scnvim](https://github.com/davidgranstrom/scnvim) and either [fzf.vim](https://github.com/junegunn/fzf.vim) or [skim.vim](https://github.com/lotabout/skim.vim)

![schelp-watch](/assets/schelp-watch.gif)

`:SCHelpWatch`

Run schelp-watch, a little helper tool that runs the help docs you are working on in a browser and recompiles it every time you make a change.

See [schelp-watch](https://github.com/elgiano/schelp-watch) for dependencies.

`:SCGetHelpWatch`

Download schelp-watch to to this plugin's diretory. This happens automatically when you use `:SCHelpWatch`

`:SCCompileThis`

Compile cpp plugin

`:SCGetSource`

Download source code for supercollider (for developing)

# Options

```lua
-- Option: choose fuzzy command ("fzf" or "skim") to use
vim.g.scnvim_fuzzy_command = "skim"

-- Option: path to supercollider development source code for compiling plugins
vim.g.sc_source_code = "$HOME/supercollider"

-- Option: Where to put a newly generated quark
vim.g.sc_quark_path = "$HOME/.local/share/SuperCollider/Extensions"

-- Option: Where to put a newly generated plugin
vim.g.sc_plugin_dir = vim.g.sc_quark_path or "$HOME/.local/share/SuperCollider/Extensions"
```
