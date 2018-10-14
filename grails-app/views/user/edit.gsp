<!DOCTYPE html>
<html>
<head>
    <asset:javascript src="application.js"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>
<div id="edit-user" class="content scaffold-edit" role="main">
    <h1><g:message code="default.edit.label" args="[entityName]"/></h1>
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
    <g:form resource="${this.user}" method="PUT">
        <g:hiddenField name="version" value="${this.user?.version}"/>
        <fieldset class="form">
            <f:with bean="user">

                <div class="form-group">
                    <f:field property="username" class="form-control">
                        <g:textField name="username" class="form-control" placeholder="Enter username" value="${value}"/>
                    </f:field>
                    <f:field property="password" class="form-control">
                        <g:passwordField name="password" class="form-control" placeholder="Enter password" value="${value}"/>
                    </f:field>
                     <div class="col-md-12">
                        <br/>
                        <div class="col-md-6 well">
                            <f:field property="avatar" class="form-control">
                                <br/>
                                <g:hiddenField name="avatar" value="${value}"/>
                                <div class="col-md-5">
                                    <div id="imgPreview">
                                        <img src="${grailsApplication.config.getProperty("grails.guides.cdnRootUrl")}/${value}" height="128px" width="128px" class="uploadedImg"/>
                                    </div>
                                </div>
                                <div class="col-md-7"><input type="file" name="myFile" accept="image/*" id="file"/><br/>
                                    <input type="button" value="upload" id="fileUpload" class="btn btn-default">
                                </div>
                            </f:field>
                        </div>
                        <div class="col-md-6">
                             <f:field property="enabled" class="form-control">
                                 <input name="enabled" type="checkbox" class="form-check-input" checked="${user.enabled}">
                             </f:field>
                             <f:field property="accountLocked" class="form-control">
                                 <input name="accountLocked" type="checkbox" class="form-check-input checked="${user.accountLocked}">
                             </f:field>
                             <f:field property="accountExpired" class="form-control">
                                 <input name="accountExpired" type="checkbox" class="form-check-input checked="${user.accountExpired}">
                             </f:field>
                             <f:field property="passwordExpired" class="form-control">
                                 <input name="passwordExpired" type="checkbox" class="form-check-input checked="${user.passwordExpired}">
                             </f:field>
                             <f:field property="isDeleted" class="form-control">
                                 <input name="isDeleted" type="checkbox" class="form-check-input checked="${user.isDeleted}">
                             </f:field>
                        </div>
                    </div>
                </div>
            </f:with>
        </fieldset>
        <fieldset class="buttons">
            <input class="save btn btn-default" type="submit"
                   value="${message(code: 'default.button.update.label', default: 'Update')}"/>
        </fieldset>
    </g:form>

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
                        url: "/user/uploadFile",
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
</body>
</html>
