on run argv
    set userQuery to (argv as text)
    set projectURL to "https://chatgpt.com/g/g-p-68b922c238a08191ae6182d95bbb30b0-english/project"
    
    tell application "Arc"
        activate
        set targetWindow to front window
        
        set foundTab to missing value
        repeat with t in tabs of targetWindow
            try
                if (URL of t contains "g-p-68b922c238a08191ae6182d95bbb30b0-english") then
                    set foundTab to t
                    exit repeat
                end if
            end try
        end repeat
        
        if foundTab is not missing value then
            set active tab of targetWindow to foundTab
        else
            tell targetWindow
                make new tab with properties {URL:projectURL}
            end tell
            delay 1
        end if
    end tell

    tell application "System Events"
        delay 0.8
        keystroke userQuery
        key code 36 -- Enter
    end tell
end run
