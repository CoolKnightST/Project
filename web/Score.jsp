<%-- 
    Document   : Score
    Created on : 8-mrt-2018, 11:04:02
    Author     : Keanu Pestka
--%>

<%@ page language="java" 
         contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"
         import="model.Gebruiker"
         %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  

<!DOCTYPE html>
<html>    
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="js/nav.js"></script>
        <script src="js/table.js"></script>
        <link rel="stylesheet" href="css/theme.css">
        <link rel="stylesheet" href="css/gebruikers.css">
        <title>Score overzicht</title>
    </head>
    <body>
        <%@include file="Bovenbalk.jsp" %>
        
        <section id="pagename">
            <h2> Score overzicht </h2> 
        </section>       
        <section>
            <form action="ScoreServlet">
                <br>
                <div class="table-container">
                    <div class="table-nav-header">
                        <table>
                            <tr>
                                <td style="background-color: rgba(0,0,0,0);" width="5%"> <img src='images/searchUser.png' > </td>

                                <!-- béta -->
                                <!-- <div style="position: relative;">
                                    <i name="gebruiker zoeken" class="material-icons" style="font-size: 50px;">person</i>
                                    <i name="gebruiker zoeken" class="material-icons" style="
                                       font-size: 25px; position: absolute; bottom: 11px; right: 0; color: #ec6e24; transform: scale(-1, 1);
                                       
                                       ">search</i>
                                </div>
                                -->
                                <td> <input type="text" name="zoekterm" value="" size="10"> </td>
                                </td>
                            <tr>
                        </table>
                    </div>
                    <br><br>
                    <table>
                        <tr>
                           <td>
                                <select name="Schooljaar">
                                    <option value="schooljaar" selected disabled> Kies schooljaar... </option>
                                    <c:forEach items="${schooljaren}" var="schooljaar">
                                        <option value="schooljaar"> ${schooljaar.schooljaar} </option>   
                                    </c:forEach>                                 
                                </select>
                            </td>
                            <td width="10px"></td>
                            <td>
                                <select name="Opleiding">
                                    <option   value="opleiding" selected disabled> Kies opleiding... </option>
                                    <c:forEach items="${opleidingen}" var="opleiding">
                                        <option value="opleiding"> ${opleiding.naam} </option>  
                                    </c:forEach>                                      
                                </select>
                            </td>
                            <td width="10px"></td>
                            <td>
                                <select name="Module" value="module" selected disabled>
                                    <option   value="module" selected disabled> Kies module... </option>
                                    <c:forEach items="${modules}" var="module">
                                       <option value="module"> ${module.naam} </option> 
                                    </c:forEach> 
                                </select>
                            </td>
                            <td width="10px"></td>
                            <td>
                                <select name="Semester" >
                                    <option   value="semester" selected disabled> Kies semester... </option>
                                    <c:forEach items="${semesters}" var="semester">
                                        <option value="semester"> ${semester.semester} </option> 
                                    </c:forEach> 
                                </select>
                            </td>
                            <td width="10px"></td>
                            <td>
                                <select name="studiegebied">
                                    <option   value="studiegebied" selected disabled> Kies studiegebied... </option>
                                    <c:forEach items="${studiegebieden}" var="studiegebied">
                                        <option value="studiegebied"> ${studiegebied.naam} </option> 
                                    </c:forEach> 
                                </select>
                            </td>
                        </tr>
                    </table>
                    <br> <br>
                    <table class="datatable">
                        <thead> 
                            <tr>
                                <th onclick="sortTable(0)"><a>Taak</a></th>
                                <th onclick="sortTable(1)"><a>Beschrijving</a></th>
                                <th onclick="sortTable(2)"><a>Score</a></th>
                                <th onclick="sortTable(3)"><a>Module</a></th>
                                    <c:if test="${sessionScope.currentSessionUser.rol == 'admin'}" >
                                    <th>Actions</th>
                                    </c:if>
                                    <c:if test="${sessionScope.currentSessionUser.rol == 'leerkracht'}" >
                                    <th>Actions</th>
                                    </c:if>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <c:forEach items="${lijstScore}" var="score">
                                <tr>
                                    <c:if test="${score.scoreID == sessionScope.editID}" >
                                        <td> <input type="text" name="score" size="15" maxlength="25" value="${score}"> </td>
                                        <td> <input type="text" name="score_beschrijving" size="15" maxlength="25" value="${score.beschrijving}"> </td>
                                        </c:if>

                                    <c:if test="${score.scoreID != sessionScope.editID}" >
                                        <td> ${score} </td>
                                        <td> ${score_beschrijving} </td>
                                    </c:if>


                                    <c:if test="${sessionScope.currentSessionUser.rol == 'admin'}" >
                                        <td>
                                            <c:if test="${score.scoreID != sessionScope.editID}" >
                                                <input type="image"  name="scoreEdit" value="${score.scoreID}" src='images/pencil.png'>
                                                <input type="image"  name="scoreDelete" value="${score.scoreID}" src='images/vuilbak.png'>
                                            </c:if>
                                            <c:if test="${score.scoreID == sessionScope.editID}" >
                                                <input type="image"  name="scoreSave" value="${score.scoreID}" src='images/green.png'>
                                                <input type="image"  name="scoreCancel" value="${score.scoreID}" src='images/cancel.png'>
                                            </c:if>
                                        </td>
                                    </c:if>

                                    <c:if test="${sessionScope.currentSessionUser.rol == 'leerkracht'}" >
                                        <td>
                                            <c:if test="${score.scoreID != sessionScope.editID}" >
                                                <input type="image"  name="scoreEdit" value="${score.scoreID}" src='images/pencil.png'>
                                                <input type="image"  name="scoreDelete" value="${score.scoreID}" src='images/vuilbak.png'>
                                            </c:if>
                                            <c:if test="${score.scoreID == sessionScope.editID}" >
                                                <input type="image"  name="scoreSave" value="${score.scoreID}" src='images/green.png'>
                                                <input type="image"  name="scoreCancel" value="${score.scoreID}" src='images/cancel.png'>
                                            </c:if>
                                        </td>
                                    </c:if>

                                </tr>
                            </c:forEach>

                        </tbody>
                    </table>
                    <br><br>
                    <table>
                        <tr style="background-color:rgba(0, 0, 0, 0);"> 
                            <td style="text-align:center;">   
                                <div>
                                    <input type="image"  name="Eerste" value="Eerste" src='images/eerste.png'> 
                                    <input type="image"  name="Vorige" value="Eerste" src='images/terug.png'>  
                                    <input type="image"  name="Volgende" value="Volgende" src='images/volgende.png'> 
                                    <input type="image"  name="Laatste" value="Laatste" src='images/laatste.png'>
                                </div>
                            </td> 
                        </tr>
                    </table>
                </div>
            </form>    
        </section>
    </body>
</html>
