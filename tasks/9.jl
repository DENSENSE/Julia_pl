using HorizonSideRobots

"""
    check(robot, x, y)

    Вспомогательная функция для проверки и установки маркера в шахматном порядке.
    
    Параметры:
    - robot: Экземпляр робота
    - x, y: Координаты текущей позиции
    
    Алгоритм:
    Устанавливает маркер, если сумма координат четная
"""
function check(robot, x, y)::nothing
    if ((x + y) % 2 == 0)
        putmarker!(robot)
    end
end
 
"""
    move_two_sides(robot, x, y)

    Вспомогательная функция для возврата робота в исходную позицию.
    
    Параметры:
    - robot: Экземпляр робота
    - x, y: Целевые координаты
"""
function move_two_sides(robot, x, y)::nothing
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
    result(robot)

    Функция заполняет поле маркерами в шахматном порядке, используя систему координат.

    Параметры:
    - robot: Экземпляр робота

    Алгоритм:
    1. Перемещается в верхний левый угол, запоминая координаты
    2. Проходит все поле змейкой:
       - Чередует движение влево и вправо
       - При достижении края спускается на строку вниз
    3. Устанавливает маркеры в клетках с четной суммой координат
    4. Возвращается в исходную позицию

    Особенности:
    - Использует систему координат (x, y) для отслеживания позиции
    - Определяет необходимость установки маркера по четности суммы координат
"""
function result(robot)
    x = 0
    y = 0
    while !isborder(robot, West)
        move!(robot, West)
        x -= 1
    end
    while !isborder(robot, Nord)
        move!(robot, Nord)
        y += 1
    end
 
    check(robot, x, y)
    dir = Ost
    while (!isborder(robot, Ost) || !isborder(robot, Sud))
        while !isborder(robot, dir)
            move!(robot, dir)
            if dir == Ost
                x += 1
            else
                x -= 1
            end
            check(robot, x, y)
        end
        if !isborder(robot, Sud)
            move!(robot, Sud)
            y -= 1
            check(robot, x, y)
        end
        if dir == Ost
            dir = West
        else
            dir = Ost
        end
    end
    move_two_sides(robot, x, y)
end
