import ../bindings

proc updateAttribute*(atr: string) =
  var tot = 0
  for val in ["base", "adjust-1", "adjust-2", "adjust-3", "temp"]:
    tot += (atr & '-' & val).propInt
  (atr & "-tot").set(tot)

proc updateAttributes* =
  updateAttribute("init")
  updateAttribute("cmb")
  updateAttribute("cmd")
