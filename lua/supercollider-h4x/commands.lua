-- COMMAND
-- :SCGetSource
-- Download source code for supercollider (for developing)
vim.cmd("command! SCGetSource lua require('supercollider-h4x/commands').get_sc_source()")

-- COMMAND
-- :SCPlugin
-- Create a plugin project using a cookiecutter template
vim.cmd("command! SCNewPlugin lua require('supercollider-h4x/commands').create_plugin()")

-- COMMAND
-- :SCQuark
-- Create a Quark project using a cookiecutter template
vim.cmd("command! SCNewQuark lua require('supercollider-h4x/commands').create_quark()")

-- COMMAND
-- :SCNVIMFuzzyHelp
-- Use fuzzy finding (fzf / skim) to search for help
vim.cmd("command! SCNvimFuzzyHelp lua require('supercollider-h4x/commands').scnvim_fuzzy_help()")

-- COMMAND
-- :SCNvimFuzzyDefinitions
-- Use fuzzy finding (fzf / skim) to search for definitions
vim.cmd("command! SCNvimFuzzyDefinitions lua require('supercollider-h4x/commands').scnvim_fuzzy_definition()")

-- COMMAND
-- :SCCompileThis
-- Compile cpp plugin
vim.cmd("command! SCCompileThis lua require('supercollider-h4x/commands').sc_compile_plugin()")

-- COMMAND
-- :GetSCHelpWatch
-- Download schelp-watch
vim.cmd("command! GetSCHelpWatch lua require('supercollider-h4x/commands').get_schelp_watch()")

-- COMMAND
-- :SCHelpWatch
-- Run schelp-watch
vim.cmd("command! SCHelpWatch lua require('supercollider-h4x/commands').schelp_watch()")
