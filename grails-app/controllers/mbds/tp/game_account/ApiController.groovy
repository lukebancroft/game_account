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
                    case "*/*":
                        render(status: 200, userInstance as JSON)
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
                List<User> usersInstance = User.getAll()
                switch (request.getHeader("Accept"))
                {
                    case "application/json":
                        render(status: 200, usersInstance as JSON)
                        break
                    case "application/xml":
                        render(status: 200, usersInstance as XML)
                        break
                    case "*/*":
                        render(status: 200, usersInstance as JSON)
                        break
                    default:
                        render(status: 400, text: "Cannot return users with header type : ${request.getHeader("Accept")}")
                        break
                }
                break

            default:
                render(status: 405, text: "Method not allowed")
                break;
        }
    }

    def message()
    {
        switch(request.getMethod()) {
            case "GET":
                def messageInstance
                messageInstance = Message.get(params.id)

                if(!messageInstance){
                    render(status: 404, text: "Message with id ${params.id} does not exist")
                    return
                }
                switch(request.getHeader("Accept")){
                    case "application/json":
                        render (status: 200, messageInstance as JSON)
                        break
                    case "application/xml":
                        render (status: 200, messageInstance as XML)
                        break
                    case "*/*":
                        render(status: 200, messageInstance as JSON)
                        break
                    default:
                        render(status: 400, text: "Cannot return message with header type : ${request.getHeader("Accept")}")
                        break
                }
                break

            case "POST":
                if (User.get(params.authorId) && User.get(params.targetId)) {
                    params.author = User.get(params.authorId)
                    params.target = User.get(params.targetId)

                    def messageInstance = new Message(params)
                    if (messageInstance.save(flush: true)) {
                        render(status: 201, text: "Message created successfully with id : ${messageInstance.getId()}")
                    }
                } else {
                    render(status: 400, text: "Message not created, check parameters and try again")
                }
                break

            case "PUT":
                if(!Message.get(params.id)) {
                    render(status: 404, text: "Message with id ${params.id} does not exist")
                    return
                }

                Message messageInstance = Message.get(params.id)
                def author = params.authorId ? User.get(params.authorId) : messageInstance.getAuthor()
                def target = params.targetId ? User.get(params.targetId) : messageInstance.getTarget()
                def content = params.content ? params.content : messageInstance.getContent()
                def isRead = params.isRead ? params.isRead : messageInstance.getIsRead()

                messageInstance. setAuthor(author)
                messageInstance.setTarget(target)
                messageInstance.setContent(content)
                messageInstance.setIsRead(isRead)

                if(messageInstance.save(flush:true))
                {
                    render(status: 200, text: "Message with id ${messageInstance.getId()} updated successfully")
                }
                else
                {
                    render(status: 400, text: "Message couldn't be updated, check parameters and try again")
                }
                break

            case "DELETE":
                def messageInstance = Message.get(params.id)

                if(!messageInstance) {
                    render(status: 404, text: "Message with id ${params.id} does not exist")
                    return
                } else {
                    messageInstance.delete(flush:true)
                    if(!Message.get(params.id))
                    {
                        render(status: 200, text: "Message successfully deleted")
                    }
                    else
                    {
                        render(status: 400, text: "Message couldn't be deleted")
                    }
                }
                break;

            default:
                render(status: 405, text: "Method not allowed")
                break
        }
    }

    def messages()
    {
        switch(request.getMethod())
        {
            case "GET":
                List<Message> messagesInstance = Message.getAll()
                switch (request.getHeader("Accept"))
                {
                    case "application/json":
                        render(status: 200, messagesInstance as JSON)
                        break
                    case "application/xml":
                        render(status: 200, messagesInstance as XML)
                        break
                    case "*/*":
                        render(status: 200, messagesInstance as JSON)
                        break
                    default:
                        render(status: 400, text: "Cannot return messages with header type : ${request.getHeader("Accept")}")
                        break
                }
                break

            default:
                render(status: 405, text: "Method not allowed")
                break;
        }
    }
}
