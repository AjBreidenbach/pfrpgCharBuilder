import nimQuery, nimQueryAbrev, dom, charData, ui/details_ui, ui/stats_ui, ui/status_ui ,ui/defenses_ui, ui/classes_ui, ui/combat_ui, ui/skills_ui, ui/equipment_ui

q(document).ready(
  proc (e: JEvent) =
    "#details".click(loadDetails)
    "#stats".click(loadStats)
    "#status".click(loadStatus)
    "#classes".click(loadClasses)
    "#defenses".click(loadDefenses)
    "#combat".click(loadCombat)
    "#skills".click(loadSkills)
    "#equipment".click(loadEquipment)
)
