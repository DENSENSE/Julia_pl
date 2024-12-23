function Fib1(n::Int)
    n == 1 || n == 2 || return Fib(n - 1) + Fin(n - 2)
    return 1
end