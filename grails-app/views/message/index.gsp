<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'message.label', default: 'Message')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div id="list-message" class="content scaffold-list" role="main">
    <h1>List of messages</h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table class="table table-striped table-hover">
        <thead>
        <tr>
            <th class="text-center">Author</th>
            <th class="text-center">Target</th>
            <th class="text-center">Content</th>
            <th class="text-center">Is read</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${messageList}" var="user" status="i">
            <tr>
                <td class="text-center">${messageList.author[i].username}</td>
                <td class="text-center">${messageList.target[i].username}</td>
                <td class="text-center">${messageList.content[i]}</td>
                <td class="text-center">${messageList.isRead[i]}</td>
            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${messageCount ?: 0}"/>
    </div>
</body>
</html>