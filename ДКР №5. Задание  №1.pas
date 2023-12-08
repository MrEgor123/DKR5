program DKR5;

type
  mass = array[1..10000000] of longint;

var
  f1, f2: text;
  i, n: longint;
  a: mass;

procedure sortselect(var a: mass; n: longint);
var
  i, j, maxIndex, tmp: longint;
begin
  for i := 1 to n - 1 do
  begin
    maxIndex := i;
    for j := i + 1 to n do
      if a[j] > a[maxIndex] then
        maxIndex := j;

    if maxIndex <> i then
    begin
      tmp := a[i];
      a[i] := a[maxIndex];
      a[maxIndex] := tmp;
    end;
  end;
end;

begin
  assign(f1, 'popit.txt');
  reset(f1);
  readln(f1, n);

  for i := 1 to n do
    read(f1, a[i]);

  close(f1);

  sortselect(a, n);

  assign(f2, 'outpopit.txt');
  rewrite(f2);

  for i := 1 to n do
    write(f2, a[i], ' ');

  close(f2);
end.


