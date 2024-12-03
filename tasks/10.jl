using HorizonSideRobots

"""
    check(robot, x, y, r)

    Вспомогательная функция для создания узора из маркеров с заданным размером клетки.
    
    Параметры:
    - robot: Экземпляр робота
    - x, y: Текущие координаты
    - r: Размер одной клетки узора
    
    Алгоритм:
    Устанавливает маркер, если текущая позиция находится в соответствующей части узора,
    основываясь на периодичности 2r по обеим осям
"""
function check(robot, x, y, r)::nothing
    fl1 = (x % (2 * r) < r)
    fl2 = (abs(y) % (2 * r) < r)
    if fl1 == fl2
        putmarker!(robot)
    end
end
 
"""
    go_back(robot, x, y)

    Вспомогательная функция для возврата робота в исходную позицию.
    
    Параметры:
    - robot: Экземпляр робота
    - x, y: Целевые координаты
"""
function go_back(robot, x, y)::nothing
    while x > 0
        move!(robot, West)
        x -= 1
    end
    while y < 0
        move!(robot, Nord)
        y += 1
    end
end
 
"""
    result(robot, r)

    Функция создает узор из маркеров в виде сетки с заданным размером клетки.

    Параметры:
    - robot: Экземпляр робота
    - r: Размер одной клетки узора

    Алгоритм:
    1. Перемещается в верхний левый угол
    2. Проходит все поле змейкой:
       - Чередует движение влево и вправо
       - При достижении края спускается на строку вниз
    3. Устанавливает маркеры согласно шаблону сетки
    4. Возвращается в исходную позицию

    Особенности:
    - Создает периодический узор с периодом 2r по обеим осям
    - Использует координатную систему для точного позиционирования
"""
function result(robot, r)::nothing
    x = 0
    y = 0
    while !isborder(robot, West)
        move!(robot, West)
    end
    while !isborder(robot, Nord)
        move!(robot, Nord)
    end
 
    check(robot, x, y, r)
    dir = Ost
    while (!isborder(robot, Ost) || !isborder(robot, Sud))
        while !isborder(robot, dir)
            move!(robot, dir)
            if dir == Ost
                x += 1
            else
                x -= 1
            end
            check(robot, x, y, r)
        end
        if !isborder(robot, Sud)
            move!(robot, Sud)
            y -= 1
            check(robot, x, y, r)
        end
        if dir == Ost
            dir = West
        else
            dir = Ost
        end
    end
    go_back(robot, x, y)
end
