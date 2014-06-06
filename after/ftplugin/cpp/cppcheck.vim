"=============================================================================
" File: cpp_cppcheck.vim
" Description: cpp cppcheck plugin
" Maintainer:  xusd-null.github.io
" License:     This program is free software. It comes without any warranty.
"=============================================================================

if exists("b:loaded_cppcheck_ftplugin")
	finish
endif
let b:loaded_cppcheck_ftplugin=1


function! s:CppCheck()
	if !executable("cppcheck")
		return
	endif
	let l:error_fmt = "\[%f:%l\]:\ (%t%s)\ %m"
	let l:cppcheck_prg = "cppcheck --enable=all "

	if exists('g:cppcheck_prg')
		let l:cppcheck_prg = g:cppcheck_prg
	endif
	if exists('b:cppcheck_prg')
		let l:cppcheck_prg = b:cppcheck_prg
	endif
	if !exists('l:cppcheck_prg')
		let l:cppcheck_prg = 'cppcheck'
	endif

	if exists('g:cppcheck_options')
		let l:cppcheck_options = g:cppcheck_options
	endif
	if exists('b:cppcheck_options')
		let l:cppcheck_options = b:cppcheck_options
	endif
	if !exists('l:cppcheck_options')
		let l:cppcheck_options = '-I.'
	endif
	let l:checkoptions = {'checkprg': l:cppcheck_prg . ' ' . l:cppcheck_options, 'checkerrorfmt': l:error_fmt}
	call staticcodeanalysis#analysis#StaticCheck(l:checkoptions)
endfunction

if exists("b:cppcheck_map")
	exec 'nnoremap <silent> <buffer> ' .b:cppcheck_map . ' :call <SID>CppCheck()<CR>'
elseif exists("g:cppcheck_map")
	exec 'nnoremap <silent> <buffer> ' .g:cppcheck_map . ' :call <SID>CppCheck()<CR>'
endif


