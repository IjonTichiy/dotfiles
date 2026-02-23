"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins reside in $XDG_CONFIG_HOME/vim/plugins/ and are autoloaded with
" pathogen. Only directories ending in .vim are loaded.
" To disable a plugin: rename its directory to remove the .vim suffix.
"
" Active plugins:
"
"   airline         status bar
"   base16-vim      colorscheme (matches terminal Xresources)
"   bufExplorer     access open buffers with <leader>b
"   comfortable-motion   smooth scrolling with <c-d> & <c-u>
"   commentary      toggle comments with gc
"   ctrlp           fuzzy file finder
"   goyo            distraction-free writing
"   NERDTree        file tree with <leader>nn
"   netrw           network/file browser
"   surround        change surrounding quotes/brackets with cs
"   tabular         align text with :Tabularize
"   tagbar          code outline with <leader>nt
"   yankstack       cycle paste history with <c-p> / <c-n>
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load plugins with pathogen
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:pluginpath = $XDG_CONFIG_HOME . '/vim/plugins'
execute pathogen#infect(g:pluginpath . '/{}.vim')
call pathogen#helptags()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" bufExplorer
"""""""""""""""""""""""""""""""""""""""
map <leader>b :BufExplorer<cr>


" comfortable-motion
"""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <C-d> :call comfortable_motion#flick(100)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(-100)<CR>
nnoremap <silent> <C-f> :call comfortable_motion#flick(200)<CR>
nnoremap <silent> <C-b> :call comfortable_motion#flick(-200)<CR>


" Cope (quickfix list navigation)
"""""""""""""""""""""""""""""""""""""""
map <leader>cn :cn<cr>
map <leader>cp :cp<cr>
map <leader>cc :botright cope<cr>


" NERDTree
"""""""""""""""""""""""""""""""""""""""
map <leader>nn :NERDTreeToggle<cr>
map <leader>nf :NERDTreeFind<cr>
map <leader>nb :NERDTreeFromBookmark<Space>


" Tagbar
"""""""""""""""""""""""""""""""""""""""
map <leader>nt :TagbarToggle<cr>


" yankstack
"""""""""""""""""""""""""""""""""""""""
nmap <c-p> <Plug>yankstack_substitute_older_paste
nmap <c-n> <Plug>yankstack_substitute_newer_paste


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Airline
"""""""""""""""""""""""""""""""""""""""
" (uses defaults — override here if needed)


" bufExplorer
"""""""""""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'


" NERDTree
"""""""""""""""""""""""""""""""""""""""
let g:NERDTreeShowHidden=1
let g:NERDTreeBookmarksFile=$HOME . '/.cache/vim/NERDTreeBookmarks'
let g:NERDTreeIgnore = ['\.pyc$', '__pycache__', '.git']
let g:NERDTreeWinPos = "left"
let g:NERDTreeWinSize=25
let g:NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1


" netrw
"""""""""""""""""""""""""""""""""""""""
let g:netrw_dirhistmax  =10
let g:netrw_dirhistcnt =1


" Tagbar
"""""""""""""""""""""""""""""""""""""""
let g:TagbarWinSize=25


" yankstack
"""""""""""""""""""""""""""""""""""""""
let g:yankstack_yank_keys = ['y', 'd']


" surround
"""""""""""""""""""""""""""""""""""""""
" (uses defaults — mostly cs, ds, ys motions)


" Vim grep
"""""""""""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=/bin/grep\ -nH


" YouCompleteMe
"""""""""""""""""""""""""""""""""""""""
let g:python3_host_prog='/usr/bin/python3'
let g:ycm_python_interpreter_path = '/usr/bin/python3'
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \  'g:ycm_python_sys_path'
  \]
let g:ycm_global_ycm_extra_conf = $XDG_CONFIG_HOME . '/vim/global_extra_conf.py'
