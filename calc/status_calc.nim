import ../bindings, nimQueryAbrev

proc updateRemainingHp*
proc dealDamage*(dmg: var int)
proc healNonlethal*(heal: int)
proc nonlethal*(dmg: var int)
proc healDamage*(heal: int)
proc updateTotalHp*

proc updateRemainingHp =
  "#hp-remaining".val(cint("tot-hp".propInt - "dmg-taken".propInt))

proc dealDamage(dmg: var int) =
  if "temp-hp".propInt >= dmg:
    "temp-hp".adj(-dmg)
  else:
    dmg -= "temp-hp".propInt
    "temp-hp".set(0)
    "dmg-taken".adj(dmg)
  updateRemainingHp()

proc healDamage(heal: int) =
  "dmg-taken".adj(-heal)
  if "dmg-taken".propInt < 0:
    "dmg-taken".set(0)
  updateRemainingHp()

proc healNonlethal(heal: int) =
  "non-lethal".adj(-heal)
  if "non-lethal".propInt < 0:
    "non-lethal".set(0)

proc nonlethal(dmg: var int) =
    "non-lethal".adj(dmg)

proc updateTotalHp() =
  "tot-hp".set("con-hp".propInt + "base-hp-tot".propInt + "hp-adjust-1".propInt + "hp-adjust-2".propInt + "hp-adjust-3".propInt)
  updateRemainingHp()

