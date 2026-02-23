"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   filetypes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype-specific configuration and autocommands.
"
" WARNING: Some plugins are used here.
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""
" Python
"""""""""""""""""""""""""""""""""""""""
highlight def link pythonSelf Special
let python_highlight_all = 1
syn keyword pythonSelf cls
syn keyword pythonSelf self


"""""""""""""""""""""""""""""""""""""""
" LaTeX
"""""""""""""""""""""""""""""""""""""""
let g:Tex_FormatDependency_dvi = 'dvi,ps,pdf'
let g:Tex_FormatDependency_pdf = 'dvi,ps,pdf'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats = 'pdf'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('autocmd')
    augroup new_file
        au!
        au BufNewFile *.py put =\"#!/usr/bin/env python\<nl># -*- coding: utf-8 -*-\"|$
        au BufNewFile,BufRead *.jinja set syntax=htmljinja
        au BufNewFile,BufRead *.mako set ft=mako
    augroup end

    augroup write_file
        au!
        if exists('*CleanExtraSpaces')
            autocmd BufWritePre *.txt,*md,*.js,*.py,*.wiki,*.sh,*.coffee call CleanExtraSpaces()
        endif
    augroup end

    augroup filetype_python
        au!
        au FileType python map <C-CR> ggVG<c-c><c-c>
        au FileType python map <CR> !python % <CR>
        au FileType python syn keyword pythonDecorator True None False self

        au FileType python set cindent
        au FileType python set cinkeys-=0#
        au FileType python set indentkeys-=0#
        au FileType python setlocal formatprg=autopep8\ -
    augroup end

    augroup filetype_cpp
        au!
        au FileType cpp set tw=79
        au FileType cpp set colorcolumn=80
        au FileType cpp set foldmethod=syntax
    augroup end

    augroup filetype_css
        au!
        au FileType css set omnifunc=csscomplete#CompleteCSS
    augroup end

    augroup filetype_tex
        au!
        au FileType tex let g:Tex_IgnoreLevel = 7
        au FileType tex let g:Tex_Leader = '='
        au FileType tex let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode $*'
        au FileType tex let g:Tex_defaultTargetFormat = 'pdf'
    augroup end
endif
