using HorizonSideRobots

"""
    along!(stop_condition::Function, robot, side, k)

    Вспомогательная функция для движения на заданное количество шагов с проверкой условия.
    
    Параметры:
    - stop_condition: Функция-условие остановки
    - robot: Экземпляр робота
    - side: Направление движения
    - k: Количество шагов

    Алгоритм:
    Делает k шагов в указанном направлении, проверяя условие остановки на каждом шаге
"""
function along!(stop_condition::Function, robot, side, k)
    for i in 1:k
        if stop_condition(robot) return end
        move!(robot, side)
    end
end
 
"""
    spiral!(stop_condition::Function, robot)

    Функция для движения по спирали с проверкой условия остановки.

    Параметры:
    - stop_condition: Функция-условие остановки
    - robot: Экземпляр робота

    Алгоритм:
    1. Движется по спирали с увеличивающейся стороной:
       - Вверх на k шагов
       - Вправо на k шагов
       - Вниз на k+1 шагов
       - Влево на k+1 шагов
    2. Увеличивает сторону спирали на 2 после каждого цикла
    3. Останавливается при выполнении условия stop_condition

    Особенности:
    - Использует функцию высшего порядка для условия остановки
    - Спираль расширяется наружу с шагом 2
"""
function spiral!(stop_condition::Function, robot)
    k = 1
    while !stop_condition(robot)
        along!(stop_condition, robot, Nord, k)
        along!(stop_condition, robot, Ost, k)
        along!(stop_condition, robot, Sud, k + 1)
        along!(stop_condition, robot, West, k + 1)
        k += 2
    end
end
