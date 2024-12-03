using HorizonSideRobots

# isborder = stop_condition()
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
    shuttle!(stop_condition::Function, r, side)

    Функция для поиска прохода методом челнока с возрастающей амплитудой.

    Параметры:
    - stop_condition: Функция-условие остановки
    - r: Экземпляр робота
    - side: Направление поиска прохода

    Алгоритм:
    1. Двигается челноком с увеличивающейся амплитудой:
       - Четные итерации - движение на восток
       - Нечетные итерации - движение на запад
    2. Увеличивает длину перемещения на каждой итерации
    3. Останавливается при выполнении условия stop_condition

    Особенности:
    - Использует функцию высшего порядка для условия остановки
    - Счетчик a определяет направление движения
    - Счетчик b определяет длину перемещения
"""
function shuttle!(stop_condition::Function, r, side)
    side1 = Ost
    side2 = West
    a = 0
    b = 1
    while stop_condition(r, side) == 1 
        if a % 2 == 0
            move_by_steps!(r, side1, b)
        end
        if a % 2 == 1
            move_by_steps!(r, side2, b)
        end
        b += 1
        a += 1
    end
    move!(r, side)
end
