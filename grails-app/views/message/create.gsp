<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'message.label', default: 'Message')}"/>
    <g:set var="userService" bean="userService"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
<div id="create-message" class="content scaffold-create col-md-9" role="main">
    <h1><g:message code="default.create.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${this.message}">
        <ul class="errors" role="alert">
            <g:eachError bean="${this.message}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                        error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form resource="${this.message}" method="POST">
        <fieldset class="form">
            <f:with bean="message">
                <div class="form-group">
                <f:field property="author">
                    <g:select id="author"
                              name="author"
                              optionKey="id"
                              from="${userService.list()}"
                              optionValue="username"
                              value="id"
                              class="form-control"/>
                </f:field>
                <f:field property="target">
                    <g:select id="target"
                              name="target"
                              optionKey="id"
                              from="${userService.list()}"
                              optionValue="username"
                              value="id"
                              class="form-control"/>
                </f:field>
                <f:field property="content" class="form-control">
                    <g:textArea name="content" class="form-control" placeholder="Enter message content" rows="4"/>
                </f:field>
            </f:with>
        </fieldset>
        <fieldset class="buttons">
            <g:submitButton name="create" class="save btn btn-default"
                            value="${message(code: 'default.button.create.label', default: 'Create')}"/>
        </fieldset>
    </g:form>
</body>
</html>
