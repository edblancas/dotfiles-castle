[{1 :julienvincent/nvim-paredit
  :lazy true
  :ft [:clojure :fennel]
  :config (fn []
            (let [paredit (require :nvim-paredit)]
              (paredit.setup
                {:keys {:<C-D-L> [(fn [] [paredit.api.slurp_forwards "Slurp forwards"])]
                        :<C-D-H> [(fn [] [paredit.api.slurp_backwards "Slurp backwards"])]
                        :<C-D-K> [(fn [] [paredit.api.barf_forwards "Barf forwards"])]
                        :<C-D-J> [(fn [] [paredit.api.barf_backwards "Barf backwards"])]
                        :<localleader>I [(fn []
                                           (paredit.cursor.place_cursor
                                             (paredit.wrap.wrap_enclosing_form_under_cursor "(" ")")
                                             {:mode :insert
                                              :placement :inner_end}))
                                         "Wrap form insert tail"]

                        :<localleader>W [(fn []
                                           (paredit.cursor.place_cursor
                                             (paredit.wrap.wrap_element_under_cursor "(" ")")
                                             {:mode :insert
                                              :placement :inner_end}))
                                         "Wrap element insert tail"]

                        :<localleader>i [(fn []
                                           (paredit.cursor.place_cursor
                                             (paredit.wrap.wrap_enclosing_form_under_cursor "( " ")")
                                             {:mode :insert
                                              :placement :inner_start}))
                                         "Wrap form insert head"]

                        :<localleader>w [(fn []
                                           (paredit.cursor.place_cursor
                                             (paredit.wrap.wrap_element_under_cursor "( " ")")
                                             {:mode :insert
                                              :placement :inner_start}))
                                         "Wrap element insert head"]}})))}

 {1 :julienvincent/nvim-paredit-fennel
  :dependencies [:julienvincent/nvim-paredit]
  :lazy true
  :ft [:fennel]
  :config true}]
