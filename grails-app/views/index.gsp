<%@ page import="mbds.tp.game_account.User" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <asset:javascript src="application.js"/>
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
        <div class="col-md-4 col-sm-4">
            <div class="circle-tile ">
                <a href="/user"><div class="circle-tile-heading dark-blue text-offwhite"><i class="fa fa-users fa-fw fa-3x"></i></div></a>
                <div class="circle-tile-content dark-blue">
                    <div class="circle-tile-description text-faded">USERS</div>
                    <div class="circle-tile-number text-faded ">${grailsApplication.classLoader.loadClass(mbds.tp.game_account.User.getName()).count()}</div>
                    <a class="circle-tile-footer" href="/user">More Info <i class="fa fa-chevron-circle-right"></i></a>
                </div>
            </div>
        </div>
        <div class="col-md-4 col-sm-4">
            <div class="circle-tile ">
                <a href="/result"><div class="circle-tile-heading dark-blue text-orange"><i class="fa fa-fire fa-fw fa-3x"></i></div></a>
                <div class="circle-tile-content dark-blue">
                    <div class="circle-tile-description text-faded">RESULTS</div>
                    <div class="circle-tile-number text-faded ">${grailsApplication.classLoader.loadClass(mbds.tp.game_account.Result.getName()).count()}</div>
                    <a class="circle-tile-footer" href="/result">More Info <i class="fa fa-chevron-circle-right"></i></a>
                </div>
            </div>
        </div>
        <div class="col-md-4 col-sm-4">
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
    <canvas id="resultChart" width="400" height="100"></canvas>
    <script>
        var dates = [];
        $(document).ready(getChartData());

        function loadChart() {
            var today = moment().format("DD");
            console.log(today);
            var ctx = document.getElementById("resultChart");
            var resultChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: [
                        moment(today + "/" + dates[0]["month"], "DD/MM/YYYY"),
                        moment(today + "/" + dates[1]["month"], "DD/MM/YYYY"),
                        moment(today + "/" + dates[2]["month"], "DD/MM/YYYY"),
                        moment(today + "/" + dates[3]["month"], "DD/MM/YYYY"),
                        moment(today + "/" + dates[4]["month"], "DD/MM/YYYY"),
                        moment(today + "/" + dates[5]["month"], "DD/MM/YYYY"),
                        moment(today + "/" + dates[6]["month"], "DD/MM/YYYY"),
                        moment(today + "/" + dates[7]["month"], "DD/MM/YYYY"),
                        moment(today + "/" + dates[8]["month"], "DD/MM/YYYY"),
                        moment(today + "/" + dates[9]["month"], "DD/MM/YYYY"),
                        moment(today + "/" + dates[10]["month"], "DD/MM/YYYY"),
                        moment(today + "/" + dates[11]["month"], "DD/MM/YYYY"),
                        moment(today + "/" + dates[12]["month"], "DD/MM/YYYY"),
                    ],
                    datasets: [{
                        label: 'Parties',
                        data: [
                            dates[0]["count"],
                            dates[1]["count"],
                            dates[2]["count"],
                            dates[3]["count"],
                            dates[4]["count"],
                            dates[5]["count"],
                            dates[6]["count"],
                            dates[7]["count"],
                            dates[8]["count"],
                            dates[9]["count"],
                            dates[10]["count"],
                            dates[11]["count"],
                            dates[12]["count"],
                        ],
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
                                unit: 'month',
                                tooltipFormat: 'MMM. YYYY',
                                min: moment().subtract(12, "months"),
                                max: moment()
                            }
                        }]
                    },
                    title: {
                        display: true,
                        text: 'Nombre de parties (Results) / mois'
                    }
                }
            });
        }

        function getChartData() {
            $.ajax({
                url: "${createLink(controller:'Result',action:'getYearResults')}",
                type: "GET",
                success: function (data) {
                    console.log(data);
                    var dataCount = 0;
                    var month = 12;
                    for (i = 0; i <= 12; i++) {
                        date = {};
                        dateToAdd = moment().subtract(month, "months").format("MM/YYYY");
                        date ["month"] = dateToAdd;
                        if (Object.keys(data)[dataCount] != null && dateToAdd.toString() == Object.keys(data)[dataCount]) {
                            date ["count"] = Object.values(data)[dataCount];
                            dataCount++;
                        }
                        else {
                            date ["count"] = 0;
                        }

                        dates.push(date);
                        month--;
                    }
                    loadChart();
                }
            });
        }
    </script>
</div>
</body>
</html>
