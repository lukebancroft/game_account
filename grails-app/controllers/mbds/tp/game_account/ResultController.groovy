package mbds.tp.game_account

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import groovy.time.TimeCategory

import java.util.function.Function
import java.util.stream.Collectors

import static org.springframework.http.HttpStatus.*

@Secured('ROLE_ADMIN')
class ResultController {

    ResultService resultService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE", getYearResults: "GET"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond resultService.list(params), model:[resultCount: resultService.count()]
    }

    def show(Long id) {
        respond resultService.get(id)
    }

    def create() {
        respond new Result(params)
    }

    def save(Result result) {
        if (result == null) {
            notFound()
            return
        }

        try {
            resultService.save(result)
        } catch (ValidationException e) {
            respond result.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'result.label', default: 'Result'), result.id])
                redirect result
            }
            '*' { respond result, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond resultService.get(id)
    }

    def update(Result result) {
        if (result == null) {
            notFound()
            return
        }

        try {
            resultService.save(result)
        } catch (ValidationException e) {
            respond result.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'result.label', default: 'Result'), result.id])
                redirect result
            }
            '*'{ respond result, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        resultService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'result.label', default: 'Result'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'result.label', default: 'Result'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def getYearResults() {
        def results = Result.list().dateCreated
        def formatedDates = []

        for (result in results) {
            use (groovy.time.TimeCategory) {
                if (result >= 1.year.ago) {
                    formatedDates.add(result.format("MM/YYYY"))
                }
            }
        }
        Map<Date, Long> counts = formatedDates.stream().collect(Collectors.groupingBy(Function.identity(), Collectors.counting()));
        Map<Date, Long> sortedCounts = new TreeMap<>(counts)

        render sortedCounts as JSON
    }
}
