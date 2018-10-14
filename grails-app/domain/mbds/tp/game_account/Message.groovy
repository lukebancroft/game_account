package mbds.tp.game_account

class Message {

    User author
    User target
    String content
    boolean isRead = false;

    static constraints = {
        author nullable: false, blank: false
        target nullable: false, blank: false
        content nullable: false
        isRead nullable: false
    }
}
