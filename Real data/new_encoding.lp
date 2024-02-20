session(SID,DAY,OR) :- operatingRoom(OR,_), sessionN(OR,N,DAY),SID=1..s_count, SID>=((s_max*DAY)-(s_max-1)), SID<=((s_max*DAY)-(s_max-N)), not inactive(OR,DAY).
n_session(N,START,END) :- N = #count{SID,OR,DAY : session(SID,DAY,OR), DAY>=START, DAY<END}, needed(_, _, START, END).
{mss(OR, SID, SP, DAY) : operatingRoom(OR, SP)} == 1 :-  session(SID, DAY, OR).
effectiveShare(SP, PERCENTAGE, START, END) :- SESSION = #count{ OR,SID,DAY : mss(OR,SID,SP,DAY), DAY>=START, DAY<END}, n_session(N, START, END), specialty(SP), PERCENTAGE = ((SESSION*100) / N).
:- effectiveShare(SP, PERCENTAGE, START, END), needed(SP,TARGET,START,END), PERCENTAGE < TARGET.
:- effectiveShare(SP, PERCENTAGE, _,_), PERCENTAGE = 0.
slack(SP, PERCENTAGE-TARGET, START) :- effectiveShare(SP, PERCENTAGE, START, _), needed(SP, TARGET, START, _), PERCENTAGE > TARGET + 10.

:~ mss(OR, SID1, SP1, DAY), mss(OR, SID2, SP2, DAY), SID2 > SID1, SP1 != SP2. [1@4, DAY, OR]
:~ mss(OR, _, SP, DAY),not mss(OR, _, SP, DAY+7), session( _, DAY+7, OR). [1@3, OR, DAY]
:~ effectiveShare(SP, P1, START, _), effectiveShare(SP, P2, START+30, _). [|P1-P2|@2,SP, START]
:~ slack(SP, SL, ST). [SL@1, SL, ST]
