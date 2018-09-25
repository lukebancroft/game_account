<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#list-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
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
                            <td class="text-center"><img src="${grailsApplication.config.getProperty("grails.guides.cdnRootUrl")}/${userList.avatar[i]}" height="64px" width="64px"/></td>
                        </tr>
                    </g:each>
                </tbody>
            </table>

            <div class="pagination">
                <g:paginate total="${userCount ?: 0}" />
            </div>
        </div>
    </body>
</html>