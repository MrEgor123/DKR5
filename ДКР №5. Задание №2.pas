program DKR5;

type
  TKey = Integer; // тип ключа для сортировки (замените на нужный вам)

  // Определение функции-компаратора
  TComparator = function(a, b: TKey): Boolean;

procedure RadixSort(var A: array of TKey; n: Integer; Comparator: TComparator);
var
  i, j, maxNum, exp, divisor: Integer;
  buckets: array[0..9] of array of TKey;
begin
  maxNum := A[0];
  for i := 1 to n - 1 do
    if A[i] > maxNum then
      maxNum := A[i];

  exp := 1;
  while maxNum div exp > 0 do
  begin
    // Инициализация корзин
    for i := 0 to 9 do
      SetLength(buckets[i], 0);

    // Распределение элементов по корзинам
    for i := 0 to n - 1 do
    begin
      j := (A[i] div exp) mod 10;
      SetLength(buckets[j], Length(buckets[j]) + 1);
      buckets[j][High(buckets[j])] := A[i];
    end;

    // Сборка элементов из корзин
    i := 0;
    for j := 0 to 9 do
    begin
      while Length(buckets[j]) > 0 do
      begin
        A[i] := buckets[j][0];
        SetLength(buckets[j], Length(buckets[j]) - 1);
        i := i + 1;
      end;
    end;

    exp := exp * 10;
  end;
end;

// Пример компаратора: сортировка по возрастанию
function CompareAsc(a, b: TKey): Boolean;
begin
  Result := a > b;
end;

// Пример компаратора: сортировка по убыванию
function CompareDesc(a, b: TKey): Boolean;
begin
  Result := a < b;
end;

var
  InputFileName, OutputFileName: String;
  InputFile, OutputFile: TextFile;
  Data: array of TKey;
  i, n: Integer;

begin
  InputFileName := 'rawr.txt';
  OutputFileName := 'outrawr.txt';
  

  // Открываем файлы
  AssignFile(InputFile, InputFileName);
  Reset(InputFile);
  AssignFile(OutputFile, OutputFileName);
  Rewrite(OutputFile);

  // Считываем данные из файла
  Readln(InputFile, n);
  SetLength(Data, n);
  for i := 0 to n - 1 do
    Read(InputFile, Data[i]);

  // Выбор компаратора (раскомментируйте нужную строку)
  RadixSort(Data, n, CompareAsc); // по возрастанию
  //RadixSort(Data, n, CompareDesc); // по убыванию

  // Выводим отсортированные данные в файл
  Writeln(OutputFile, n);
  for i := 0 to n - 1 do
    Write(OutputFile, Data[i], ' ');

  // Закрываем файлы
  CloseFile(InputFile);
  CloseFile(OutputFile);

  writeln('Сортировка завершена. Результат записан в файл ', OutputFileName);
end.
