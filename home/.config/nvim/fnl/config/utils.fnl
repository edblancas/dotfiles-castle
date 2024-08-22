(fn toggle-test-file []
  (let [nt (require :neotest)
        path (vim.fn.expand "%:h:t")
        filename (vim.fn.expand "%:t")]
    (if (= (string.sub filename 1 5) "test_")
        (vim.cmd.edit (.. "src/" path "/" (string.sub filename 6)))
        (vim.cmd.edit (.. "test/" path "/test_" filename)))))

{: toggle-test-file}
