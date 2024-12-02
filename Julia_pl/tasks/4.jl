using HorizonSideRobots

"""
    dmove!(r, side1, side2)

    Вспомогательная функция для движения по диагонали.
    
    Параметры:
    - r: Экземпляр робота
    - side1, side2: Направления для создания диагонального движения
"""
function dmove!(r, side1, side2)
    move!(r, side1)
    move!(r, side2)
end 
"""
    diagonalalongandback!(r, Side1, Side2, Side3, Side4)

    Функция для движения по диагонали с установкой маркеров и возвратом.
    
    Параметры:
    - r: Экземпляр робота
    - Side1, Side2: Направления для движения вперед по диагонали
    - Side3, Side4: Направления для возврата по диагонали

    Алгоритм:
    1. Движется по диагонали, устанавливая маркеры
    2. Возвращается по той же диагонали до начальной точки
"""
function diagonalalongandback!(r, Side1, Side2, Side3, Side4)
    while !isborder(r, Side1) && !isborder(r, Side2)
        dmove!(r, Side1, Side2)
        putmarker!(r)
    end
    while ismarker(r) == 1
        dmove!(r, Side3, Side4)
    end
end
 
"""
    task4!(r)

    Функция рисует крест из маркеров по диагоналям поля.

    Параметры:
    - r: Экземпляр робота

    Алгоритм:
    1. Проходит по каждой из четырех диагоналей от центра:
       - Северо-восток
       - Юго-восток
       - Юго-запад
       - Северо-запад
    2. Ставит маркер в центре
    
    Результат:
    Создает Х-образный узор из маркеров через центр поля
"""
function task4!(r)
	Side1 = Nord
	Side2 = Ost
	Side3 = Sud 
	Side4 = West
    diagonalalongandback!(r, Side1, Side2, Side3, Side4)
    diagonalalongandback!(r, Side2, Side3, Side4, Side1)
    diagonalalongandback!(r, Side3, Side4, Side1, Side2)
    diagonalalongandback!(r, Side4, Side1, Side2, Side3)
    putmarker!(r)   
end
