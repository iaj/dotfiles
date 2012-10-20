XPTemplate priority=sub
XPTemplateDef
XPT osa
#!/usr/bin/osascript

XPT gn
do shell script "/usr/local/bin/growlnotify --iconpath /Users/iaj/Icons/growlnotify/Icon -t vim -m " & `message^
..XPT

XPT ac
on handle_string(myString)
    `action_for_text_input^
end handle_string

on open(theseItems)
    `action_for_files^
end open
..XPT
