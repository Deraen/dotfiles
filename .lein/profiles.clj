{:repl {:plugins [[cider/cider-nrepl "0.14.0"]
                  [refactor-nrepl "2.2.0"]
                  [venantius/ultra "0.5.1"]]}
 :user {:plugins [[lein-ancient "0.6.10"]
                  [lein-deps-tree "0.1.2"]
                  [lein-pprint "1.1.2"]
                  [lein-licenses "0.2.1"]
                  [lein-try "0.4.3"]]
        :dependencies [[org.clojure/tools.nrepl "0.2.12"]
                       [org.clojure/tools.namespace "0.2.11"]
                       [aprint "0.1.3"]]
        :ultra {:color-scheme :solarized_dark}}
 :auth {:repository-auth #=(eval (read-string (slurp (clojure.java.io/file (System/getProperty "user.home") ".lein/credentials.clj"))))}}
