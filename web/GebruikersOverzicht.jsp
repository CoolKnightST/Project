<%-- 
    Document   : Gebruiker
    Created on : 8-mrt-2018, 11:16:41
    Author     : Gil
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="js/nav.js"></script>
        <script src="js/table.js"></script>
        <link rel="stylesheet" href="css/theme.css">
        <title>Gebruikers overzicht</title>

        -->
    </head>

    <body>
        <%@include file="Bovenbalk.jsp" %>
        <section>
            <form action="GebruikersServlet">
                <br>
                <div class="table-container">
                    <div class="table-nav-header">

                        <table >
                            <tr >
                                <td style="background-color: rgba(0,0,0,0);" width="5%"> <img src='images/searchUser.png' > </td>

                                <!-- b�ta -->
                                <!-- <div style="position: relative;">
                                    <i name="gebruiker zoeken" class="material-icons" style="font-size: 50px;">person</i>
                                    <i name="gebruiker zoeken" class="material-icons" style="
                                       font-size: 25px; position: absolute; bottom: 11px; right: 0; color: #ec6e24; transform: scale(-1, 1);
                                       
                                       ">search</i>
                                </div>
                                -->
                                <td> <input type="text" name="zoekterm" value="" size="15"> </td>
                                <td> </td>
                                <td> </td>
                                <td> </td>
                                <td> </td>
                                <td  align="right"> <center> Totaal aantal gebruikers: <br><br> ${sessionScope.getoondeGebruikers}/${sessionScope.aantalRecords} </center></td>

                            <tr>
                        </table>
                    </div>
                    <br>
                    <table >
                        <thead>
                            <tr>
                                <th align="center" width="12%" onclick="sortTable(0)">Achternaam</a</th>
                                <th align="center" width="12%" onclick="sortTable(1)">Voornaam</a</th>
                                <th align="center" width="12%" onclick="sortTable(2)">Login</th>
                                <th align="center" width="9%" onclick="sortTable(3)">Rol</th>
                                <th align="center" width="9%" onclick="sortTable(4)">GebtDatum</th>
                                <th align="center" width="31%" onclick="sortTable(5)">E-mail</th>
                                    <c:if test="${sessionScope.currentSessionUser.rol == 'admin'}" >
                                    <th width="15%">Acties</th>
                                    </c:if>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${lijstGebruikers}" var="cursist">
                                <tr>
                                    <c:if test="${cursist.gebruikerID == sessionScope.editID}" >
                                        <td width="12%"> <input type="text" name="achternaam"  value="${cursist.achternaam}"> </td>
                                        <td width="12%"> <input type="text" name="voornaam" value="${cursist.voorNaam}"> </td>
                                        <td width="12%"> <input type="text" name="login"  value="${cursist.login}"> </td>
                                        <td> 
                                <select width="9%" name="rol" value="${cursist.rol}">
                                    <option value="admin">admin</option>
                                    <option value="leerkracht">leerkracht</option>
                                    <option value="cursist">cursist</option>
                                    <option value="secretariaat">secretariaat</option></td>
                                </select>
                                <td width="19%" align="center"> <input  style="text-align:right;" type="date" name="geboorteDatum" value="${cursist.geboorteDatum}" > </td>
                                <td width="26%"> <input type="text" name="email"  value="${cursist.email}"/> </td>
                                </c:if>

                            <c:if test="${cursist.gebruikerID != sessionScope.editID}" >
                                <td> ${cursist.achternaam} </td>
                                <td> ${cursist.voorNaam} </td>
                                <td> ${cursist.login} </td>
                                <td > ${cursist.rol} </td>
                                <td align="center"> <fmt:formatDate value = "${cursist.geboorteDatum}" pattern="dd-MM-yyyy" /> </td>
                                <td> ${cursist.email} </td>

                            </c:if>

                            <c:if test="${sessionScope.currentSessionUser.rol == 'admin'}" >
                                <td class="actie" width="10%">
                                    <c:if test="${cursist.gebruikerID != sessionScope.editID}" >
                                        <input type="image"  name="idEdit" value="${cursist.gebruikerID}" src='images/pencil.png'>
                                        <input type="image"  name="idDelete" value="${cursist.gebruikerID}" src='images/vuilbak.png'>
                                    </c:if>
                                    <c:if test="${cursist.gebruikerID == sessionScope.editID}" >
                                        <input type="image"  name="idSave" value="${cursist.gebruikerID}" src='images/green.png'>
                                        <input type="image"  name="idCancel" value="${cursist.gebruikerID}" src='images/cancel.png'>
                                    </c:if>
                                </td>
                            </c:if>
                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>
                    <br><br>
                    <div class="table-nav-footer">
                        <!-- b�ta -->
                        <!--
                        <div class="table-nav-icons">
                            <a name="Eerste"><i class="material-icons">skip_previous</i></a>
                            <a name="Vorige"><i class="material-icons">fast_rewind</i></a>
                            <a name="Volgende"><i class="material-icons">fast_forward</i></a>
                            <a name="Laatste"><i class="material-icons">skip_next</i></a>
                        </div>
                        <a name="gebruiker toevoegen"><i class="material-icons">person_add</i></a>
                        -->

                        <div>
                            <input type="image"  name="Eerste" value="Eerste" src='images/eerste.png'> 
                            <input type="image"  name="Vorige" value="Eerste" src='images/terug.png'>  
                            <input type="image"  name="Volgende" value="Volgende" src='images/volgende.png'> 
                            <input type="image"  name="Laatste" value="Laatste" src='images/laatste.png'>
                        </div>
                        <br>
                        <input type="image"  name="gebruiker toevoegen" value="gebruiker toevoegen" src='images/adduser.png'> 
                        <br><br>

                    </div>
                </div>
            </form>
        </section>
    </body>
</html>
