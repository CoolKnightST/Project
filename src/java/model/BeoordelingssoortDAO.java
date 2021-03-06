package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 * BeoordelingssoortDAO(Beoordelingssoort Data Access Object) is een klasse voor
 * alle handelingen in de database betreffend beoordelingssoorten.
 *
 * @author Keanu en Gil en Ewout
 */

public class BeoordelingssoortDAO {
    
    // Methode om beoordelingssoorten toe te voegen.
    public void beoordelingssoortToevoegen(Beoordelingssoort beoordelingssoort) {
        Connection currentCon = null;
        PreparedStatement ps = null;

        String sql = "INSERT INTO beoordelingssoorten (naam, beschrijving, waarde) VALUES (?, ?, ?)";

        try {
            currentCon = ConnectionManager.getConnection();

            ps = currentCon.prepareStatement(sql);
            ps.setString(1, beoordelingssoort.getNaam());
            ps.setString(2, beoordelingssoort.getBeschrijving());
            ps.setDouble(3, beoordelingssoort.getWaarde());

            ps.executeQuery();
        } catch (SQLException ex) {
        } finally {
            Utilities.sluitVariabelen(ps, currentCon);
        }
    }
    
// Methode voor beoordelingssoorten toe te voegen.
    public void beoordelingssoortenToevoegen(ArrayList<Beoordelingssoort> beoordelingssoorten) {
        beoordelingssoorten.forEach((beoordelingssoort) -> this.beoordelingssoortToevoegen(beoordelingssoort)
        );
    }   
    
    // Methode om beoordelingssoorten aan te passen met dynamische query.
    public void beoordelingssoortAanpassen(Beoordelingssoort beoordelingssoort) {
        Connection currentCon = null;
        PreparedStatement ps = null;

        String sql = "UPDATE beoordelingssoorten SET naam = ?, beschrijving = ?, waarde = ? WHERE beoordelingssoortID = ?";

        try {
            currentCon = ConnectionManager.getConnection();

            ps = currentCon.prepareStatement(sql);
            ps.setString(1, beoordelingssoort.getNaam());
            ps.setString(2, beoordelingssoort.getBeschrijving());
            ps.setDouble(3, beoordelingssoort.getWaarde());
            ps.setInt(4, beoordelingssoort.getBeoordelingssoortID());

            ps.executeQuery();
        } catch (SQLException ex) {
        } finally {
            Utilities.sluitVariabelen(ps, currentCon);
        }
    }
    
    // Methode voor beoordelingssoorten aan te passen.
    public void beoordelingssoortenAanpassen(ArrayList<Beoordelingssoort> beoordelingssoorten) {
        beoordelingssoorten.forEach((beoordelingssoort) -> this.beoordelingssoortAanpassen(beoordelingssoort));
    }
    
    // Methode om beoordelingssoorten te verwijderen met dynamische query.
    public void beoordelingssoortVerwijderen(Beoordelingssoort beoordelingssoort) {
        Connection currentCon = null;
        PreparedStatement ps = null;

        String sql = "DELETE FROM beoordelingssoorten WHERE beoordelingssoorten.beoordelingssoortID = ?";

        try {
            currentCon = ConnectionManager.getConnection();

            ps = currentCon.prepareStatement(sql);
            ps.setInt(1, beoordelingssoort.getBeoordelingssoortID());

            ps.executeQuery();
        } catch (SQLException ex) {
        } finally {
            Utilities.sluitVariabelen(ps, currentCon);
        }
    }
    
    // Methode om beroordelingssoorten te verwijderen.
    public void beoordelingssoortVerwijderen(ArrayList<Beoordelingssoort> beoordelingssoorten) {
        beoordelingssoorten.forEach((beoordelingssoort) -> this.beoordelingssoortVerwijderen(beoordelingssoort));
    }
    
