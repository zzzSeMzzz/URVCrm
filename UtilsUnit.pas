unit UtilsUnit;

interface

Uses
  System.Classes, System.SysUtils, ComObj, Vcl.ComCtrls, System.Variants;

  function qs(s:string):string;
  function toMySqlDate(dt:TDate):string;
  function minToHour(min:integer):string;
  function CompareDoubleInc(Item1, Item2: Double): Integer;
  procedure saveListViewToExel(lv:TListView; fileName:String);
  //function toMySqlDate(dt:string):string;
type
   TSortState =(ssUp, ssDown, ssNone);

type
  TLockupPair = class(TObject)
    private
      fid:integer;
      fvalue:string;
    public
      constructor Create(id:integer; value:string);
      destructor Destroy; override;

      property id:integer read fid write fid;
      property value:string read fvalue write fvalue;
  end;

type
  TLockupValue = class(TObject)
    private
     fslValues, fslIds:TStringList;

    public
      constructor Create; overload;

      destructor Destroy; override;

      property slValues:TStringList read fslValues write fslValues;
      property slIds:TStringList read fslIds write fslIds;

      function getIdFromValue(value:string):string;
      function getIdFromPosValue(position:integer):string;
      function getValueFromId(id:integer):string;
      function getPositionFromId(id:integer):integer;
      function getPair(index:integer):TLockupPair;
      function count:integer;
      function getIds(delimeter:char):string;
      procedure addPair(id:integer; value:string); overload;
      procedure addPair(id:string; value:string); overload;
      procedure addPair(pair:TLockupPair); overload;
      procedure Assign(obj:TLockupValue);
  end;


implementation

procedure saveListViewToExel(lv:TListView; fileName:String);
var i, j, r, c:integer;
     excel, Sheet: OLEVariant;
begin
excel := CreateOleObject('Excel.Application');

//делаем окно Excel невидимым
excel.Visible := false;
excel.DisplayAlerts := false;
excel.Workbooks.Add;

Sheet := excel.Workbooks[1].WorkSheets[1];

c:=lv.Columns.Count-1;
r:=lv.Items.Count;

for j:= 0 to r do
       for i:=0 to c do
         if(j=0) then sheet.cells[j+1,i+1]:=lv.Columns.Items[i].Caption
         else begin
                if(i=0) then sheet.cells[j+1,i+1]:=lv.Items.Item[j-1].Caption
                else sheet.cells[j+1,i+1]:=lv.Items.Item[j-1].SubItems[i-1];
              end;

excel.Visible := true;
excel.WorkBooks[1].SaveAs(fileName);

//excel.Quit;

 //очищаем выделенную память
 excel := unassigned;
 Sheet := unassigned;
end;

function CompareDoubleInc(Item1, Item2: Double): Integer;
begin
  if Item1=Item2 then begin
    Result := 0;
  end else if Item1<Item2 then begin
    Result := -1
  end else begin
    Result := 1;
  end;
end;

function toMySqlDate(dt:TDate):string;
var s:string;
begin
 s:=datetostr(dt);
 Result:=copy(s,7,4)+'-'+copy(s, 4,2)+'-'+copy(s, 1,2);
end;

function qs(s:string):string;
begin
  Result:=chr(39)+s+chr(39);
end;

function minToHour(min:integer):string;
var h, m:integer;
begin
  h:= min div 60;
  m:=min-h*60;
  Result:=Format('%.2d:%.2d', [h, m]);
end;

procedure TLockupValue.addPair(id: integer; value: string);
begin
 fslValues.Add(value);
 fslIds.Add(inttostr(id));
end;

procedure TLockupValue.addPair(id, value: string);
begin
 fslValues.Add(value);
 fslIds.Add(id);
end;

procedure TLockupValue.addPair(pair: TLockupPair);
begin
addPair(pair.id, pair.value);
end;

procedure TLockupValue.Assign(obj: TLockupValue);
var i:integer;
begin
//Self:=TLockupValue.Create;
for I := 0 to obj.count-1 do
 self.addPair(obj.getPair(i));
end;

function TLockupValue.count: integer;
begin
Result:=slIds.Count;
end;

constructor TLockupValue.Create;
begin
  inherited;
  fslValues:=TStringList.Create;
  fslIds:=TStringList.Create;
end;

destructor TLockupValue.Destroy;
begin
  inherited;
  fslValues.Free;
  fslIds.Free;
end;

function TLockupValue.getIdFromPosValue(position: integer): string;
begin
if(position>=slIds.Count) then result:=''
else Result:=slIds.Strings[position];
end;

function TLockupValue.getIdFromValue(value: string): string;
var ind:integer;
begin
  ind:=slValues.IndexOf(value);
  if(ind=-1) then Result:=''
  else Result:=slIds.Strings[ind];
end;


function TLockupValue.getIds(delimeter: char): string;
begin
slIds.Delimiter:=delimeter;
Result:=slIds.DelimitedText;
end;

function TLockupValue.getPair(index: integer): TLockupPair;
begin
Result:=TLockupPair.Create(strtoint(slIds.Strings[index]), slValues.Strings[index]);
end;

function TLockupValue.getPositionFromId(id: integer): integer;
begin
  Result:=slIds.IndexOf(inttostr(id));
end;

function TLockupValue.getValueFromId(id: integer): string;
var ind:integer;
begin
 ind:=slIds.IndexOf(inttostr(id));
 if(ind=-1) then Result:=''
 else Result:=slValues.Strings[ind];
end;

{ TLockupPair }

constructor TLockupPair.Create(id: integer; value: string);
begin
fid:=id;
fvalue:=value;
end;

destructor TLockupPair.Destroy;
begin

  inherited;
end;

end.
