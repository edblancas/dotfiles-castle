(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(local test-code
"def {}({}):
    {}


import unittest

class Test{}(unittest.TestCase):
    def test_{}(self):
        self.assertEqual({}({}), ...)
")

(local test-file  
"
if __name__ == '__main__':
    unittest.main()
")

(local test-main
"
def main():
    test = Test{}()
    test.test_{}()


main()
")

(fn camel-to-snake [str]
  (string.gsub str "%u" (fn [c] (.. "_" (string.lower c)))))

(fn snake-to-camel [str]
  (let [str-without-underscore
        (string.gsub str "_%l" (fn [s] (string.upper (string.sub s 2))))] ; capitalize letter after underscore
    (.. 
      (string.upper (string.sub str-without-underscore 1 1)) ; capitalize the first letter
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
    (fmt (.. test-code test-file)
         [(i 1) (i 2) (i 0 "...") (rep-camel 1) (rep 1) (rep 1) (rep 2)]))

 (s "test-main"
    (fmt (.. test-code test-main)
         [(i 1) (i 2) (i 0 "...") (rep-camel 1) (rep 1) (rep 1) (rep 2) (rep-camel 1) (rep 1)]))
 ]


