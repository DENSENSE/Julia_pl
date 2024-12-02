using HorizonSideRobots

"""
    goandmark!(r, Side)

    Вспомогательная функция для движения робота в заданном направлении с установкой маркеров.
    
    Параметры:
    - r: Экземпляр робота
    - Side: Направление движения
    
    Алгоритм:
    Двигается в указанном направлении до упора, ставя маркеры в каждой клетке
"""
function goandmark!(r, Side)
    while !isborder(r, Side)
        putmarker!(r)
        move!(r, Side)
    end
end
 
 
"""
    task2!(r, Side1, Side2, Side3, Side4)

    Функция рисует периметр поля маркерами.

    Параметры:
    - r: Экземпляр робота
    - Side1, Side2, Side3, Side4: Направления (Nord, Ost, Sud, West)

    Алгоритм:
    1. Перемещает робота в верхний правый угол
    2. Отмечает периметр маркерами, двигаясь против часовой стрелки
    3. Возвращается в исходную позицию
"""
function task2!(r, Side1, Side2, Side3, Side4)
	Side1 = Nord
	Side2 = Ost
	Side3 = Sud 
	Side4 = West
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
    goandmark!(r, Side3)
    goandmark!(r, Side4)
    goandmark!(r, Side1)
    goandmark!(r, Side2)
    while a != 0
        move!(r, Side3)
        a -= 1
    end
    while b != 0
        move!(r, Side4)
        b -= 1
    end
end
