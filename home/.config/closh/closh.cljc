;; ALIAS ;;
(defalias ls "gls --color=auto -FGH")
(defalias la "gls --color=auto -lAhF")
(defalias l "gls --color=auto -lhF")
(defalias g "git")
(defalias c "clear")

;; ABBREVIATIONS ;;
(defabbr gco "git checkout")
(defabbr gc "git commit")

;; COMMANDS ;;
(defcmd nu-proj []
  (sh cd (str (System/getenv "HOME") "/dev/nu")))

(defcmd notes []
  (sh cd (str (System/getenv "HOME") "/Dropbox/dev/current/notes")))

(defcmd h []
  (sh sqlite3 (str (getenv "HOME") "/.closh/closh.sqlite") "SELECT command FROM history ORDER BY id ASC" | cat))

  (defcmd git [& [dispatch :as args]]
  (if (= dispatch "browse")
      (let [{:keys [code stderr]
             remote-url :stdout} (sh-value "git" "remote" "get-url" "origin")]
        (if (zero? code)
          (do (println "Opening" remote-url)
              (sh "open" (clojure.string/trim remote-url)))
          (println stderr)))
      (eval `(sh "git" ~@args))))

(defcmd closhrc []
  (load-file (str (getenv "HOME") "/.closhrc")))

;; FUNCTIONS ;;
(defn git-current-branch []
  (let [{:keys [code stdout]} (sh-value "git" "branch")]
    (when (zero? code)
      (some (fn [line]
              (when (.startsWith line "* ")
                (clojure.string/trim (subs line 2 ))))
            (clojure.string/split-lines stdout)))))


(defn current-dir []
  (let [{dir :stdout} (sh-value "pwd")]
    (last (clojure.string/split (clojure.string/trim dir) #"\/"))))

(defn git-installed? []
  (sh-ok which "git" > "/dev/null"))

(defn git-version []
  (when (git-installed?)
    (second (re-matches #"git version (.+)"
                        (sh-str "git" "--version")))))

(defn destructure-semantic-version [s]
  (mapv #(Long/parseLong %) (clojure.string/split s #"\.")))

(defn compare-semantic-versions [a b]
  (loop [[head-a & left-a] (destructure-semantic-version a)
         [head-b & left-b] (destructure-semantic-version b)]
    (let [comparison (compare head-a head-b)]
      (if (and head-a head-b
              (zero? comparison))
        (recur left-a left-b)
        comparison))))

(def POST_1_7_2_GIT? (<= 0 (compare-semantic-versions (git-version) "1.7.2")))

(def DISABLE_UNTRACKED_FILES_DIRTY? false)

;; https://github.com/robbyrussell/oh-my-zsh/blob/f75d096c1a3863b84cb9788d0934babe4cd3c577/lib/git.zsh#L12
(defn git-dirty? []
  (let [flags (cond-> ["--porcelain"]
                POST_1_7_2_GIT?
                (conj "--ignore-submodules=dirty")

                DISABLE_UNTRACKED_FILES_DIRTY?
                (conj "--untracked-files=no"))]
    (not (clojure.string/blank? (eval `(sh-str "git" "status" ~@flags))))))

(defn add-dependencies
  "A helper function to lazily load dependencies using Pomegranate."
  [& args]
  (when-not (find-ns 'cemerick.pomegranate)
    (require '[cemerick.pomegranate]))
  (apply (resolve 'cemerick.pomegranate/add-dependencies)
    (concat args
      [:repositories (merge @(resolve 'cemerick.pomegranate.aether/maven-central) {"clojars" "https://clojars.org/repo"})])))


(when-not (find-ns 'colorize.core)
    (add-dependencies :coordinates '[[colorize "0.1.1"]])
    (require '[colorize.core :as color]))

(defn closh-prompt []
  (clojure.string/join " "
                       (remove
                        nil?
                        [(color/bold (color/green "$"))
                         (color/bold (color/cyan (current-dir)))
                         (when-let [b (git-current-branch)]
                           (str (color/bold (color/blue "git:("))
                                (color/bold (color/red b))
                                (color/bold (color/blue ")"))))

                         (when (git-dirty?)
                           (color/bold (color/yellow  "✗")))
                         ""])))

#_(do
    ;; Fast closh scripts see https://github.com/dundalek/closh/pull/123

    (defn load-script [f]
      (println "evalling" f)
      (println (slurp f))
      (load-file f)
      )

    (clojure.core.server/start-server {:port 49999 :name "closh-server" :accept 'clojure.core.server/repl}))

;; LOAD ;;
(load-file (str (getenv "HOME") "/.config/closh/closh_autojump.cljc"))
