<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'result.label', default: 'Result')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
<div id="create-result" class="content scaffold-create" role="main">
    <h1><g:message code="default.create.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${this.result}">
        <ul class="errors" role="alert">
            <g:eachError bean="${this.result}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                        error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form resource="${this.result}" method="POST">
        <fieldset class="form">
            <f:with bean="result">
                <f:field property="winner" class="form-control"/>
                <f:field property="loser" class="form-control"/>
                <f:field property="losersScore" class="form-control">
                    <g:textField name="losersScore" class="form-control" placeholder="Enter loser's score"/>
                </f:field>
                <f:field property="winnersScore" class="form-control">
                    <g:textField name="winnersScore" class="form-control" placeholder="Enter winner's score"/>
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
