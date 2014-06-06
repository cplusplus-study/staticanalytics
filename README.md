
syntax and style check plugin


$HOME/.vimrc配置示例:
```viml
set nocompatible
set nu
filetype indent plugin on

let b:cppcheck_options = "-I include -I /usr/include -I /usr/include/c++/4.8/"
let g:cppcheck_map = "<F6>"
let g:cpplint_map = "<F7>"
let b:cpp_compiler_options = "-std=c++11 -I include -I lib/gtest-1.7.0/include"
let g:cppsyntaxcheck_map = "<F8>"

let g:javacheckstyle_map = "<F7>"
let g:javasyntaxcheck_map = "<F8>"
```

来看看效果吧:

1. cppcheck效果

![image](https://raw.githubusercontent.com/cplusplus-study/staticanalytics/master/doc/cppcheck_1.png)

2. cpplint效果

![image](https://raw.githubusercontent.com/cplusplus-study/staticanalytics/master/doc/cpplint_1.png)

3. 语法检查效果

![image](https://raw.githubusercontent.com/cplusplus-study/staticanalytics/master/doc/syntax_check_1.png)


