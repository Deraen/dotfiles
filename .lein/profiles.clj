{:user {:plugins [[lein-ancient "0.6.1"]
                  [lein-midje "3.1.3"]
                  [cider/cider-nrepl "0.8.2"]
                  [lein-deps-tree "0.1.2"]
                  [jonase/eastwood "0.2.1"]
                  [lein-exec "0.3.4"]
                  [lein-pprint "1.1.2"]]
        :dependencies [[redl "0.2.4"]
                       [org.clojure/tools.namespace "0.2.8"]
                       [im.chit/vinyasa.inject "0.3.0"]
                       [im.chit/vinyasa.pull "0.3.0"]
                       [aprint "0.1.3"]
                       [flare "0.2.8"]]
        :injections [(require '[vinyasa.inject :as inject])
                     (require '[redl core complete])
                     (require 'flare.clojure-test)
                     (flare.clojure-test/install!)
                     (inject/in
                             ;; To . namespace
                             [vinyasa.inject inject]
                             [vinyasa.pull pull]
                             [clojure.tools.namespace.repl refresh clear]
                             [aprint.core aprint ap])]}}

