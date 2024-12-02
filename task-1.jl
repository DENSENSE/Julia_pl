using HorizonSideRobots
r = Robot(animate=true)

function shiza(r)
    for side in (Nord, West, Ost, Sud):
        if !isborder!(side):
            move!(side)
        end
    end
end