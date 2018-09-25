<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
        <g:layoutTitle default="Grails"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>

    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"
          integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
    <asset:stylesheet src="bootstrap.css"/>
    <asset:stylesheet src="main.css"/>

    <g:layoutHead/>
</head>

<body>

<div class="navbar navbar-default" role="navigation" style="background-color: #111; border-radius: 0px; border: none;">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/#">
                <asset:image src="logo.png" alt="Grails Logo"/>
            </a>
        </div>

        <div class="navbar-collapse collapse" aria-expanded="false" style="height: 0.8px;">
            <ul class="nav navbar-nav navbar-right">
                <g:each var="c" in="${grailsApplication.controllerClasses.sort { it.fullName }}">
                    <g:if test="${c.name == 'Logout'}">
                        <li>
                            <a id="accueil" href="/" role="button"><i class="fa fa-home fa-fw"
                                                                      aria-hidden="true"></i> Accueil</a>
                        </li>
                        <li>
                            <a id="logout" href="${c.logicalPropertyName}" role="button"><i
                                    class="fa fa-sign-out-alt fa-fw" aria-hidden="true"></i> Déconnexion</a>
                        </li>
                    </g:if>
                </g:each>
            </ul>
        </div>
    </div>
</div>

<div class="col-md-3">
    <div class="sidenav">
        <button class="dropdown-btn active">Utilisateur
            <i class="fa fa-caret-down"></i>
        </button>

        <div class="dropdown-container" style="display: block;">
            <a href="/user">Liste de User</a>
            <a href="/user/create">Créer un User</a>
        </div>
        <button class="dropdown-btn active">Resultat
            <i class="fa fa-caret-down"></i>
        </button>

        <div class="dropdown-container" style="display: block;">
            <a href="/result">Liste de Result</a>
            <a href="/result/create">Créer un Result</a>
        </div>
        <button class="dropdown-btn active">Message
            <i class="fa fa-caret-down"></i>
        </button>

        <div class="dropdown-container" style="display: block;">
            <a href="/message">Liste de Message</a>
            <a href="/message/create">Créer un Message</a>
        </div>
    </div>
</div>

<div class="col-md-12">
    <g:layoutBody/>
    <div/>

    <!-- <div class="footer" role="contentinfo"></div> -->

    <div id="spinner" class="spinner" style="display:none;">
        <g:message code="spinner.alt" default="Loading&hellip;"/>
    </div>

    <script>
        /* Loop through all dropdown buttons to toggle between hiding and showing its dropdown content - This allows the user to have multiple dropdowns without any conflict */
        var dropdown = document.getElementsByClassName("dropdown-btn");
        var i;

        for (i = 0; i < dropdown.length; i++) {
            dropdown[i].addEventListener("click", function () {
                this.classList.toggle("active");
                var dropdownContent = this.nextElementSibling;
                if (dropdownContent.style.display === "block") {
                    dropdownContent.style.display = "none";
                } else {
                    dropdownContent.style.display = "block";
                }
            });
        }
    </script>

    <asset:javascript src="jquery-2.2.0.min.js"/>
    <asset:javascript src="bootstrap.js"/>

</body>
</html>
