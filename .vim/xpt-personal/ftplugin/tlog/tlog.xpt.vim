XPTemplate priority=personal
XPTinclude
    \ _common/personal
    \ _common/common
XPTvar $DATE_FMT     '%Y %b %d, %a'

"whole workouts go below here
"XPT sq hint=squat-te
"`date()^ squats                (`squats^kg*`^)`...1^ (`squats^kg*`^)`...1^
"`date()^ bench presses (`benches^kg*`^)`...2^ (`benches^kg*`^)`...2^
"`date()^ barbell rows  (`rows^kg*`^)`...3^ (`rows^kg*`^)`...3^
"..XPT

XPT sq hint=squats\ 6-8/8-10/10-12
`date()^ squats         (`squats^kg*`^)`...1^ (`squats^kg*`^)`...1^
..XPT
"`date()^ calf raises       (`calfr^kg*`^)`...2^ (`calfr^kg*`^)`...2^

XPT bp hint=benchpresses\ 6-8/8-10/10-12
`date()^ bench presses  (`benches^kg*`^)`...1^ (`benches^kg*`^)`...1^
..XPT
"`date()^ pushups           (`pushs^`^)`...2^ (`pushs^)`...2^

"XPT dl hint=deadlift-te
"`date()^ deadlifts         (`deads^kg*`^)`...1^ (`deads^kg*`^)`...1^
"`date()^ chinups           (`chins^)`...2^ (`chins^)`...2^
"`date()^ pulldowns         (`pulls^kg*`^)`...3^ (`pulls^kg*`^)`...3^
"`date()^ military presses  (`militaries^kg*`^)`...4^ (`militaries^kg*`^)`...4^
"..XPT

XPT dl hint=deads\ 4-6/6-8/8-10
`date()^ deadlifts      (`deads^kg*`^)`...1^ (`deads^kg*`^)`...1^
..XPT
"`date()^ chinups               (`chins^)`...2^ (`chins^)`...2^
"`date()^ pulldowns             (`pulls^kg*`^)`...3^ (`pulls^kg*`^)`...3^
"`date()^ military presses      (`militaries^kg*`^)`...4^ (`militaries^kg*`^)`...4^

XPT dips hint=diptime
`date()^ dips           (`dips^)`...1^ (`dips^)`...1^
..XPT

XPT armpwo hint=neutral\ grip\ on\ chins\ and\ dbpresses\ arm\ workout\ ng\ means\ palms\ facing\ each\ other
`date()^ chinups            (`chins^)`...1^ (`chins^)`...1^
`date()^ dumbell presses    (`dbpress^kg*`^)`...2^ (`dbpress^kg*`^)`...2^
`date()^ barbelldrag curls  (`curls^kg*`^)`...3^ (`curls^kg*`^)`...3^
`date()^ dips               (`dips^)`...4^ (`dips^)`...4^
`date()^ zottmanns          (`zottmans^kg*`^)`...5^ (`zottmans^kg*`^)`...5^
`date()^ overheads          (`overheads^kg*`^)`...6^ (`overheads^kg*`^)`...6^
..XPT

"single exercices go here!
XPT chins hint=superior\ ex
`date()^ chinups        (`chins^)`...^ (`chins^)`...^
..XPT

XPT pull hint=superior\ ex
`date()^ pullups        (`pullups^)`...^ (`pullups^)`...^
..XPT

XPT crunches hint=not\ needed\ but\ mb\ has\ some\ merit
`date()^ crunches       (`crunches^)`...^ (`crunches^)`...^
..XPT

XPT calv hint=get\ some\ big\ ass\ calves
`date()^ calv raises    (`calv^kg*`^)`...^ (`calv^kg*`^)`...^
..XPT

"nutrition stuff
XPT if hint=another\ fasted\ session
`date() intermittent fasted for `time^ hours
..XPT

XPT w hint=weight\ loggage\ in\ kilograms
`date()^ weight `weight^ kilograms
..XPT

XPT wp hint=weight\ loggage\ in\ pounds
`date()^ weight `weight^ pounds
..XPT

XPT wi hint=water\ intake
waterintake (`water intake?^)
..XPT

"misc, measurements etc.
XPT i hint=insert\ an\ image
`date()^ progresspic ▸ transformation/`^
..XPT

XPT c hint=comment\ inserting
comments (`comment?^)
..XPT

XPT m hint=measurements
measurements ▸
`date()^ brustfalte             (`^mm)`...1^ (`^mm)`...1^ (avg:`chest^mm)
`date()^ bauchfalte             (`^mm)`...2^ (`^mm)`...2^ (avg:`abs^mm)
`date()^ beinfalte              (`^mm)`...3^ (`^mm)`...3^ (avg:`legs^mm)
`date()^ bauchumfang            (`^cm)`...4^ (`^cm)`...4^ (avg:`extent^cm)
`date()^ hüftumfang             (`^cm)`...4^ (`^cm)`...4^ (avg:`extent^cm)
`date()^ kf/lbm/fat             (kf:`kf%^%) (lbm:`lbm^kg) (fat:`fat^kg)
..XPT

XPT bmr hint=basal\ metabolic\ rate\ with\ formula
`date()^ `weight^pd tbm*0.`kf^% kf=`fatbodymass^pd fbm
`date()^ `weight^pd tbm-`fatbodymass^pd fbm=`leanbodymass^pd lbm
`date()^ `leanbodymass^pd lbm*17=`basal metabolic rate^ bmr
..XPT

XPT sleep hint=sleep\ tracking
`date()^ sleep: `^ hrs
..XPT
