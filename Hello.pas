PROGRAM Hello(INPUT, OUTPUT);
USES
  DOS;
VAR
  QueryString, Name: STRING;
  PosName: INTEGER;
BEGIN
  WRITELN('Content-Type: text/plain');
  WRITELN;
  
  QueryString := GetEnv('QUERY_STRING');
  PosName := Pos('name=', QueryString);
  Name := Copy(QueryString, PosName + 5, 255);
  
  IF (PosName > 0) AND (Name <> '')
  THEN
    BEGIN
      WRITELN('Hello dear, ', Name, '!');
    END
  ELSE
    WRITELN('Hello Anonymous!')  
END.