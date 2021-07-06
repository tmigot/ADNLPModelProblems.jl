function ncb20_radnlp(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    n ≥ 31 || error("ncb20 : n ≥ 31")
    function f(x)
        n = length(x)
        h = 1.0 / (n - 1)
        return 2.0 +
               sum(
                   (10.0 / i) * (sum(x[i+j-1] / (1 + x[i+j-1]^2) for j = 1:20))^2 -
                   0.2 * sum(x[i+j-1] for j = 1:20) for i = 1:n-30
               ) +
               sum(x[i]^4 + 2 for i = 1:n-10) +
               1.0e-4 * sum(x[i] * x[i+10] * x[i+n-10] + 2.0 * x[i+n-10]^2 for i = 1:10)
    end

    x0 = ones(T, n)
    x0[1:n-10] .= zero(T)

    return RADNLPModel(f, x0, name = "ncb20_radnlp"; kwargs...)
end

function ncb20_autodiff(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    n ≥ 31 || error("ncb20 : n ≥ 31")
    function f(x)
        n = length(x)
        h = 1.0 / (n - 1)
        return 2.0 +
               sum(
                   (10.0 / i) * (sum(x[i+j-1] / (1 + x[i+j-1]^2) for j = 1:20))^2 -
                   0.2 * sum(x[i+j-1] for j = 1:20) for i = 1:n-30
               ) +
               sum(x[i]^4 + 2 for i = 1:n-10) +
               1.0e-4 * sum(x[i] * x[i+10] * x[i+n-10] + 2.0 * x[i+n-10]^2 for i = 1:10)
    end

    x0 = ones(T, n)
    x0[1:n-10] .= zero(T)

    return ADNLPModel(f, x0, name = "ncb20_autodiff"; kwargs...)
end

ncb20_meta = Dict(
    :nvar => 100,
    :variable_size => false,
    :ncon => 0,
    :variable_con_size => false,
    :nnzo => 100,
    :nnzh => 5050,
    :nnzj => 0,
    :minimize => true,
    :name => "ncb20",
    :optimal_value => NaN,
    :has_multiple_solution => missing,
    :is_infeasible => false,
    :objtype => :other,
    :contype => :unconstrained,
    :origin => :unknown,
    :deriv => typemax(UInt8),
    :not_everywhere_defined => missing,
    :has_cvx_obj => false,
    :has_cvx_con => false,
    :has_equalities_only => false,
    :has_inequalities_only => false,
    :has_bounds => false,
    :has_fixed_variables => false,
    :cqs => 0,
)
