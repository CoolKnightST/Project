<%-- 
    Document   : module
    Created on : 8-mrt-2018, 11:37:32
    Author     : Davino
--%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %> 

<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="js/nav.js"></script>
             <script src="js/table.js"></script>
        <link rel="stylesheet" href="css/theme.css">
         <link rel="stylesheet" href="css/Module.css">
        <title>Modules</title>
    </head>
    
    <body>
        <%@include file="Bovenbalk.jsp" %>
        <section>
            <form action="ModuleServlet">
                <h2>Modules</h2><br>
                <div class="table-container">
                
                       <table>
                        <tr style="background-color:rgba(0, 0, 0, 0);">
                            <td  style="text-align:center;">   
                                <input type="image"  na me="Module zoeken" value="module zoeken" src='images/searchUser.png'> 
                                <input  type="text" style="height:30px;font-size:14pt;" name="zoekterm" size="25" maxlength="25" value=""> 
                                 <td  align="right"> <center> Totaal aantal modules: <br><br> ${sessionScope.getoondeModules}/${sessionScope.aantalRecords} </center></td>
                            </td>
                        </tr>
                    </table>
              
          <table class="datatable">
                        <thead>
                            <tr>
                            
                                <th onclick="sortTable(0)"><a>naam</a></th>
                                    <c:if test="${sessionScope.currentSessionUser.rol == 'admin'}" >
                                    <th>Actions</th>
                                    </c:if>

                            </tr>
                        </thead>
                        <tbody>
                             <c:forEach items="${lijstModules}" var="module">
                                <tr>
                                    <c:if test="${module.moduleID == sessionScope.editID}" >
                          
                                        <td> <input type="text" name="modulenaam" size="15" maxlength="25" value="${module.naam}"> </td>
                                        </c:if>

                                    <c:if test="${module.moduleID != sessionScope.editID}" >
                                   
                                        <td> ${module.naam} </td>
                                    </c:if>

                                    <c:if test="${sessionScope.currentSessionUser.rol == 'admin'}" >
                                        <td>
                                            <c:if test="${module.moduleID != sessionScope.editID}" >
                                                <input type="image"  name="idEdit" value="${module.moduleID}" src='images/pencil.png'>
                                                <input type="image"  name="idDelete" value="${module.moduleID}" src='images/vuilbak.png'>
                                            </c:if>
                                            <c:if test="${module.moduleID == sessionScope.editID}" >
                                                <input type="image"  name="idSave" value="${module.moduleID}" src='images/green.png'>
                                                <input type="image"  name="idCancel" value="${module.moduleID}" src='images/cancel.png'>
                                            </c:if>
                                        </td>
                                    </c:if>
                         </c:forEach>
                        </tbody>
                    </table>
                 <table>
                        <tr style="background-color:rgba(0, 0, 0, 0);"> 
                            <td style="text-align:center;">   
                                <input type="image"  name="Eerste" value="Eerste 10" src='images/eerste.png'> 
                                <input type="image"  name="Vorige" value="Eerste 10" src='images/terug.png'>  
                                <input type="image"  name="Volgende" value="Volgende 10" src='images/volgende.png'> 
                                <input type="image"  name="Laatste" value="Laatste 10" src='images/laatste.png'> 
                            </td> 
                        </tr>
                        <tr> 
                            <td colspan="3" style="text-align:center;">   
                                <input type="image"  name="Module Toevoegen" value="Module Toevoegen" src='images/adduser.png'> 
                            </td> 
                        </tr>
                    </table>
                </div> 
            </form>
        </section>
    </body>
</html>