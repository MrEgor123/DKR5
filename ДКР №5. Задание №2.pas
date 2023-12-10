Program DKR5;
const
  Sz = 100;
  K = 4;

var
  a, b: array[0..Sz] of Integer;
  c: array[0..15] of Integer;
  m, n, i, t: Integer;
  e: Integer;
  inputFile, outputFile: Text; // тектовые файлы

procedure RadixSort(i: integer);
begin
  while m > 0 do
  begin
    for i := Low(c) to High(c) do // обнуление массива c
      c[i] := 0;

    for i := 0 to n - 1 do // для подсчета элементов в каждом разряде
    begin
      t := a[i] div (1 * (2 shl e)) and 15; 
      Inc(c[t]);
    end;

    for i := 1 to 15 do // вычисление префиксных сумм для массива с
      Inc(c[i], c[i - 1]);

    for i := n - 1 downto 0 do // перемешивание элементов с учетом разряда
    begin
      t := a[i] div (1 * (2 shl e)) and 15; 
      Dec(c[t]);
      b[c[t]] := a[i];
    end;

    for i := 0 to n - 1 do // копирование массива b обратно в массив a
      a[i] := b[i];

    Inc(e, K);
    m := m div (1 * (2 shl K));  // обновление переменной m со сдвигом вправо
  end;
end;  // конец процедуры

begin
  Assign(inputFile, 'rawr.txt'); // привязка файла к переменной
  Reset(inputFile);
  Read(inputFile, n);
  Read(inputFile, m);
  a[0] := m; // присвоение элемента m
  for i := 1 to n - 1 do // для оставшихся элементов массива а из файла
  begin
    Read(inputFile, a[i]);
    if m < a[i] then
      m := a[i];
  end;
  Close(inputFile); // закрытие файла с входными данными

  e := 0;
  RadixSort(i);

  Assign(outputFile, 'outrawr.txt'); // запись отсортированных значений в файл
  Rewrite(outputFile);
  for i := 0 to n - 1 do
    Write(outputFile, a[i], ' ');
  WriteLn(outputFile);
  Close(outputFile); // закрытие файла с выходными данными

  Writeln('Результат успешно сохранен в файл outrawr.txt');
end.
