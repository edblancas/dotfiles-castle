 ; TJ Luasnips Adv Conf
 ; https://youtu.be/KtQZRAkgLqo
 (fn same [index]
     (f (fn [arg]
          (print (vim.inspect arg))
          "")
        [index index]))

(fn rep-impl [index]
     (f (fn [arg]
          (. arg 1 1))
        [index]))

[
  (s "todo"
   (fmt "{}: {}"
      [(c 1 [(t "TODO") (t "NOTE") (t "FIXME") (t "BUG")])
       (i 0)]))

 (s "currtime"
    (f (fn []
        (os.date "%D - %H:%M"))))

 (s "print-same"
   (fmt "example: {}, function: {}"
        [(i 1) (same 1)]))

 (s "rep-impl"
    (fmt "example: {}, function: {}"
      [(i 1) (rep-impl 1)]))
 ]

; example: adb, function: 
; example: daniel, function: daniel
