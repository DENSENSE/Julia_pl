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
    while !isborder(r, Sud) || !isborder(r, West) 
        trymove!(r, Sud)
        trymove!(r, West)
    end
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
    gap_size = 0
    was_wall_before = 0
    while !isborder(r, Ost)
        move!(r, Ost)
        if !isborder(r, Nord) && was_wall_before == 0 && gap_size == 1
            count_of_walls += 1
            gap_size = 0
        end
        
    end

    while !isborder(r, West)
        move!(r, West)
    end

    return count_of_walls
end

r = Robot(animate=true)