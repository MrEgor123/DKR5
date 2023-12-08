program DKR5;

type
  arr = array[1..100] of Integer;

var
  f1, f2: text; // файловые переменные
  i, n: Integer;
  a: arr;

procedure sortselect(var a: arr; n: Integer); // упорядочивание элементов массива
var
  i, j, maxIndex, k: Integer;
begin
  for i := 1 to n - 1 do
  begin
    maxIndex := i;
    for j := i + 1 to n do
      if a[j] > a[maxIndex] then // макс. эл. в неотсорт. части массива
        maxIndex := j;

    if maxIndex <> i then // обмен местами текущего с максимальным
    begin
      k := a[i];
      a[i] := a[maxIndex];
      a[maxIndex] := k;
    end;
  end;
end;

begin
  assign(f1, 'popit.txt'); // открытие файла с данными
  reset(f1);
  readln(f1, n);

  for i := 1 to n do // счетчик элементов в файле
    read(f1, a[i]);

  close(f1);

  sortselect(a, n); // процедура сортировки

  assign(f2, 'outpopit.txt'); // открытие файла с результатом
  rewrite(f2);

  for i := 1 to n do // запись отсортированных в файл
    write(f2, a[i], ' ');

  close(f2);
end.
