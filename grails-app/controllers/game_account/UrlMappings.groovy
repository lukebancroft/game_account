package game_account

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
            }
        }

        "/api/result"(controller: "api", action: "result")
        "/api/results"(controller: "api", action: "results")
        "/api/user"(controller: "api", action: "user")
        "/api/users"(controller: "api", action: "users")
        "/api/message"(controller: "api", action: "message")
        "/api/messages"(controller: "api", action: "messages")

        "/"(view:"/index")
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
