(require 'boot.repl)

(swap! boot.repl/*default-dependencies*
       concat '[[cider/cider-nrepl "0.7.0"]
                [redl "0.2.4"]
                [org.clojure/tools.namespace "0.2.6"]
                [im.chit/vinyasa.inject "0.2.2"]
                [im.chit/vinyasa.pull "0.2.2"]
                [aprint "0.1.1"]
                ; [jonase/eastwood "0.1.4"]
                ])

(swap! boot.repl/*default-middleware*
       conj 'cider.nrepl/cider-middleware)

(task-options!
  repl [:eval '(do (require '[vinyasa.inject :as inject])
                   (require '[redl core complete])
                   (require '[aprint.core])
                   (inject/in
                     ;; To . namespace
                     [vinyasa.inject inject]
                     [vinyasa.pull pull]
                     [clojure.tools.namespace.repl refresh clear]
                     [clojure.java.shell sh]
                     [aprint.core aprint ap]
                     ))])

; vim: ft=clojure:
