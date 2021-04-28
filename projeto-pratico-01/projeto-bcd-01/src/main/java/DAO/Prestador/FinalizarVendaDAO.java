package DAO.Prestador;

import db.ConnectionFactory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class FinalizarVendaDAO {

    public int finalizar(int idVenda, String date) {

        String query = "UPDATE Compra SET status = 'concluida', fim = ? WHERE id = ?";
        int linhasAlteradas = 0;

        try (Connection conexao = ConnectionFactory.getDBConnection();
             PreparedStatement stmt = conexao.prepareStatement(query)) {

            stmt.setString(1, date);
            stmt.setInt(2, idVenda);

            linhasAlteradas = stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return linhasAlteradas;

    }

}
