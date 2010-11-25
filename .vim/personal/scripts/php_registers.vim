"" when PRESSED F11 the list of registers will be displayed
"" example: register 't' can be trigger by typing '@t' when not in insertion
"" mode
echo "PHP MACROS: @t = die(var_dump()) | @a = _assert() | @l = _log(content) | @p = _popup(content)" 


" load recordings into registers by pressing "pa after a recording 
" more on this topic type ':help recording'  or ': "'
let @t = "idie( var_dump(   ) );ODODODODODOD"
let @a = "i_assert( ,"");ODODODODODOD"
let @l = "i\";€kl€K4:s/\"//g€K4:s/;//gi_log( \"\\€kr€K4y€K4a \" . p€K4a );^€kd"
let @p = "i\";€kl€K4:s/\"//g€K4:s/;//gi_popup( \"\\€kr€K4y€K4a \" . p€K4a );^€kd"

" load abbreviations
abbr pph php
