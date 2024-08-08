;TJ https://youtu.be/KtQZRAkgLqo?t=646
(fn req []
  (fn [import-name]
    (-> import-name
        (. 1 1)
        (vim.split "." true)
        ((fn [parts] (. parts (# parts))))
        (or ""))))

[
 (s "req1"
   (fmt "local {} = require('{}')"
      [(i 1 "default") (rep 1)]))

  (s "req"
    (fmt "local {} = require '{}'"
      [(f (req) [1]) (i 1)]))
 ]
