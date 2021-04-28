package Menu.Prestador;

import DAO.Prestador.ListarVendasDAO;
import entities.Usuario;

import java.util.Scanner;

public class ListarVendasMenu {

    private Scanner teclado;

    public ListarVendasMenu() { this.teclado = new Scanner(System.in); }

    public boolean finalizadas(Usuario u) {
        String query = "SELECT c.id, u.nome as consumidor, c.total, c.status, u.endereco, c.formaPagamento, c.inicio, c.fim FROM Compra c " +
                "INNER JOIN Usuario u ON u.login = c.loginConsumidor WHERE c.loginPrestador = " + "\'" + u.getLogin() + "\' AND c.status = 'concluida'";
        return menu(query, u);
    }

    public boolean pendentes(Usuario u) {
        String query = "SELECT c.id, u.nome as consumidor, c.total, c.status, u.endereco, c.formaPagamento, c.inicio, c.fim FROM Compra c " +
                "INNER JOIN Usuario u ON u.login = c.loginConsumidor WHERE c.loginPrestador = "
                + "\'" + u.getLogin() + "\' AND c.status = 'pendente'";

        return menu(query, u);
    }

    public boolean menu(String query, Usuario u) {
        ListarVendasDAO l = new ListarVendasDAO();
        String[] vendas = l.listarVendas(query);
        boolean aux = false; int op = -1; boolean voltar = false;

        if (vendas[0].equals("vazio")) {
            System.out.println("> Nenhum registro foi encontrado!");
            return true;
        }

        // Tabela com todas as vendas
        System.out.println(vendas[0]);

        // Lista com idCompra - String para Inteiro
        String[] idCompra = vendas[1].split(";");
        int[] idCompra_integer = new int[idCompra.length];
        for (int i = 0; i < idCompra_integer.length; i++) {
            idCompra_integer[i] = Integer.parseInt(idCompra[i]);
        }

        // Listando produtos de uma determinada compra
        do {
            System.out.println("> Selecione uma das opções:");
            System.out.println("1 - Listar produtos de uma venda");
            System.out.println("2 - Voltar ao menu principal");

            try {
                op = teclado.nextInt();
            } catch (Exception e) {
                System.err.println("Erro. Informe um número inteiro.");
                op = -1;
                teclado.nextLine();// consumindo caracter extra NL/CR
            }

            switch (op) {
                case 1:
                    do {
                        System.out.println("> Digite o código de uma venda:");
                        boolean contem = false;

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
                    } while (!aux);
                    System.out.println(l.produtosVenda(u.getLogin(), op));
                    aux = false;
                    break;
                case 2:
                    aux = true;
                    break;
                default:
                    System.out.println("> Opção inválida!");
            }

        } while (!aux);

        return true;
    }
}
