import tables, nimQuery, nimQueryAbrev, dom, strutils
const initialCapacity = 8

var
  data = initTable[string, string] (initialCapacity)
  intData = initTable[string, int] (initialCapacity)
  bindings* =  initTable[string, Element](initialCapacity * 2)

proc propExists*(propName: string):bool =
  data.contains(propName)
  
proc bindp*(el: Element, prop: string) =
  if data.contains(prop):
    el.val(data[prop])
  elif intData.contains(prop):
    el.val(cint(intData[prop]))
  else:
    data[prop] = $el.val
  el.change(
    proc(e: JEvent) =
      if data.contains(prop):
        data[prop] = $el.val
      elif intData.contains(prop):
        intData[prop] = el.valInt
      else:
        log "element " & $el.attr("id") & " is unbound"
  )
  bindings[prop] = el

proc bindp*(sel, prop: string) =
  bindp(jQuery(sel), prop)

proc bindid*(prop: string) =
  bindp(jQuery('#' & prop), prop)

proc id* (prop: string): Element =
  jQuery('#' & prop)
  

proc set*(propName, value: string) =
  data[propName] = value
  if bindings.contains(propName):
    bindings[propName].val(value)

proc set*(propName: string, value: int) =
  intData[propName] = value
  if bindings.contains(propName):
    bindings[propName].val(cint(value))

proc setIfNo*(propName, value: string) =
  if not propExists(propName):
    propName.set(value)

proc setIfNo*(propName: string, value: int) =
  if not propExists(propName):
    propName.set(value)

proc prop*(propName: string): string =
  if data.contains(propName):
    data[propName]
  elif intData.contains(propName):
    $intData[propName]
  else:
    #log "prop " & propName & " not found"
    "undefined"
    
proc propInt*(propName: string): int =
  if intData.contains(propName):
    intData[propName]
  elif data.contains(propName):
    data[propName].parseInt
  else:
    #log "prop " & propName & " not found"
    0

proc adj*(propName: string, amount: int) =
  if intData.contains(propName) or data.contains(propName):
    let val = propName.propInt + amount
    propName.set(val)
  else:
    log "cannot adjust " & propName & " (does not exist)"

proc sec*(propName: string, section: int): string =
  propName.split(sep ='-')[0]
