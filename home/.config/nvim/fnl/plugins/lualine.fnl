(local {: autoload} (require :nfnl.module))
(local lsp (autoload :config.lsp))
(local core (autoload :nfnl.core))

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

(fn lsp_connection_evil []
  (let [msg "No Active Lsp"
        buf_ft (vim.api.nvim_get_option_value "filetype" {:buf 0})
        clients (vim.lsp.get_clients)]
    (if (= (next clients) nil)
        (lua "return msg"))
    (each [_ client (ipairs clients)]
      (let [filetypes (. client.config :filetypes)]
        (if (and filetypes
                 (not= (vim.fn.index filetypes buf_ft) -1))
          (lua "return client.name"))))
    msg))

;; Me ;;
(local my_setup {:options {:theme "tokyonight"
                           :icons_enabled true
                           :globalstatus true}
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
                                        {1 lsp_connection_evil
                                           :icon " LSP:"}
                                        {1 :filename
                                         :file_status true
                                         :path 1
                                         :shorting_target 40}]
                            :lualine_x [:filetype]
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
  {:buffer_not_empty
   (fn []
     (not= (vim.fn.empty (vim.fn.expand "%:t")) 1))
   :hide_in_width
   (fn []
     (> (vim.fn.winwidth 0) 80))
   :check_git_workspace
   (fn []
     (let [filepath (vim.fn.expand "%:p:h")
           gitdir (vim.fn.finddir ".git" (.. filepath ";"))]
       (and gitdir
            (> (string.len gitdir) 0)
            (< (string.len gitdir) (string.len filepath)))))})
  
;; Config
(local config
  {:options
    ;Disable sections and component separators
   {:component_separators ""
    :section_separators ""
    ;We are going to use lualine_c an lualine_x as left and
    ;right section. Both are highlighted by c theme .  So we
    ;are just setting default looks o statusline
    :theme {:normal {:c {:fg colors.fg :bg colors.bg}}
            :inactive {:c {:fg colors.fg :bg colors.bg}}}}
              ;these are to remove the defaults
   :sections {:lualine_a [] :lualine_b [] :lualine_y [] :lualine_z []
              ;These will be filled later
              :lualine_c [] :lualine_x []}
                       ;these are to remove the defaults
   :inactive_sections {:lualine_a [] :lualine_b [] :lualine_y [] :lualine_z []
                       :lualine_c [] :lualine_x []}})

;Inserts a component in lualine_c at left section
(fn ins_left [component]
  (table.insert config.sections.lualine_c component))

;Inserts a component in lualine_x at right section
(fn ins_right [component]
  (table.insert config.sections.lualine_x component))

(ins_left
 {1 (fn [] "▊")
  :color {:fg colors.blue}
  :padding {:left 0 :right 1}})

(ins_left
 ;mode component
 {1 (fn [] "")
  :color (fn []
           (let [mode_color
                 {:n colors.red :i colors.green :v colors.blue "" colors.blue
                  :V colors.blue :c colors.magenta :no colors.red
                  :s colors.orange :S colors.orange "" colors.orange
                  :ic colors.yellow :R colors.violet :Rv colors.violet
                  :cv colors.red :ce colors.red :r colors.cyan :rm colors.cyan
                  :r? colors.cyan :! colors.red :t colors.red}]
             {:fg (. mode_color (vim.fn.mode))}))
  :padding {:right 1}})

(ins_left {1 "filesize" :cond conditions.buffer_not_empty})
(ins_left {1 "filename" :cond conditions.buffer_not_empty
           :color {:fg colors.magenta :gui "bold"}})
(ins_left {1 "location"})
(ins_left {1 "progress" :color {:fg colors.fg :gui "bold"}})
(ins_left {1 "diagnostics"
           :sources ["nvim_diagnostic"]
           :symbols {:error " " :warn " " :info " "}
           :diagnostics_color {:error {:fg colors.red}
                               :warn {:fg colors.yellow}
                               :info {:fg colors.cyan}}})

;Insert mid section. You can make any number of sections in neovim :)
;for lualine it's any number greater then 2
(ins_left [(fn [] "%=")])
(ins_left
 ;Lsp server name
 {1 lsp_connection_evil
    :icon " LSP:"
    :color {:fg "#ffffff" :gui "bold"}})

;; Add components to right
(ins_right {1 "o:encoding"
            :fmt string.upper
            :cond conditions.hide_in_width
            :color {:fg colors.green :gui "bold"}})
(ins_right {1 "fileformat"
            :fmt string.upper
            :icons_enabled false
            :color {:fg colors.green :gui "bold"}})
(ins_right {1 "branch" :icon ""
            :color {:fg colors.violet :gui "bold"}})
(ins_right {1 "diff"
            :symbols {:added " " :modified "󰝤 " :removed " "}
            :diff_color {:added {:fg colors.green}
                         :modified {:fg colors.orange}
                         :removed {:fg colors.red}}
            :cond conditions.hide_in_width})
(ins_right {1 (fn [] "▊")
            :color {:fg colors.blue}
            :padding {:left 1}})

[{1 :nvim-lualine/lualine.nvim
  :config (fn []
            (let [lualine (require :lualine)]
              ;NOTE: withoyt setting it renders well the separators
              (lualine.setup my_setup)))}]