    // Methode om beoordelingssoorten aan te passen aan de hand van de beoordelingssoortnaam.
    public Beoordelingssoort beoordelingssoortLaden(String beoordelingssoortNaam) {
        Beoordelingssoort beoordelingssoort = new Beoordelingssoort();
        Connection currentCon = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "SELECT beoordelingssoorten.* FROM beoordelingssoorten WHERE beoordelingssoorten.naam = ?";

        try {
            currentCon = ConnectionManager.getConnection();

            ps = currentCon.prepareStatement(sql);
            ps.setString(1, beoordelingssoortNaam);

            rs = ps.executeQuery();
            while (rs.next()) {
                beoordelingssoort.setBeoordelingssoortID(rs.getInt("beoordelingssoortID"));
                beoordelingssoort.setNaam(rs.getString("naam"));
                beoordelingssoort.setBeschrijving(rs.getString("beschrijving"));
                beoordelingssoort.setWaarde(rs.getDouble("waarde"));
            }
        } catch (SQLException e) {
        } finally {
            Utilities.sluitVariabelen(ps, rs, currentCon);
        }
        return beoordelingssoort;
    }
    // Methode om beoordelingssoorten aan te passen aan de hand van de id.
    public Beoordelingssoort beoordelingssoortLaden(int beoordelingssoortID) {
        Beoordelingssoort beoordelingssoort = new Beoordelingssoort();
        Connection currentCon = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "SELECT beoordelingssoorten.* FROM beoordelingssoorten WHERE beoordelingssoorten.beoordelingssoortID = ?";

        try {
            currentCon = ConnectionManager.getConnection();

            ps = currentCon.prepareStatement(sql);
            ps.setInt(1, beoordelingssoortID);

            rs = ps.executeQuery();
            while (rs.next()) {
                beoordelingssoort.setBeoordelingssoortID(rs.getInt("beoordelingssoortID"));
                beoordelingssoort.setNaam(rs.getString("naam"));
                beoordelingssoort.setBeschrijving(rs.getString("beschrijving"));
                beoordelingssoort.setWaarde(rs.getDouble("waarde"));
            }
        } catch (SQLException e) {
        } finally {
            Utilities.sluitVariabelen(ps, rs, currentCon);
        }
        return beoordelingssoort;
    }
    // Methode om alle beoordelingssoorten te laden.
    public ArrayList<Beoordelingssoort> beoordelingssoortenLaden() {
        ArrayList<Beoordelingssoort> beoordelingssoorten = new ArrayList<>();
        Connection currentCon = null;
        Statement statement = null;
        ResultSet rs = null;

        String sql = "SELECT beoordelingssoorten.* FROM beoordelingssoorten";

        try {
            currentCon = ConnectionManager.getConnection();
            statement = currentCon.createStatement();

            rs = statement.executeQuery(sql);

            while (rs.next()) {
                Beoordelingssoort beoordelingssoort = new Beoordelingssoort();
                beoordelingssoort.setBeoordelingssoortID(rs.getInt("beoordelingssoortID"));
                beoordelingssoort.setNaam(rs.getString("naam"));
                beoordelingssoort.setBeschrijving(rs.getString("beschrijving"));
                beoordelingssoort.setWaarde(rs.getDouble("waarde"));
                beoordelingssoorten.add(beoordelingssoort);
            }
        } catch (SQLException e) {
        } finally {
            Utilities.sluitVariabelen(statement, rs, currentCon);
        }
        return beoordelingssoorten;
    }
    // Methode om een beoordeling een soortnaam te geven.
    public String geefBeoordelingssoortNaam(int beoordelingssoortID) {
        return beoordelingssoortLaden(beoordelingssoortID).getNaam();
    }
    // Methode om een beoordeelingssoort ID te verkrijgen.
    public int geefBeoordelingssoortID(String beoordelingssoortNaam) {
        return beoordelingssoortLaden(beoordelingssoortNaam).getBeoordelingssoortID();
    }
    // Methode om aantal opleidingen te tonen.
    public int geefAantalOpleidingen() {
        return beoordelingssoortenLaden().size();
    }
    
    // Methode om beoordelingssoorten aan te passen met dynamische query.
    public void beoordelingssoortAanpassen(int beoordelingssoortID, Beoordelingssoort beoordelingssoort) {
        Connection currentCon = null;
        ResultSet rs = null;
        PreparedStatement ps = null;

        String sql = "UPDATE beoordelingssoorten set beoordelingssoorten.naam=?,"
                + "beoordelingssoorten.beschrijving =?, beoordelingssoorten.waarde=? "
                + "WHERE beoordelingssoorten.beoordelingssoortID=?";

        try {
            currentCon = ConnectionManager.getConnection();
            ps = currentCon.prepareStatement(sql);

            ps.setString(1, beoordelingssoort.getNaam());
            ps.setString(2, beoordelingssoort.getBeschrijving());
            ps.setDouble(3, beoordelingssoort.getWaarde());
            ps.setInt(4, beoordelingssoortID);

            ps.executeUpdate();

        } catch (SQLException ex) {

        } finally {
            Utilities.sluitVariabelen(ps, rs, currentCon);
        }

    }
    
    // Methode om beoordelingssoorten aan te maken.
    public void beoordelingssoortAanmaken(Beoordelingssoort beoordelingssoort) {
        Connection currentCon = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "INSERT INTO beoordelingssoorten(naam, beschrijving, waarde) VALUES(?,?,?)";

        try {
            currentCon = ConnectionManager.getConnection();
            ps = currentCon.prepareStatement(sql);

            ps.setString(1, beoordelingssoort.getNaam());
            ps.setString(2, beoordelingssoort.getBeschrijving());
            ps.setDouble(3, beoordelingssoort.getWaarde());
            ps.executeUpdate();

        } catch (SQLException ex) {

        } finally {
            Utilities.sluitVariabelen(ps, rs, currentCon);

        }
    }
    
    // Methode om beoordelingssoort te verwijderen aan de hand van de id.
    public void beoordelingssoortVerwijderen(int beoordelingssoortID) {
        Connection currentCon = null;
        PreparedStatement ps = null;

        String sql
                = "DELETE from beoordelingssoorten WHERE beoordelingssoorten.beoordelingssoortID = ?";
        try {
            currentCon = ConnectionManager.getConnection();
            ps = currentCon.prepareStatement(sql);

            ps.setInt(1, beoordelingssoortID);
            ps.executeQuery();

        } catch (SQLException ex) {

        } finally {
            Utilities.sluitVariabelen(ps, currentCon);
        }
    }

}
