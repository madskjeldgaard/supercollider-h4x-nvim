<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [supercollider-h4x-nvim](#supercollider-h4x-nvim)
- [Requirements](#requirements)
  - [Dependencies](#dependencies)
  - [Install](#install)
  - [See also](#see-also)
- [Usage](#usage)
- [Available commands](#available-commands)
  - [Plugins / extensions](#plugins--extensions)
    - [SCNewPlugin](#scnewplugin)
    - [SCNewQuark](#scnewquark)
  - [Help file development](#help-file-development)
    - [SCHelpWatch](#schelpwatch)
    - [SCGetHelpWatch](#scgethelpwatch)
    - [SCHelpWatch](#schelpwatch-1)
  - [Help file navigation / search](#help-file-navigation--search)
    - [SCNVIMFuzzyHelp](#scnvimfuzzyhelp)
    - [SCExternalHelpOpen SinOsc](#scexternalhelpopen-sinosc)
    - [SCExternalHelpSearch](#scexternalhelpsearch)
    - [SCNvimFuzzyDef](#scnvimfuzzydef)
  - [File loading](#file-loading)
    - [SCLoad <file>](#scload-file)
    - [SCLoadRel <file>](#scloadrel-file)
    - [SCLoadMain](#scloadmain)
  - [Gui stuff](#gui-stuff)
    - [SCServerGui](#scservergui)
    - [SCServerMeter](#scservermeter)
    - [SCServerPlotTree](#scserverplottree)
    - [SCServerScope](#scserverscope)
  - [Code generation](#code-generation)
    - [SCGeneratePattern](#scgeneratepattern)
- [Options](#options)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

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

## Install
To install using vim-plug
1. Add this to your init.vim / .vimrc:
`Plug 'madskjeldgaard/supercollider-h4x-nvim'`
2. Open Vim and run the command `:PlugInstall`

## See also

- [scnvim](https://github.com/davidgranstrom/scnvim) / [scvim](https://github.com/supercollider/scvim)
- [vim-scdoc-snippets](https://github.com/madskjeldgaard/vim-scdoc-snippets) (for UltiSnips)
- [lua-supercollider-snippets](https://github.com/madskjeldgaard/lua-supercollider-snippets/) (for snippets.nvim)

# Usage

To use these functions you need to call the setup function. This can be done in a number of ways, but perhaps the simplest is to add this to your `init.vim`:

```vimscript
autocmd filetype supercollider,scnvim,scdoc,supercollider.help lua require'supercollider-h4x'.setup()
```

# Available commands

## Plugins / extensions


### SCNewPlugin

![new plugin](/assets/newplugin.gif)

`:SCNewPlugin`

Create a plugin project using [this cookiecutter template](https://github.com/supercollider/cookiecutter-supercollider-plugin)

This will open up a terminal with a questionnaire. Answering the questions will generate and populate a new plugin project.

Requires [cookiecutter](https://cookiecutter.readthedocs.io/en/1.7.2/installation.html)


### SCNewQuark

![new quark](/assets/newquark.gif)

`:SCNewQuark`

Create a Quark project using [this cookiecutter template](https://github.com/madskjeldgaard/cookiecutter-quark)

This will open up a terminal with a questionnaire. Answering the questions will generate and populate a new quark project.

Requires [cookiecutter](https://cookiecutter.readthedocs.io/en/1.7.2/installation.html)


## Help file development

### SCHelpWatch

![schelp-watch](/assets/schelp-watch.gif)

`:SCHelpWatch`

Run schelp-watch, a little helper tool that runs the help docs you are working on in a browser and recompiles it every time you make a change.

See [schelp-watch](https://github.com/elgiano/schelp-watch) for dependencies.

### SCGetHelpWatch

`:SCGetHelpWatch`

### SCHelpWatch

Download schelp-watch to to this plugin's diretory. This happens automatically when you use `:SCHelpWatch`

## Help file navigation / search


### SCNVIMFuzzyHelp

![fuzzy help](/assets/fuzzyhelp.gif)

`:SCNVIMFuzzyHelp`

Use fuzzy finding (fzf / skim) to search for help

Requires [scnvim](https://github.com/davidgranstrom/scnvim) and either [fzf.vim](https://github.com/junegunn/fzf.vim) or [skim.vim](https://github.com/lotabout/skim.vim)

`:SCExternalHelpOpen
`
### SCExternalHelpOpen SinOsc

Open external QT help browser page for class. Eg: `:SCExternalHelpOpen SinOsc`

### SCExternalHelpSearch

`:SCExternalHelpSearch`
Open external QT help browser search page


### SCNvimFuzzyDef

![fuzzy def](/assets/fuzzydef.gif)

`:SCNvimFuzzyDef`

Use fuzzy finding (fzf / skim) to search for definitions

Requires [scnvim](https://github.com/davidgranstrom/scnvim) and either [fzf.vim](https://github.com/junegunn/fzf.vim) or [skim.vim](https://github.com/lotabout/skim.vim)

## File loading

### SCLoad <file>

`:SCLoad <file>` 

Load <file> in SuperCollider

### SCLoadRel <file>

`:SCLoadRel <file>` 

Relatively load <file> in SuperCollider

### SCLoadMain

`:SCLoadMain` 

Load "main.scd" from root of current dir

## Gui stuff

### SCServerGui

`:SCServerGui`

Open server gui

### SCServerMeter

`:SCServerMeter`

Open server meter

### SCServerPlotTree

`:SCServerPlotTree`

Open server plot tree

### SCServerScope

`:SCServerScope`

Open server scope

## Code generation

### SCGeneratePattern 

![pattern inserter code generator in action](/assets/pattern-inserter.gif)

`:SCGeneratePattern synthdef_name`

This will generate a Pbind with key/value pairs for all of a Synthdef's arguments and insert it into a text document. 


# Options


Options may be defined in either vimscript or lua. Here is how to do it in Lua:
```lua

-- Option: choose fuzzy command ("fzf" or "skim") to use
vim.g.scnvim_fuzzy_command = "skim"

-- Option: Where to put a newly generated quark
vim.g.sc_quark_path = "$HOME/.local/share/SuperCollider/Extensions"

-- Option: Where to put a newly generated plugin
vim.g.sc_plugin_dir = "$HOME/.local/share/SuperCollider/Extensions"

-- Option: Set custom urls for cookiecutter recipes (if you have a nice fork or something)
vim.g.sc_plugin_recipe = "https://github.com/supercollider/cookiecutter-supercollider-plugin"
vim.g.sc_quark_recipe = "https://github.com/madskjeldgaard/cookiecutter-quark"

```
