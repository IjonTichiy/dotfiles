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
"   bufExplorer     access open buffers with <leader>b
"   comfortable-motion   smooth scrolling with <c-d> & <c-u>
"   commentary      toggle comments with gc
"   ctrlp           fuzzy file finder with <leader>p
"   goyo            distraction-free writing
"   NERDTree        file tree with <leader>nn
"   netrw           network/file browser
"   surround        change surrounding quotes/brackets with cs
"   tabular         align text with :Tabularize
"   tagbar          code outline with <leader>nt
"   yankstack       cycle paste history with <c-p> / <c-n>
"   YouCompleteMe   semantic completion, goto, diagnostics
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load plugins with pathogen
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:pluginpath = $XDG_CONFIG_HOME . '/vim/plugins'

" Variables that must be set BEFORE plugins load
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'

execute pathogen#infect(g:pluginpath . '/{}.vim')
call pathogen#helptags()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" airline
"""""""""""""""""""""""""""""""""""""""


" bufExplorer
"""""""""""""""""""""""""""""""""""""""
map <leader>b :BufExplorer<cr>
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'


" comfortable-motion
"""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <C-d> :call comfortable_motion#flick(100)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(-100)<CR>
nnoremap <silent> <C-f> :call comfortable_motion#flick(200)<CR>
nnoremap <silent> <C-b> :call comfortable_motion#flick(-200)<CR>


" ctrlp
"""""""""""""""""""""""""""""""""""""""
" (g:ctrlp_map set above pathogen — must load before plugin init)


" cope (quickfix navigation - built-in)
"""""""""""""""""""""""""""""""""""""""
map <leader>cn :cn<cr>
map <leader>cp :cp<cr>
map <leader>cc :botright cope<cr>


" grep (built-in)
"""""""""""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=/bin/grep\ -nH


" NERDTree
"""""""""""""""""""""""""""""""""""""""
map <leader>nn :NERDTreeToggle<cr>
map <leader>nf :NERDTreeFind<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
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


" tagbar
"""""""""""""""""""""""""""""""""""""""
map <leader>nt :TagbarToggle<cr>
let g:TagbarWinSize=25


" yankstack
"""""""""""""""""""""""""""""""""""""""
nmap <c-p> <Plug>yankstack_substitute_older_paste
nmap <c-n> <Plug>yankstack_substitute_newer_paste
let g:yankstack_yank_keys = ['y', 'd']


" YouCompleteMe
"""""""""""""""""""""""""""""""""""""""
" Python interpreter (always use the WSL system python for ycmd itself)
let g:ycm_server_python_interpreter = '/usr/bin/python3'
let g:python3_host_prog = '/usr/bin/python3'

" Global config (handles compile_commands.json discovery, virtualenvs, WSL paths)
let g:ycm_global_ycm_extra_conf = $XDG_CONFIG_HOME . '/python/global_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \  'g:ycm_python_sys_path'
  \]
let g:ycm_python_interpreter_path = '/usr/bin/python3'
let g:ycm_python_sys_path = []

" Performance: large repo safety valve
" Files above this size (in KB) disable YCM automatically
let g:ycm_disable_for_files_larger_than_kb = 1000

" Don't run YCM on filetypes where it just wastes CPU
let g:ycm_filetype_blacklist = {
  \ 'tagbar': 1,
  \ 'nerdtree': 1,
  \ 'markdown': 1,
  \ 'text': 1,
  \ 'help': 1,
  \ 'qf': 1,
  \ 'gitcommit': 1,
  \}

" Reduce idle re-parsing (default is 2 seconds — raise for large projects)
let g:ycm_update_diagnostics_in_insert_mode = 0

" Collect identifiers from comments and strings (cheap, useful)
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_complete_in_strings = 1

" GoTo mappings
nnoremap <leader>gd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gr :YcmCompleter GoToReferences<CR>
nnoremap <leader>gt :YcmCompleter GetType<CR>
nnoremap <leader>gi :YcmCompleter GoToImplementation<CR>
nnoremap <leader>gf :YcmCompleter FixIt<CR>
nnoremap <leader>gk :YcmCompleter GetDoc<CR>
nnoremap <leader>gs :YcmDiags<CR>

" Toggle YCM on/off for the current buffer (performance escape hatch)
" Usage:  ,yt  to toggle YCM off when editing in a huge repo
function! YcmToggle()
    if !exists('b:ycm_disabled')
        let b:ycm_disabled = 0
    endif
    if b:ycm_disabled
        let b:ycm_disabled = 0
        let b:ycm_largefile = 0
        echo "YCM enabled for this buffer"
    else
        let b:ycm_disabled = 1
        let b:ycm_largefile = 1
        echo "YCM disabled for this buffer"
    endif
endfunction
nnoremap <leader>yt :call YcmToggle()<CR>
