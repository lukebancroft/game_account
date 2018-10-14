<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <asset:stylesheet src="show.css"/>
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
    <div class="col-md-offset-2 col-md-8 col-lg-offset-3 col-lg-6">
        <div class="well profile">
            <div class="col-sm-12">
                <div class="col-xs-12 col-sm-8">
                    <h2><strong>${user.username}</strong></h2>
                </div>
                <div class="col-xs-12 col-sm-4 text-center">
                    <figure>
                        <img src="${grailsApplication.config.getProperty('grails.guides.cdnRootUrl') + "/" + user.avatar}" alt="" class="img-circle img-responsive">
                    </figure>
                </div>
                <div class="col-xs-12 col-sm-6">
                    <p><strong>User roles: </strong> <g:if test="${user.getAuthorities().authority.size() > 0}">${user.getAuthorities().authority}</g:if><g:else>None</g:else></p>
                    <p><strong>Acount enabled: </strong> <g:if test="${user.enabled}"><i class="fa fa-check text-success" aria-hidden="true"></i></g:if><g:else><i class="fa fa-times text-danger" aria-hidden="true"></i></g:else> </p>
                    <p><strong>Account locked: </strong> <g:if test="${user.accountLocked}"><i class="fa fa-check text-success" aria-hidden="true"></i></g:if><g:else><i class="fa fa-times text-danger" aria-hidden="true"></i></g:else> </p>
                </div>
                <div class="col-xs-12 col-sm-6">
                    <p><strong>Account expired: </strong> <g:if test="${user.accountExpired}"><i class="fa fa-check text-success" aria-hidden="true"></i></g:if><g:else><i class="fa fa-times text-danger" aria-hidden="true"></i></g:else> </p>
                    <p><strong>Password expired: </strong> <g:if test="${user.passwordExpired}"><i class="fa fa-check text-success" aria-hidden="true"></i></g:if><g:else><i class="fa fa-times text-danger" aria-hidden="true"></i></g:else> </p>
                    <p><strong>Account Deleted: </strong> <g:if test="${user.isDeleted}"><i class="fa fa-check text-success" aria-hidden="true"></i></g:if><g:else><i class="fa fa-times text-danger" aria-hidden="true"></i></g:else> </p>
                </div>
            </div>
            <div class="col-xs-12 divider text-center">
                <div class="col-xs-12 col-sm-6 emphasis">
                    <h2><strong> ${user.matchWon.size()} </strong></h2>
                    <p><small>Match(es) won</small></p>
                    <a href="/user/edit/${user.id}" class="nounderline"><button class="btn btn-success btn-block"><span class="fa fa-user"></span> Edit user </button></a><br/>
                    <a href="/user/create" class="nounderline"><button class="btn btn-primary btn-block"><span class="fa fa-user-plus"></span> New user </button></a>
                </div>
                <div class="col-xs-12 col-sm-6 emphasis">
                    <h2><strong> ${user.matchLost.size()} </strong></h2>
                    <p><small>Match(es) lost</small></p>
                    <g:form resource="${this.result}" method="PUT">
                        <button class="btn btn-danger btn-block" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"><span class="fa fa-times-circle"></span> Delete result </button><br/>
                    </g:form>
                    <a href="/user" class="nounderline"><button class="btn btn-primary btn-block"><span class="fa fa-server"></span> User list </button></a>
                </div>
                </div>
            </div>
        </div>
    </body>
</html>
