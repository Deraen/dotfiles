(require 'boot.repl)

(swap! boot.repl/*default-dependencies*
       concat '[[cider/cider-nrepl "0.10.1"]
                [refactor-nrepl "2.0.0-SNAPSHOT"]
                [org.clojure/tools.namespace "0.2.11"]
                [aprint "0.1.3"]])

(swap! boot.repl/*default-middleware* conj
       'cider.nrepl/cider-middleware
       'refactor-nrepl.middleware/wrap-refactor)

;; Read credentials from Lein directory
(try
 ((resolve 'boot.core/configure-repositories!)
  (fn [m]
    (merge m (some (fn [[regex cred]] (if (re-find regex (:url m)) cred))
                   (read-string (slurp (clojure.java.io/file (System/getProperty "user.home") ".lein/credentials.clj")))))))
 (catch Exception _
   nil))
