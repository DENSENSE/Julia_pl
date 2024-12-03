using HorizonSideRobots

"""
    backside(side)

    Вспомогательная функция для получения противоположного направления.

    Параметры:
    - side: Исходное направление

    Возвращает:
    Противоположное направление (Nord↔Sud, West↔Ost)
"""
function backside(side)
    if side == Nord 
        return Sud
    elseif side == Sud 
        return Nord
    elseif side == West
        return Ost
    else
        return West 
    end
end
 
"""
    can_move!(robot, side)

    Функция для проверки возможности движения и установки маркера.

    Параметры:
    - robot: Экземпляр робота
    - side: Направление движения

    Возвращает:
    true, если движение возможно и нет маркера; иначе false

    Алгоритм:
    1. Если возможно движение:
       - Шаг вперед
       - Проверка на наличие маркера
       - Если маркера нет - возврат true
       - Иначе - шаг назад и возврат false
    2. Если движение невозможно - возврат false

    Особенности:
    - Проверяет наличие маркера после движения
    - Возвращает робота в исходное положение при наличии маркера
"""
function can_move!(robot, side)
    if !isborder(robot, side)
        move!(robot, side)
        if !ismarker(robot) return true
        else
            move!(robot, backside(side))
            return false
        end
    end
    return false
end
 
"""
    go_labirint!(robot, last = 0)

    Функция для обхода лабиринта с установкой маркеров.

    Параметры:
    - robot: Экземпляр робота
    - last: Последнее направление движения (по умолчанию 0)

    Алгоритм:
    1. Если это начальная точка:
       - Установка маркера
    2. Для каждого направления (Nord, Ost, Sud, West):
       - Если направление не противоположно последнему и движение возможно:
         - Установка маркера
         - Рекурсивный вызов для нового направления
         - Возврат в исходное положение

    Особенности:
    - Использует рекурсию для обхода всех возможных путей
    - Устанавливает маркеры на всех посещенных клетках
    - Возвращается в исходную точку после обхода
"""
function go_labirint!(robot, last = 0)
    if last == 0 putmarker!(robot) end
    for i in (Nord, Ost, Sud, West)
        if backside(i) != last && can_move!(robot, i)
            putmarker!(robot)
            go_labirint!(robot, i)
            move!(robot, backside(i))
        end
    end
end
