using HorizonSideRobots

"""
    find_robot_position(robot)

    Функция для определения текущей позиции робота и установки маркеров на периметре.

    Параметры:
    - robot: Экземпляр робота

    Алгоритм:
    1. Определяет расстояния до границ в каждом направлении
    2. Перемещает робота по периметру, устанавливая маркеры
    3. Возвращает робота в исходную позицию
"""
function find_robot_position(robot)
    distances = calculate_corner_distances(robot)
    east_steps = move_to_border!(robot, Ost)
    south_steps = move_to_border!(robot, Sud)
    west_steps = move_to_border!(robot, West)
    north_steps = move_to_border!(robot, Nord)
    for i in 1:length(distances)
        if ((i+2) % 2) == 0
            move_steps!(robot, Sud, distances[length(distances)-i + 1])
        else
            move_steps!(robot, Ost, distances[length(distances)-i + 1])
        end
    end
    (x1, y1, x2, y2) = (0, 0, 0, 0)
    for i in 1:length(distances)
        if (i+2) % 2 == 0
            x1 += distances[i]
        else
            y1 += distances[i]
        end
    end
    x2 = 11 - x1
    y2 = 10 - y1

    move_steps!(robot, Ost, x1)
    putmarker!(robot)
    move_to_border!(robot, Ost)
    move_steps!(robot, Sud, y1)
    putmarker!(robot)
    move_to_border!(robot, Sud)
    move_steps!(robot, West, x2)
    putmarker!(robot)
    move_to_border!(robot, West)
    move_steps!(robot, Nord, y2)
    putmarker!(robot)
    move_to_border!(robot, Nord)

    for i in 1:length(distances)
        if ((i+2) % 2) == 0
            move_steps!(robot, Sud, distances[length(distances)-i + 1])
        else
            move_steps!(robot, Ost, distances[length(distances)-i + 1])
        end
    end
end

"""
    calculate_corner_distances(robot)

    Функция для вычисления расстояний до границ в направлениях Nord и West.

    Параметры:
    - robot: Экземпляр робота

    Возвращает:
    Массив расстояний до границ
"""
function calculate_corner_distances(robot)
    distances = []
    while !isborder(robot, Nord) || !isborder(robot, West)
        push!(distances, move_to_border!(robot, Nord))
        push!(distances, move_to_border!(robot, West))
    end
    return distances
end

"""
    move_to_border!(robot::Robot, direction::HorizonSide)

    Функция для перемещения робота до границы в указанном направлении.

    Параметры:
    - robot: Экземпляр робота
    - direction: Направление движения

    Возвращает:
    Количество шагов до границы
"""
function move_to_border!(robot::Robot, direction::HorizonSide)
    steps::Int = 0
    while !isborder(robot, direction)
        move!(robot, direction)
        steps += 1
    end
    return steps
end

"""
    move_steps!(robot, direction, num_steps::Integer)

    Функция для перемещения робота на заданное количество шагов в указанном направлении.

    Параметры:
    - robot: Экземпляр робота
    - direction: Направление движения
    - num_steps: Количество шагов
"""
function move_steps!(robot, direction, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot, direction)
    end
end

r = Robot(animate=true)