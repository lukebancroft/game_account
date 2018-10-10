package mbds.tp.game_account

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException

import javax.imageio.ImageIO

import static org.springframework.http.HttpStatus.*

@Secured('ROLE_ADMIN')
public class UserController {

    UserService userService
    def springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond User.notDeleted.list(params), model:[userCount: userService.count()]
    }

    def show(Long id) {
        respond userService.get(id)
    }

    def create() {
        respond new User(params)
    }

    def save(User user) {
        if (user == null) {
            notFound()
            return
        }

        try {
            userService.save(user)
        } catch (ValidationException e) {
            respond user.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), user.id])
                redirect user
            }
            '*' { respond user, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond userService.get(id)
    }

    def update(User user) {
        if (user == null) {
            notFound()
            return
        }

        try {
            userService.save(user)
        } catch (ValidationException e) {
            respond user.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), user.id])
                redirect user
            }
            '*'{ respond user, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        userService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def uploadFile() {
        if (params.file && ImageIO.read(params.file.getInputStream())) {
            def cdnRootUrl = grailsApplication.config.getProperty("grails.guides.cdnRootUrl")
            def cdnFolderPath = grailsApplication.config.getProperty("grails.guides.cdnFolder")

            def fileName = "${UUID.randomUUID().toString()}${Long.toString(Calendar.getInstance().getTimeInMillis())}.png"

            File folder = new File(cdnFolderPath)
            if ( !folder.exists() ) {
                folder.mkdirs()
            }

            String path = "${cdnFolderPath}/${fileName}"
            params.file.transferTo(new File(path))

            def result = [:]
            result.placeholder = '<img src="' + "${cdnRootUrl}/${fileName}" + '" height="128px" width="128px" id=" ' + fileName +' class="uploadedImg"/>'
            result.name = fileName
            render result as JSON

        } else {
            def result = [:]
            result.placeholder = "<p class='alert alert-danger'><strong>Uploaded file must be an image (128KB max.)</strong></p>"
            result.name = null
            render result as JSON
        }
    }
}
