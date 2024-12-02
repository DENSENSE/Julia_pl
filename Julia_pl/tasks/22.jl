using HorizonSideRobots
r = Robot(animate = true)
 
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
    task22!(r, side)

    Рекурсивная функция для движения вперед и двойного шага назад.

    Параметры:
    - r: Экземпляр робота
    - side: Направление движения

    Алгоритм:
    1. Если нет препятствия впереди:
       - Шаг вперед
       - Рекурсивный вызов
       - Возврат на два шага назад
    2. Иначе (базовый случай):
       - Завершение рекурсии

    Особенности:
    - При возврате делает два шага назад вместо одного
    - Использует рекурсию для подсчета глубины
    - Оставляет робота на расстоянии n шагов от начальной позиции,
      где n - количество сделанных шагов вперед
"""
function task22!(r, side)
    if isborder(r, side) == 0
        move!(r, side)
        task22!(r, side)
        move!(r, backside(side))
        move!(r, backside(side))
    end
end
