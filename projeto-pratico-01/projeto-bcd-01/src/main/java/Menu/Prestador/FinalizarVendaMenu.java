package Menu.Prestador;

import DAO.Prestador.FinalizarVendaDAO;
import DAO.Prestador.ListarVendasDAO;
import entities.Usuario;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Scanner;

public class FinalizarVendaMenu {

    private Scanner teclado;

    public FinalizarVendaMenu() { this.teclado = new Scanner(System.in); }

    public boolean finalizar(Usuario u) {
        String query = "SELECT c.id, u.nome as consumidor, u.endereco, c.total, c.status, c.formaPagamento, c.inicio, c.fim FROM Compra c " +
                "INNER JOIN Usuario u ON u.login = c.loginConsumidor WHERE c.loginPrestador = "
                + "\'" + u.getLogin() + "\' AND c.status = 'pendente'";

        return menu(query);
    }

    public boolean menu(String query) {
        FinalizarVendaDAO f = new FinalizarVendaDAO();
        ListarVendasDAO l = new ListarVendasDAO();
        String[] vendas = l.listarVendas(query);
        boolean aux = false; int op = -1; boolean voltar = false;

        if (vendas[0].equals("vazio")) {
            System.out.println("> Nenhum registro foi encontrado!");
            return true;
        }

        System.out.println("> Vendas pendentes:");

        // Tabela com todas as vendas
        System.out.println(vendas[0]);

        // Lista com idCompra - String para Inteiro
        String[] idCompra = vendas[1].split(";");
        int[] idCompra_integer = new int[idCompra.length];
        for (int i = 0; i < idCompra_integer.length; i++) {
            idCompra_integer[i] = Integer.parseInt(idCompra[i]);
        }

        // Escolhendo venda para finalizar
        do {
            boolean contem = false;
            System.out.println("> Digite o código da venda a ser finalizada:");

            try {
                op = teclado.nextInt();
            } catch (Exception e) {
                System.err.println("Erro. Informe um número inteiro.");
                op = -1;
                teclado.nextLine();// consumindo caracter extra NL/CR
            }

            for (int j : idCompra_integer) { // Verifica se op é um dos idCompra
                if (op == j) {
                    aux = true;
                    contem = true;
                    break;
                }
            }
            if (!contem) { System.out.println("> Código inválido!"); }
        } while(!aux);

        aux = false;
        int idVenda = op;
        op = -1;

        // Confirmando finalização
        System.out.println("> O que você deseja? ");
        do {
            System.out.println("1 - Finalizar venda de código " + idVenda);
            System.out.println("2 - Cancelar ação");

            try {
                op = teclado.nextInt();
            } catch (Exception e) {
                System.err.println("Erro. Informe um número inteiro.");
                op = -1;
                teclado.nextLine();// consumindo caracter extra NL/CR
            }

            if (op==1) {
                String date = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
                f.finalizar(idVenda, date); // Finalizando
                System.out.println("> Venda finalizada!");
                aux = true;
            } else if (op==2) {
                System.out.println("> Ação cancelada!");
                aux = true;
            } else {
                System.out.println("> Opção inválida!");
            }

        } while(!aux);

        return true;

    }


}
