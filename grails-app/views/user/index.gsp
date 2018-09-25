<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div id="content" role="main">
    <section class="row colset-2-its">
        <div class="col-md-2">

        </div>

        <div class="col-md-10">

            <div id="list-user" class="content scaffold-list" role="main">
                <h1>List of active users</h1>
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>

                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <th class="text-center">Username</th>
                        <th class="text-center">Roles</th>
                        <th class="text-center">Matches won</th>
                        <th class="text-center">Matches lost</th>
                        <th class="text-center">Avatar</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${userList}" var="user" status="i">
                        <tr>
                            <td class="text-center">${userList.username[i]}</td>
                            <td class="text-center">${userList[i].getAuthorities().authority}</td>
                            <td class="text-center">${userList.matchWon[i].size()}</td>
                            <td class="text-center">${userList.matchLost[i].size()}</td>
                            <td class="text-center"><img
                                    src="${grailsApplication.config.getProperty("grails.guides.cdnRootUrl")}/${userList.avatar[i]}"
                                    height="64px" width="64px"/></td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>

                <div class="pagination">
                    <g:paginate total="${userCount ?: 0}"/>
                </div>
            </div>
        </div>
    </section>
</div>
</body>
</html>