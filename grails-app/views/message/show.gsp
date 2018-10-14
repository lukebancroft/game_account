<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'message.label', default: 'Message')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
    <div class="col-md-offset-2 col-md-8 col-lg-offset-3 col-lg-6">
        <div class="well row profile">
            <div class="col-sm-12">
                <div class="col-xs-12 col-sm-12 text-center">
                    <h2><strong>Message n°${message.id}</strong></h2>
                </div>
                <div class="col-xs-12 col-sm-12 text-center">
                    <p>Status : <g:if test="${message.isRead}">Is read</g:if><g:else>Not read</g:else></p>
                </div>
            </div>
            <div class="col-xs-12 divider text-center">
                <div class="col-xs-12 col-sm-6 emphasis">
                    <h4>Author :<a href="/user/show/${message.author.id}"><strong> ${message.author.id} </strong></a></h4>
                </div>
                <div class="col-xs-12 col-sm-6 emphasis">
                    <h4>Target :<a href="/user/show/${message.target.id}"><strong> ${message.target.id} </strong></a></h4>
                 </div>
                <div class="col-xs-12 col-sm-12">
                    <p>${message.content}</p>
                </div>
                <div class="col-xs-12 col-sm-6">
                    <a href="/message/edit/${message.id}" class="nounderline"><button class="btn btn-success btn-block"><span class="fa fa-user"></span> Edit message </button></a><br/>
                    <a href="/message/create" class="nounderline"><button class="btn btn-primary btn-block"><span class="fa fa-user-plus"></span> New message </button></a>
                </div>
                <div class="col-xs-12 col-sm-6">
                    <g:form resource="${this.message}" method="DELETE">
                        <button class="btn btn-danger btn-block" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"><span class="fa fa-times-circle"></span> Delete message </button><br/>
                    </g:form>
                    <a href="/message" class="nounderline"><button class="btn btn-primary btn-block"><span class="fa fa-server"></span> Message list </button></a>
                </div>
            </div>
        </div>
    </div>
    </body>
</html>
