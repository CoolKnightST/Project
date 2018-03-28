package controller;

import java.io.IOException;

import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Score;
import model.ScoreDAO;

/**
 *  Deze klasse bevat de aanpassing van het scoretype.
 * @author gil-_
 */
@WebServlet(name = "ScoreServlet", urlPatterns = {"/ScoreServlet"})
public class ScoreServlet extends HttpServlet {
    
    ScoreDAO scoreDAO = new ScoreDAO();

    /**
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
        
        HttpSession session = request.getSession(true);
        ArrayList<Score> beoordelingssoorten = null;

        try {
            String actie = "";
            String editID = request.getParameter("idEdit");
            String cancelID = request.getParameter("idCancel");
            String saveID = request.getParameter("idSave");
            
             if (editID != null) {
                actie = "Edit typeScore";
            }
            if (cancelID != null) {
                actie = "Cancel typeScore";
            }
            if (saveID != null) {
                actie = "Save typeScore";
            }
            
            Score scoreType = new Score();

            switch (actie) {

                case "Edit typeScore":
                    session.setAttribute("editID", editID);
                    session.removeAttribute("deleteID");
                    session.removeAttribute("saveID");
                    
                    
                    scoreDAO.typeScoreAanpassen(Integer.parseInt(editID), scoreType);
                    beoordelingssoorten = scoreDAO.typeScoreLaden();
                    session.setAttribute("lijstBeoordelingssoorten", beoordelingssoorten);
                    response.sendRedirect("typeScoreOverzicht.jsp");
                    break;
                    
                case "Cancel typeScore":
                    session = request.getSession(true);
                    session.removeAttribute("editID");
                    session.removeAttribute("deleteID");
                    session.removeAttribute("saveID");
                    response.sendRedirect("typeScoreOverzicht.jsp");
                    break;

                case "Save typeScore":
                    session = request.getSession(true);
                    session.removeAttribute("editID");
                    session.removeAttribute("deleteID");
                    response.sendRedirect("typeScoreOverzicht.jsp");
                    break;
     
            }

        } catch (Throwable theException) {}
    }
        
}