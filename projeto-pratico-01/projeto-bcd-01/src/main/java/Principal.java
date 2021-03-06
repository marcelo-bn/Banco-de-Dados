import DAO.LoginDAO;
import Menu.Consumidor.CompraMenu;
import Menu.Consumidor.ListarComprasMenu;
import Menu.Prestador.FinalizarVendaMenu;
import Menu.Prestador.ListarVendasMenu;
import entities.Usuario;

import java.util.Scanner;

public class Principal {

    private final String[] CONSUMIDOR_principal = {
            "\n> Menu principal, selecione uma das opções: ",
            "1 - Comprar",
            "2 - Listar todas as compras",
            "3 - Listar compras pendentes",
            "4 - Sair do sistema"
    };

    private final String[] PRESTADOR_principal = {
            "\n> Menu principal, selecione uma das opções: ",
            "1 - Listar vendas finalizadas",
            "2 - Listar vendas pendentes",
            "3 - Finalizar venda",
            "4 - Sair do sistema"
    };

    private Scanner teclado;

    public Principal() {
        this.teclado = new Scanner(System.in);
    }

    public static void main(String[] args) {

        Principal p = new Principal();
        int op = -1;

        // Objeto entities.Usuario
        Usuario u = p.login();
        System.out.print("\n..:: Olá, " + u.getNome() + "! ::..");

        // Verificando tipo do usuário
        if (u.getTipo().equals("consumidor")) {
            CompraMenu compraMenu = new CompraMenu();
            ListarComprasMenu listarComprasMenu = new ListarComprasMenu();

           do {
                op = p.menuGeral(p.CONSUMIDOR_principal);

                switch (op) {
                    case 1:
                        compraMenu.consumidorCompra(u);
                        break;
                    case 2:
                        listarComprasMenu.geral(u);
                        break;
                    case 3:
                        listarComprasMenu.pendentes(u);
                        break;
                    case 4:
                        break;
                    default:
                        System.out.println("> Opção inválida!");
                        break;
                }
           }  while (op!=4);

        } else {
            ListarVendasMenu v = new ListarVendasMenu();
            FinalizarVendaMenu f = new FinalizarVendaMenu();

            do {
                op = p.menuGeral(p.PRESTADOR_principal);

                switch (op) {
                    case 1:
                        v.finalizadas(u);
                        break;
                    case 2:
                        v.pendentes(u);
                        break;
                    case 3:
                        f.finalizar(u);
                        break;
                    case 4:
                        break;
                    default:
                        System.out.println("> Opção inválida!");
                        break;
                }

            } while(op!=4);

        }

        System.out.println("> Saindo...");
    }

    /**
     * Apresenta menu de opções
     * @param menuComOpcoes
     * @return
     */
    private int menuGeral(String[] menuComOpcoes) {
        int opcao = -1;
        if (menuComOpcoes != null) {
            for (String linha : menuComOpcoes) {
                System.out.println(linha);
            }
            System.out.print("Entre com uma opção: ");
            try {
                opcao = teclado.nextInt();
            } catch (Exception e) {
                System.err.println("Erro. Informe um número inteiro.");
                opcao = -1;
                teclado.nextLine();// consumindo caracter extra NL/CR
            }

        }
        return opcao;
    }

    /**
     * Realiza o procedimento de login no sistema
     * @return entities.Usuario
     */
    private Usuario login() {
        LoginDAO app = new LoginDAO();
        Usuario usuario = new Usuario();
        boolean ok = true;

        System.out.println("\n..:: Sistema de Serviços e Produtos ::..");

        while (ok) {
            System.out.println("> Insira seu login: ");
            String nome = this.teclado.nextLine();
            String[] user = app.verificaLogin(nome);

            if (user[0].equals("error")) {
                System.out.println("> Login inválido");
            } else {
                usuario = app.infoLogin(user);
                ok = false;
            }
        }

        return usuario;
    }

}
