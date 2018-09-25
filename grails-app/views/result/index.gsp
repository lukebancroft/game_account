<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'result.label', default: 'Result')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div id="content" role="main">
    <section class="row colset-2-its">
        <div class="col-md-2">

        </div>

        <div class="col-md-10">

            <div id="list-result" class="content scaffold-list" role="main">
                <h1><g:message code="default.list.label" args="[entityName]"/></h1>
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <f:table collection="${resultList}"/>

                <div class="pagination">
                    <g:paginate total="${resultCount ?: 0}"/>
                </div>
            </div>
        </div>
    </section>
</div>
</body>
</html>