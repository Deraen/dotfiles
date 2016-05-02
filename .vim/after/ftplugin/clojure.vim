" defschema, defnk...
" GET/POST... and GET*/POST* for Compojure-api
let g:clojure_fuzzy_indent_patterns=['^GET', '^POST', '^PUT', '^DELETE', '^ANY', '^HEAD', '^PATCH', '^OPTIONS', '^def', '^let', '^with']

" Clojure test
autocmd FileType clojure setlocal lispwords+=describe,it
" Core.match
autocmd FileType clojure setlocal lispwords+=match
" Compojure-api
autocmd FileType clojure setlocal lispwords+=context,swaggered,middlewares,context*
" Midje
autocmd FileType clojure setlocal lispwords+=fact,facts,provided,fact-group
" Core.logic
autocmd FileType clojure setlocal lispwords+=run*
" Om
autocmd FileType clojure setlocal lispwords+=will-mount,render,render-state,init-state,did-mount,should-update,will-receive-props,will-update,did-update,display-name,will-unmount
" Om next
autocmd FileType clojure setlocal lispwords+=ident
" Cljs
autocmd FileType clojure setlocal lispwords+=this-as
" Plumbing
autocmd FileType clojure setlocal lispwords+=for-map,fnk,letk
" Core.async
autocmd FileType clojure setlocal lispwords+=go-loop
" Chesire
autocmd FileType clojure setlocal lispwords+=add-encoder
" Boot
autocmd FileType clojure setlocal lispwords+=with-call-in,with-eval-in,with-pre-wrap,with-post-wrap
" Re-frame
autocmd FileType clojure setlocal lispwords+=register-handler,register-sub
" Cats
autocmd FileType clojure setlocal lispwords+=with-context,alet,mlet
