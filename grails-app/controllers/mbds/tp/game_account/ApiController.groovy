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

    //Result
    def result()
    {
        switch(request.getMethod()) {
            case "GET":
                def resultInstance
                resultInstance = Result.get(params.id)

                if(!resultInstance){
                    render(status: 404, text: "Result with id ${params.id} does not exist")
                    return
                }
                switch(request.getHeader("Accept")){
                    case "application/json":
                        render (status: 200, resultInstance as JSON)
                        break
                    case "application/xml":
                        render (status: 200, resultInstance as XML)
                        break
                    default:
                        render(status: 400, text: "Cannot return result with header type : ${request.getHeader("Accept")}")
                        break
                }
                break

            case "POST":
                def resultInstance = new Result(params)
                if(resultInstance.save(flush:true))
                {
                    render(status: 201, text: "Result match ${resultInstance.getId()} between ${resultInstance.getLoser().getUsername()} and ${resultInstance.getWinner().getUsername()} created successfully")
                }
                else
                {
                    render(status: 400, text: "Result not created, check parameters and try again")
                }
                break

            case "PUT":
                if(!Result.get(params.id)) {
                    render(status: 404, text: "Result with id ${params.id} does not exist")
                    return
                }

                Result resultInstance = Result.get(params.id)
                def winner = params.winnerId ? User.get(params.winnerId) : resultInstance.getWinner()
                def loser = params.loserId ? User.get(params.loserId) : resultInstance.getLoser()
                def winnersScore = params.winnersScore ? params.winnersScore : resultInstance.getWinnersScore()
                def losersScore = params.losersScore ? params.losersScore : resultInstance.getLosersScore()

                println params
                resultInstance.setWinner(winner)
                resultInstance.setLoser(loser)
                resultInstance.setWinnersScore(Integer.parseInt(winnersScore))
                resultInstance.setLosersScore(Integer.parseInt(losersScore))

                if(resultInstance.save(flush:true))
                {
                    render(status: 200, text: "Result ${resultInstance.getId()} updated successfully")
                }
                else
                {
                    render(status: 400, text: "Result ${resultInstance.getId()} couldn't be updated")
                }
                break

            case "DELETE":
                def resultInstance
                resultInstance = Result.get(params.id)

                if(!resultInstance) {
                    render(status: 404, text: "Result with id ${params.id} does not exist")
                    return
                }
                else {
                    resultInstance.delete(flush:true)
                    if(!Result.get(params.id))
                    {
                        render(status: 200, text: "Result successfully deleted")
                    }
                    else
                    {
                        render(status: 400, text: "Result couldn't be deleted")
                    }
                }
                break;

            default:
                render(status: 405, text: "Method not allowed")
                break
        }
    }

    def results()
    {
        switch(request.getMethod())
        {
            case "GET":
                List<Result> resultsInstance = Result.getAll()
                switch (request.getHeader("Accept"))
                {
                    case "application/json":
                        render(status: 200, resultsInstance as JSON)
                        break
                    case "application/xml":
                        render(status: 200, resultsInstance as XML)
                        break
                    default:
                        render(status: 400, text: "Cannot return results with header type : ${request.getHeader("Accept")}")
                        break
                }

            default:
                render(status: 405, text: "Method not allowed")
                break;
        }
    }
}
