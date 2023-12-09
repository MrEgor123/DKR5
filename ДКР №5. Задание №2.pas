Program DKR5;
const
  Sz = 100;
  K = 4;

var
  a, b: array[0..Sz] of Integer;
  c: array[0..15] of Integer;
  m, n, i, t: Integer;
  e: Integer;
  inputFile, outputFile: Text;

procedure RadixSort(i: integer);
begin
  while m > 0 do
  begin
    for i := Low(c) to High(c) do
      c[i] := 0;

    for i := 0 to n - 1 do
    begin
      t := a[i] div (1 * (2 shl e)) and 15; 
      Inc(c[t]);
    end;

    for i := 1 to 15 do
      Inc(c[i], c[i - 1]);

    for i := n - 1 downto 0 do
    begin
      t := a[i] div (1 * (2 shl e)) and 15; 
      Dec(c[t]);
      b[c[t]] := a[i];
    end;

    for i := 0 to n - 1 do
      a[i] := b[i];

    Inc(e, K);
    m := m div (1 * (2 shl K)); 
  end;
end;

begin
  Assign(inputFile, 'rawr.txt');
  Reset(inputFile);
  Read(inputFile, n);
  Read(inputFile, m);
  a[0] := m;
  for i := 1 to n - 1 do
  begin
    Read(inputFile, a[i]);
    if m < a[i] then
      m := a[i];
  end;
  Close(inputFile);

  e := 0;
  RadixSort(i);

  Assign(outputFile, 'outrawr.txt');
  Rewrite(outputFile);
  for i := 0 to n - 1 do
    Write(outputFile, a[i], ' ');
  WriteLn(outputFile);
  Close(outputFile);

  Writeln('Результат успешно сохранен в файл outrawr.txt');
end.
