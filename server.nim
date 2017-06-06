import asyncdispatch, asynchttpserver, strutils, os


var server = newAsyncHttpServer()
let dir = getAppDir()

proc serveFile(req: Request){.async.} =
  let path = dir/req.url.path
  if fileExists(path):
    await req.respond(Http200, readFile(path))
  else:
    echo "not found: " & path
    await req.respond(Http404, "file not found!")

proc cb(req: Request) {.async.} =
  echo $req.url.path
  case req.url.path.split('/')[1]
  of "quit":
    echo "we can stop now guys"
    await req.respond(Http200, "goodbye")
    server.close()
  of "public":
    discard serveFile(req)
  else:
    await req.respond(Http404, "dammit")


waitFor server.serve(Port(8000), cb)
