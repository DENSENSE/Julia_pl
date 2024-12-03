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
    rec1!(robot, side)

    Первая рекурсивная функция в паре взаимно-рекурсивных функций.
    Делает шаг вперед, вызывает rec2! и возвращается назад.

    Параметры:
    - robot: Экземпляр робота
    - side: Направление движения

    Алгоритм:
    1. Если возможно движение:
       - Шаг вперед
       - Вызов rec2!
       - Возврат назад
    2. Иначе - завершение рекурсии
"""
function rec1!(robot, side)
    if !isborder(robot, side)
        move!(robot, side)
        rec2!(robot, side)
        move!(robot, backside(side))
    end
    return
end
 
"""
    rec2!(robot, side)

    Вторая рекурсивная функция в паре взаимно-рекурсивных функций.
    Делает шаг вперед и вызывает rec1!.

    Параметры:
    - robot: Экземпляр робота
    - side: Направление движения

    Алгоритм:
    1. Если возможно движение:
       - Шаг вперед
       - Вызов rec1!
    2. Иначе - завершение рекурсии

    Особенности:
    Функции rec1! и rec2! образуют пару взаимно-рекурсивных функций,
    создающих чередующийся паттерн движения:
    - rec1! делает шаг вперед-назад
    - rec2! только вперед
"""
function rec2!(robot, side)
    if !isborder(robot, side)
        move!(robot, side)
        rec1!(robot, side)
    end
    return
end
