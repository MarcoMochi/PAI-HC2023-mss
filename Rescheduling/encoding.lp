newsession(SID,DAY,OR) :- operatingRoom(OR,_), sessionN(OR,N,DAY),SID=1..s_count, SID>=((s_max*DAY)-(s_max-1)), SID<=((s_max*DAY)-(s_max-N)), not inactive(OR,DAY), not unusable(OR,DAY).
n_newsession(N,START,END) :- N = #count{SID,OR,DAY : newsession(SID,DAY,OR), DAY>=START, DAY<END}, newTARGETshare(_, _, _,START, END).
newMSS(OR, SID, SP, DAY) :- mss(OR, SID, SP, DAY), not unusable(_,DAY), unusable(_,_).
{newMSS(OR, SID, SP, DAY) : operatingRoom(OR, SP)} == 1 :- newsession(SID, DAY, OR).
:- #count{SP,OR,DAY: newMSS(OR,SID,SP,DAY), DAY>=START, DAY<=END}>=N, limit(SP,START,END,N).
newEFFshare(SP, PERCENTAGE, START, END) :- SESSION = #count{ OR,SID,DAY : newMSS(OR,SID,SP,DAY), DAY>=START, DAY<END}, n_newsession(N, START, END), specialty(SP), PERCENTAGE = ((SESSION*100) / N).
:- newEFFshare(SP, PERCENTAGE, START, END), newTARGETshare(SP,TARGET,ERROR,START,END), PERCENTAGE < (TARGET-ERROR).
:- newEFFshare(SP, PERCENTAGE, START,END), newTARGETshare(SP,TARGET,ERROR,START,END), PERCENTAGE > (TARGET+ERROR).
:- newEFFshare(SP, PERCENTAGE, _,_), PERCENTAGE = 0.
:~ newEFFshare(SP, ES, START, END), newTARGETshare(SP,TS,ERR,START,END). [|ES-TS|@3, SP, START]
:~ effectiveShare(SP, ES, START, END), newEFFshare(SP, NES, START, END). [|ES-NES|@2, SP, START]
:~ mss(OR, SID, SP, DAY), not newMSS(OR, SID, SP, DAY), not unusable(OR,DAY). [1@1,OR,SID]