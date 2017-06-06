import ../bindings, math, strutils


proc mdf*(val: int): int =
  int(floor(val / 2 - 5))

proc mdf*(score: string): int =
  (score & "-score").propInt.mdf

proc mdfAdj*(score: string): int =
  mdf((score & "-score").propInt + (score & "-adj").propInt)

proc updateScore*(score: string) =
  (score & "-mod").set($mdf((score & "-score").prop.parseInt))
  (score & "-adj-mod").set($mdf((score & "-score").prop.parseInt + (score & "-adj").prop.parseInt))

