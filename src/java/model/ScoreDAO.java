package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * ScoreDAO(Score Data Access Object) is een klasse voor alle handelingen in de
 * database betreffende Scores.
 *
 * @author gil-_
 */
public class ScoreDAO {

    public ArrayList<Score> klassikaleScore(int schooljaarID, int semesterID, int moduleID) {
        ArrayList<Score> cursistenScores = new ArrayList<>();
        Connection currentCon = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "SELECT gebruikers.voornaam, gebruikers.achternaam, AVG(beoordelingssoorten.waarde) as score FROM evaluatieformulieren\n"
                + "INNER JOIN inschrijvingen ON evaluatieformulieren.inschrijvingID = inschrijvingen.inschrijvingID\n"
                + "INNER JOIN gebruikers ON inschrijvingen.gebruikerID = gebruikers.gebruikerID\n"
                + "INNER JOIN evalform_scores ON evaluatieformulieren.evaluatieformID = evalform_scores.evaluatieformID\n"
                + "INNER JOIN beoordelingssoorten ON evalform_scores.beoordelingssoortID = beoordelingssoorten.beoordelingssoortID\n"
                + "WHERE inschrijvingen.moduleID=? "
                + "AND inschrijvingen.semesterID=? "
                + "AND inschrijvingen.schooljaarID=? "
                + "GROUP BY gebruikers.gebruikerID;";

        try {
            //connectie met de database
            currentCon = ConnectionManager.getConnection();

            ps = currentCon.prepareStatement(sql);
            ps.setInt(1, moduleID);
            ps.setInt(2, semesterID);
            ps.setInt(3, schooljaarID);
            rs = ps.executeQuery();

            while (rs.next()) {
                Score score = new Score();
                score.setVoornaam(rs.getString("voornaam"));
                score.setAchternaam(rs.getString("achternaam"));
                score.setScore(rs.getDouble("score"));
                cursistenScores.add(score);

            }
        } catch (SQLException e) {

        } finally {
            Utilities.sluitVariabelen(ps, rs, currentCon);
        }
        return cursistenScores;
    }

    public ArrayList<Score> cursistScore(int moduleID, int gebruikerID) {
        ArrayList<Score> cursistScore = new ArrayList<>();
        Connection currentCon = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "SELECT doelstellingen.naam, avg(beoordelingssoorten.waarde) AS score FROM doelstellingen_taken\n" +
        "right JOIN doelstellingen ON doelstellingen_taken.doelstellingID = doelstellingen.doelstellingID\n" +
        "INNER JOIN taken ON doelstellingen_taken.taakID = taken.taakID\n" +
        "INNER JOIN modules_taken ON taken.taakID = modules_taken.taakID\n" +
        "INNER JOIN modules on modules_taken.moduleID = modules.moduleID\n" +
        "INNER JOIN evalform_scores ON taken.taakID = evalform_scores.taakID\n" +
        "INNER JOIN beoordelingssoorten ON evalform_scores.beoordelingssoortID = beoordelingssoorten.beoordelingssoortID\n" +
        "INNER JOIN evaluatieformulieren ON evalform_scores.evaluatieformID = evaluatieformulieren.evaluatieformID\n" +
        "INNER JOIN inschrijvingen ON evaluatieformulieren.inschrijvingID = inschrijvingen.inschrijvingID\n" +
        "INNER JOIN gebruikers ON inschrijvingen.gebruikerID = gebruikers.gebruikerID\n" +
        "WHERE gebruikers.gebruikerID = ? AND modules.moduleID = ?\n" +
        "GROUP BY doelstellingen.naam";

        try {
            //connectie met de database
            currentCon = ConnectionManager.getConnection();

            ps = currentCon.prepareStatement(sql);
            ps.setInt(1, gebruikerID);
            ps.setInt(2, moduleID);

            rs = ps.executeQuery();

            while (rs.next()) {
                Score score = new Score();
                score.setVoornaam(rs.getString("naam"));
                score.setScore(rs.getDouble("score"));
                cursistScore.add(score);

            }
        } catch (SQLException e) {

        } finally {
            Utilities.sluitVariabelen(ps, rs, currentCon);
        }
        return cursistScore;
    }
}
