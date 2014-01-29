{:user {:plugins [[lein-localrepo "0.5.2"]
                  [lein-pprint "1.1.1"]
                  [lein-midje "3.0.0"]]
        :dependencies [[spyscope "0.1.3"]
                       [redl "0.2.2"]]
        :injections [(require 'spyscope.core)
                     (require '[redl complete core])]
        :jvm-opts ^:replace []}}

