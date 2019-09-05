uses SpeechABC, GraphABC;
uses System.Net;
uses System.IO;

var
  Ear: Recognizer;
  data_str: string;
  blocked: Boolean;

procedure Response(phrase: string);
begin
  if blocked = false then
  begin 
    data_str := '';
    writeln(phrase);
    
    if (phrase = 'Круг') then 
    begin
      data_str := 'circle';
    end
    else 
    if (phrase = 'Стоп') then 
    begin
      data_str := 'stop';
    end
    else 
    if (phrase = 'Трапеция') then 
    begin
      data_str := 'trapeze';
    end;
    
    if (data_str <> '') then
    begin
      var data := Encoding.UTF8.GetBytes(data_str);
        
    end;
     
  end;
end;

procedure KeyDown(key: integer);
begin
  if blocked = true then
  begin
    blocked := false;
    Ear.Start;
    writeln('Прием команд начат');
  end
  else
  begin
    blocked := true;
    Ear.Stop;
    writeln('Прием команд окончен'); 
  end;
  
end;

begin
  SpeechInfo;
  
  blocked := false;
  
  OnKeyDown := KeyDown;
  var Phrases := new string[]('Круг', 'Стоп', 'Трапеция');
  Ear := new Recognizer(Phrases);
  Ear.OnRecognized := Response;
  
  Ear.Start;
end.