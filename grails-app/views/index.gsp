<%@ page import="mbds.tp.game_account.User" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <asset:stylesheet src="stats.css"/>
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
    <h2>Statistiques des entités:</h2>
    <div class="col-md-12">
        <div class="col-md-4">
            <div class="circle-tile ">
                <a href="/user"><div class="circle-tile-heading dark-blue text-offwhite"><i class="fa fa-users fa-fw fa-3x"></i></div></a>
                <div class="circle-tile-content dark-blue">
                    <div class="circle-tile-description text-faded">USERS</div>
                    <div class="circle-tile-number text-faded ">${grailsApplication.classLoader.loadClass(mbds.tp.game_account.User.getName()).count()}</div>
                    <a class="circle-tile-footer" href="/user">More Info <i class="fa fa-chevron-circle-right"></i></a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="circle-tile ">
                <a href="/result"><div class="circle-tile-heading dark-blue text-orange"><i class="fa fa-fire fa-fw fa-3x"></i></div></a>
                <div class="circle-tile-content dark-blue">
                    <div class="circle-tile-description text-faded">RESULTS</div>
                    <div class="circle-tile-number text-faded ">${grailsApplication.classLoader.loadClass(mbds.tp.game_account.Result.getName()).count()}</div>
                    <a class="circle-tile-footer" href="/result">More Info <i class="fa fa-chevron-circle-right"></i></a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="circle-tile ">
                <a href="/message"><div class="circle-tile-heading dark-blue text-offwhite"><i class="fa fa-envelope fa-fw fa-3x"></i></div></a>
                <div class="circle-tile-content dark-blue">
                    <div class="circle-tile-description text-faded">MESSAGES</div>
                    <div class="circle-tile-number text-faded ">${grailsApplication.classLoader.loadClass(mbds.tp.game_account.Message.getName()).count()}</div>
                    <a class="circle-tile-footer" href="/message">More Info <i class="fa fa-chevron-circle-right"></i></a>
                </div>
            </div>
        </div>
    </div>
    <canvas id="myChart" width="400" height="100"></canvas>
    <script>
        var ctx = document.getElementById("myChart");
        var myChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: [
                    moment().subtract(12, "months"),
                    moment().subtract(11, "months"),
                    moment().subtract(10, "months"),
                    moment().subtract(9, "months"),
                    moment().subtract(8, "months"),
                    moment().subtract(7, "months"),
                    moment().subtract(6, "months"),
                    moment().subtract(5, "months"),
                    moment().subtract(4, "months"),
                    moment().subtract(3, "months"),
                    moment().subtract(2, "months"),
                    moment().subtract(1, "months"),
                    moment()
                ],
                datasets: [{
                    label: 'Parties',
                    data: [4, 2, 10, 6, 8, 0, 1, 11, 5, 3, 5, 5, 8],
                    lineTension: 0.2/*,
                    pointBackgroundColor: "#FFFFFF",
                    pointBorderColor: "#fed67e",
                    borderColor: "#fed67e"*/
                }],
            },
            options: {
                legend: {
                    display: false
                },
                scales: {
                    xAxes: [{
                        type: 'time',
                        position: 'bottom',
                        distribution: 'linear',
                        time: {
                            displayFormats: {'day': 'MM/YY'},
                            tooltipFormat: 'DD/MM/YY',
                            unit: 'month',
                            tooltipFormat: 'MMM. YYYY',
                            min: moment().subtract(12, "months").format("DD-MM-YYYY 23:59:59"),
                            max: moment().format("DD-MM-YYYY 23:59:59")
                        }
                    }]
                },
                title: {
                    display: true,
                    text: 'Nombre de parties (Results) / mois'
                }
            }
        });
    </script>
</div>
</body>
</html>
