(local ls (require :luasnip))

 ; TJ Luasnips Adv Conf
 ; https://youtu.be/KtQZRAkgLqo
 (fn same [index]
     (f (fn [arg]
          (print (vim.inspect arg))
          "")
        [index]))

(fn rep-impl [index]
     (f (fn [arg]
          (. arg 1))
        [index]))

[
  (s "todo"
   (fmt "{}: {}"
      [(c 1 [(t "TODO") (t "NOTE") (t "FIXME") (t "BUG")])
       (i 0)]))

 (s "currtime"
    (f (fn []
        (os.date "%D - %H:%M"))))

;example: adb, function: 
 (s "print-same"
   (fmt "example: {}, function: {}"
        [(i 1) (same 1)]))

;example: daniel, function: daniel
 (s "rep-impl"
    (fmt "example: {}, function: {}"
      [(i 1) (rep-impl 1)]))
 ;https://github.com/L3MON4D3/LuaSnip/blob/v2.3.0/DOC.md#transformations
 ;uses jsregexp
 (ls.parser.parse_snippet {:trig "filename"} "${TM_FILENAME/(.*)\\..+$/$1/}")
 ]

