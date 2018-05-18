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
        <script src="js/evaluatie.js"></script>
        <script src="js/nav.js"></script>
        <link rel="stylesheet" href="css/theme.css">
        <link rel="stylesheet" href="css/formulier.css">

        <title>EvaluatieFormulier</title>
    </head>

    <body>
        <%@include file="Bovenbalk.jsp" %>
        <form method="post" action="EvaluatieFormulierServlet?keuze=reset" >
            <section id="pagename">
                <h2> EvaluatieFormulier </h2>
            </section>
            <hr>

            <table>

                <tr>
                    <td width="20px"></td>

                    <td> <input type="date" id="datum" 
                                required style="font-size: 0.9rem"  > </td>

                    <td> <select name="Semester" id="Semester" onchange="checkDate()" style="max-width:175px;" >
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

                    <td width="75px">  
                        <select id="lesnr" onchange="genereerFormuliernaam()" hidden  style="max-width:75px;">

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

            <table>

                <tr bgcolor="#ceccca" height="50px" >
                    <td width="3%" />
                    <td width="20%"><b>Taak</td>   
                    <td width="3%" />
                    <td width="40%"><b>Doelstelling</b></td>  
                    <td width="3%" />
                    <td width="3%"><b>Kern</b></td>
                    <td width="3%" />
                    <td width="7%"><b>Score</b></td>
                    <td width="3%" />
                    <td width="30%"><b>Commentaar</b></td>
                    <td width="3%" />
                </tr>

                <br/>
                <%--lijn met invoer --%>

                <tr height="10px" />

                
                
                
                <tr>
                    <td />
                    <td><select name="taak" id="formTaken1" hidden  onchange="laadFormDoelstellingen()" ></select></td>
                    <td />

                    <td nowrap>
                        <label  id="formDoelstellingen1_1"  class="formDoelstellingen1" hidden disabled ><font size="6"></font></label>
                        <label id="formDoelstellingen1_2"  class="formDoelstellingen1" hidden disabled ></label>
                        <label id="formDoelstellingen1_3"  class="formDoelstellingen1" hidden disabled ></label>
                        <label  id="formDoelstellingen1_4"  class="formDoelstellingen1" hidden disabled ></label>
                        <label  id="formDoelstellingen1_5"  class="formDoelstellingen1" hidden disabled ></label>
                        <label  id="formDoelstellingen1_6"  class="formDoelstellingen1" hidden disabled ></label>
                        <label id="formDoelstellingen1_7"  class="formDoelstellingen1" hidden disabled ></label>
                        <label  id="formDoelstellingen1_8"  class="formDoelstellingen1" hidden disabled ></label>
                        <label id="formDoelstellingen1_9"  class="formDoelstellingen1" hidden disabled ></label>
                        <label  id="formDoelstellingen1_10"  class="formDoelstellingen1" hidden disabled ></label>
                    </td>
                    <td />

                    <td style="text-align: center">
                        <label  id="formkern1_1"  class="formkern1" hidden disabled ></label>
                        <label  id="formkern1_2"  class="formkern1" hidden disabled ></label>
                        <label  id="formkern1_3"  class="formkern1" hidden disabled ></label>
                        <label  id="formkern1_4"  class="formkern1" hidden disabled ></label>
                        <label  id="formkern1_5"  class="formkern1" hidden disabled ></label>
                        <label  id="formkern1_6"  class="formkern1" hidden disabled ></label>
                        <label  id="formkern1_7"  class="formkern1" hidden disabled ></label>
                        <label  id="formkern1_8"  class="formkern1" hidden disabled ></label>
                        <label  id="formkern1_9"  class="formkern1" hidden disabled ></label>
                        <label  id="formkern1_10"  class="formkern1" hidden disabled ></label>
                    <td />
    
                    <td>
                        <select style="font-size: 10pt" style="height: 1.1em;"  id="formScore1_1" class="formScore1" hidden ></select>
                        <select style="font-size: 10pt" style="height: 1.1em;"  id="formScore1_2" class="formScore1" hidden ></select>
                        <select style="font-size: 10pt" style="height: 1.1em;" id="formScore1_3" class="formScore1" hidden ></select>
                        <select style="font-size: 10pt" style="height: 1.1em;" id="formScore1_4" class="formScore1" hidden ></select>
                        <select style="font-size: 10pt" style="height: 1.1em;" id="formScore1_5" class="formScore1" hidden ></select>
                        <select style="font-size: 10pt" style="height: 1.1em;" id="formScore1_6" class="formScore1" hidden ></select>
                        <select style="font-size: 10pt" style="height: 1.1em;" id="formScore1_7" class="formScore1" hidden ></select>
                        <select style="font-size: 10pt" style="height: 1.1em;" id="formScore1_8" class="formScore1" hidden ></select>
                        <select style="font-size: 10pt" style="height: 1.1em;"  id="formScore1_9" class="formScore1" hidden ></select>
                        <select style="font-size: 10pt" style="height: 1.1em;"  id="formScore1_10" class="formScore1"hidden ></select>
                    </td>
                    <td/>

                    <td><textarea id="formCommentaar1" cols="45" rows="5" hidden >Commentaar...</textarea></td>
                    <td />
                </tr>
                
                <tr class="taakScore1" hidden height="20px" />
                <tr class="taakScore1" hidden> <td></td> <td></td> <td></td><td> <b>TaakScore: </b></td> </tr>
                <tr class="taakScore1" hidden height="20px" />
              

                
                
                
               
                <tr class="addLine" hidden>
                <td></td>
                <td><input type="button" width="25" value="+" id="addLine" onclick="laadLijn();" height="20" class="lijnButton" /></td>
                </tr>



            </table>

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

