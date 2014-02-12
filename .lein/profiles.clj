{:user {:plugins [[lein-pprint "1.1.1"]
                  [lein-ancient "0.5.4"]]
        :dependencies [[spyscope "0.1.3"]
                       [redl "0.2.2"]]
        :injections [(require 'spyscope.core)
                     (require '[redl complete core])]
        :jvm-opts ^:replace []}}

