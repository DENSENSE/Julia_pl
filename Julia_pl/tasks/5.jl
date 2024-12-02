using HorizonSideRobots
"""
    task5!(robot)

    Функция для установки маркеров по периметру внешней и внутренней перегородок.

    Параметры:
    - robot: Экземпляр робота

    Алгоритм:
    1. Устанавливает маркеры по периметру внешней рамки
    2. Находит и устанавливает маркеры по периметру внутренней перегородки
    3. Возвращает робота в исходное положение
"""
function task5!(robot)
    # Определяем начальные координаты
    initial_position = determine_position!(robot)

    # Установка маркеров по периметру внешней рамки
    mark_outer_perimeter!(robot)

    # Поиск и установка маркеров по периметру внутренней перегородки
    mark_inner_perimeter!(robot)

    # Возврат в исходное положение
    move_to_position!(robot, initial_position)
end

"""
    determine_position!(robot)

    Определяет текущую позицию робота относительно верхнего левого угла.

    Параметры:
    - robot: Экземпляр робота

    Возвращает:
    Кортеж с координатами текущей позиции
"""
function determine_position!(robot)
    x, y = 0, 0
    while !isborder(robot, West)
        move!(robot, West)
        x += 1
    end
    while !isborder(robot, Nord)
        move!(robot, Nord)
        y += 1
    end
    return (x, y)
end

"""
    mark_outer_perimeter!(robot)

    Устанавливает маркеры по периметру внешней рамки.

    Параметры:
    - robot: Экземпляр робота
"""
function mark_outer_perimeter!(robot)
    for direction in [Nord, Ost, Sud, West]
        while !isborder(robot, direction)
            putmarker!(robot)
            move!(robot, direction)
        end
    end
end

"""
    mark_inner_perimeter!(robot)

    Находит внутреннюю перегородку и устанавливает маркеры по её периметру.

    Параметры:
    - robot: Экземпляр робота
"""
function mark_inner_perimeter!(robot)
    # Перемещение к внутренней перегородке
    while !isborder(robot, Ost) || !isborder(robot, Sud)
        move!(robot, Ost)
        move!(robot, Sud)
    end
    # Установка маркеров по периметру внутренней перегородки
    for direction in [Nord, Ost, Sud, West]
        while !isborder(robot, direction)
            putmarker!(robot)
            move!(robot, direction)
        end
    end
end

"""
    move_to_position!(robot, position)

    Перемещает робота в заданную позицию.

    Параметры:
    - robot: Экземпляр робота
    - position: Целевая позиция (кортеж координат)
"""
function move_to_position!(robot, position)
    current_position = determine_position!(robot)
    x_diff = position[1] - current_position[1]
    y_diff = position[2] - current_position[2]
    if x_diff > 0
        for _ in 1:x_diff
            move!(robot, Ost)
        end
    elseif x_diff < 0
        for _ in 1:-x_diff
            move!(robot, West)
        end
    end
    if y_diff > 0
        for _ in 1:y_diff
            move!(robot, Nord)
        end
    elseif y_diff < 0
        for _ in 1:-y_diff
            move!(robot, Sud)
        end
    end
end