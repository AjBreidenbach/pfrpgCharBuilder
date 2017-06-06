import nimQuery, nimQueryAbrev, ../bindings, dom, ../calc/combat_calc, ../calc/stats_calc

proc updateCombat(response, status, xhr: cstring)
proc setupdate(atr, val: string)
proc addrowbtn
proc rmrowbtn
proc removeRow
proc bindattributes
proc setbase 
proc bindRow(row: int)
proc newCell(i: int): Element
proc addRow
proc updaterows

const columns = ["""<input type="text" class="form-control width-150">""",
"""<input type="number" class="form-control width-60" value = "0">""",
"""<input type="text" class="form-control width-75">""",
"""<input type="text" class="form-control width-50">""",
"""<input type="number" class="form-control width-60" value = "0" min="0">""",
"""<input type="number" class="form-control width-60" value = "0" min="0">""",
"""<input type="text" class="form-control width-75">""",
"""<input type="text" class="form-control width-150">"""]

const colIds = ["attack-name", "attack-bns", "crit-rng", "attack-type", "attack-range", "ammo", "attack-damage", "attack-notes"]

proc loadCombat*(e :JEvent) =
  "#page-content-wrapper".load(url ="/public/combat.html", complete=updateCombat)

proc updateCombat(response, status, xhr: cstring) =
  updaterows()
  addrowbtn()
  rmrowbtn()
  bindattributes()
  setbase()
  updateAttributes()
  if "attack-counter".propInt == 0:
    addRow()

proc setbase =
  let
    bab = "bab-tot".propInt
    dex = mdfAdj("dex")
    str = mdfAdj("str")
  "cmb-base".set(str + bab)
  "cmd-base".set(str + dex + bab + 10)
  "init-base".set(dex)
  

proc bindattributes =
  for atr in ["cmb", "cmd", "init"]:
    for val in ["tot", "base", "adjust-1", "adjust-2", "adjust-3", "temp"]:
      (atr & '-' & val).bindid
    for val in ["adjust-1", "adjust-2", "adjust-3", "temp"]:
      setupdate(atr, val)
  
proc setupdate(atr, val: string) =
  closureScope:
    let a = atr
    ('#' & atr & '-' & val).change(
      proc (e: JEvent) =
        updateAttribute(a)
    )

proc updaterows =
  let c = "attack-counter".propInt
  "attack-counter".set(0)
  while "attack-counter".propInt < c:
    addRow()

proc addrowbtn =
  "#add-attack".click(
    proc(e: JEvent) =
      addRow()
  )

proc rmrowbtn =
  "#remove-attack".click(
    proc(e: JEvent) =
      removeRow()
  )

proc removeRow =
  ("#attack-row" & "attack-counter".prop).remove
  "attack-counter".adj(-1)
  if "attack-counter".propInt < 1:
    "attack-counter".set(1)

proc addRow =
  "attack-counter".adj(1)
  let row = jQuery("<tr></tr>")
  row.attr("id", "attack-row" & "attack-counter".prop)
  for i in 0..<columns.len:
    row.append(newCell(i))
  "#attacks".append(row)
  bindRow("attack-counter".propInt)

proc newCell(i: int): Element =
  let cell = jQuery("<td></td>")
  let el = jQuery(columns[i])
  el.attr("id", colIds[i] & "attack-counter".prop)
  cell.append(el)
  cell

proc bindRow(row: int) =
  for id in colIds:
    (id & $row).bindid
