"=============================================================================
" File: analysis.vim
" Description: syntax and style check plugin
" Maintainer:  xusd-null.github.io
" License:     This program is free software. It comes without any warranty.
"=============================================================================

" path to staticcodeanalys install directories
let s:scriptdir = expand("<sfile>:h") . '/'
let s:scriptdirpy = expand("<sfile>:h") . '/analysises/'

if has('signs')
	highlight link SyntasticErrorSign error
	highlight link SyntasticWarningSign todo
	highlight link SyntasticStyleErrorSign SyntasticErrorSign
	highlight link SyntasticStyleWarningSign SyntasticWarningSign
	highlight link SyntasticStyleErrorLine SyntasticErrorLine
	highlight link SyntasticStyleWarningLine SyntasticWarningLine

	" define the signs used to display syntax and style errors/warns
	sign define StaticAnalysisError text=>> texthl=SyntasticErrorSign linehl=SyntasticErrorLine
	sign define StaticAnalysisWarning text=>> texthl=SyntasticWarningSign linehl=SyntasticWarningLine
	sign define StaticAnalysisStyleError text=$> texthl=SyntasticStyleErrorSign linehl=SyntasticStyleErrorLine
	sign define StaticAnalysisStyleWarning text=$> texthl=SyntasticStyleWarningSign linehl=SyntasticStyleWarningLine
endif

function! staticcodeanalysis#analysis#GetErrorList(analisysOptions)

	if !has_key(a:analisysOptions,'checkprg') || !has_key(a:analisysOptions,'checkerrorfmt')
		return []
	endif

	" store old grep settings (to restore later)
	let l:old_gfm=&grepformat
	let l:old_gp=&grepprg
	let l:old_qflist = getqflist()
	let l:ret_qflist = []

	" perform the grep itself
	let &grepprg = a:analisysOptions['checkprg']
	let &grepformat = a:analisysOptions['checkerrorfmt']
	silent! grep! %
	let l:ret_qflist = getqflist()

	" restore grep settings
	let &grepformat=l:old_gfm
	let &grepprg=l:old_gp
	:call setqflist(l:old_qflist)

	return l:ret_qflist
endfunction

function! staticcodeanalysis#analysis#StaticCheck(analisysOptions)
	set lazyredraw   " delay redrawing
	cclose           " close any existing cwindows

	" write any changes before continuing
	if &readonly == 0
		update
	endif

	let l:results = staticcodeanalysis#analysis#GetErrorList(a:analisysOptions)


	exec 'sign unplace * buffer=' . bufnr("%")
	" open cwindow
	let l:has_results = l:results != []
	if has_results
		for d in l:results
			if bufnr("%") == d.bufnr && d.lnum > 0
				execute ':sign place ' . d.lnum . ' line=' . d.lnum . ' name=StaticAnalysisError buffer=' . d.bufnr
			endif
		endfor
		call setqflist(l:results)
		execute 'belowright copen'
		setlocal wrap
		nnoremap <buffer> <silent> c :cclose<CR>
		nnoremap <buffer> <silent> q :cclose<CR>
	endif

	set nolazyredraw
	redraw!

	if has_results == 0
		" Show OK status
		hi Green ctermfg=green
		echohl Green
		if has_key(a:analisysOptions,'okmsg')
			echon a:analisysOptions['okmsg']
		else
			echon "OK!!!"
		endif
		echohl
	endif
endfunction

function! staticcodeanalysis#analysis#GetDefaultCheckstyleConfigerFile()
	return s:scriptdirpy . 'sun_checks.xml'
endfunction

function! staticcodeanalysis#analysis#GetCpplint()
	return s:scriptdirpy . 'cpplint.py'
endfunction


