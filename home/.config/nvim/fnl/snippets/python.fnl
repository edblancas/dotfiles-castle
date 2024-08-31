[
 (s "fun"
   (fmt "def {}({}){}:\n    {}\n"
        [(i 1) (i 2) (i 3) (i 0)]))
 (s "test-file"
    (fmt "import unittest\n\nclass Test{}(unittest.TestCase):\n    def test_{}(self):\n        {}\n\nif __name__ == '__main__':\n    unittest.main()"
         [(i 1) (i 2) (i 0)]))
 ]

