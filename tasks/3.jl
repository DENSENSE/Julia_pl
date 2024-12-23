using HorizonSideRobots

"""
    tocorner!(r, Side1, Side2)

    Вспомогательная функция для перемещения робота в угол поля.
    
    Параметры:
    - r: Экземпляр робота
    - Side1, Side2: Направления движения
"""
function tocorner!(r, Side1, Side2)
    while !isborder(r, Side1)
        move!(r, Side1)
    end
    while !isborder(r, Side2)
        move!(r, Side2)
    end
end

"""
    goandmark!(r, Side)

    Вспомогательная функция для движения с установкой маркеров до упора.
    
    Параметры:
    - r: Экземпляр робота
    - Side: Направление движения
"""
function goandmark!(r, Side)
    while !isborder(r, Side)
        putmarker!(r)
        move!(r, Side)
    end
end

"""
    task3!(r)

    Функция заполняет поле маркерами в шахматном порядке.

    Параметры:
    - r: Экземпляр робота

    Алгоритм:
    1. Перемещается в верхний правый угол
    2. Заполняет поле маркерами зигзагообразно:
       - Нечетные столбцы - сверху вниз
       - Четные столбцы - снизу вверх
    3. Возвращается в исходную позицию

    Особенности:
    - Использует счетчик d для определения четности столбца
    - Сохраняет начальную позицию через координаты a и b
"""
function task3!(r)
	Side1 = Nord
	Side2 = Ost
	Side3 = Sud 
	Side4 = West
    d = 1
    a = 0
    b = 0
    while !isborder(r, Side1)
        move!(r, Side1)
        a += 1
    end
    while !isborder(r, Side2)
        move!(r, Side2)
        b += 1
    end
 
    while isborder(r, Side4)==0
        if d % 2 == 1
            goandmark!(r, Side3)
            putmarker!(r)
            move!(r, Side4)
        end
        if d % 2 == 0
            goandmark!(r, Side1)
            putmarker!(r)
            move!(r, Side4)
        end
        d += 1
 
    end
    if !isborder(r, Side3)
        goandmark!(r, Side3)
        putmarker!(r)
    else
        goandmark!(r, Side1)
        putmarker!(r)
    end

    tocorner!(r, Side1, Side2)
 
    while a != 0
        move!(r, Side3)
        a -= 1
    end
    while b != 0
        move!(r, Side4)
        b -= 1
    end
end
