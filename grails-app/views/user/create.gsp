<!DOCTYPE html>
<html>
<head>
    <asset:javascript src="application.js"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
<script type="text/javascript" language="Javascript">
    $(document).ready(function () {
        $('#fileUpload').click(function () {
            var file = $('#file').prop('files')[0];
            if (file.size > 128000) {
                $("#imgPreview").html("<p class='alert alert-danger'><strong>File cannot be larger than 128KB</strong></p>");
            }
            else {
                var jForm = new FormData();
                jForm.append("file", file);
                $.ajax({
                    url: "uploadFile",
                    type: "POST",
                    data: jForm,
                    mimeType: "multipart/form-data",
                    contentType: false,
                    cache: false,
                    processData: false,
                    success: function (data) {
                        data = JSON.parse(data);
                        $("input[name='avatar']").val(data['name']);
                        $("#imgPreview").html(data['placeholder']);
                    }
                });
            }
        });
    });
</script>

<div id="content" role="main">
    <section class="row colset-2-its">
        <div class="col-md-2">

        </div>

        <div class="col-md-10">

            <div id="create-user" class="content scaffold-create" role="main">
                <h1><g:message code="default.create.label" args="[entityName]"/></h1>
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <g:hasErrors bean="${this.user}">
                    <ul class="errors" role="alert">
                        <g:eachError bean="${this.user}" var="error">
                            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                    error="${error}"/></li>
                        </g:eachError>
                    </ul>
                </g:hasErrors>
                <g:form resource="${this.user}" method="POST">
                    <fieldset class="form">
                        <f:with bean="user">
                            <f:field property="username"/>
                            <f:field property="password"/>
                            <f:field property="avatar">
                                <g:hiddenField name="avatar"/>
                                <input type="file" name="myFile" accept="image/*" id="file"/><br/>
                                <input type="button" value="upload" id="fileUpload">

                                <div id="imgPreview"></div>
                            </f:field>
                            <f:field property="accountLocked"/>
                            <f:field property="accountExpired"/>
                            <f:field property="passwordExpired"/>
                            <f:field property="matchWon"/>
                            <f:field property="matchLost"/>
                            <f:field property="messageSent"/>
                            <f:field property="messageReceived"/>
                        </f:with>
                    </fieldset>
                    <fieldset class="buttons">
                        <g:submitButton name="create" class="save"
                                        value="${message(code: 'default.button.create.label', default: 'Create')}"/>
                    </fieldset>
                </g:form>
            </div>
        </div>
    </section>
</div>
</body>
</html>
