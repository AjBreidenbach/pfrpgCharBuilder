import ../charData, nimQuery, nimQueryAbrev, tables, strutils, dom, ../bindings, ../calc/classes_calc

proc updateClasses(response, status, xhr: cstring)
const fields = ["class-name", "class-levels", "hit-die", "bab", "base-skills", "base-fort", "base-ref", "base-will"]

proc listclasses
proc rmbtn
proc bindall
proc update

proc loadClasses*(e: JEvent) =
  "#page-content-wrapper".load(url ="/public/classes.html", complete = updateClasses)

proc updateClasses(response, status, xhr: cstring) =
  listclasses()
  rmbtn()
  bindall()
  update()

proc listclasses =
  for i in 1.."classCounter".propInt:
    ("#class" & $i).show()
  "#add-class".click(
    proc(e: JEvent) =
      "classCounter".adj(1)
      if "classCounter".propInt > 5:
        "classCounter".set(5)
      ("#class" & "classCounter".prop).show()
  )

proc rmbtn =
  "#remove-class".click(
    proc(e: JEvent) =
      ("#class" & "classCounter".prop).hide()
      "classCounter".adj(-1)
      if "classCounter".propInt < 0:
        "classCounter".set(0)
  )

proc bindall =
  "base-hp-tot".bindid
  for field in fields:
    if field == "class-name": continue
    if field != "hit-die":
      (field & "-tot").bindid
    for i in 1..5:
      setIfNo((field & $i), "")
      (field & $i).bindid
      closureScope:
        let
          f = field
          j = i
        ('#' & f & $j).change(
          proc (e: JEvent) =
            classesCalcTotal(f)
        )

proc update =
  classesCalcTotal("class-levels")

