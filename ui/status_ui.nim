import ../charData, nimQuery, nimQueryAbrev, tables, strutils, ../bindings, ../calc/classes_calc,  ../calc/status_calc, ../calc/stats_calc

const adjust = ["hp-adjust-1", "hp-adjust-2", "hp-adjust-3"]

proc updateStatus(response, status, xhr: cstring)

proc healbtn
proc dmgbtn
proc restbtn
proc nonletbtn  
proc recbtn 
proc clearbtn 
proc bindall
proc defaults
proc update

proc loadStatus*(e: JEvent) =
  "#page-content-wrapper".load(url = "/public/status.html", complete = updateStatus)

proc updateStatus(response, status, xhr: cstring) =
  defaults()
  bindall()
  dmgbtn()
  healbtn()
  nonletbtn()
  recbtn()
  clearbtn()
  restbtn()
  update()

proc healbtn =
  "#heal-btn".click(
    proc(e: JEvent) =
      healDamage("#hp-buffer".valInt)
      healNonlethal("#hp-buffer".valInt)
      "#hp-buffer".val(0)
  )

proc dmgbtn =
  "#dmg-btn".click(
    proc(e: JEvent) =
      var dmg = int("#hp-buffer".valInt)
      dealDamage(dmg)
      "#hp-buffer".val(0)
  )

proc restbtn =
  "#daily-rest-btn".click(
    proc(e: JEvent) =
      let lv = "level".propInt
      healDamage(lv)
      healNonlethal(lv * 8)
      "#hp-buffer".val(0)
  )

proc recbtn =
  "#recover-btn".click(
    proc(e: JEvent) =
      healNonlethal("level".propInt)
  )

proc nonletbtn =
  "#non-lethal-btn".click(
    proc(e: JEvent) =
      var dmg = int("#hp-buffer".valInt)
      nonlethal(dmg)
      "#hp-buffer".val(0)
  )

proc clearbtn =
  "#hp-clear-btn".click(
    proc(e: JEvent) =
      "dmg-taken".set(0)
      "non-lethal".set(0)
      updateRemainingHp()
      "#hp-buffer".val(0)
  )

proc defaults =
  setIfNo("dmg-taken", 0)
  setIfNo("base-hp", 0)


proc bindall =
  "con-hp".set(mdfAdj("con") * "class-levels-tot".propInt)
  for prop in ["con-hp", "tot-hp", "temp-hp", "non-lethal"]:
    prop.bindid
  bindp("#base-hp", "base-hp-tot")
  for a in adjust:
    bindp('#' & a, a)
    ('#' & a).change(
      proc(e: JEvent) =
        updateTotalHp()
    )
proc update =
  updateBaseHp()
  updateTotalHp()

