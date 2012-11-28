XPTemplate priority=personal
XPTinclude
    \ _common/personal
XPT java
public class `E('%:t:r')^ {
    `cursor^
}
XPT p
System.out.println(`cursor^);
XPT pe
System.err.println(`cursor^);
