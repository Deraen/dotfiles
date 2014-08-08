{:user {:plugins [[lein-ancient "0.5.5"]
                  [lein-midje "3.1.3"]
                  [cider/cider-nrepl "0.7.0"]
                  [lein-deps-tree "0.1.2"]
                  [jonase/eastwood "0.1.4"]
                  [lein-exec "0.3.4"]
                  ]
        :dependencies [[redl "0.2.4"]
                       [org.clojure/tools.namespace "0.2.5"]
                       [im.chit/vinyasa.inject "0.2.2"]
                       [im.chit/vinyasa.pull "0.2.2"]
                       ]
        :injections [(require '[vinyasa.inject :as inject])
                     (require '[redl core complete])
                     (inject/in
                             ;; To . namespace
                             [vinyasa.inject inject]
                             [vinyasa.pull pull]
                             [clojure.tools.namespace.repl refresh clear]
                             [clojure.java.shell sh]

                             ;; To core, prefixed
                             clojure.core >
                             [clojure.pprint pprint]
                             )]}}

