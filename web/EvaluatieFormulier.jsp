<%-- 
    Document   : EvaluatieFormulier
    Created on : 8-mrt-2018, 20:19:21
    Author     : Dirk
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="js/nav.js"></script>
        <script src="js/table.js"></script>
        <script src="js/evaluatie.js"></script>
        <link rel="stylesheet" href="css/theme.css">
        <link rel="stylesheet" href="css/formulier.css">

        <title>EvaluatieFormulier</title>
    </head>

    <body>
        <%@include file="Bovenbalk.jsp" %>
        <form method="post" action="EvaluatieFormulierServlet" >
            <section id="pagename">
                <h2> EvaluatieFormulier </h2>
            </section>
            <hr>

            <table>

                <tr>
                    <td width="70px"></td>

                    <td> <input type="date" id="datum" 
                                required style="font-size: 0.9rem"  > </td>

                    <td> <select name="Semester" id="Semester" onchange="checkDate()" style="max-width:140px;" >
                            <option selected > Semester... </option>
                            <c:forEach items="${semesters}" var="semester">                  
                                <option> ${semester.semester} </option>                     
                            </c:forEach>

                        </select> </td>

                    <td width="10px"></td>

                    <td>
                        <select name="studiegebied" id="studiegebied" hidden  onchange="laadOpleidingen()"  style="max-width:170px;">
                            <option selected disabled> Studiegebied... </option>
                            <c:forEach items="${studiegebieden}" var="studiegebied">                  
                                <option> ${studiegebied.naam} </option>                     
                            </c:forEach>
                            <option> Voeg studiegebied toe... </option>

                        </select> 
                    </td>


                    <td width="10px"></td>

                    <td><select id="opleidingen" onchange="laadModules()" hidden  style="max-width:170px;">

                        </select></TD>

                    <td width="10px"></td>

                    <td>  <select id="modules" hidden onchange="laadCursisten()" style="max-width:170px;">

                        </select> </td>

                    <td width="10px"></td>


                    <td>  <select id="cursisten" onchange="laadLesnr()" hidden  style="max-width:170px;">

                        </select> </td>

                    <td width="10px"></td>  

                    <td>  <select id="lesnr" onchange="genereerFormuliernaam()" hidden  style="max-width:170px;">

                            <option selected disabled> Lesnr... </option>
                            <c:forEach items="${lesnrs}" var="lesnr">                  
                                <option> ${lesnr.lesnr} </option>                     
                            </c:forEach>
                            <option> Voeg lesnr toe... </option>

                        </select> </td> 



                    <td width="20px"></td>

                    <td>  <label id="formulierNaam"  hidden  style="max-width:120px;">
                        </label> </td>

                    <td width="10px"></td>
                </tr>
            </table>
            <br>
            <table class="doelstelling2">
                <thead>

                    <tr class="lijn" bgcolor="#AAAA00" height="50" >
                        <th  ><b>Doelstellingen</th>                      
                        <th ><b>Kern</b></th>               
                        <th><b>Taken</b></th>
                        <th ><b>Score</b></th>
                        <th ><b>Waarde</b></th>
                        <th ><b>Commentaar</b></th>
                    </tr>
                </thead>


                <tbody>

                    <tr class="formrow">
                        <td><select name="doelstelling"  id="doelstellingen" hidden >
                        </select></td>

                        
                          <td><select name="kern" hidden >
                            <input type="checkbox" name="kerncheck"><br>
                            </select>
                    
                        <td><select name="taak" hidden >

                            </select>
                        <td class="center">
                            <select name="score" hidden>

                            </select></td>
                      
                        <td><textarea name="textarea" hidden
                                      rows="3" cols="35">Vul hier je commentaar in...</textarea></td>
                    </tr>
            </table>
            <br>

            <table class="doelstelling1">

                <tr >

                    <td align="center" >Totale Score: 80% </td>
                </tr>

            </table>
            <br>

            <table class="doelstelling1" >

                <tr >
                    <td > <input type="submit"  value=" Maak Formulier leeg " class="button"></td>
                    <td > <input type="submit"  value=" Print Formulier "  class="button"></td>
                    <td > <input type="submit"  value=" Bewaar Formulier " class="button"></td>
                    <td > <input type="submit"  value=" Laad Formulier " class="button"></td>
                </tr>

            </table>

            <h2 id="demo"> </h2>
        </p>
    </form>

</body>
</html>

