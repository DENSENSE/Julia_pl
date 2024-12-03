using HorizonSideRobots

"""
    move_by_steps(r, Side, Numsteps)

    Вспомогательная функция для перемещения робота на заданное количество шагов.
    
    Параметры:
    - r: Экземпляр робота
    - Side: Направление движения
    - Numsteps: Количество шагов
"""
function move_by_steps(r, Side, Numsteps)
    while Numsteps != 0
        move!(r, Side)
        Numsteps -= 1
    end
end

"""
    task7!(r, Prohod)

    Функция для обхода препятствия и прохода через проход.

    Параметры:
    - r: Экземпляр робота
    - Prohod: Направление, в котором ищется проход

    Алгоритм:
    1. Двигается зигзагообразно с увеличивающейся амплитудой:
       - Нечетные шаги - вправо
       - Четные шаги - влево
    2. При нахождении прохода - проходит через него

    Особенности:
    - Использует переменную i для определения длины и направления шага
    - Увеличивает длину шага на каждой итерации
"""
function task7!(r, Prohod)
    i = 2
    while isborder(r, Prohod)
        if i % 2 == 1
            move_by_steps(r, Ost, i)
            i += 1
        else
            move_by_steps(r, West, i)
            i += 1
        end
    end
    move!(r, Prohod)
end
