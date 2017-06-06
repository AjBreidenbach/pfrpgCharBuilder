import nimQuery, nimQueryAbrev, strutils, ../charData, ../bindings, ../calc/defenses_calc, ../calc/classes_calc, ../calc/stats_calc

const bonuses = ["armor-bns", "shield-bns", "nat-bns", "defl-bns", "dodge-bns", "misc-bns"]
const saves = ["fort-mag", "fort-misc", "fort-temp", "ref-mag", "ref-misc", "ref-temp", "will-mag", "will-misc", "will-temp"]

proc updateDefenses(response, status, xhr: cstring)
proc getmods
proc bindfields
proc bindbns
proc bindsaves
proc update

proc loadDefenses*(e: JEvent) =
  "#page-content-wrapper".load(url ="/public/defenses.html", complete = updateDefenses)

proc updateDefenses(response, status, xhr: cstring) =
  getmods()
  bindfields()
  bindbns()
  bindsaves()
  update()

proc getmods =
  "fort-mod".set(mdfAdj("con"))
  "ref-mod".set(mdfAdj("dex"))
  "will-mod".set(mdfAdj("wis"))
  bindp("#dex-ac", "ref-mod")

proc bindfields =
  for field in ["ac", "ff", "touch", "fort-tot", "ref-tot", "will-tot", "base-fort-tot", "base-ref-tot", "base-will-tot" ,"fort-mod", "ref-mod", "will-mod"]:
    field.bindid

proc bindbns =
  for bonus in bonuses:
    bonus.bindid
    closureScope:
      let bns = bonus
      bonus.id.change(
        proc(e: JEvent) =
          updateAC(bns)
      )

proc bindsaves =
  for save in saves:
    save.bindid
    closureScope:
      let s = save
      save.id.change(
        proc(e: JEvent) =
          updateSave(s.sec(0))
      )

proc update =
  updateBaseSaves()
  updateSaves()
  updateAC("*")

