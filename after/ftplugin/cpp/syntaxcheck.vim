"=============================================================================
" File: cpp_syntaxcheck_webkit.vim
" Description: cpp syntax checking plugin
" Maintainer:  xusd-null.github.io
" License:     This program is free software. It comes without any warranty.
"=============================================================================

if exists("b:loaded_cppsyntaxcheck_ftplugin")
    finish
endif
let b:loaded_cppsyntaxcheck_ftplugin=1


function! s:CppSyntaxCheck()
	let l:error_fmt = '%-G%f:%s:,%f:%l:%c: %trror: %m,%f:%l:%c: %tarning: '.
				\ '%m,%f:%l:%c: %m,%f:%l: %trror: %m,%f:%l: %tarning: %m,'.
				\ '%f:%l: %m'

	if exists('g:cpp_compiler_cmd')
		let l:cpp_compiler_cmd = g:cpp_compiler_cmd
	endif
	if exists('b:cpp_compiler_cmd')
		let l:cpp_compiler_cmd = b:cpp_compiler_cmd
	endif
	if !exists('l:cpp_compiler_cmd')
		let l:cpp_compiler_cmd = 'g++'
	endif

	if exists('g:cpp_compiler_options')
		let l:cpp_compiler_options = g:cpp_compiler_options
	endif
	if exists('b:cpp_compiler_options')
		let l:cpp_compiler_options = b:cpp_compiler_options
	endif
	if !exists('l:cpp_compiler_options')
		let l:cpp_compiler_options = '-I.'
	endif

	let l:cpp_compiler_options .= ' -fsyntax-only'
	let l:check_prg = l:cpp_compiler_cmd . ' ' . l:cpp_compiler_options

	let l:checkoptions = {'checkprg': l:check_prg, 'checkerrorfmt': l:error_fmt}

	call staticcodeanalysis#analysis#StaticCheck(l:checkoptions)
endfunction

if exists('b:cppsyntaxcheck_map')
exec 'nnoremap <silent> <buffer> ' . b:cppsyntaxcheck_map . ' :call <SID>CppSyntaxCheck()<CR>'
elseif exists('g:cppsyntaxcheck_map')
exec 'nnoremap <silent> <buffer> ' . g:cppsyntaxcheck_map . ' :call <SID>CppSyntaxCheck()<CR>'
endif


