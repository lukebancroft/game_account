<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'result.label', default: 'Result')}"/>
    <g:set var="userService" bean="userService"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div id="list-result" class="content scaffold-list" role="main">
    <h1>List of match results</h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table class="table table-striped table-hover">
        <thead>
        <tr>
            <th class="text-center">Match number</th>
            <th class="text-center">Date</th>
            <th class="text-center">Winner</th>
            <th class="text-center">Winner's score</th>
            <th class="text-center">Loser</th>
            <th class="text-center">Loser's score</th>
            <th class="text-center">Edit</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${resultList}" var="user" status="i">
            <tr>
                <td class="text-center"><a href="/result/show/${resultList.id[i]}">${resultList.id[i]}</a></td>
                <td class="text-center">${resultList.dateCreated[i]}</td>
                <td class="text-center"><a href="/user/show/${userService.get(resultList.winnerId[i]).id}">${userService.get(resultList.winnerId[i]).username}</a></td>
                <td class="text-center">${resultList.winnersScore[i]}</td>
                <td class="text-center"><a href="/user/show/${userService.get(resultList.loserId[i]).id}">${userService.get(resultList.loserId[i]).username}</a></td>
                <td class="text-center">${resultList.losersScore[i]}</td>
                <td class="text-center"><a href="/result/edit/${resultList.id[i]}" role="button"><i class="fas fa-edit" aria-hidden="true"></i>
            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${resultCount ?: 0}"/>
    </div>
</body>
</html>