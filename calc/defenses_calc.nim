import ../bindings

proc calcAC*
proc calcFF*
proc calcTouch*
proc updateAC*(fromBns: string)
proc updateSave*(savingThrow: string)
proc updateSaves*

proc updateSave(savingThrow: string) =
  var tot = 0
  for save in ["base-" & savingThrow & "-tot", savingThrow & "-mod", savingThrow & "-mag", savingThrow & "-misc", savingThrow & "-temp"]:
    tot += save.propInt
  (savingThrow & "-tot").set(tot)


proc updateSaves =
  updateSave("fort")
  updateSave("ref")
  updateSave("will")

proc updateAC(fromBns: string) =
  calcAC()
  case fromBns:
    of "armor-bns", "shield-bns", "nat-bns": calcFF()
    of "dodge-bns", "dex-mod": calcTouch()
    else:
      calcFF()
      calcTouch()

proc calcAC =
  var tot = 10
  for bns in ["armor-bns", "shield-bns", "nat-bns", "defl-bns", "dodge-bns", "misc-bns", "dex-mod"]:
    tot+= bns.propInt
  "ac".set(tot)

proc calcFF =
  var tot = 10
  for bns in ["armor-bns", "shield-bns", "nat-bns", "misc-bns"]:
    tot+= bns.propInt
  "ff".set(tot)

proc calcTouch =
  var tot = 10
  for bns in ["dodge-bns", "defl-bns", "dex-mod"]:
    tot+= bns.propInt
  "touch".set(tot)
