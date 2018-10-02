package mbds.tp.game_account

import grails.converters.JSON
import grails.converters.XML
import grails.plugin.springsecurity.annotation.Secured

@Secured(['permitAll'])
class ApiController {

    def user()
    {
        switch(request.getMethod()) {
            case "GET":
                def userInstance
                userInstance = params.id ? User.get(params.id) : userInstance
                userInstance = (!userInstance && params.username) ? User.findByUsername(params.username) : userInstance

                if(!userInstance){
                    render(status: 404, text: "User with id ${params.id} does not exist")
                    return
                }
                switch(request.getHeader("Accept")){
                    case "application/json":
                        render (status: 200, userInstance as JSON)
                        break
                    case "application/xml":
                        render (status: 200, userInstance as XML)
                        break
                    default:
                        render(status: 400, text: "Cannot return user with header type : ${request.getHeader("Accept")}")
                        break
                }
                break

            case "POST":
                def userInstance = new User(params)
                if(userInstance.save(flush:true))
                {
                    render(status: 201, text: "User ${userInstance.getUsername()} created successfully")
                }
                else
                {
                    userInstance.errors.allErrors.each{println it}
                    render(status: 400, text: "User not created, check parameters and try again")
                }
                break

            case "PUT":
                if(!User.get(params.id)) {
                    render(status: 404, text: "User with id ${params.id} does not exist")
                    return
                }

                User userInstance = User.get(params.id)
                def username = params.username ? params.username : userInstance.getUsername()
                def password = params.password ? params.password : userInstance.getPassword()
                def avatar = params.avatar ? params.avatar : userInstance.getAvatar()

                userInstance.setUsername(username)
                userInstance.setPassword(password)
                userInstance.setAvatar(avatar)

                if(userInstance.save(flush:true))
                {
                    render(status: 200, text: "User ${userInstance.getId()} updated successfully")
                }
                else
                {
                    render(status: 400, text: "User ${userInstance.getId()} couldn't be updated")
                }
                break

            case "DELETE":
                def userInstance
                userInstance = params.id ? User.get(params.id) : userInstance
                userInstance = (!userInstance && params.username) ? User.findByUsername(params.username) : userInstance

                if(!userInstance) {
                    render(status: 404, text: "User with id ${params.id} does not exist")
                    return
                }
                else {
                    userInstance.setIsDeleted(true)
                    if(userInstance.save(flush:true))
                    {
                        render(status: 200, text: "User successfully deleted")
                    }
                    else
                    {
                        render(status: 400, text: "User couldn't be deleted")
                    }
                }
                break;

            default:
                render(status: 405, text: "Method not allowed")
                break
        }
    }

    def users()
    {
        switch(request.getMethod())
        {
            case "GET":
                List<User> UsersInstance = User.getAll()
                switch (request.getHeader("Accept"))
                {
                    case "application/json":
                        render(status: 200, UsersInstance as JSON)
                        break
                    case "application/xml":
                        render(status: 200, UsersInstance as XML)
                        break
                    default:
                        render(status: 400, text: "Cannot return users with header type : ${request.getHeader("Accept")}")
                        break
                }

            default:
                render(status: 405, text: "Method not allowed")
                break;
        }
    }
}
