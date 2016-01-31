{:repl {:plugins [[cider/cider-nrepl "0.10.1"]
                  [refactor-nrepl "2.0.0-SNAPSHOT"]
                  [venantius/ultra "0.3.3"]]}
 :user {:plugins [[lein-ancient "0.6.7"]
                  [lein-deps-tree "0.1.2"]
                  [lein-pprint "1.1.2"]]
        :dependencies [[org.clojure/tools.nrepl "0.2.10"]
                       [org.clojure/tools.namespace "0.2.11"]
                       [im.chit/vinyasa.inject "0.3.4"]
                       [im.chit/vinyasa.pull "0.3.4"]
                       [aprint "0.1.3"]]
        :ultra {:color-scheme :solarized_dark}
        :injections [(require '[vinyasa.inject :as inject])
                     (inject/in
                             ;; To . namespace
                             [vinyasa.inject inject]
                             [vinyasa.pull pull]
                             [clojure.tools.namespace.repl refresh clear]
                             [aprint.core aprint])]}}
