XPTemplate priority=personal
XPTinclude
    \ _common/personal
    \ _common/common

XPT sq hint=squat-te
`date()^
squats			(`sqset1^)	(`sqset2?^)	(`sqset3?^)
bench presses		(`bpset1^)	(`bpset2?^)	(`bpset3?^)
barbell rows		(`rwset1^)	(`rwset2?^)	(`rwset3?^)
comments		(`comment?^)
..XPT

XPT dl hint=deadlift-te
`date()^
deadlifts		(`dlset1^)	(`dlset2?^)	(`dlset3?^)
chinups			(`cuset1^)	(`cuset2?^)	(`cuset3?^)
militaries		(`mpset1^)	(`mpset2?^)	(`mpset3?^)
comments		(`comment?^)
..XPT

XPT if hint=another\ fasted\ session
<intermittent fasted on `date() for `time^ hours.>
..XPT

XPT w hint=weight\ loggage
<weight on `date(): `weight^ kilogram>
..XPT

XPT i hint=insert\ an\ image
`date()^ pics/`filename^
..XPT
