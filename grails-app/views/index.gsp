<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Welcome to Grails</title>
</head>

<body>
<h1>Bienvenue sur l'Interface Admin</h1>

<p>
    Congratulations, you have successfully started your first Grails application! At the moment
    this is the default page, feel free to modify it to either redirect to a controller or display
    whatever content you may choose. Below is a list of controllers that are currently deployed in
    this application, click on each to execute its default action:
</p>

<div id="controllers" role="navigation">
    <h2>Statistique des entités:</h2>
    <div class="col-md-12">
        <g:each var="c" in="${grailsApplication.getDomainClasses()}">
            <div class="panel panel-default col-md-6">
                <div class="panel-body">
                    <h4>Nombre de ${c.name} : ${grailsApplication.getClassForName(c.fullName).count()}</h4>
                </div>
            </div>
        </g:each>
    </div>
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
</body>
</html>
