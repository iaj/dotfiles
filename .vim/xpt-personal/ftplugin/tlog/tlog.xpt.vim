XPTemplate priority=personal
XPTinclude
    \ _common/personal
    \ _common/common

"whole workouts go below here
XPT sq hint=squat-te
`date()^ squats		(`squats^kg*`^)`...1^ (`squats^kg*`^)`...1^
`date()^ bench presses	(`benches^kg*`^)`...2^ (`benches^kg*`^)`...2^
`date()^ barbell rows	(`rows^kg*`^)`...3^ (`rows^kg*`^)`...3^
..XPT

XPT dl hint=deadlift-te
`date()^ deadlifts		(`deads^kg*`^)`...1^ (`deads^kg*`^)`...1^
`date()^ chinups		(`chins^)`...2^ (`chins^)`...2^
`date()^ pulldowns		(`pulls^kg*`^)`...3^ (`pulls^kg*`^)`...3^
`date()^ military presses	(`militaries^kg*`^)`...4^ (`militaries^kg*`^)`...4^
..XPT

XPT armpwo hint=arm\ workout\ ng\ means\ palms\ facing\ each\ other
`date()^ ng chinups		(`chins^)`...1^ (`chins^)`...1^
`date()^ ng dumbell presses	(`dbpress^kg*`^)`...2^ (`dbpress^kg*`^)`...2^
`date()^ barbell drag curls	(`curls^kg*`^)`...3^ (`curls^kg*`^)`...3^
`date()^ dips		(`dips^)`...4^ (`dips^)`...4^
`date()^ zottmann curls	(`zottmans^kg*`^)`...5^ (`zottmans^kg*`^)`...5^
`date()^ overhead extensions	(`overheads^kg*`^)`...6^ (`overheads^kg*`^)`...6^
..XPT

"single exercices go here!
XPT chins hint=superior\ ex
`date()^ chinups		(`chins^)`...^ (`chins^)`...^
..XPT

XPT crunches hint=not\ needed\ but\ mb\ has\ some\ merit
`date()^ crunches		(`crunches^)`...^ (`crunches^)`...^
..XPT

XPT calv hint=get\ some\ big\ ass\ calves
`date()^ calv raises		(`calv^kg*`^)`...^ (`calv^kg*`^)`...^
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
`date()^ progresspic ▸ pics/`^
..XPT

XPT c hint=comment\ inserting
comments (`comment?^)
..XPT

XPT m hint=measurements
measurements ▸
`date()^ brustfalte		(`^mm)`...1^ (`^mm)`...1^ (avg:`chest^mm)
`date()^ bauchfalte		(`^mm)`...2^ (`^mm)`...2^ (avg:`abs^mm)
`date()^ beinfalte		(`^mm)`...3^ (`^mm)`...3^ (avg:`legs^mm)
`date()^ bauchumfang		(`^cm)`...4^ (`^cm)`...4^ (avg:`extent^cm)
`date()^ kf/lbm/fat		(kf:`kf%^%) (lbm:`lbm^kg) (fat:`fat^kg)
..XPT

XPT bmr hint=basal\ metabolic\ rate\ with\ formula
`date()^ `weight^pd tbm*0.`kf^% kf=`fatbodymass^pd fbm
`date()^ `weight^pd tbm-`fatbodymass^pd fbm=`leanbodymass^pd lbm
`date()^ `leanbodymass^pd lbm*17=`basal metabolic rate^ bmr
..XPT

XPT > hint=▸
▸ 
..XPT
