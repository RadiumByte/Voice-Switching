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
      data_str := 'circlesign';
    end
    else 
    if (phrase = 'Стоп') then 
    begin
      data_str := 'stopsign';
    end
    else 
    if (phrase = 'Уступи') then 
    begin
      data_str := 'yieldsign';
    end
    else 
    if (phrase = 'Стоять') then 
    begin
      data_str := 'halt';
    end
    else 
    if (phrase = 'Ехать') then 
    begin
      data_str := 'go';
    end
    else 
    if (phrase = 'Ручное') then 
    begin
      data_str := 'manual';
    end
    else 
    if (phrase = 'Автомат') then 
    begin
      data_str := 'auto';
    end;
    
    if (data_str <> '') then
    begin
      var url : string := 'http://localhost:8080/' + data_str;
      var message : string;
      
      var request : HttpWebRequest := HttpWebRequest(WebRequest.Create(url));
      request.Method := 'PUT';
      
      var response : WebResponse := request.GetResponse();
      var sr : StreamReader := new StreamReader(response.GetResponseStream(), System.Text.Encoding.UTF8);
     
      message := sr.ReadToEnd();
      response.Close();
      writeln(message);
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
  var Phrases := new string[]('Круг', 'Стоп', 'Уступи', 'Стоять', 'Ехать', 'Ручное', 'Автомат');
  Ear := new Recognizer(Phrases);
  Ear.OnRecognized := Response;
  
  Ear.Start;
end.