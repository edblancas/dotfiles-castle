(local {: autoload} (require :nfnl.module))
(local str (autoload :nfnl.string))
(local core (autoload :nfnl.core))

(local test-file  
"import unittest

class Test{}(unittest.TestCase):
    def test_{}(self):
        self.assertEqual({}(), ...)


if __name__ == '__main__':
    unittest.main()")

(local fun
"def {}({}):
    {}
")

(fn camel-to-snake [str]
  (string.gsub str "%u" (fn [c] (.. "_" (string.lower c)))))

(fn snake-to-camel [str]
  (let [str-without-underscore (string.gsub str "_%a" (fn [c] (string.upper (string.sub c 2))))]
    (.. 
      (string.lower (string.sub str-without-underscore 1 1))
      (string.upper (string.sub str-without-underscore 1 1))  ;capitalize the 1st letter
        (string.sub str-without-underscore 2))))

(fn rep-snake [index]
     (f (fn [arg]
          (let [word (core.get-in arg [1 1])]
            (camel-to-snake word)))
        [index]))

(fn rep-camel [index]
     (f (fn [arg]
          (let [word (core.get-in arg [1 1])]
            (snake-to-camel word)))
        [index]))

[
 (s "test-file"
    (fmt test-file
         [(i 1) (rep-snake 1) (i 0)]))

 (s "pattern-file"
    (fmt (.. fun "\n\n" test-file)
         [(i 1) (i 2) (i 0 "...") (rep-camel 1) (rep 1) (rep 1)]))
 ]


