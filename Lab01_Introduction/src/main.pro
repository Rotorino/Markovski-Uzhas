% Лабораторная работа №1. Visual Prolog 7.5, Console Application.
implement main
    open core, console

class predicates
    readInteger : (string Prompt) -> integer Value.
    showStringTasks : (string Text, string First, string Last, integer Hash) procedure.
    showMathTask : (integer A, integer B, integer C, integer Result) procedure.
    saveAnsiReport : (string Text, string First, string Last, integer Hash,
                      integer A, integer B, integer C, integer ExpressionResult,
                      integer InputNumber, integer RandomNumber, integer Sum) procedure.

clauses
    readInteger(Prompt) = Value :-
        write(Prompt),
        Line = readLine(),
        Value = tryToTerm(integer, Line).

    showStringTasks(Text, First, Last, Hash) :-
        Hash = string::hash(Text),
        Length = string::length(Text),
        string::front(Text, Length div 2, First, Last),
        write("Хэш строки: ", Hash), nl,
        write("Первая половина: ", First), nl,
        write("Вторая половина: ", Last), nl.

    showMathTask(A, B, C, Result) :-
        Result = math::max(A, B, C) - math::min(B, C),
        write("max(A,B,C) - min(B,C) = ", Result), nl.

    saveAnsiReport(Text, First, Last, Hash, A, B, C, ExpressionResult,
                   InputNumber, RandomNumber, Sum) :-
        Out = outputStream_file::create8("Lab01_Task05_ANSI.txt"),
        Out:write("Лабораторная работа №1", "\n"),
        Out:write("Исходная строка: ", Text, "\n"),
        Out:write("Хэш: ", Hash, "\n"),
        Out:write("Половины: ", First, " | ", Last, "\n"),
        Out:write("A, B, C: ", A, ", ", B, ", ", C, "\n"),
        Out:write("max(A,B,C) - min(B,C): ", ExpressionResult, "\n"),
        Out:write("Число: ", InputNumber, "; случайное число: ", RandomNumber,
                  "; сумма: ", Sum, "\n"),
        Out:close(),
        write("Результат записан в Lab01_Task05_ANSI.txt"), nl.

    run() :-
        write("Лабораторная работа №1", "\n\n"),
        write("Введите строку: "),
        Text = readLine(),
        showStringTasks(Text, First, Last, Hash), nl,

        A = readInteger("Введите A: "),
        B = readInteger("Введите B: "),
        C = readInteger("Введите C: "),
        showMathTask(A, B, C, ExpressionResult), nl,

        InputNumber = readInteger("Введите число для сложения: "),
        Bound = readInteger("Введите положительную верхнюю границу случайного числа: "),
        Bound > 0,
        RandomNumber = math::random(Bound),
        Sum = InputNumber + RandomNumber,
        write("Случайное число: ", RandomNumber, "; сумма: ", Sum), nl,
        saveAnsiReport(Text, First, Last, Hash, A, B, C, ExpressionResult,
                       InputNumber, RandomNumber, Sum),
        _ = readLine().

end implement main

goal
    console::runUtf8(main::run).
