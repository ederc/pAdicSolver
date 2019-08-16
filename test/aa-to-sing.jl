using Hecke
import Nemo
import Singular

# For now, simple conversion function.

# import Singular.CoefficientRing
# function Singular.CoefficientRing(::Hecke.FlintZZ)
#     return Singular.ZZ
# end

# function Singular.CoefficientRing(::Hecke.FlintQQ)
#     return Singular.QQ
# end

## Make Polynomial ring input less annoying...


function AAtoSingular(R::Hecke.Generic.MPolyRing{T} where T)
    br = R.base_ring
    @assert br == FlintQQ
    return Singular.PolynomialRing(Singular.QQ, ["s$x" for x in R.S])
end

function AAtoSingular(R::Hecke.Generic.MPolyRing{T} where
                      T<:Union{Singular.Ring, Nemo.gfp_elem, Singular.n_Zp})
    br = R.base_ring
    c = Int(characteristic(br))
    return Singular.PolynomialRing(Singular.N_ZpField(c), ["s$x" for x in R.S])
end


function (R::Singular.PolyRing)(p::MPolyElem{T} where T)
    return singR(eval(Meta.parse("$p")))
end


function random_linear_equations(R::MPolyRing{T} where T)
    var_vec   = Vector(gens(R))
    rand_vec  = Vector([rand(-1000:1000) for i in 1:length(gens(R))])

    return (transpose(var_vec)*rand_vec)
end


## There is a bug where the typeof R is PolyRing{Singular elemtype}

R, (x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17, x18, x19, x20, x21, x22, x23, x24, x25, x26, x27, x28, x29, x30, x31, x32, x33, x34, x35, x36, x37, x38, x39, x40) =
    #PolynomialRing(Singular.QQ,
    PolynomialRing(FiniteField(32003),
    #PolynomialRing(Singular.N_ZpField(32003),
                   ["x1", "x2", "x3", "x4", "x5", "x6", "x7", "x8", "x9", "x10", "x11", "x12",
                    "x13", "x14", "x15", "x16", "x17", "x18", "x19", "x20", "x21", "x22", "x23",
                    "x24", "x25", "x26", "x27", "x28", "x29", "x30", "x31", "x32", "x33", "x34",
                    "x35", "x36", "x37", "x38", "x39", "x40"], ordering=:degrevlex)



