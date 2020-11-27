function! s:check_minimum_nvim_version() abort
  if !has('nvim-0.5.0')
    call health#report_error('has(nvim-0.5.0)','scnvim requires nvim 0.5.0 or later')
  endif
endfunction

function! s:check_scnvim() abort
	if match(&runtimepath, 'scnvim') != -1
		call health#report_ok('scnvim is installed')
	else
		call health#report_error('scnvim is not installed')
	endif
endfunction

function! s:check_fuzzy() abort
	if match(&runtimepath, 'skim.vim') != -1
		call health#report_ok('skim.vim is installed')
	elseif match(&runtimepath, 'fzf.vim') != -1
		call health#report_ok('fzf.vim is installed')
	else
		call health#report_error('No fuzzy finder installed. Consider installing fzf.vim or skim.vim')
	endif
endfunction

function! s:check_schelp_watcher_deps() abort
	call health#report_info(system("pip show watchdog"))
endfunction

function! s:check_cookiecutter() abort
	if executable('cookiecutter') == 1
		call health#report_ok("cookiecutter is installed on the system")
	else
		call health#report_error("cookiecutter is not installed on the system")
	endif
endfunction

function! health#supercollider_h4x_nvim#check() abort
	call health#report_start('supercolliderh4xnvim')

	call s:check_scnvim()
	call s:check_minimum_nvim_version()
	call s:check_cookiecutter()
	call s:check_fuzzy()
	call s:check_schelp_watcher_deps()
endfunction
