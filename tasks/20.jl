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
    along_rec!(robot, side)

    Рекурсивная функция для движения до упора с возвратом и маркировкой конечной точки.

    Параметры:
    - robot: Экземпляр робота
    - side: Направление движения

    Алгоритм:
    1. Если впереди стена:
       - Ставит маркер
    2. Иначе:
       - Делает шаг вперед
       - Рекурсивно вызывает себя
       - Возвращается на шаг назад

    Особенности:
    - Использует рекурсию с возвратом
    - Маркирует только конечную точку пути
    - Возвращается в исходную позицию
"""
function along_rec!(robot, side)
    if isborder(robot, side) putmarker!(robot)
    else
        move!(robot, side)
        along_rec!(robot, side)
        move!(robot, backside(side))
    end
end
