using HorizonSideRobots
"""
    task11(r)

    Функция для подсчёта всех перегородок на ограниченном поле при условии, что робот находится в произвольной точке этого же поля.
    
    Параметры:

    - r: Экземпляр робота

    Алгоритм:
    Робот двигается в левый нижний угол.
    Робот двигается вправо и проверяет стенки над собой,
    учитывая, была ли стенка до этого сверху.
    Двигается вверх и повторяет.

    Если стенка была и сейчас стенки нет -> +1
    Если стенка была и сейчас есть -> продолжаем двигаться
"""

function task11(r)
    wall_count = 0
    # Сначала влево вниз двигаемся для начальной точки
    (x, y) = cornerway(r, West, Sud)
    # На всякий случай двигаемся влево до упора
    while !isborder(r, West)
        move!(r, West)
    end
    # считаем кол-во стенок на каждой строке, двигаясь вверх
    while !isborder(r, Nord)
        wall_count += moverightandchecktop(r)
        move!(r, Nord)
    end

    # Вывод!
    println("Количество перегородок на ограниченном поле: ", wall_count)

    goback(r, x, y)
end

# вспомогательная функция для попытки движения
function trymove!(r, side)
    if !isborder(r, side)
        move!(r, side)

    end
end

# вспомогательная функция для движения вправо и проверки сверху
function moverightandchecktop(r)
    count_of_walls = 0
        was_wall_before = 0
        counted = 0
        once_wall = 0
    while !isborder(r, Ost)
        move!(r, Ost)
        if isborder(r, Nord)
            once_wall = 1
            was_wall_before = 1
            counted = 0
        elseif !isborder(r, Nord) && isborder(r, Ost) && was_wall_before == 1 && once_wall == 1 || !isborder(r, Nord) && was_wall_before == 0 && counted == 0 && once_wall == 1 
            count_of_walls += 1
            putmarker!(r)
            counted = 1
        elseif !isborder(r, Nord) && was_wall_before == 1
            was_wall_before = 0
        else
            continue
        end
        println(counted)
    end

    while !isborder(r, West)
        once_wall = 0
        move!(r, West)
    end

    return count_of_walls
end
function goback(r, x, y)
    while !isborder(r, Sud)
        move!(r, Sud)
    end

    for _ in 1:y
        move!(r, Nord)
    end
    for _ in 1:x
        move!(r, Ost)
    end
end
function cornerway(r, side1, side2)
    x = 0
    y = 0
    while !isborder(r, side1)
        x += 1
        move!(r, side1)
    end
    while !isborder(r, side2)
        y += 1
        move!(r, side2)
    end
    return (x, y)
end

r = Robot(animate=true)