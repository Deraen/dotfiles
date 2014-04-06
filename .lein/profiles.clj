{:user {:plugins [[lein-ancient "0.5.4"]
                  [lein-midje "3.1.3"]
                  ]
        :dependencies [[redl "0.2.2"]
                       [org.clojure/tools.namespace "0.2.4"]
                       [io.aviso/pretty "0.1.8"]
                       [leiningen "2.3.4"]
                       [im.chit/vinyasa "0.2.0"]
                       ]
        :injections [(require 'vinyasa.inject)
                     (vinyasa.inject/inject 'clojure.core
                                            '[[vinyasa.inject inject]
                                              [vinyasa.pull pull]
                                              [vinyasa.lein lein]
                                              [vinyasa.reimport reimport]])
                     (vinyasa.inject/inject 'clojure.core '>
                                            '[[cemerick.pomegranate add-classpath get-classpath resources]
                                              [clojure.tools.namespace.repl refresh]
                                              [clojure.repl apropos dir doc find-doc source pst [root-cause >cause]]
                                              [clojure.pprint pprint]
                                              [clojure.java.shell sh]])
                     ]
        }}

