function laadOpleidingen() {

    if (document.getElementById("studiegebied").selectedIndex === 0) {
        return;
    }
    var keuze = document.getElementById('studiegebied').value;
    var xhttp = new XMLHttpRequest();

    if (window.XMLHttpRequest) {
        // code voor moderne browsers
        xhttp = new XMLHttpRequest();
    } else {
        // code voor oude IE browsers
        xhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }

    //open(method,url,async)
    xhttp.open("POST", "ScoreServlet?studiegebied=" + keuze, true);
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

            let dropdown = document.getElementById('opleidingen');
            dropdown.hidden = false;
            dropdown.length = 0;

            let defaultOption = document.createElement('option');
            defaultOption.text = 'Opleiding...';
            defaultOption.disabled = true;
            dropdown.add(defaultOption);
            dropdown.selectedIndex = 0;

            const data = JSON.parse(xhttp.responseText);
            let option;
            for (let i = 0; i < data.length; i++) {
                option = document.createElement('option');
                option.text = data[i].naam;
                dropdown.add(option);
            }
            option.text = "Voeg Opleiding toe...";
            dropdown.add(option);
        }
    };
}

function laadStudiegebieden() {

    var keuze = document.getElementById('studiegebieden').value;
    var xhttp = new XMLHttpRequest();

    if (window.XMLHttpRequest) {
        // code voor moderne browsers
        xhttp = new XMLHttpRequest();
    } else {
        // code voor oude IE browsers
        xhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }

    //open(method,url,async)
    xhttp.open("POST", "ScoreServlet?studiegebieden=" + keuze, true);
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

            let dropdown = document.getElementById('studiegebieden');
            dropdown.length = 0;

            let defaultOption = document.createElement('option');
            defaultOption.text = 'Kies studiegebieden...';

            dropdown.add(defaultOption);
            dropdown.selectedIndex = 0;

            const data = JSON.parse(xhttp.responseText);
            let option;
            for (let i = 0; i < data.length; i++) {
                option = document.createElement('option');
                option.text = data[i].naam;
                dropdown.add(option);
            }
        }
    };
}

function laadModules() {

    if (document.getElementById("opleidingen").selectedIndex === 0) {
        return;
    }
    var keuze = document.getElementById('opleidingen').value;
    var xhttp = new XMLHttpRequest();

    if (window.XMLHttpRequest) {
        // code voor moderne browsers
        xhttp = new XMLHttpRequest();
    } else {
        // code voor oude IE browsers
        xhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }

    //open(method,url,async)
    xhttp.open("POST", "ScoreServlet?opleiding=" + keuze, true);
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

            let dropdown = document.getElementById('modules');
            dropdown.hidden = false;
            dropdown.length = 0;

            let defaultOption = document.createElement('option');
            defaultOption.text = 'Module...';
            defaultOption.disabled = true;
            dropdown.add(defaultOption);
            dropdown.selectedIndex = 0;

            const data = JSON.parse(xhttp.responseText);
            let option;
            for (let i = 0; i < data.length; i++) {
                option = document.createElement('option');
                option.text = data[i].naam;
                dropdown.add(option);
            }
            option.text = "Voeg Module toe...";
            dropdown.add(option);
        }
    };
}

function checkJaar() {

    var schooljaar = document.getElementById("schooljaar").value;

    if (schooljaar === '') {
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

function laadCursistenScores() {
    if (document.getElementById("modules").selectedIndex === 0) {
        return;
    }
    var keuze = document.getElementById('modules').value;
    var xhttp = new XMLHttpRequest();

    if (window.XMLHttpRequest) {
        // code voor moderne browsers
        xhttp = new XMLHttpRequest();
    } else {
        // code voor oude IE browsers
        xhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }

    var schooljaar = document.getElementById("schooljaar").value;
    var semester = document.getElementById("semester").value;


    //open(method,url,async)
    xhttp.open("POST", "ScoreServlet?module=" + keuze + "&schooljaar=" + schooljaar + "&semester=" + semester, true);
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

            let achternaam = document.getElementById('achternaam');
            let voornaam = document.getElementById('voornaam');
            let score = document.getElementById('score');
            
            
                                
            const data = JSON.parse(xhttp.responseText);

            for (let teller = 0; teller < data.length; teller++) {
                var rij = document.getElementById("rij" + teller);
               rij.cells[0].innerHTML = data[teller].achternaam;
               rij.cells[1].innerHTML= data[teller].voornaam;
               rij.cells[2].innerHTML = data[teller].score;                
            }

        }
    };
    //als een keuze wordt gewijzigd, ledig dan de daaropvolgende dropdowns
function resetDropdowns(naam) {

    formulierLeegMaken();
    let dropdowns = document.getElementsByClassName('drop');
    var idDropDown;
    for (let i = 0; i < dropdowns.length; i++) {
        idDropDown = dropdowns[i].id;
        //reset dropdowns na studiegebied
        switch (naam) {
            case 'studiegebied':

                if (idDropDown === 'opleiding') {
                    dropdowns[i].selectedIndex = 0;
                    dropdowns[i].style = "background: #efc4c4";
                    ledigDropDown(dropdowns[i]);
                }
                if (idDropDown === 'module') {
                    dropdowns[i].selectedIndex = 0;
                    dropdowns[i].style = "background: #efc4c4";
                    ledigDropDown(dropdowns[i]);
                }
                break;
            case 'opleidingen':
                if (idDropDown === 'module') {
                    dropdowns[i].selectedIndex = 0;
                    dropdowns[i].style = "background: #efc4c4";
                    ledigDropDown(dropdowns[i]);
                }
                break;
        }
    }
}
}