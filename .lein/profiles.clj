{:repl {:plugins [[cider/cider-nrepl "0.25.3"]
                  [refactor-nrepl "2.5.0"]]}
 :user {:plugins [[lein-ancient "0.6.15"]
                  [lein-pprint "1.3.2"]
                  [lein-licenses "0.2.2"]]
        :dependencies [[nrepl "0.8.2"]
                       [org.clojure/tools.namespace "1.0.0"]
                       [aprint "0.1.3"]]
        :ultra {:color-scheme :solarized_dark}}
 :auth {:repository-auth #=(eval (read-string (slurp (clojure.java.io/file (System/getProperty "user.home") ".lein/credentials.clj"))))}}
