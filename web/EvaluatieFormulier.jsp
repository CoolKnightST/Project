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
            <br>
            <table>

                <tr bgcolor="#ceccca" height="50px" >
                    <td width="3%" />
                    <td width="30%"><b>Taak</td>   
                    <td width="3%" />
                    <td width="30%"><b>Doelstelling</b></td>  
                    <td width="3%" />
                    <td width="3%"><b>Kern</b></td>
                    <td width="3%" />
                    <td width="3%"><b>Score</b></td>
                    <td width="3%" />
                    <td width="30%"><b>Commentaar</b></td>
                    <td width="3%" />
                </tr>

                <tr height="20px" />

                <tr>

                    <td />
                   

                    <td><select name="taak" id="formTaken" hidden ></select></td>
                    <td />
                    
                     <td><select name="doelstelling"  id="formDoelstellingen" hidden >
                        </select></td>
                    <td />

                    <td><label name="kern" id="formKern" hidden disabled></label> </td>
                    <td />
                    <td><select name="score" id="formScore" hidden></select></td>
                    <td />
                    <td><textarea name="textarea" hidden id="formCommentaar"
                                  rows="3" cols="35">Vul hier je commentaar in...</textarea></td>
                    <td />
                    
                </tr>


            </table>
            <br>
            <br>
            <br>
            <br>

            <table class="doelstelling1" >

                <tr >
                    <td > <input type="submit"  value=" Formulier leeg maken " class="button"></td>
                    <td > <input type="submit"  value=" Print formulier  "  class="button"></td>
                    <td > <input type="submit"  value=" Bewaar formulier " class="button"></td>
                    <td > <input type="submit"  value=" Laad formulier " class="button"></td>
                </tr>

            </table>


        </p>
    </form>

</body>
</html>

