<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'result.label', default: 'Result')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="col-md-offset-2 col-md-8 col-lg-offset-3 col-lg-6">
            <div class="well row profile">
                <div class="col-sm-12">
                    <div class="col-xs-12 col-sm-12 text-center">
                        <h2><strong>Match n°${result.id}</strong></h2>
                    </div>
                    <div class="col-xs-12 col-sm-12 text-center">
                        <p>${result.dateCreated}</p>
                    </div>
                </div>
                <div class="col-xs-12 divider text-center">
                    <div class="col-xs-12 col-sm-6 emphasis">
                        <h4>Winner :<a href="/user/show/${result.winner.id}"><strong> ${result.winner.username} </strong></a></h4>
                        <h4>Score :<strong> ${result.winnersScore} </strong></h4>
                        <a href="/result/edit/${result.id}" class="nounderline"><button class="btn btn-success btn-block"><span class="fa fa-user"></span> Edit result </button></a><br/>
                        <a href="/result/create" class="nounderline"><button class="btn btn-primary btn-block"><span class="fa fa-user-plus"></span> New result </button></a>
                    </div>
                    <div class="col-xs-12 col-sm-6 emphasis">
                        <h4>Loser :<a href="/user/show/${result.loser.id}"><strong> ${result.loser.username} </strong></a></h4>
                        <h4>Score :<strong> ${result.losersScore} </strong></h4>
                        <g:form resource="${this.result}" method="DELETE">
                            <button class="btn btn-danger btn-block" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"><span class="fa fa-times-circle"></span> Delete result </button><br/>
                        </g:form>
                        <a href="/result" class="nounderline"><button class="btn btn-primary btn-block"><span class="fa fa-server"></span> Result list </button></a>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
