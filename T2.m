% --- Завдання 2: XOR в динаміці ---

% Крок 4: Автоматичне формування правильної послідовності
rng(42); % Фіксуємо випадковість, щоб стовпчики автокореляції не стрибали щоразу
xor_input = [0 1 1 0 0 1 0 1 1 0 1 0 0 1 1 1 0 1]; % Наш випадковий вхідний ряд

xor_target = zeros(1, length(xor_input));
for t = 3:length(xor_input)
    % Результат залежить від двох попередніх кроків: xor_input(t-1) та xor_input(t-2)
    xor_target(t) = xor(xor_input(t-1), xor_input(t-2));
end

% Конвертуємо в cell-формат для рекурентної мережі
p_xor = con2seq(xor_input);
t_xor = con2seq(xor_target);


% Крок 5: Створення мережі Елмана з пам'яттю на 2 кроки назад (1:2)
net_xor = layrecnet(1:2, 10);

% Налаштування параметрів навчання
net_xor.trainParam.epochs = 500;
net_xor.trainParam.goal = 1e-5;

% Запуск навчання
[net_xor, tr_xor] = train(net_xor, p_xor, t_xor);

% --- Перевірка Завдання 2 на нових даних ---
test_xor_input = [1 1 0 1 0 0 1 1 0]; % Новий рядок для перевірки

% Проганяємо через навчену XOR-мережу
p_xor_test = con2seq(test_xor_input);
y_xor_test = net_xor(p_xor_test);
res_xor_output = round(cell2mat(y_xor_test));

disp('--- Результати тестування XOR ---');
disp('Новий вхід для XOR:');
disp(test_xor_input);
disp('Відповідь мережі (XOR від 2 попередніх кроків):');
disp(res_xor_output);