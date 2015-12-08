(require 'boot.repl)

(swap! boot.repl/*default-dependencies*
       concat '[[cider/cider-nrepl "0.10.0"]
                [refactor-nrepl "1.1.0"]
                [org.clojure/tools.namespace "0.2.11"]
                [im.chit/vinyasa.inject "0.3.0"]
                [aprint "0.1.3"]])

(swap! boot.repl/*default-middleware* conj
       'cider.nrepl/cider-middleware
       'refactor-nrepl.middleware/wrap-refactor)

(task-options!
  repl {:eval '(do (require '[vinyasa.inject :as inject])
                   (require 'clojure.repl)
                   (inject/in
                     ;; To . namespace
                     [vinyasa.inject inject]
                     [clojure.tools.namespace.repl refresh clear]
                     [aprint.core aprint ap]
                     [clojure.repl source doc]))})
