package mbds.tp.game_account

import grails.gorm.services.Service

@Service(Message)
interface MessageService {

    Message get(Serializable id)

    List<Message> list(Map args)

    Long count()

    void delete(Serializable id)

    Message save(Message message)

}