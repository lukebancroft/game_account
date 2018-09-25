package mbds.tp.game_account

class MessageAutoDeleteJob {
    static triggers = {
        //Execution du trigger à 4h du matin tous les jours
        cron name: 'messageDeleteTrigger', cronExpression: "0 0 4 * * ?"
    }

    def execute() {
        //Suppression de tous les messages lus
        println("Daily message deletion : ${Message.executeUpdate("delete Message where isRead = true")} message(s) deleted")
    }
}
