package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author Keanu hier komen sql query's 
 */
public class ScoreDAO {
    
    //laadt alle verschillende type scores.
    public ArrayList<Score> typeScoreLaden() {
        ArrayList<Score> typeScores = new ArrayList<>();
        Connection currentCon = null;
        Statement statement = null;
        ResultSet rs = null;
        
        try {
            currentCon = ConnectionManager.getConnection();
            String sql = "SELECT beoordelingssoortID, naam, beschrijving, waarde FROM beoordelingssoorten";
            statement = currentCon.createStatement();
            rs = statement.executeQuery(sql);

            while (rs.next()) {
                Score typeScore = new Score();
                typeScore.setBeoordelingssoortID(rs.getInt("beoordelingssoortID"));
                typeScore.setNaam(rs.getString("naam"));
                typeScore.setBeschrijving(rs.getString("beschrijving"));
                typeScore.setWaarde(rs.getInt("waarde"));
                
                typeScores.add(typeScore);
            }
        } catch (SQLException e) {

        } finally {
            sluitVariabelen(rs, statement, null, currentCon);

        }
        return typeScores;
    }
    
    // methode die het type score aanpast
    public void typeScoreAanpassen(int beoordelingssoortID, Score typeScore) {
        Connection currentCon = null;
        PreparedStatement ps = null;

        String sql = "UPDATE beoordelingssoorten SET beoordelingssoorten.naam = ? , beoordelingssoorten.beschrijving = ? ,"
                    + " beoordelingssoorten.waarde = ? WHERE beoordelingssoorten.beoordelingssoortID = ?";

        try {
            currentCon = ConnectionManager.getConnection();
            ps = currentCon.prepareStatement(sql);
            
            ps.setString(1, typeScore.getNaam());
            ps.setString(2, typeScore.getBeschrijving());
            ps.setInt(3, typeScore.getWaarde());
            ps.setInt(4, beoordelingssoortID);
            ps.executeUpdate();

        } catch (SQLException ex) {

        } finally {            
            sluitVariabelen(null, null, ps, currentCon);
        }

    }
    
    // methode die een type score verwijdert
    public void typeScoreVerwijderen(int beoordelingssoortID) {
        Connection currentCon = null;
        PreparedStatement ps = null;

        String sql = "DELETE FROM beoordelingssoorten WHERE beoordelingssoorten.beoordelingssoortID = ?";

        try {
            currentCon = ConnectionManager.getConnection();
            ps = currentCon.prepareStatement(sql);
            
            ps.setInt(1, beoordelingssoortID);
            ps.executeUpdate();
        
        } catch (SQLException ex) {

        } finally {
            sluitVariabelen(null, null, ps, currentCon);
        }

    }
    
    // methode die een type score toevoegt
    public void typeScoreToevoegen(Score typeScore) {
        Connection currentCon = null;        
        PreparedStatement ps = null;

        String sql = "INSERT INTO beoordelingssoorten(naam, beschrijving, waarde) VALUES(?,?,?)";

        try {
            currentCon = ConnectionManager.getConnection();
            ps = currentCon.prepareStatement(sql);
            
            ps.setString(1, typeScore.getNaam());
            ps.setString(2, typeScore.getBeschrijving());
            ps.setInt(3, typeScore.getWaarde());
            ps.executeUpdate();
        
        } catch (SQLException ex) {

        } finally {
            sluitVariabelen(null, null, ps, currentCon);
        }
    }
 
    public void scoreAanmaken(Gebruiker gebruiker) {
        
    }

    public void scoreVerwijderen(Gebruiker gebruiker) {
        
    }
    
    /* Sluit enkele variabelen en zet ze op null */
    private void sluitVariabelen(ResultSet rs, Statement statement, PreparedStatement ps, Connection currentCon) {
        if (rs != null) {
            try {
                rs.close();
            } catch (Exception e) {
            }
            try {
                rs = null;
            } catch (Exception e) {
            }
        }
        if (statement != null) {
            try {
                statement.close();
            } catch (Exception e) {
            }
            try {
                statement = null;
            } catch (Exception e) {
            }
        }
        if (ps != null) {
            try {
                ps.close();
            } catch (Exception e) {
            }
            try {
                ps = null;
            } catch (Exception e) {
            }
        }
        if (currentCon != null) {
            try {
                currentCon.close();
            } catch (Exception e) {
            }
            try {
                currentCon = null;
            } catch (Exception e) {
            }
        }
    }
}
