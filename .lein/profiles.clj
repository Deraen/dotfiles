{:repl {:plugins []}
 :user {:plugins [[lein-ancient "0.7.0"]
                  [lein-pprint "1.3.2"]
                  [com.github.johnnyjayjay/lein-licenses "0.2.0"]]
        :dependencies []}
 :auth {:repository-auth #=(eval (read-string (slurp (clojure.java.io/file (System/getProperty "user.home") ".lein/credentials.clj"))))}}
