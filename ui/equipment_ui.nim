import nimQuery, nimQueryAbrev

proc updateEquipment(response, status, xhr: cstring)

#const columns = []

proc loadEquipment*(e: JEvent) =
  "#page-content-wrapper".load(url = "/public/equipment.html", complete = updateEquipment)

proc updateEquipment(response, status, xhr: cstring) =
  log "hello"

