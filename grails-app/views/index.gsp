<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Welcome to Grails</title>
</head>
<body>
    <content tag="nav">
        <g:each var="c" in="${grailsApplication.controllerClasses.sort { it.fullName } }">
        <li>
            <a href="${c.logicalPropertyName}" role="button">
                ${c.name}
            </a>
        </li>
        </g:each>
    </content>

    <div id="content" role="main">
        <section class="row colset-2-its">
            <h1>Bienvenue sur l'Interface Admin</h1>

            <p>
                Congratulations, you have successfully started your first Grails application! At the moment
                this is the default page, feel free to modify it to either redirect to a controller or display
                whatever content you may choose. Below is a list of controllers that are currently deployed in
                this application, click on each to execute its default action:
            </p>

            <div id="controllers" role="navigation">
                <h2>Statistique des entités:</h2>
                <ul>
                    <g:each var="c" in="${grailsApplication.getDomainClasses() }">
                        <li class="controller">
                            Nombre de ${c.name} : ${grailsApplication.getClassForName(c.fullName).count()}
                        </li>
                    </g:each>
                </ul>
            </div>
        </section>
    </div>

</body>
</html>
