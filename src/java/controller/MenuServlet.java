package controller;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Doelstelling;
import model.DoelstellingDAO;
import model.Gebruiker;
import model.GebruikerDAO;
import model.Instellingen;
import model.Module;
import model.ModuleDAO;
import model.Opleiding;
import model.OpleidingDAO;
import model.Score;
import model.ScoreDAO;
import model.Taak;
import model.TaakDAO;

/**
 *
 * @author Dirk
 */
public class MenuServlet extends HttpServlet {

    /**
     *
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
                 
            String actie = request.getParameter("actie");
            HttpSession session = request.getSession(true);
            session.setAttribute("zoekterm", null);
            
            switch (actie) {

                case "Overzicht cursisten":

                    //laden van cursisten uit database
                    GebruikerDAO gebruikerDAO = new GebruikerDAO();
                    ArrayList<Gebruiker> cursisten = gebruikerDAO.cursistenLaden();

                    session.setAttribute("lijstCursisten", cursisten);

                    response.sendRedirect("CursistenOverzicht.jsp");
                    break;
                    
                case "Overzicht gebruikers":

                    //laden van gebruikers uit database
                    gebruikerDAO = new GebruikerDAO();
                    ArrayList<Gebruiker> gebruikers = gebruikerDAO.gebruikersLaden(1);

                    int aantalGebruikers = gebruikerDAO.geefAantalGebruikers();
                    session.setAttribute("aantalRecords", aantalGebruikers);
                    session.setAttribute("bladzijde", 1);
                    int getoondeGebruikers = Instellingen.AANTAL_RECORDS_PER_PAGE;
                    if (getoondeGebruikers > aantalGebruikers) {
                        getoondeGebruikers = aantalGebruikers;
                    }
                    session.setAttribute("getoondeGebruikers", getoondeGebruikers);
                    session.setAttribute("lijstGebruikers", gebruikers);
                    response.sendRedirect("GebruikersOverzicht.jsp");
                    break;

                case "Overzicht doelstellingen":

                    DoelstellingDAO doelstellingDAO = new DoelstellingDAO();
                    ArrayList<Doelstelling> doelstellingen = doelstellingDAO.doelstellingenLaden(1,1);

                    int aantalDoelstellingen = doelstellingDAO.geefAantalDoelstellingen();
                    session.setAttribute("aantalRecords", aantalDoelstellingen);
                    session.setAttribute("bladzijde", 1);
                    int getoondeDoelstellingen = Instellingen.AANTAL_RECORDS_PER_PAGE;
                    if (getoondeDoelstellingen > aantalDoelstellingen) {
                        getoondeDoelstellingen = aantalDoelstellingen;
                    }
                    session.setAttribute("getoondeDoelstellingen", getoondeDoelstellingen);
                    session.setAttribute("lijstDoelstellingen", doelstellingen);
                    response.sendRedirect("DoelstellingenOverzicht.jsp");
                    break;

                case "Overzicht taken":
                    TaakDAO taakDAO = new TaakDAO();
                    ArrayList<Taak> taken = taakDAO.takenLaden(1);

                    int aantalTaken = taakDAO.geefAantalTaken();
                    session.setAttribute("aantalRecords", aantalTaken);
                    session.setAttribute("bladzijde", 1);
                    int getoondeTaken = Instellingen.AANTAL_RECORDS_PER_PAGE;
                    if (getoondeTaken > aantalTaken) {
                        getoondeTaken = aantalTaken;
                    }
                    session.setAttribute("getoondeTaken", getoondeTaken);
                    session.setAttribute("lijstTaken", taken);
                    response.sendRedirect("Taken.jsp");
                    break;

                case "Overzicht opleidingen":
                    OpleidingDAO opleidingDAO = new OpleidingDAO();
                    ArrayList<Opleiding> opleidingen = opleidingDAO.opleidingenLaden();
                    session.setAttribute("lijstOpleidingen", opleidingen);
                    response.sendRedirect("Opleiding.jsp");
                    break;
                case "Overzicht modules":

                    ModuleDAO moduleDAO = new ModuleDAO();
                    ArrayList<Module> modules = moduleDAO.modulesLaden(1);

                    int aantalModules = moduleDAO.geefAantalModules();
                    session.setAttribute("aantalRecords", aantalModules);
                    session.setAttribute("bladzijde", 1);
                    int getoondeModules = Instellingen.AANTAL_RECORDS_PER_PAGE;
                    if (getoondeModules > aantalModules) {
                        getoondeModules = aantalModules;
                    }
                    session.setAttribute("getoondeModules", getoondeModules);

                    session.setAttribute("lijstModules", modules);
                    response.sendRedirect("Module.jsp");
                    break;

                case "Overzicht scores":

                    //laden schooljaren uit database en in het geheugen plaatsen
                    //laden semester uit database en in het geheugen plaatsen
                    //laden modules uit database en in het geheugen plaatsen
                    response.sendRedirect("Score.jsp");
                    break;
                case "Evaluatieformulieren":
                    doelstellingDAO = new DoelstellingDAO();
                    doelstellingen = doelstellingDAO.doelstellingenLaden(1);
                    session.setAttribute("doelstellingen", doelstellingen);
                    response.sendRedirect("EvaluatieFormulier.jsp");
                    break;
                case "Rapport":
                    response.sendRedirect("Rapport.jsp");
                    break;

                case "Type score aanpassen":
                    //laden van de types scores
                    ScoreDAO scoreDAO = new ScoreDAO();
                    ArrayList<Score> typeScores = scoreDAO.typeScoreLaden();
                    session.setAttribute("lijstBeoordelingssoorten", typeScores);
                    response.sendRedirect("TypeScoreOverzicht.jsp");
                    break;
            }

        } catch (Throwable theException) {

        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
