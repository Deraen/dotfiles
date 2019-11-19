{:repl {:plugins [[cider/cider-nrepl "0.21.1"]
                  [refactor-nrepl "2.4.0"]
                  #_[venantius/ultra "0.5.2"]]}
 :user {:plugins [[lein-ancient "0.6.15"]
                  [lein-deps-tree "0.1.2" :exclusions [org.clojure/clojure]]
                  [lein-pprint "1.2.0"]
                  [lein-licenses "0.2.2"]
                  [lein-try "0.4.3"]]
        :dependencies [[nrepl "0.6.0"]
                       [org.clojure/tools.namespace "0.2.11"]
                       [aprint "0.1.3"]]
        :ultra {:color-scheme :solarized_dark}}
 :auth {:repository-auth #=(eval (read-string (slurp (clojure.java.io/file (System/getProperty "user.home") ".lein/credentials.clj"))))}}
