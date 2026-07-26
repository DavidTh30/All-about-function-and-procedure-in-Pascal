Procedure TimeExpired;
Begin
    Writeln('The timer finished.');
End;

setTimer(10, @TimeExpired); // start a timer for 10 seconds