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
            <th class="text-center">Message ID</th>
            <th class="text-center">Author</th>
            <th class="text-center">Target</th>
            <th class="text-center">Content</th>
            <th class="text-center">Is read</th>
            <th class="text-center">Edit</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${messageList}" var="user" status="i">
            <tr>
                <td class="text-center"><a href="/message/show/${messageList.id[i]}">${messageList.id[i]}</a></td>
                <td class="text-center"><a href="/user/show/${messageList.author[i].id}">${messageList.author[i].username}</a></td>
                <td class="text-center"><a href="/user/show/${messageList.target[i].id}">${messageList.target[i].username}</a></td>
                <td class="text-center">${messageList.content[i]}</td>
                <td class="text-center">${messageList.isRead[i]}</td>
                <td class="text-center"><a href="/message/edit/${messageList.id[i]}" role="button"><i class="fas fa-edit" aria-hidden="true"></i>
            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${messageCount ?: 0}"/>
    </div>
</body>
</html>