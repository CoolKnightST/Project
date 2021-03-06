var dropdownKeuze;
var aantalCursisten = 0;
var scoretable;

// Functie die het jaar controleert.
function checkJaar() {

    var schooljaar = document.getElementById("schooljaar").value;

    if (schooljaar === 'Kies schooljaar..') {
        alert("Selecteer eerst een schooljaar!");
        document.getElementById("semester").selectedIndex = 0;
    } else {
        if (document.getElementById("semester").selectedIndex === 0) {
            document.getElementById("studiegebied").hidden = true;
        } else {
            document.getElementById("studiegebied").hidden = false;
        }
    }
}

// Functies die de scores van alle cursisten in een module.
function laadCursistenScores() {

    dropdown = document.querySelector("#modules");
    dropdown.style = "background: #f9f9f9";

    if (document.getElementById("modules").selectedIndex === 0) {
        return;
    }

    var xhttp = new XMLHttpRequest();

    if (window.XMLHttpRequest) {
        // code voor moderne browsers
        xhttp = new XMLHttpRequest();
    } else {
        // code voor oude IE browsers
        xhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    //Selecteer lijst aan de hand van volgende selectie.
    dropdownKeuze = document.getElementById('modules').value;
    var schooljaar = document.getElementById("datum").value;
    var semester = document.getElementById("Semester").value;
    xhttp.open("POST", "ScoreServlet?module=" + dropdownKeuze + "&schooljaar=" + schooljaar + "&semester=" + semester, true);

    xhttp.send();

    xhttp.onreadystatechange = function () {

        //200: "OK"
        //403: "Forbidden"
        //404: "Not Found"

        //0: request not initialized 
        //1: server connection established
        //2: request received 
        //3: processing request 
        //4: request finished and response is ready
        if (this.readyState === 4 && this.status === 200) {

            var jsonData = JSON.parse(xhttp.responseText);
           // Scoretabel aanmaken en opvullen.
            var scoreTable = document.getElementById("scoretable");
            for (let i = 0; i < jsonData.length; i++) {
                aantalCursisten = aantalCursisten + 1;
                var row = scoreTable.insertRow(i);
                row.id = "row" + aantalCursisten;

                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);

                var naam = jsonData[i].achternaam;
                var voornaam = jsonData[i].voornaam;
                var score = jsonData[i].score;
                cell1.innerHTML = naam;
                cell2.innerHTML = voornaam;
                cell3.innerHTML = score;

            }

        }
    };
}

// Leegt de dropdowns indien er een andere keuze wordt gemaakt.
function resetDropdowns(naam) {

    formulierLeegMaken();
    let dropdowns = document.getElementsByClassName('drop');
    var idDropDown;
    for (let i = 0; i < dropdowns.length; i++) {
        idDropDown = dropdowns[i].id;

        //reset dropdowns na studiegebied
        switch (naam) {
            case 'studiegebieden':

                if (idDropDown === 'opleidingen') {
                    dropdowns[i].selectedIndex = 0;
                    dropdowns[i].style = "background: #efc4c4";
                    ledigDropDown(dropdowns[i]);
                }
                if (idDropDown === 'modules') {
                    dropdowns[i].selectedIndex = 0;
                    dropdowns[i].style = "background: #efc4c4";
                    ledigDropDown(dropdowns[i]);
                }
                break;
            case 'opleidingen':
                if (idDropDown === 'modules') {
                    dropdowns[i].selectedIndex = 0;
                    dropdowns[i].style = "background: #efc4c4";
                    ledigDropDown(dropdowns[i]);
                }
                break;

        }
    }
}

//laad de dropdown met de gevraagde soort
function laadDropdown(soort) {

    var xhttp2 = new XMLHttpRequest();
    //vraag informatie aan servlet
    switch (soort) {
        case 'opleidingen':
            //highlight opleiding in het rood
            dropdown = document.querySelector("#studiegebied");
            dropdown.style = "background: #f9f9f9";
            dropdown = document.querySelector("#opleidingen");
            dropdown.style = "background: #efc4c4";
            dropdownKeuze = document.getElementById('studiegebied').value;
            xhttp2.open("POST", "ScoreServlet?studiegebied=" + dropdownKeuze, true);
            break;
        case 'modules':
            dropdown = document.querySelector("#opleidingen");
            dropdown.style = "background: #f9f9f9";
            dropdown = document.querySelector("#modules");
            dropdown.style = "background: #efc4c4";
            dropdownKeuze = document.getElementById('opleidingen').value;
            xhttp2.open("POST", "ScoreServlet?opleiding=" + dropdownKeuze, true);
            break;

        case 'cursisten':
            laadDoestellingen();
            dropdown = document.querySelector("#modules");
            dropdown.style = "background: #f9f9f9";
            dropdown = document.querySelector("#cursisten");
            dropdown.style = "background: #efc4c4";
            var modules = document.getElementById("modules").value;
            var schooljaar = document.getElementById("datum").value;
            var semester = document.getElementById("Semester").value;
            xhttp2.open("POST", "ScoreServlet?modules=" + modules + "&schooljaar=" + schooljaar + "&semester=" + semester, true);
            break;
    }

    xhttp2.send();

    //als het antwoord wordt ontvangen...
    xhttp2.onreadystatechange = function () {

        if (this.readyState === 4 && this.status === 200) {

            //plaats het antwoord in een object...
            const data = JSON.parse(xhttp2.responseText);
            //toon dropdown
            let dropdown = document.getElementById(soort);
            dropdown.hidden = false;
            dropdown.length = 0;
            //plaats naam in dropdown en zorg ervoor dat de gebruiker dat niet kan selecteren
            let defaultOption = document.createElement('option');
            //plaats titel in dropdown
            switch (soort) {
                case 'opleidingen':
                    defaultOption.text = 'Opleiding...';
                    break;
                case 'modules':
                    defaultOption.text = 'Module...';
                    break;
                case 'cursisten':
                    defaultOption.text = 'Cursist...';
                    break;
            }
            defaultOption.disabled = true;
            dropdown.add(defaultOption);
            dropdown.selectedIndex = 0;

            for (let i = 0; i < data.length; i++) {
                let  optiondata = document.createElement('option');
                optiondata.text = data[i].naam;
                dropdown.add(optiondata);
            }
        }
    };
}

