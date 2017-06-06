import ../charData, nimQuery, nimQueryAbrev, tables, strutils, ../bindings

const fields = ["char-name", "portrait", "level", "deity", "homeland", "race", "alignment", "gender", "age", "height", "weight", "hair", "eyes", "xp", "size"]

proc updateDetails(response, status, xhr: cstring)

proc loadDetails*(e: JEvent) =
  "#page-content-wrapper".load(url = "/public/details.html", complete = updateDetails)

proc updateDetails(response, status, xhr: cstring) =
  for field in fields:
    field.bindid
