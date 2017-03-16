import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

let names = ["accounts":[
    ["username":"cbcdiver", "email":"c@d.com", "password":"pencil99"],
    ["username":"dogs", "email":"a@b.com", "password":"pencil99"]
]]

let server = HTTPServer()
server.serverPort = 8080
server.documentRoot = "webroot"

var routes = Routes()

server.addRoutes(routes)

do {
    try server.start()
} catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}
