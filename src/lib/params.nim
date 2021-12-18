import ../wrapper/slvs
import types


proc addParam*[N:SomeNumber](sys:var System; val:N; group:IdGroup = 0):IdParam {.discardable.} =
  var g = group
  if g == 0:
    g = sys.groupNewId

  result = sys.paramNewId.IdParam
  sys.params &= Slvs_MakeParam(sys.paramNewId.IdParam, g, val.cdouble)
  sys.paramNewId += 1

