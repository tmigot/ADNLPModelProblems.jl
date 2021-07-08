function dqrtic_radnlp(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    function f(x)
        n = length(x)
        return sum((x[i] - i)^4 for i = 1:n)
    end
    x0 = 2 * ones(T, n)
    return RADNLPModel(f, x0, name = "dqrtic_radnlp"; kwargs...)
end

function dqrtic_autodiff(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    function f(x)
        n = length(x)
        return sum((x[i] - i)^4 for i = 1:n)
    end
    x0 = 2 * ones(T, n)
    return ADNLPModel(f, x0, name = "dqrtic_autodiff"; kwargs...)
end

dqrtic_meta = Dict(
    :nvar => 100,
    :variable_size => false,
    :ncon => 0,
    :variable_con_size => false,
    :nnzo => 100,
    :nnzh => 5050,
    :nnzj => 0,
    :minimize => true,
    :name => "dqrtic",
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

get_dqrtic_meta(; n::Int=default_nvar) = (dqrtic_meta[:nvar], dqrtic_meta[:ncon])
