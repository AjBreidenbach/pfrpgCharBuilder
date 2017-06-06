import nimQuery, nimQueryAbrev, tables, strutils, math, ../bindings, ../calc/stats_calc

const scores = ["str-score", "str-adj", "dex-score", "dex-adj", "con-score", "con-adj", "int-score", "int-adj", "wis-score", "wis-adj", "cha-score", "cha-adj"]
const modifiers = ["str-mod", "str-adj-mod", "dex-mod", "dex-adj-mod", "con-mod", "con-adj-mod", "int-mod", "int-adj-mod", "wis-mod", "wis-adj-mod", "cha-mod", "cha-adj-mod"]

proc updateStats(response, status, xhr: cstring)
proc bindscores
proc bindmods
proc calcmods

proc loadStats*(e: JEvent) =
  "#page-content-wrapper".load(url = "/public/stats.html", complete = updateStats)

proc updateStats(response, status, xhr: cstring) =
  bindscores()
  bindmods()
  calcmods()

proc bindscores =
  for score in scores:
    score.bindid
    closureScope:
      let s = score
      ('#' & score).change(
        proc(e: JEvent) =
          updateScore(s.sec(0))
      )

proc bindmods =
  for modifier in modifiers:
    modifier.bindid

proc calcmods =
  for score in ["str", "dex", "con", "int", "wis", "cha"]:
    updateScore(score)