ps = [
x7*x23-x10*x29+x11*x30,
  x11*x23+x7*x28-x6*x29,
  -x3*x19+x12*x29-x11*x32,
  -x3*x15+x8*x29-x7*x32,
  -x7*x15+x4*x29-x3*x30,
  -x3*x18-x7*x22+x9*x29-x11*x33,
  x11*x19+x3*x28-x2*x29,
  -x3*x14-x11*x22+x5*x29-x7*x31,
  -x7*x14-x11*x18-x3*x27+x1*x29,
  x3*x11-x20*x29+x19*x36,
  x3*x7-x16*x29+x15*x36,
  x3^2-x32*x36+x29*x39,
  -x3*x20+x12*x36-x11*x39,
  -x3*x16+x8*x36-x7*x39,
  -x7*x11+x24*x29-x23*x36,
  -x7^2+x30*x36-x29*x37,
  x7*x24-x10*x36+x11*x37,
  -x7*x16+x4*x36-x3*x37,
  -x3*x4-x7*x8+x33*x36-x29*x40,
  x3*x17+x7*x21-x9*x36+x11*x40,
  x11^2+x29*x35-x28*x36,
  x11*x24+x7*x35-x6*x36,
  x11*x20+x3*x35-x2*x36,
  x2*x3+x11*x12-x31*x36+x29*x38,
  x3*x13+x11*x21-x5*x36+x7*x38,
  -x6*x7-x10*x11-x29*x34+x27*x36,
  x7*x13+x11*x17+x3*x34-x1*x36,
  x1*x3+x5*x7+x9*x11+x25*x29-x26*x36,
  x8*x11-x7*x12+x16*x19-x15*x20,
  -x15*x23+x18*x29-x19*x30,
  x3*x10+x15*x24-x17*x29+x19*x37,
  -x19*x23-x15*x28+x14*x29,
  x7*x14-x6*x15+x11*x18-x10*x19,
  x3*x6+x19*x24-x13*x29+x15*x35,
  -x3*x12+x20*x32-x19*x39,
  -x3*x8+x16*x32-x15*x39,
  x15*x19-x22*x29+x23*x32,
  x15^2-x30*x32+x29*x33,
  x7*x12-x16*x19-x24*x32+x22*x36,
  x8*x15-x4*x32+x3*x33,
  -x3*x4-x15*x16+x32*x37-x29*x40,
  x15*x22-x18*x32+x19*x33,
  x3*x9+x15*x21-x17*x32+x19*x40,
  -x19^2-x29*x31+x28*x32,
  -x12*x19-x3*x31+x2*x32,
  x2*x3+x19*x20-x32*x35+x29*x38,
  x19*x22+x15*x31-x14*x32,
  x3*x5+x19*x21-x13*x32+x15*x38,
  x14*x15+x18*x19+x26*x29-x27*x32,
  -x5*x15-x9*x19-x3*x26+x1*x32,
  x1*x3+x13*x15+x17*x19+x25*x29-x32*x34,
  -x2*x15-x12*x23+x5*x29-x7*x31,
  -x4*x19+x7*x22+x12*x30-x10*x32,
  x2*x19-x12*x28+x11*x31,
  -x3*x6+x2*x7+x20*x23-x19*x24,
  x3*x10+x4*x11-x17*x29-x20*x30+x18*x36+x19*x37,
  -x2*x11+x20*x28-x19*x35,
  x2*x20-x12*x35+x11*x38,
  x5*x11-x6*x12+x13*x19-x14*x20,
  -x2*x12+x20*x31-x19*x38,
  -x4*x19-x8*x23+x9*x29-x11*x33,
  -x4*x15+x8*x30-x7*x33,
  -x3*x17+x4*x20-x7*x21+x8*x24,
  -x8*x22+x9*x32-x12*x33,
  x2*x15-x11*x22-x8*x28+x6*x32,
  x5*x7-x6*x8-x17*x19+x18*x20,
  x3*x5-x2*x8+x19*x21-x20*x22,
  x8*x14-x5*x15+x12*x18-x9*x19,
  -x12*x22-x8*x31+x5*x32,
  x4*x11+x16*x23-x17*x29+x19*x37,
  x4*x7-x16*x30+x15*x37,
  -x16*x24+x17*x36-x20*x37,
  -x4*x16+x8*x37-x7*x40,
  x7*x9-x8*x10+x15*x17-x16*x18,
  -x3*x9+x4*x12-x15*x21+x16*x22,
  x4*x8-x16*x33+x15*x40,
  -x2*x7+x19*x24+x16*x28-x14*x36,
  -x7*x13+x6*x16-x11*x17+x10*x20,
  -x3*x13+x2*x16-x11*x21+x12*x24,
  -x20*x24-x16*x35+x13*x36,
  -x9*x11+x10*x12+x13*x15-x14*x16,
  -x8*x13+x5*x16-x12*x17+x9*x20,
  -x8*x11-x16*x19+x21*x29-x23*x39,
  -x7*x8-x15*x16+x30*x39-x29*x40,
  -x4*x20+x7*x21+x12*x37-x10*x39,
  x16*x20-x21*x36+x24*x39,
  -x8*x16+x4*x39-x3*x40,
  x16^2-x37*x39+x36*x40,
  x4*x12-x15*x21-x20*x33+x18*x39,
  -x8*x12+x21*x32-x22*x39,
  -x8^2+x33*x39-x32*x40,
  x8*x21-x9*x39+x12*x40,
  -x16*x21+x17*x39-x20*x40,
  x11*x12+x19*x20+x29*x38-x28*x39,
  -x3*x13+x12*x24+x8*x35-x6*x39,
  x12*x20+x3*x38-x2*x39,
  -x20^2-x36*x38+x35*x39,
  x3*x5-x20*x22-x16*x31+x14*x39,
  x12^2+x32*x38-x31*x39,
  x12*x21+x8*x38-x5*x39,
  -x20*x21-x16*x38+x13*x39,
  -x5*x7-x10*x12-x13*x15-x18*x20-x25*x29+x27*x39,
  x8*x13+x12*x17+x3*x25-x1*x39,
  -x13*x16-x17*x20-x25*x36+x34*x39,
  x5*x8+x9*x12+x25*x32-x26*x39,
  -x7*x10+x24*x30-x23*x37,
  x15*x18-x22*x30+x23*x33,
  x7*x9+x15*x17-x21*x30+x23*x40,
  x23^2+x27*x29-x28*x30,
  x10*x23+x7*x27-x6*x30,
  -x6*x7-x23*x24-x29*x34+x30*x35,
  -x18*x23-x15*x27+x14*x30,
  x14*x15+x22*x23+x26*x29-x30*x31,
  x1*x15+x9*x23+x7*x26-x5*x30,
  -x1*x7-x17*x23+x13*x30-x15*x34,
  x5*x7+x13*x15+x21*x23+x25*x29-x30*x38,
  -x6*x23-x11*x27+x10*x28,
  x6*x11-x24*x28+x23*x35,
  -x6*x24-x11*x34+x10*x35,
  x2*x10-x1*x11-x13*x23+x14*x24,
  -x6*x10+x24*x27-x23*x34,
  x4*x18-x9*x30+x10*x33,
  x7*x14-x10*x19-x4*x28+x2*x30,
  -x4*x6+x1*x7+x17*x23-x18*x24,
  x1*x3-x2*x4-x21*x23+x22*x24,
  x4*x14-x1*x15+x10*x22-x9*x23,
  x4*x13-x1*x16+x10*x21-x9*x24,
  x10*x18+x4*x27-x1*x30,
  -x4*x10+x17*x30-x18*x37,
  x8*x10-x15*x17-x24*x33+x22*x37,
  x4^2-x33*x37+x30*x40,
  -x4*x17+x9*x37-x10*x40,
  -x16*x17+x21*x37-x24*x40,
  -x10*x11-x23*x24-x29*x34+x28*x37,
  -x10*x24-x7*x34+x6*x37,
  x7*x13-x10*x20-x4*x35+x2*x37,
  x24^2+x34*x36-x35*x37,
  -x1*x7+x18*x24+x16*x27-x14*x37,
  -x1*x3-x10*x12-x13*x15-x22*x24-x25*x29+x31*x37,
  -x1*x16-x9*x24-x7*x25+x5*x37,
  x17*x24+x16*x34-x13*x37,
  -x13*x16-x21*x24-x25*x36+x37*x38,
  x10^2+x30*x34-x27*x37,
  -x10*x17-x4*x34+x1*x37,
  -x1*x4-x9*x10-x25*x30+x26*x37,
  x14*x23+x19*x27-x18*x28,
  -x2*x18+x5*x23+x12*x27-x10*x31,
  x2*x10-x13*x23-x20*x27+x18*x35,
  x4*x5-x1*x8+x18*x21-x17*x22,
  -x14*x19+x22*x28-x23*x31,
  -x1*x19+x6*x22+x12*x27-x10*x31,
  -x6*x12+x13*x19+x24*x31-x22*x35,
  -x14*x22-x19*x26+x18*x31,
  x14*x18+x23*x26-x22*x27,
  -x4*x9+x17*x33-x18*x40,
  x8*x9-x21*x33+x22*x40,
  x18*x19+x22*x23+x26*x29-x28*x33,
  -x1*x15+x10*x22+x8*x27-x6*x33,
  -x5*x15+x12*x18+x4*x31-x2*x33,
  -x1*x3-x5*x7-x18*x20-x22*x24-x25*x29+x33*x35,
  -x18*x22-x15*x26+x14*x33,
  x22^2+x26*x32-x31*x33,
  x9*x22+x8*x26-x5*x33,
  -x4*x5-x18*x21-x15*x25+x13*x33,
  x5*x8+x21*x22+x25*x32-x33*x38,
  -x18^2-x26*x30+x27*x33,
  x9*x18+x4*x26-x1*x33,
  -x1*x4-x17*x18-x25*x30+x33*x34,
  -x1*x19-x5*x23-x11*x26+x9*x28,
  x6*x9-x13*x18-x24*x26+x22*x34,
  x2*x9-x13*x22-x20*x26+x18*x38,
  x1*x20+x5*x24+x11*x25-x9*x35,
  -x5*x22-x12*x26+x9*x31,
  x1*x18+x10*x26-x9*x27,
  x1*x11+x13*x23-x17*x28+x19*x34,
  -x2*x17+x5*x24+x12*x34-x10*x38,
  -x13*x24-x20*x34+x17*x35,
  -x5*x10+x14*x17+x24*x26-x22*x34,
  x1*x12+x13*x22+x19*x25-x17*x31,
  -x1*x10+x17*x27-x18*x34,
  -x1*x17-x10*x25+x9*x34,
  x1*x9+x18*x25-x17*x26,
  -x5*x11-x13*x19+x21*x28-x23*x38,
  -x1*x20+x6*x21+x12*x34-x10*x38,
  x13*x20-x21*x35+x24*x38,
  x1*x12-x14*x21-x20*x26+x18*x38,
  -x5*x12+x21*x31-x22*x38,
  x5*x21+x12*x25-x9*x38,
  -x13*x21-x20*x25+x17*x38,
  x5*x10+x13*x18+x23*x25-x21*x27,
  x13*x17+x24*x25-x21*x34,
  -x5*x9-x22*x25+x21*x26,
  x9*x11+x17*x19+x21*x23+x25*x29-x28*x40,
  -x1*x16+x10*x21+x8*x34-x6*x40,
  -x8*x13+x9*x20+x4*x38-x2*x40,
  -x17*x20-x21*x24-x25*x36+x35*x40,
  x1*x8-x18*x21-x16*x26+x14*x40,
  x9*x12+x21*x22+x25*x32-x31*x40,
  x9*x21+x8*x25-x5*x40,
  -x17*x21-x16*x25+x13*x40,
  x21^2+x25*x39-x38*x40,
  -x9*x10-x17*x18-x25*x30+x27*x40,
  x9*x17+x4*x25-x1*x40,
  -x17^2-x25*x37+x34*x40,
  x9^2+x25*x33-x26*x40,
  -x2*x14+x5*x28-x6*x31,
  -x6*x14-x2*x27+x1*x28,
  x2*x6-x13*x28+x14*x35,
  x2^2-x31*x35+x28*x38,
  x2*x13-x5*x35+x6*x38,
  -x6^2-x28*x34+x27*x35,
  x6*x13+x2*x34-x1*x35,
  x1*x2+x5*x6+x25*x28-x26*x35,
  x2*x5-x13*x31+x14*x38,
  x14^2+x26*x28-x27*x31,
  -x5*x14-x2*x26+x1*x31,
  x1*x2+x13*x14+x25*x28-x31*x34,
  x1*x14+x6*x26-x5*x27,
  -x1*x6+x13*x27-x14*x34,
  -x1*x13-x6*x25+x5*x34,
  x1*x5+x14*x25-x13*x26,
  x5*x6+x13*x14+x25*x28-x27*x38,
  -x5*x13-x2*x25+x1*x38,
  x13^2+x25*x35-x34*x38,
  -x5^2-x25*x31+x26*x38,
x1^2+x25*x27-x26*x34
]

singR, (x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17, x18, x19, x20, x21, x22, x23, x24, x25, x26, x27, x28, x29, x30, x31, x32, x33, x34, x35, x36, x37, x38, x39, x40) = AAtoSingular(R)

id = Singular.Ideal(singR, [singR(eval(Meta.parse("$p"))) for p in ps])
idl = Singular.Ideal(singR, [random_linear_equations(singR) for i = 1:11])
id = id + idl

@time G = Singular.slimgb(id);
# basis of quotient R/id
B = Singular.kbase(G)
