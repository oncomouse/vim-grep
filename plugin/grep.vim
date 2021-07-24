if exists('g:grep_plugin')
    finish
endif
let g:grep_plugin = 1

" Try to use RipGrep or TheSilverSearcher, if available:
if get(g:, 'grep_guess_my_grepprg', 1)
	if executable('rg')
	  set grepprg=rg\ --vimgrep
	  set grepformat=%f:%l:%c:%m
	elseif executable('ag')
	  set grepprg=ag\ --vimgrep
	  set grepformat=%f:%l:%c:%m
	endif
endif

" Can we do an async :Grep?
let g:grep_async = get(g:, 'grep_async', has('nvim')) " || (has('job') && has('channel') && has('lambda'))

if g:grep_async
  command! -nargs=+ -complete=file_in_path -bar Grep  call grep#grep(<f-args>)
  command! -nargs=+ -complete=file_in_path -bar LGrep call grep#lgrep(<f-args>)
else
  command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr grep#grep(<f-args>)
  command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr grep#lgrep(<f-args>)
endif

cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

augroup grep_quickfix
  autocmd!
  autocmd QuickFixCmdPost [^l]* call grep#open_list(1)
  autocmd QuickFixCmdPost l* call grep#open_list(0)
augroup END
