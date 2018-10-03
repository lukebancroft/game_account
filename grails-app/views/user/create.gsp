<!DOCTYPE html>
<html>
<head>
    <asset:javascript src="application.js"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <g:set var="roleService" bean="roleService"/>
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
<div class="col-md-9">
    <g:form resource="${this.user}" method="POST">
        <fieldset class="form">
            <f:with bean="user">

                <div class="form-group">
                <f:field property="username" class="form-control">
                    <g:textField name="username" class="form-control" placeholder="Enter username"/>
                </f:field>
                <f:field property="password">
                    <g:passwordField name="password" class="form-control" placeholder="Enter password"/>
                </f:field>
                <br/>
                <f:field property="avatar" label="Upload an avatar">
                    <br/>
                    <g:hiddenField name="avatar"/>
                    <div class="col-md-6"><input type="file" name="myFile" accept="image/*" id="file"/><br/>
                        <input type="button" value="upload" id="fileUpload" class="btn btn-default"></div>

                    <div class="col-md-3"><div id="imgPreview"></div></div>
                </f:field>
            </f:with>
            <div class="col-md-12">
                <br/><g:select name="role.authority" from="${roleService.list()}" value="${role?.id}" optionKey="id" />
            </div>
        </fieldset><br/><br/>
        <fieldset class="buttons">
            <g:submitButton name="create" class="save btn btn-default"
                            value="${message(code: 'default.button.create.label', default: 'Create')}"/>
        </fieldset>
        </div>
    </g:form>
</body>
</html>
