XPTemplate priority=personal
XPTinclude
    \ _common/personal

XPT html " <html><head>..<head><body>...
<!DOCTYPE html>
<html>
    `:head:^
    <body>
        `cursor^
    </body>
</html>
..XPT

XPT css " <link rel="stylesheet>...
<link rel="stylesheet" type="text/css" href="`cursor^">
..XPT
