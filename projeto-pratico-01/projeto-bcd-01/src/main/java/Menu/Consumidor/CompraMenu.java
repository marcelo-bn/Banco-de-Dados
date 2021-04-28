package Menu.Consumidor;

import DAO.Consumidor.CompraDAO;
import entities.Usuario;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Scanner;

/**
 * Realiza os procedimentos de compra do Consumidor
 */
public class CompraMenu {

    private Scanner teclado;

    public CompraMenu() { this.teclado = new Scanner(System.in); }

    public boolean consumidorCompra(Usuario usuario) {
        CompraDAO compra = new CompraDAO();
        List<String> categorias;
        categorias = compra.listaCategorias();
        boolean aux = false;
        boolean voltar = false;
        int op = -1;

        /**
         * Escolhendo categoria
         */
        System.out.println("\n> Escolha uma das categorias");
        do {
            for (int i = 0; i < categorias.size(); i++) {
                System.out.println((i+1) + " - " + categorias.get(i));
            }
            System.out.println((categorias.size()+1) + " - Voltar ao menu principal");

            try {
                op = teclado.nextInt();
            } catch (Exception e) {
                System.err.println("Erro. Informe um número inteiro.");
                op = -1;
                teclado.nextLine();// consumindo caracter extra NL/CR
            }

            if ((op > categorias.size()+1) || (op < 1)) {
                System.out.println("> Escolha inválida!");
            }
            else if (op == categorias.size()+1) {
                System.out.println("> Compra cancelada!");
                voltar = true;
                break;
            }
            else {
                aux = true;
            }
        } while(!aux);

        // Verifica se deve cancelar a compra
        if (voltar) {
            return false;
        }

        /**
         * Escolhendo prestador
         */
        List<List<String>> prestadores;
        prestadores = compra.listaPrestadores(categorias.get(op-1));
        System.out.println("\n> Vendedores da categoria ..:: " + categorias.get(op-1) + " ::..");
        aux = false; op = -1;
        do {
            for (int i = 0; i < prestadores.size(); i++) {
                System.out.println((i+1) + " | " + prestadores.get(i).get(1) + " - " + prestadores.get(i).get(2));
            }
            System.out.println((prestadores.size()+1) + " - Voltar ao menu principal");

            try {
                op = teclado.nextInt();
            } catch (Exception e) {
                System.err.println("Erro. Informe um número inteiro.");
                op = -1;
                teclado.nextLine();// consumindo caracter extra NL/CR
            }

            if ((op > prestadores.size()+1) || (op < 1)) {
                System.out.println("> Escolha inválida!");
            }
            else if (op == prestadores.size()+1) {
                System.out.println("> Compra cancelada!");
                voltar = true;
                break;
            }
            else {
                aux = true;
            }
        } while(!aux);

        // Verifica se deve cancelar a compra
        if (voltar) {
            return false;
        }

        /**
         * Escolhendo produtos
         */
        String prestadorEscolhidoLogin = prestadores.get(op-1).get(0);
        String prestadorEscolhidoNome = prestadores.get(op-1).get(1);
        System.out.println("\n> Vendedor escolhido ..:: " + prestadorEscolhidoNome + " ::..");
        System.out.println("> Descrição do vendedor: " + compra.desGeralPrestador(prestadorEscolhidoLogin));

        List<List<String>> listaProdutos;
        listaProdutos = compra.listarProdutos(prestadorEscolhidoNome);

        System.out.println("> Produtos disponíveis:");
        aux = false; op = -1;

        List<Integer> produtosEscolhasId = new ArrayList<>();

        for (int i = 0; i < listaProdutos.size(); i++) {
            System.out.println((i+1) + " | " + listaProdutos.get(i).get(1) + " | R$ " + listaProdutos.get(i).get(2));
        }
        System.out.println((listaProdutos.size()+1) + " - Finalizar compra");
        System.out.println((listaProdutos.size()+2) + " - Voltar ao menu principal");
        System.out.println("> Digite os produtos desejados ou alguma das opções:");
        int aux_qt = 0;
        do {

            try {
                op = teclado.nextInt();
            } catch (Exception e) {
                System.err.println("Erro. Informe um número inteiro.");
                op = -1;
                teclado.nextLine();// consumindo caracter extra NL/CR
            }

            if ((op > listaProdutos.size()+2) || (op < 0)) {
                System.out.println("> Escolha inválida!");
            }
            else if (op == listaProdutos.size()+2) { // Voltar menu
                System.out.println("> Compra cancelada!");
                voltar = true;
                break;
            }
            else if (op == listaProdutos.size()+1) { // Finalizar compra
                if (aux_qt>0){
                    aux = true;
                } else {
                    System.out.println("> Escolha ao menos 1 produto!");
                }
            } else {
                produtosEscolhasId.add(Integer.parseInt(listaProdutos.get(op-1).get(0))); // idProduto
                aux_qt++;
            }

        } while(!aux);

        // Verifica se deve cancelar a compra
        if (voltar) {
            return false;
        }

        /**
         * Verificando quantidade de produtos
         */
        Collections.sort(produtosEscolhasId); // Ordenando lista de idProduto
        List<String> quantidadeProdutos = new ArrayList<>(); // Lista de produtos e suas quantidades

        String sqt;
        int anterior = produtosEscolhasId.get(0);
        sqt = anterior + "-" + Collections.frequency(produtosEscolhasId, anterior);
        quantidadeProdutos.add(sqt);

        for (int i = 1; i < produtosEscolhasId.size(); i++) {
            int atual = produtosEscolhasId.get(i);
            if (anterior != atual) {
                sqt = atual + "-" + Collections.frequency(produtosEscolhasId, atual);
                quantidadeProdutos.add(sqt);
                anterior = atual;
            }
        }

        /**
         * Visualizando compra
         */
        double total = 0;
        
        System.out.println("> Produtos escolhidos:");
        for (int i = 0; i < quantidadeProdutos.size(); i++) {
            // Conferindo id e quantidade de cada produto
            String[] p = quantidadeProdutos.get(i).split("-");
            int id = Integer.parseInt(p[0]);
            int qt = Integer.parseInt(p[1]);

            // Consultando nome e preço do produto pelo id
            String[] info = compra.nomePrecoProduto(id);

            System.out.println(info[0] + " - "+ qt + "x R$ " + Double.parseDouble(info[1]));
            total += qt * Double.parseDouble(info[1]);
        }
        total = Math.floor(total * 100) / 100;
        System.out.println("> Valor total: R$ " + total);

        /**
         * Forma de pagamento
         */
        aux = false; op = -1;
        String formaPagamento = "";
        if (usuario.getNumCartao() != null) {
            System.out.println("> Forma de pagamento: ");
            do {
                System.out.println("1 - Cartão");
                System.out.println("2 - Dinheiro");

                try {
                    op = teclado.nextInt();
                } catch (Exception e) {
                    System.err.println("Erro. Informe um número inteiro.");
                    op = -1;
                    teclado.nextLine();// consumindo caracter extra NL/CR
                }

                switch (op) {
                    case 1:
                        formaPagamento = "cartao";
                        aux = true;
                        break;
                    case 2:
                        formaPagamento = "dinheiro";
                        aux = true;
                        break;
                    default:
                        System.out.println("> Opção inválida!");
                }
            } while (!aux);
        } else {
            formaPagamento = "dinheiro";
        }

        /**
         * Confirmando compra
         */
        aux = false; op = -1;
        System.out.println("> Confirmar compra:");
        do {
            System.out.println("1 - Confirmar compra");
            System.out.println("2 - Voltar ao menu principal");

            try {
                op = teclado.nextInt();
            } catch (Exception e) {
                System.err.println("Erro. Informe um número inteiro.");
                op = -1;
                teclado.nextLine();// consumindo caracter extra NL/CR
            }

            if (op == 2) {
                System.out.println("> Compra cancelada!");
                voltar = true;
                aux = true;
            }
            else if (op == 1) {
                // Inserindo ocorrência na entidade Compra
                String date = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
                int idCompra = compra.realizaCompra(produtosEscolhasId, total, usuario.getLogin(), prestadorEscolhidoLogin, date, formaPagamento);

                // Inserindo ocorrência na entidade Lista_Produtos
                for (int i = 0; i < quantidadeProdutos.size(); i++) {
                    // Conferindo id e quantidade de cada produto
                    String[] p = quantidadeProdutos.get(i).split("-");
                    int idProduto = Integer.parseInt(p[0]);
                    int qt = Integer.parseInt(p[1]);
                    compra.listaDeProdutos(idProduto,idCompra,qt);
                }
                aux = true;
            } else {
                System.out.println("> Escolha inválida!");
            }

        } while (!aux);

        // Verifica se deve cancelar a compra
        if (voltar) {
            return false;
        }

        System.out.println("> Compra realizada!");
        return true;
    }

}