//leegt de dropdowns indien er een andere keuze wordt gemaakt
function ledigDropDown(dropdown) {
    var length = dropdown.options.length;
    for (i = 1; i < length; i++) {
        dropdown.options[i] = null;
    }
}

// Functie die het semester aanpast aan de hand van de kalender.
function pasSemesterAan() {
  // functie die ervoor worgt dat het semester automatisch wordt gekozen aan de hand van datum.
    let nu = new Date(document.querySelector("#datum").value);
    switch (nu.getMonth() + 1) {
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
            document.querySelector("#Semester").selectedIndex = 2;
            break;
        case 7:
        case 8:
        case 9:
        case 10:
        case 11:
        case 12:
        case 1:
            document.querySelector("#Semester").selectedIndex = 1;
            break;
    }
}

// Functie die alle geladen doelstellingen/scores verwijderd.
function formulierLeegMaken() {
 // Met deze functie maken we formulieren leeg.
    aantalRijen = scoretable.rows.length;
    for (let i = aantalRijen - 2; i > 0; i--) {
        var row = scoretable.rows[i];
        if (row.id !== "firstRow") {
            if (row.id !== "addLine") {
                scoretable.deleteRow(i);
            }
        }
    }
    aantalCursisten = 0;
}

// Deze functie laad de totaal scores per doelstelling per cursist.
function laadDoelstellingenScores() {
    
    var xhttp4 = new XMLHttpRequest();    

    if (window.XMLHttpRequest) {
        // code voor moderne browsers
        xhttp4 = new XMLHttpRequest();
    } else {
        // code voor oude IE browsers
        xhttp4 = new ActiveXObject("Microsoft.XMLHTTP");
    }

    dropdown = document.querySelector("#cursisten");
    dropdown.style = "background: #f9f9f9";

    var dropdownCursist = document.getElementById('cursisten').value;
    var module = document.getElementById("modules").value;
    
    xhttp4.open("POST", "ScoreServlet?cursistenScore=" + dropdownCursist + "&modules=" + module, true); 
    xhttp4.send();
    
    xhttp4.onreadystatechange = function () {

        if (this.readyState === 4 && this.status === 200) {

            var doelstellingScore = JSON.parse(xhttp4.responseText);

            var doelstellingscoretable = document.getElementById("doelstellingscoretable");
            for (let i = 0; i < doelstellingScore.length; i++) {
                var aantalDoelstellingen = aantalDoelstellingen + 1;
                var row = doelstellingscoretable.insertRow.id;
                row.id = "row" + aantalDoelstellingen;

                var cell2 = row.insertCell(1);
                var score = doelstellingScore[i].score;

                cell2.innerHTML = score;

            }
        }
    };
}

// Deze functie laad alle doelstellingen per module.
function laadDoestellingen() {    

    var xhttp3 = new XMLHttpRequest();

    if (window.XMLHttpRequest) {
        // code voor moderne browsers
        xhttp5 = new XMLHttpRequest();
    } else {
        // code voor oude IE browsers
        xhttp5 = new ActiveXObject("Microsoft.XMLHTTP");
    }

    var moduleDoelstelling = document.getElementById('modules').value;
    xhttp3.open("POST", "ScoreServlet?moduleDoelstelling=" + moduleDoelstelling, true);

    xhttp3.send();

    xhttp3.onreadystatechange = function () {

        if (this.readyState === 4 && this.status === 200) {

            var doelstellingen = JSON.parse(xhttp3.responseText);

            var doelstellingtable = document.getElementById("doelstellingtable");
            for (let i = 0; i < doelstellingen.length; i++) {
                var aantalDoelstellingen = aantalDoelstellingen + 1;
                var row = doelstellingtable.insertRow(i);
                row.id = "row" + aantalDoelstellingen;

                var cell1 = row.insertCell(0);
                var naam = doelstellingen[i].naam;

                cell1.innerHTML = naam;

            }
        }
    };
}
