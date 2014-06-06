
if exists("b:loaded_javachecksyntax_ftplugin")
    finish
endif
let b:loaded_javachecksyntax_ftplugin=1

function! s:JavaCheckSyntax()
	if !executable('javac')
		echoerr "java not found. Please install it first."
		return
	endif

	let l:syntaxcheck_prog = 'javac '
	let l:checksyntax_errorformat = '%E%f:%l:\ error:\ %m,%W%f:%l:\ warning:\ %m,%A%f:%l:\ %m,%+Z%p^,%+C%.%#,%-G%.%#'


	if exists('g:javasource_path')
		let l:javasource_path  = g:javasource_path
	endif
	if exists('b:javasource_path')
		let l:javasource_path  = b:javasource_path
	endif

	if exists('g:javaoutput_path')
		let l:javaoutput_path  = g:javaoutput_path
	endif
	if exists('b:javaoutput_path')
		let l:javaoutput_path  = b:javaoutput_path
	endif

	if exists('g:javaclasses_path')
		let l:javaclasses_path = g:javaclasses_path
	endif
	if exists('b:javaclasses_path')
		let l:javaclasses_path = b:javaclasses_path
	endif

	if exists('l:javasource_path')
		let l:syntaxcheck_prog .= ' -sourcepath ' . l:javasource_path
	endif
	if exists('l:javaoutput_path')
		let l:syntaxcheck_prog .= ' -d ' . l:javaoutput_path
	endif
	if exists('l:javaclasses_path')
		let l:syntaxcheck_prog .= ' -classpath ' . l:javaclasses_path
	endif

	let l:checkoptions = {'checkprg': l:syntaxcheck_prog, 'checkerrorfmt': l:checksyntax_errorformat,'okmsg': 'java compile ok!!!'}
	call staticcodeanalysis#analysis#StaticCheck(l:checkoptions)
endfunction

if exists('b:javasyntaxcheck_map')
exec 'nnoremap <silent> <buffer> ' . b:javasyntaxcheck_map . ' :call <SID>JavaCheckSyntax()<CR>'
elseif exists('g:javasyntaxcheck_map')
exec 'nnoremap <silent> <buffer> ' . g:javasyntaxcheck_map .' :call <SID>JavaCheckSyntax()<CR>'
endif

