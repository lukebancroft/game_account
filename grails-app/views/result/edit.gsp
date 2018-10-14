<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'result.label', default: 'Result')}" />
        <g:set var="userService" bean="userService"/>
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="edit-result" class="content scaffold-edit" role="main">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.result}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.result}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
            <g:form resource="${this.result}" method="PUT">
                <g:hiddenField name="version" value="${this.result?.version}" />
                <fieldset class="form">
                    <f:with bean="result">
                        <f:field property="winner" class="form-control">
                            <g:select id="winner"
                                      name="winner"
                                      optionKey="id"
                                      from="${userService.list()}"
                                      optionValue="username"
                                      value="${result.winner.id}"
                                      class="form-control"/>
                        </f:field>
                        <f:field property="loser" class="form-control">
                            <g:select id="loser"
                                      name="loser"
                                      optionKey="id"
                                      from="${userService.list()}"
                                      optionValue="username"
                                      value="${result.loser.id}"
                                      class="form-control"/>
                        </f:field>
                        <f:field property="winnersScore" class="form-control">
                            <g:textField name="winnersScore" class="form-control" placeholder="Enter winner's score" value="${result.winnersScore}"/>
                        </f:field>
                        <f:field property="losersScore" class="form-control">
                            <g:textField name="losersScore" class="form-control" placeholder="Enter loser's score" value="${result.losersScore}"/>
                        </f:field><br/>
                    </f:with>
                </fieldset>
                <fieldset class="buttons">
                    <input class="save btn btn-default" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
