package game_account

import mbds.tp.game_account.Match
import mbds.tp.game_account.Message
import mbds.tp.game_account.Role
import mbds.tp.game_account.User
import mbds.tp.game_account.UserRole

class BootStrap {

    def init = { servletContext ->
        def adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true, failOnError: true)
        def userRole = new Role(authority: 'ROLE_USER').save(flush: true, failOnError: true)

        def user1 = new User(username: 'admin', password: '123').save(flush: true, failOnError: true)
        def user2 = new User(username: 'Player Two', password: '123').save(flush: true, failOnError: true)

        UserRole.create(user1, adminRole, true)
        UserRole.create(user2, userRole, true)

        new Match(winner: user1, loser: user2, winnersScore: 10, losersScore: 1).save(flush: true, failOnError: true)

        new Message(author: user1, target: user2, content: "Haha j'ai gagné mdr").save(flush: true, failOnError: true)
        new Message(author: user2, target: user1, content: "Mon père travaille à Microsoft tu vas te faire ban").save(flush: true, failOnError: true)
    }
    def destroy = {
    }
}
