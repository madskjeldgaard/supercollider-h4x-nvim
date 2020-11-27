-- COMMAND
-- :SCGetSource
-- Download source code for supercollider (for developing)
vim.cmd("command! SCGetSource lua require('supercollider-h4x').get_sc_source()")

-- COMMAND
-- :SCNewPlugin
-- Create a plugin project using a cookiecutter template
vim.cmd("command! SCNewPlugin lua require('supercollider-h4x').create_plugin()")

-- COMMAND
-- :SCNewQuark
-- Create a Quark project using a cookiecutter template
vim.cmd("command! SCNewQuark lua require('supercollider-h4x').create_quark()")

-- COMMAND
-- :SCNVIMFuzzyHelp
-- Use fuzzy finding (fzf / skim) to search for help
vim.cmd("command! SCNvimFuzzyHelp lua require('supercollider-h4x').scnvim_fuzzy_help()")

-- COMMAND
-- :SCNvimFuzzyDefinitions
-- Use fuzzy finding (fzf / skim) to search for definitions
vim.cmd("command! SCNvimFuzzyDef lua require('supercollider-h4x').scnvim_fuzzy_definition()")

-- COMMAND
-- :SCCompileThis
-- Compile cpp plugin
vim.cmd("command! SCCompileThis lua require('supercollider-h4x').sc_compile_plugin()")

-- COMMAND
-- :GetSCHelpWatch
-- Download schelp-watch
vim.cmd("command! SCGetHelpWatch lua require('supercollider-h4x').get_schelp_watch()")

-- COMMAND
-- :SCHelpWatch
-- Run schelp-watch
vim.cmd("command! SCHelpWatch lua require('supercollider-h4x').schelp_watch()")
