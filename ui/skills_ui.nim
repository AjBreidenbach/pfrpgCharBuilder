import ../charData, nimQuery, nimQueryAbrev, tables, strutils, ../bindings, ../calc/stats_calc, ../calc/skills_calc

proc updateSkills(response, status, xhr: cstring)

proc updateabilitymods
proc bindall
proc setarmorpen

proc loadSkills*(e: JEvent) =
  "#page-content-wrapper".load(url = "/public/skills.html", complete = updateSkills)

proc updateSkills(response, status, xhr: cstring) =
  bindall()
  setarmorpen()
  updateabilitymods()
  calcSkills()
  "is-class-skill-acrobatics".set("TRUE")


proc setarmorpen =
  for skill in skills:
    ("is-armor-pen-" & skill).set("FALSE")
  for skill in ["acrobatics", "climb", "disable-device", "escape-artist", "ride", "sleight-of-hand", "stealth", "swim"]:
    ("is-armor-pen-" & skill).set("TRUE")

proc bindall =
  for skill in skills:
    setIfNo("is-class-skill-" & skill, "FALSE")
    for field in ["specialty", "is-armor-pen"]:
      let el = field & '-' & skill
      setIfNo(el, "")
      el.bindid
    for field in ["ranks", "class-bns", "misc-mod", "ability-mod", "is-class-skill"]:
      closureScope:
        let el = field & '-' & skill
        setIfNo(el, 0)
        el.bindid
        let s = skill
        ('#' & el).change(
          proc (e: JEvent) =
            log "changed"
            calcSkill(s)
        )
    ("tot-" & skill).bindid
    
proc updateabilitymods =
  let 
    str = mdfAdj("str")
    dex = mdfAdj("dex")
    int = mdfAdj("int")
    wis = mdfAdj("wis")
    cha = mdfAdj("cha")
  for skill in ["climb", "swim"]: ("ability-mod-" & skill).set(str)
  for skill in ["acrobatics", "disable-device", "escape-artist", "fly", "ride", "sleight-of-hand", "stealth"]: ("ability-mod-" & skill).set(dex)
  for skill in ["appraise", "craft", "knowledge1", "knowledge2", "knowledge3", "linguistics", "spellcraft"]: ("ability-mod-" & skill).set(int)
  for skill in ["heal", "perception", "profession", "sense-motive", "survival"]: ("ability-mod-" & skill).set(wis)
  for skill in ["bluff", "diplomacy", "disguise", "handle-animal", "intimidate", "perform", "use-magic"]: ("ability-mod-" & skill).set(cha)
