<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'message.label', default: 'Message')}" />
        <g:set var="userService" bean="userService"/>
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="edit-message" class="content scaffold-edit" role="main">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.message}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.message}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
            <g:form resource="${this.message}" method="PUT">
                <g:hiddenField name="version" value="${this.message?.version}" />
                <fieldset class="form">
                    <f:with bean="message">
                        <div class="form-group">
                        <f:field property="author">
                            <g:select id="author"
                                      name="author"
                                      optionKey="id"
                                      from="${userService.list()}"
                                      optionValue="username"
                                      value="${message.author.id}"
                                      class="form-control"/>
                        </f:field>
                        <f:field property="target">
                            <g:select id="target"
                                      name="target"
                                      optionKey="id"
                                      from="${userService.list()}"
                                      optionValue="username"
                                      value="${message.target.id}"
                                      class="form-control"/>
                        </f:field>
                        <f:field property="content" class="form-control">
                            <g:textArea name="content" class="form-control" placeholder="Enter message content" rows="4" value="${message.content}"/>
                        </f:field>
                    </f:with>
                </fieldset>
                <fieldset class="buttons">
                    <input class="save btn btn-default" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
