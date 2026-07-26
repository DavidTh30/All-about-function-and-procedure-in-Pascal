Type
    ProcType = Procedure(num : Integer);

Var
    ptr : ProcType;

Procedure MyProc(i : Integer);
Begin
    ...
End;

(* Main *)
Begin
    ptr := @MyProc;
    ptr(1234);
End.