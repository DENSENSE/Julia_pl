using HorizonSideRobots

"""
    task8!(r, Side1, Side2, Side3, Side4)

    Функция для поиска маркера на поле по спирали.

    Параметры:
    - r: Экземпляр робота
    - Side1, Side2, Side3, Side4: Направления движения по спирали

    Алгоритм:
    1. Движется по спирали, увеличивая длину пути на каждом витке:
       - Нечетные витки: движение вправо и вверх
       - Четные витки: движение влево и вниз
    2. Останавливается при нахождении маркера

    Особенности:
    - Использует счетчик i для определения длины пути
    - Проверяет наличие маркера после каждого шага
    - Спиральное движение расширяется наружу от начальной точки
"""
function task8!(r, Side1, Side2, Side3, Side4)
    i = 1
    while !ismarker(r) == 1
        a = i
        if i % 2 == 1
            while a != 0
                move!(r, Side2)
                if ismarker(r)
                    break
                end
                a -= 1
            end
            a = i
            while a != 0
                move!(r, Side1)
                if ismarker(r)
                    break
                end
                a -= 1
            end
        else
 
            while a != 0
                move!(r, Side4)
                if ismarker(r)
                    break
                end
                a -= 1
            end
            a = i
            while a != 0
                move!(r, Side3)
                if ismarker(r)
                    break
                end
                a -= 1
            end
        end
        i += 1
    end
end
