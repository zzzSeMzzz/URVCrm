unit TaskUnit;

interface

Uses
  System.SysUtils, System.Classes;

type
  TTask = class(TObject)
    private
     FId:Integer;
     FIdUser:integer;
     FDate:TDate;
     FIdClient, FIdWork, FTime:integer;
     Fclient, Fwork, FComment:string;


    public
      constructor Create; overload;
      constructor Create(Id:integer; date:TDate; idClient, idWork:integer; work,
          client, comment:string; time, idUser:integer); overload;


      destructor Destroy; override;

      property id:Integer read FId write FId;
      property idClient:integer read FIdClient write FIdClient;
      property idWork:integer read FIdWork write FIdWork;
      property client:string read Fclient write fClient;
      property work:string read Fwork write Fwork;
      property date:TDate read FDate write FDate;
      property comment:string read FComment write FComment;
      property time:integer read FTime write FTime;
      property idUser:integer read FIdUser write FIdUser;
  end;

implementation

{ TUser }

constructor TTask.Create;
begin

end;

constructor TTask.Create(Id: integer; date: TDate; idClient, idWork: integer;
  work, client, comment: string; time, idUser: integer);
begin
inherited Create;
 FId:=id;
 FDate:=date;
 FIdClient:=idClient;
 FIdWork:=idWork;
 Fwork:=work;
 Fclient:=client;
 FComment:=comment;
 FTime:=time;
 FIdUser:=idUser;
end;

destructor TTask.Destroy;
begin

  inherited;
end;

end.
