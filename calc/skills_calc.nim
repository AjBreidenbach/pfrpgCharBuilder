import ../bindings

const skills* = ["acrobatics", "appraise", "bluff", "climb", "craft", "diplomacy", "disable-device", "disguise", "escape-artist", "fly", "handle-animal", "heal", "intimidate", "knowledge1", "knowledge2", "knowledge3", "linguistics", "perception", "perform", "profession", "ride", "sense-motive", "sleight-of-hand", "spellcraft", "stealth", "survival", "swim", "use-magic"]


proc calcSkill*(skill: string) =
  var tot = 0
  for field in ["class-bns", "misc-mod", "ability-mod"]:
    tot += (field & '-' & skill).propInt
  let ranks = ("ranks-" & skill).propInt
  tot += ranks
  #[if ("is-class-skill-" & skill).prop == "TRUE" and ranks > 0:
    tot += 3
    ]#

  ("tot-" & skill).set(tot)

proc calcSkills* =
  for skill in skills:
    calcSkill(skill)
