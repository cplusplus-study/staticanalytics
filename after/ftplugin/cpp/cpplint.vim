"=============================================================================
" File: cpp_lint.vim
" Description: cpp lint plugin
" Maintainer:  xusd-null.github.io
" License:     This program is free software. It comes without any warranty.
"=============================================================================

if exists("b:loaded_cpplint_ftplugin")
	finish
endif
let b:loaded_cpplint_ftplugin=1

function! s:CppLint()
	let l:cpplint_cmd=staticcodeanalysis#analysis#GetCpplint()
	if executable("cpplint.py")
		let l:cpplint_cmd = 'cpplint.py'
	endif

	let l:cpplint_prg = l:cpplint_cmd . " --filter=-whitespace/line_length,-whitespace/comma,-whitespace/labels"
	let l:error_fmt = "%f:%l: %m"

	let l:cpplintoptions = {'checkprg': l:cpplint_prg, 'checkerrorfmt': l:error_fmt, 'okmsg': 'cpplint ok!!!'}
	call staticcodeanalysis#analysis#StaticCheck(l:cpplintoptions)
endfunction

if exists("b:cpplint_map")
exec 'nnoremap <silent> <buffer> ' . b:cpplint_map . ' :call <SID>CppLint()<CR>'
elseif exists("g:cpplint_map")
exec 'nnoremap <silent> <buffer> ' . g:cpplint_map . ' :call <SID>CppLint()<CR>'
endif

