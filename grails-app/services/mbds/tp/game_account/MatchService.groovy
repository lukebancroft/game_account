package mbds.tp.game_account

import grails.gorm.services.Service

@Service(Result)
interface MatchService {

    Result get(Serializable id)

    List<Result> list(Map args)

    Long count()

    void delete(Serializable id)

    Result save(Result match)

}