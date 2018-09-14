package mbds.tp.game_account

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class ResultServiceSpec extends Specification {

    ResultService resultService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Result(...).save(flush: true, failOnError: true)
        //new Result(...).save(flush: true, failOnError: true)
        //Result result = new Result(...).save(flush: true, failOnError: true)
        //new Result(...).save(flush: true, failOnError: true)
        //new Result(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //result.id
    }

    void "test get"() {
        setupData()

        expect:
        resultService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Result> resultList = resultService.list(max: 2, offset: 2)

        then:
        resultList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        resultService.count() == 5
    }

    void "test delete"() {
        Long resultId = setupData()

        expect:
        resultService.count() == 5

        when:
        resultService.delete(resultId)
        sessionFactory.currentSession.flush()

        then:
        resultService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Result result = new Result()
        resultService.save(result)

        then:
        result.id != null
    }
}
