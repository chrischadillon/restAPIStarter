import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

let names = ["usernames":[
    ["first":"Chris", "Last":"Chadillon", "username":"cbcdiver", "password":"pencil99"],
    ["first":"Alice", "Last":"Chadillon", "username":"dogs", "password":["pencil99","groundhog"]]
]]

let server = HTTPServer()
server.serverPort = 8080
server.documentRoot = "webroot"

var routes = Routes()

routes.add(method: .get, uri: "/hello", handler: {
    request, response in
    response.appendBody(string: "<H1>Hello</H1>")
    response.completed()
})

routes.add(method: .get, uri: "/json/all_data") {
    request, response in
    do {
        try response.setBody(json: names)
            response.setHeader(.contentType, value: "application/json")
            response.completed()
        
    } catch {
        response.setBody(string: "Error handling request: \(error)")
        response.completed()
    }
}

routes.add(method: .get, uri: "/json/username/{username}", handler: {
    request, response in
    
    if let userName = request.urlVariables["username"] {
        response.appendBody(string: userName)
    }
    response.completed()
})

server.addRoutes(routes)

do {
    try server.start()
} catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}
