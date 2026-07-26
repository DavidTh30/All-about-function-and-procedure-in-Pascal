OnIdle(Sender: TObject; var Done: boolean);

Application.OnIdle := @OnIdle; 

Done := false; 

Done variable is set to false to allow it to repeat.