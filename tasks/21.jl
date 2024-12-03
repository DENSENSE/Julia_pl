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
    along_rec!(robot, side1, side2 = ((side1 == Nord) || (side1 == Sud)) ? West : Nord)

    Рекурсивная функция для обхода препятствий с возвратом.

    Параметры:
    - robot: Экземпляр робота
    - side1: Основное направление движения
    - side2: Направление обхода препятствия (по умолчанию перпендикулярно к side1)

    Алгоритм:
    1. Если впереди препятствие:
       - Шаг в сторону (side2)
       - Рекурсивный вызов для продолжения движения
       - Возврат в исходный ряд
    2. Иначе:
       - Шаг вперед по направлению side1

    Особенности:
    - Автоматически выбирает направление обхода препятствия
    - Использует рекурсию для обхода препятствий любой формы
    - Возвращается в исходный ряд после обхода
"""
function along_rec!(robot, side1, side2 = ((side1 == Nord) || (side1 == Sud)) ? West : Nord)
    if isborder(robot, side1)
        move!(robot, side2)
        along_rec!(robot, side1)
        move!(robot, backside(side2))
    else move!(robot, side1) 
    end
end
