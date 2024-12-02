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
    do_simmetry!(robot, side, flag = false)

    Рекурсивная функция для создания симметричного движения робота.

    Параметры:
    - robot: Экземпляр робота
    - side: Направление движения
    - flag: Флаг фазы движения (false - прямой ход, true - обратный)

    Алгоритм:
    1. Прямая фаза (flag = false):
       - Движение вперед при возможности
       - Рекурсивный вызов
       - Дополнительный шаг вперед при возврате
    2. Обратная фаза (flag = true):
       - Движение назад при возможности
       - Рекурсивный вызов с сохранением флага

    Особенности:
    - Создает симметричное движение относительно середины пути
    - Использует флаг для определения фазы движения
    - Автоматически определяет точку разворота
"""
function do_simmetry!(robot, side, flag = false)
    if !isborder(robot, side) && !flag
        move!(robot, side)
        do_simmetry!(robot, side)
        move!(robot, side)
    elseif !isborder(robot, backside(side))
        move!(robot, backside(side))
        do_simmetry!(robot, side, true)
    else return end
end
