(require 'boot.repl)

(def java-8 (.startsWith (System/getProperty "java.version") "1.8.0"))

(swap! boot.repl/*default-dependencies* into
       '[])

; (swap! boot.repl/*default-middleware* into
;        '[cider.nrepl/cider-middleware
;          refactor-nrepl.middleware/wrap-refactor])

;; Read credentials from Lein directory
(try
 ((resolve 'boot.core/configure-repositories!)
  (fn [m]
    (merge m (some (fn [[regex cred]] (if (re-find regex (:url m)) cred))
                   (read-string (slurp (clojure.java.io/file (System/getProperty "user.home") ".lein/credentials.clj")))))))
 (catch Exception _
   nil))
