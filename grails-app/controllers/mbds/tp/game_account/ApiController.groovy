package mbds.tp.game_account

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

@Secured('ROLE_ADMIN')
class ApiController {

    def index() {
        switch (request.getMethod())
        {
            case "POST":
                render "post"
                println request.getHeader('Allow text/xml')
                break;
            case "GET":
                render User.get(1) as JSON
            break;
        }
    }
}
