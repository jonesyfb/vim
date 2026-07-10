let s:plugin_dir = expand('~/vim/plugged')
let s:patch_dir = expand('~/dotfiles/vim/patches')

" Optional trailing args are patch filenames (in vim/patches/) applied once,
" right after a fresh clone - for local fixes ahead of upstream (see
" README "Plugin freshness" section for why these exist and how to check
" if they're still needed).
function! s:ensure(repo, ...)
    let name = split(a:repo, '/')[-1]
    let path = s:plugin_dir . '/' . name

    if !isdirectory(path)
        if !isdirectory(s:plugin_dir)
            call mkdir(s:plugin_dir, 'p')
        endif
        execute '!git clone --depth=1 https://github.com/' . a:repo . ' ' . shellescape(path)

        for l:patch in a:000
            let l:patch_path = s:patch_dir . '/' . l:patch
            if filereadable(l:patch_path)
                execute '!cd ' . shellescape(path) . ' && git apply ' . shellescape(l:patch_path)
            endif
        endfor
    endif

    execute 'set runtimepath+=' . fnameescape(path)
endfunction

call s:ensure('arcticicestudio/nord-vim')
call s:ensure('ghifarit53/tokyonight-vim')

call s:ensure('junegunn/fzf')
call s:ensure('junegunn/fzf.vim')
call s:ensure('itchyny/lightline.vim')
call s:ensure('yegappan/lsp', 'lsp-async-pull-diagnostics.patch')
