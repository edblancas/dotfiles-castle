(local {: autoload} (require :nfnl.module))
(local lsp (autoload :config.lsp))

(fn lsp_connection []
  (let [message (lsp.get-progress-message)]
    (if
      ; if has progress handler and is loading
      (or (= message.status "begin")
          (= message.status "report"))
      (.. message.msg " : " message.percent "%% ")

      ; if has progress handler and finished loading
      (= message.status "end")
      ""

      ; if hasn't progress handler, but has connected lsp client
      (and (= message.status "")
           (not (vim.tbl_isempty (vim.lsp.get_clients 0))))
      ""

      ; else
      "")))

;; Me ;;
(local my-setup {:options {:theme "tokyonight"
                           :icons_enabled true
                           :globalstatus true
                           :section_separators {:left "" :right ""}
                           :component_separators {:left "|" :right "|"}}
                 :winbar {:lualine_a []}
                 :inactive_winbar {:lualine_a []}
                 :disabled_filetypes {:statusline {}
                                      :winbar []}
                 :sections {:lualine_a [:mode]
                            :lualine_b [:branch]
                            :lualine_c [:diff
                                        {1 :diagnostics
                                         :sections [:error :warn :info :hint]
                                         :sources [:nvim_lsp]}
                                        {1 :filename
                                         :file_status true
                                         :path 1
                                         :shorting_target 40}]
                            :lualine_x [[lsp_connection]
                                        :filetype]
                            :lualine_y [:progress]
                            :lualine_z [:location]}
                 :inactive_sections {:lualine_a []
                                     :lualine_b []
                                     :lualine_c [{1 :filename
                                                  :file_status true
                                                  :path 1}]
                                     :lualine_x []
                                     :lualine_y []
                                     :lualine_z []}
                 :extensions [:neo-tree 
                              :oil 
                              :nvim-dap-ui 
                              :fugitive 
                              :aerial 
                              :quickfix
                              :lazy
                              :mason]})

;; https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua
;; Eviline config for lualine
;; Author: shadmansaleh
;; Credit: glepnir

;; Color table for highlights
(local colors
  {:bg "#202328"
   :fg "#bbc2cf"
   :yellow "#ECBE7B"
   :cyan "#008080"
   :darkblue "#081633"
   :green "#98be65"
   :orange "#FF8800"
   :violet "#a9a1e1"
   :magenta "#c678dd"
   :blue "#51afef"
   :red "#ec5f67"})

(local conditions
  {:buffer-not-empty
   (fn []
     (not= (vim.fn.empty (vim.fn.expand "%:t")) 1))
   :hide-in-width
   (fn []
     (> (vim.fn.winwidth 0) 80))
   :check-git-workspace
   (fn []
     (let [filepath (vim.fn.expand "%:p:h")
           gitdir (vim.fn.finddir ".git" (.. filepath ";"))]
       (and gitdir
            (> (string.len gitdir) 0)
            (< (string.len gitdir) (string.len filepath)))))})
  
;; Config
(local config
  {:options
   {:component_separators ""
    :section_separators ""
    :theme {:normal {:c {:fg colors.fg :bg colors.bg}}
            :inactive {:c {:fg colors.fg :bg colors.bg}}}}
   :sections {:lualine_a [] :lualine_b [] :lualine_y [] :lualine_z []
              :lualine_c [] :lualine_x []}
   :inactive_sections {:lualine_a [] :lualine_b [] :lualine_y [] :lualine_z []
                       :lualine_c [] :lualine_x []}})

;; Helper functions to insert components
(fn ins-left [component]
  (table.insert config.sections.lualine_c component))

(fn ins-right [component]
  (table.insert config.sections.lualine_x component))

;; Add components to left
(ins-left
 {1 (fn [] "▊")
  :color {:fg colors.blue}
  :padding {:left 0 :right 1}})

(ins-left
 {1 (fn [] "")
  :color (fn []
           (let [mode-color
                 {:n colors.red :i colors.green :v colors.blue :V colors.blue
                  :V colors.blue :c colors.magenta :no colors.red
                  :s colors.orange :S colors.orange :S colors.orange
                  :ic colors.yellow :R colors.violet :Rv colors.violet
                  :cv colors.red :ce colors.red :r colors.cyan :rm colors.cyan
                  :r? colors.cyan :! colors.red :t colors.red}]
             {:fg (. mode-color (vim.fn.mode))}))
  :padding {:right 1}})

(ins-left {:component "filesize" :cond conditions.buffer-not-empty})
(ins-left {:component "filename" :cond conditions.buffer-not-empty
           :color {:fg colors.magenta :gui "bold"}})
(ins-left {:component "location"})
(ins-left {:component "progress" :color {:fg colors.fg :gui "bold"}})
(ins-left {:component "diagnostics"
           :sources ["nvim_diagnostic"]
           :symbols {:error " " :warn " " :info " "}
           :diagnostics-color {:error {:fg colors.red}
                               :warn {:fg colors.yellow}
                               :info {:fg colors.cyan}}})
(ins-left {:1 (fn [] "%=")})
(ins-left
 {1
  (fn []
    (let [msg "No Active Lsp"
          buf-ft (vim.api.nvim_get_option_value "filetype" {:buf 0})
          clients (vim.lsp.get_clients)]
      (if (= (next clients) nil)
          msg
          (do
            (each [_ client (ipairs clients)]
              (let [filetypes (. client.config :filetypes)]
                (if (and filetypes
                         (not= (vim.fn.index filetypes buf-ft) -1))
                    client.name)))
            msg))))
  :icon " LSP:"
  :color {:fg "#ffffff" :gui "bold"}})

;; Add components to right
(ins-right {:component "o:encoding"
            :fmt string.upper
            :cond conditions.hide-in-width
            :color {:fg colors.green :gui "bold"}})
(ins-right {:component "fileformat"
            :fmt string.upper
            :icons_enabled false
            :color {:fg colors.green :gui "bold"}})
(ins-right {:component "branch" :icon ""
            :color {:fg colors.violet :gui "bold"}})
(ins-right {:component "diff"
            :symbols {:added " " :modified "󰝤 " :removed " "}
            :diff_color {:added {:fg colors.green}
                         :modified {:fg colors.orange}
                         :removed {:fg colors.red}}
            :cond conditions.hide-in-width})
(ins-right {1 (fn [] "▊")
            :color {:fg colors.blue}
            :padding {:left 1}})

[{1 :nvim-lualine/lualine.nvim
  :config (fn []
            (let [lualine (require :lualine)]
              ;NOTE: withoyt setting it renders well the separators
              (lualine.setup config)))}]
