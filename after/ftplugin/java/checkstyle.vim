"=============================================================================
" File: java_checksytle.vim
" Description: java sytle checking plugin
" Maintainer:  xusd-null.github.io
" License:     This program is free software. It comes without any warranty.
"=============================================================================

if exists("b:loaded_javalint_ftplugin")
    finish
endif
let b:loaded_javalint_ftplugin=1

function! s:JavaCheckStyle()
	if !executable('java')
		echoerr "java not found. Please install it first."
		return
	endif
	let l:stylecheck_prog = ''
	let l:check_config = ''
	if exists("g:checkstyle_checkconfig") && filereadable(g:checkstyle_checkconfig)
		let l:check_config = g:checkstyle_checkconfig
	else
		let l:check_config = staticcodeanalysis#analysis#GetDefaultCheckstyleConfigerFile()
		if !filereadable(l:check_config)
			echoerr "not found checkstyle configure file. please set 'g:checkstyle_checkconfig'."
			return
		endif
	endif

	if exists("g:checkstyle_jar") && filereadable(g:checkstyle_jar)
		let l:stylecheck_prog = 'java -jar ' . g:checkstyle_jar
	elseif executable('checkstyle')
		let l:stylecheck_prog = 'checkstyle'
	else
		echoerr "not found checkstyle. please set 'g:checkstyle_jar'."
		return
	endif

	let l:stylecheck_prog .= ' -c ' . l:check_config
	let l:checkstyle_errorformat= '%f:%l:%c:\ %m,%f:%l:\ %m,%-G%.%#'
	if l:stylecheck_prog == '' || l:check_config == ''
		echoerr "checkstyle program or checkstyle configure not found."
		return
	endif

	let l:checkoptions = {'checkprg': l:stylecheck_prog, 'checkerrorfmt': l:checkstyle_errorformat,'okmsg': 'java style ok!!!'}
	call staticcodeanalysis#analysis#StaticCheck(l:checkoptions)
endfunction

if exists('b:javacheckstyle_map')
exec 'nnoremap <silent> <buffer> ' . b:javacheckstyle_map . ' :call <SID>JavaCheckStyle()<CR>'
elseif exists('g:javacheckstyle_map')
exec 'nnoremap <silent> <buffer> ' . g:javacheckstyle_map . ' :call <SID>JavaCheckStyle()<CR>'
endif

