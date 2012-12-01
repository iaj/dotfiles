"author iaj (tyberion@googlemail.com)
syn match keyword "\<\(addCodeElem\|addCodeLine\|after\|along\|angle\|arc\|around\|array\|arrayEnd\|arrayIndex\|arrayMarker\|arrayPointer\|arrayPut\|arraySwap\|as\|at\|atIndex\|baseline\|bold\|bottom\|boundingBox\|bounds\|boxFillColor\|boxed\|bundle\|bwArrow\|cascaded\|cellHighlight\|center\|centered\|circle\|circleseg\|circlesegment\|clearLink\|clockwise\|clone\|closed\|codegroup\|color\|context\|contextColor\|corner\|cornerDef\|counterclockwise\|defLocation\|defineLocation\|degrees\|delay\|depth\|depthVal\|echo\|elemHighlight\|elementColor\|ellipse\|ellipseseg\|ellipsesegment\|end\|exchange\|field\|fillColor\|filled\|font\|fontSize\|from\|fwArrow\|group\|height\|hidden\|hide\|hideAll\|hideAllBut\|hideCode\|highlightArrayCell\|highlightArrayElem\|highlightCode\|highlightColor\|horizontal\|ids\|indentation\|italic\|jumpArrayIndex\|jumpArrayMarker\|jumpArrayPointer\|jumpIndex\|jumpMarker\|jumpPointer\|key\|label\|left\|length\|line\|link\|listelement\|location\|merge\|move\|moveArrayIndex\|moveArrayMarker\|moveArrayPointer\|moveIndex\|moveMarker\|movePointer\|ms\|name\|node\|none\|offset\|on\|outside\|point\|pointerAreaColor\|pointerAreaFillColor\|pointers\|polygon\|polyline\|position\|prev\|ptr\|radius\|rectangle\|region\|relrect\|relrectangle\|remove\|resource\|resourceBundle\|right\|rotate\|row\|rule\|set\|setLink\|show\|size\|square\|start\|starts\|supports\|swap\|text\|textColor\|ticks\|to\|top\|translate\|triangle\|type\|ungroup\|unhighlightArrayCell\|unhighlightArrayElem\|unhighlightCode\|unquotedText\|value\|vertical\|via\|visible\|width\|with\|within\)\>"
syn match coloring "\<\(black\|blue\|blue2\|blue3\|blue4\|brown2\|brown3\|brown4\|cyan\|cyan2\|cyan3\|cyan4\|dark\|Gray\|gold\|green\|green2\|green3\|green4\|light\|Gray\|light_blue\|magenta\|magenta2\|magenta3\|magenta4\|orange\|pink\|pink2\|pink3\|pink4\|red\|red2\|red3\|red4\|white\|yellow\)\>"
syn match direction "\<\(NW\|N\|NE\|W\|C\|E\|SW\|S\|SE\|Northwest\|North\|Northeast\|West\|Middle\|Center\|East\|Southwest\|South\|Southeast\)\>"
syn match headnode "^\(%Animal\|title\|author\)\>"
syn match font "\(Monospaced\|SansSerif\|Serif\)"
syn match Number "\<\d\+\>"
syn match id "\"[^"]*\""
"
" syntax region Comment   start=+comments (+  skip=+comments (+  end=+)+
" comment that whole line with a # prefix
syntax region Comment start="^#"hs=s end=/$/he=e

hi def link keyword Number
hi def link headnode Number
hi def link coloring PreProc
hi def link direction PreProc
hi def link id PreProc
hi def link font Statement
