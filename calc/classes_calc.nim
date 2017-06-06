import ../bindings

proc classesCalcTotal*(frm: string)
proc updateBaseHp*
proc updateBaseSkills*
proc updateBAB*
proc updateBaseSave*(p: string)
proc updateBaseSaves*

proc classesCalcTotal(frm: string) =
  case frm:
    of "class-levels":
      var tot = 0
      for i in 1..5:
        if ("class-levels" & $i).prop != "" :
          tot += ("class-levels" & $i).propInt
      ("class-levels-tot").set(tot)
      updateBaseHp()
      updateBaseSkills()
      updateBAB()
      updateBaseSaves()
    of "hit-die":
      updateBaseHp()
    of "base-skills":
      updateBaseSkills()
    of "bab":
      updateBAB()
    of "base-fort", "base-ref", "base-will":
      updateBaseSave(frm)

proc updateBaseHp =
  var tot = 0
  case ("hit-die1").prop:
    of "d6":
      tot += int(3.5 * float(("class-levels1").propInt)) + 3
    of "d8":
      tot += int(4.5 * float(("class-levels1").propInt)) + 4
    of "d10":
      tot += int(5.5 * float(("class-levels1").propInt)) + 5
    of "d12":
      tot += int(6.5 * float(("class-levels1").propInt)) + 6
  for i in 2..5:
    case ("hit-die" & $i).prop:
      of "d6":
        tot += int(3.5 * float(("class-levels" & $i).propInt))
      of "d8":
        tot += int(4.5 * float(("class-levels" & $i).propInt))
      of "d10":
        tot += int(5.5 * float(("class-levels" & $i).propInt))
      of "d12":
        tot += int(6.5 * float(("class-levels" & $i).propInt))
  "base-hp-tot".set(tot)

proc updateBaseSkills =
  var tot = 0
  for i in 1..5:
    if ("base-skills" & $i).prop != "":
      tot += ("base-skills" & $i).propInt * ("class-levels"& $i).propInt
  "base-skills-tot".set(tot)

proc updateBAB =
  var tot = 0
  for i in 1..5:
    case ("bab" & $i).prop:
      of "1/2":
        tot += int(("class-levels" & $i).propInt/2)
      of "3/4":
        tot += int(("class-levels" & $i).propInt * 3 / 4)
      of "full":
        tot += ("class-levels" & $i).propInt
  "bab-tot".set(tot)

proc updateBaseSave(p: string) =
  var tot = 0
  case (p & '1').prop:
    of "good":
      tot += int(("class-levels1").propInt/2) + 2
    of "poor":
      tot += int(("class-levels1").propInt/3)
  for i in 2..5:
    case (p & $i).prop:
      of "good":
        tot += int(("class-levels" & $i).propInt/2)
      of "poor":
        tot += int(("class-levels" & $i).propInt/3)
  (p & "-tot").set(tot)


proc updateBaseSaves =
  updateBaseSave("base-fort")
  updateBaseSave("base-ref")
  updateBaseSave("base-will")


