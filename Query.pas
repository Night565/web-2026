PROGRAM WorkWithQueryString(INPUT, OUTPUT);
USES
  DOS;

FUNCTION GetQueryStringParameter(Key: STRING): STRING;
VAR
  QueryString: STRING;
  StartPos, EndPos: INTEGER;
BEGIN {GetQueryStringParameter}
  QueryString := GetEnv('QUERY_STRING') + '&';
  StartPos := Pos(Key + '=', QueryString);
  IF StartPos > 0
  THEN
    BEGIN
      StartPos := StartPos + Length(Key) + 1;
      EndPos := StartPos;
      WHILE QueryString[EndPos] <> '&'
      DO
        EndPos := EndPos + 1;
    END
  ELSE
    Exit('Nothing');
  GetQueryStringParameter := Copy(QueryString, StartPos, EndPos - StartPos)
END; {GetQueryStringParameter}

BEGIN {WorkWithQueryString}
  WRITELN('Content-Type: text/plain');
  WRITELN;
  WRITELN('First Name: ', GetQueryStringParameter('first_name'));
  WRITELN('Last Name: ', GetQueryStringParameter('last_name'));
  WRITELN('Age: ', GetQueryStringParameter('age'))
END. {WorkWithQueryString}