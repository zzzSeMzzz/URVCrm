unit DataUnit;

interface

uses
  System.SysUtils, System.Classes, Data.DB, MemDS, DBAccess, MyAccess, dialogs,
  ShFolder, IniFiles;

function GetMyS:string;

type
  Tdm = class(TDataModule)
    cn: TMyConnection;
    usersQ: TMyQuery;
    usersDS: TDataSource;
    departmentsQ: TMyQuery;
    handbookDS: TDataSource;
    clientsQ: TMyQuery;
    worksQ: TMyQuery;
    taskQ: TMyQuery;
    taskDS: TDataSource;
    tasksFilter: TMyQuery;
    taskFDS: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    pk:TLocateOption;
    dstate, dstate_ins:TDATAsetState;
  end;

const
  taskSql:string=' select tasks.*,' +chr(13)+
  'clients.`name` as `client`,' +chr(13)+
  'works.`name` as `work`,' +chr(13)+
  'users.`user_name` as `fio`,' +chr(13)+
  'department.`name` as `dep`'+chr(13)+
  'from tasks' +chr(13)+
  'LEFT JOIN works ON (works.`id`=tasks.`id_work`)' +chr(13)+
  'LEFT JOIN clients ON (clients.`id`=tasks.`id_client`)'+chr(13)+
  'LEFT JOIN users ON (users.`id`=tasks.`user_id`)'+chr(13)+
  'LEFT JOIN department ON (department.`id`=users.`id_dep`)';
  taskSqlGrop:String='GROUP BY tasks.id';

var
  dm: Tdm;
  ini:TIniFile;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses ufrsett;

function GetMyS:string;
var
  Buf:array[0..255] of Char;
  s:string;
begin
  Result:='';
  if SHGetFolderPath(0, CSIDL_APPDATA, 0, 0, Buf) = 0 then s:=Buf;
  if s[length(s)]<>'\' then  s:=s+'\';
  result:=s;
end;

procedure Tdm.DataModuleCreate(Sender: TObject);
var fn:string;
begin
cn.Connected:=false;
fn:=getmys+settFolder+'\';
//ShowMessage(fn);
createdir(fn);
ini:=TIniFile.Create(fn+'sett.ini');

cn.Server:=ini.ReadString('connection', 'host', cn.Server);
cn.Username:=ini.ReadString('connection', 'user', cn.Username);
cn.password:=ini.ReadString('connection', 'password', cn.Password);
cn.Database:=ini.ReadString('connection', 'db', cn.Database);
cn.Port:=ini.ReadInteger('connection', 'port', cn.Port);
ini.Free;

//showmessage(cn.Password);

cn.Connected:=false;
pk:=loPartialKey;
dstate:=dsEdit ;
dstate_ins:=dsInsert;
end;

end.
