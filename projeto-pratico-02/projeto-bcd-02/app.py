from flask import Flask, flash, redirect, url_for, request, session, render_template, jsonify
from flask_bootstrap import Bootstrap
from flask_nav import Nav
from flask_nav.elements import Navbar, View, Subgroup
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import func, desc
from sqlalchemy.ext.automap import automap_base
from datetime import datetime, timedelta, date
import math

# https://fontawesome.com/icons
from flask_fontawesome import FontAwesome

# Salvando senhas de maneira apropriada no banco de dados.
# https://werkzeug.palletsprojects.com/en/1.0.x/utils/#module-werkzeug.security
# Para gerar a senha a ser salva no DB, faça:
# senha = generate_password_hash('1234')
# from werkzeug.security import generate_password_hash, check_password_hash

from forms.pesquisar_paciente import PesquisarPaciente
from forms.cadastrar_paciente import CadastrarPaciente
from forms.calendario import PesquisarCalendario
from forms.vacinacao import VacinarPaciente

app = Flask(__name__)
app.secret_key = "SECRET_KEY"

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:marcelomac@localhost:3306/pp02marcelo'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS']=False

db = SQLAlchemy(app)

Base = automap_base()
Base.prepare(db.engine, reflect=True)
Pessoa = Base.classes.Pessoa
Vacinacao = Base.classes.Vacinacao
Faixa_Etaria = Base.classes.Faixa_Etaria
Ano = Base.classes.Ano
Vacina_Geral = Base.classes.Vacina_Geral
Cidade = Base.classes.Cidade
Endereco = Base.classes.Endereco
Telefone = Base.classes.Telefone
Vacina_Doenca = Base.classes.Vacina_Doenca
Doenca = Base.classes.Doenca
Intervalo = Base.classes.Intervalo
Vacina = Base.classes.Vacina
Estoque = Base.classes.Estoque
Unidade_Saude = Base.classes.Unidade_Saude
Historico = Base.classes.Historico
Proxima_Dose = Base.classes.Proxima_Dose
Compra = Base.classes.Compra

boostrap = Bootstrap(app)
fa = FontAwesome(app)

nav = Nav()
nav.init_app(app)

@nav.navigation()
def meunavbar():
    menu = Navbar('Sistema de Vacinação')
    menu.items = [View('Início', 'inicio'), ]
    menu.items.append(View('Calendário', 'listar_calendario'))
    menu.items.append(Subgroup('Vacinar', View('Pesquisar', 'pesquisar_paciente'), View('Cadastrar', 'cadastrar_paciente')))
    return menu


@app.route('/')
def inicio():
    session['logged_in'] = True
    return render_template('index.html', title='SICOVAC')


@app.route('/pesquisar', methods=['GET', 'POST'])
def pesquisar_paciente():
    '''Realiza a pesquisa por um paciente'''

    form = PesquisarPaciente()

    if request.method == 'GET':
        return render_template('pesquisar_paciente.html', title='Pesquisar paciente', form=form)

    if form.validate_on_submit():
        cpf = request.form['cpf']
        paciente = db.session.query(Pessoa).filter(Pessoa.cpf == cpf).first()

        if paciente is not None:
            session['cpf'] = paciente.cpf
            session['idPaciente'] = paciente.id
            return redirect(url_for('historico_paciente'))
        else:
            flash('Paciente não encontrado, favor realizar o seu cadastro')
            return render_template('index.html', title='SICOVAC')


@app.route('/cadastrar', methods=['GET', 'POST'])
def cadastrar_paciente():
    '''Realiza o cadastro de um paciente'''

    form = CadastrarPaciente()
    cidades = db.session.query(Cidade).all()
    form.cidade.choices = [(c.id, c.nome) for c in cidades]

    if request.method == 'GET':
        return render_template('cadastrar_paciente.html', title='Cadastrar paciente', form=form)

    if form.validate_on_submit():
        cpf = request.form['cpf']
        nome = request.form['nome']
        nascimento = request.form['dataNasc']
        cidade = request.form['cidade']
        rua = request.form['rua']
        telefone = request.form['telefone']

        paciente = db.session.query(Pessoa).filter(Pessoa.cpf == cpf).first()

        format = '%d/%m/%Y'
        new_format = '%Y-%m-%d'
        dataNasc = datetime.strptime(nascimento, format).strftime(new_format)

        if paciente is not None:
            flash('Paciente já possui cadastro')
            return redirect(url_for('inicio'))
        else:

            # Cadastrando Pessoa
            # Objeto Pessoa
            p = Pessoa()

            # Verificando se deve criar Telefone
            telefone_existente = db.session.query(Telefone).filter(Telefone.numero == telefone).first()
            telefone_max_id = db.session.query(func.max(Telefone.id)).scalar()

            # Objeto telefone
            t = Telefone()

            if telefone_existente is None:
                t.id = telefone_max_id + 1
                t.numero = telefone
                db.session.add(t)
                p.idTelefone = telefone_max_id + 1
            else:
                p.idTelefone = telefone_existente.id

            # Verifica se a rua já existe
            rua_existente  = db.session.query(Endereco).filter(Endereco.idCidade == cidade, Endereco.rua == rua).first()
            rua_max_id = db.session.query(func.max(Endereco.id)).scalar()
            pessoa_max_id = db.session.query(func.max(Pessoa.id)).scalar()

            if rua_existente is None:

                e = Endereco()
                e.id = rua_max_id+1
                e.rua = rua
                e.idCidade = cidade
                db.session.add(e)
                p.idEndereco = rua_max_id+1

            else:
                p.idEndereco = rua_existente.id

            p.id = pessoa_max_id + 1
            p.cpf = cpf
            p.nome = nome
            p.nascimento = dataNasc
            db.session.add(p)

            db.session.commit()
            db.session.close()

            return redirect(url_for('inicio'))


@app.route('/historico')
def historico_paciente():
    '''Fornece o histórico de um paciente'''

    # Dados do paciente
    paciente = db.session.query(Pessoa).filter(Pessoa.id == session['idPaciente']).first()

    # Sua idade em mês
    d1 = datetime.strptime(str(paciente.nascimento), "%Y-%m-%d")
    d2 = datetime.strptime(str(datetime.now().strftime('%Y-%m-%d')), "%Y-%m-%d")
    idade_mes = math.floor((abs((d2 - d1).days)/365)*12)

    # Buscando alguma Faixa Etaria
    faixa_etaria = db.session.query(Faixa_Etaria).filter(Faixa_Etaria.faixa == idade_mes).first()

    # Buscando id do ano atual
    now = datetime.now()
    ano = db.session.query(Ano).filter(Ano.ano == str(now.year)).first()
    session['idAnoAtual'] = ano.id

    # Vacinas geral
    lista_vacinas_geral = []
    if not faixa_etaria:
        print("> Nenhuma faixa etaria.")
    else:
        session['faixaEtariaPaciente'] = faixa_etaria.faixa
        session['idFaixaEtaria'] = faixa_etaria.id

        # Vacinas a serem aplicadas no momento da tabela Vacinacao
        vacinas = db.session.query(Vacinacao).filter(Vacinacao.idFaixaEtaria == faixa_etaria.id, Vacinacao.idAno == ano.id).all()
        # Vacinas que ja foram aplicadas nessa faixa etaria a partir da Tabela historico
        vacinas_ja_aplicadas = db.session.query(Historico).filter(Historico.idPessoa == session['idPaciente'],Historico.idFaixaEtaria == faixa_etaria.id)

        # Seleiconando vacinas geral que nao foram aplicadas na faixa etaria
        aux = False
        for v in vacinas:
            vacina_geral = db.session.query(Vacina_Geral).filter(Vacina_Geral.id == v.idVacinaGeral).first()
            for vj in vacinas_ja_aplicadas:
                if vacina_geral.id == vj.idVacinaGeral:
                    aux = True

            if aux:
                print("> Vacina já aplicada para essa faixa etária")
            else:
                lista_vacinas_geral.append(vacina_geral)

            aux = False

    # Verificando qual a dose da vacina geral
    lista_vacinas_geral_num_dose = []
    for i in lista_vacinas_geral:

        # Verificando todas as faixas etarias de cada Vacina Geral escolhida
        faixas_vacina_escolhida = db.session.query(Faixa_Etaria).join(Vacinacao).filter(Vacinacao.idVacinaGeral == i.id, Vacinacao.idAno == ano.id).order_by(Faixa_Etaria.faixa)
        lista_faixas_vacina_escolhida = []
        for i in faixas_vacina_escolhida: # Lista com todas as faixas da vacina geral
            lista_faixas_vacina_escolhida.append(i.faixa)

        numDoseAtual = lista_faixas_vacina_escolhida.index(session['faixaEtariaPaciente']) + 1
        lista_vacinas_geral_num_dose.append(numDoseAtual)

    # Historico
    historico = db.session.query(Historico).filter(Historico.idPessoa == session['idPaciente'])
    lista_historico = []
    if not historico:
        print("> Nenhum histórico")
    else:
        for h in historico:
            item = []
            vacina_geral = db.session.query(Vacina_Geral).filter(Vacina_Geral.id == h.idVacinaGeral).first()
            local = db.session.query(Unidade_Saude).filter(Unidade_Saude.id == h.idUnidadeSaude).first()
            vacina = db.session.query(Vacina).filter(Vacina.id == h.idVacina).first()
            item.append(vacina_geral.nome)
            item.append(local.nome)
            item.append(h.data)
            item.append(vacina.nome)
            item.append(h.doseAtual)
            item.append(vacina.nDose)
            lista_historico.append(item)

    # Proxima Dose
    pd = db.session.query(Proxima_Dose).filter(Proxima_Dose.idPessoa == session['idPaciente'])
    # Listando somente datas que ainda nao ocorreram
    lista_pd_ativas = []
    hoje = date.today()

    for i in pd:
        if i.data > hoje:
            lista_pd_ativas.append(i)

    lista_proximas_vacinas = []
    for l in lista_pd_ativas:
        lista_aux_pd = []
        vacinaGeral = db.session.query(Vacina_Geral).filter(Vacina_Geral.id == l.idVacinaGeral).first()
        lista_aux_pd.append(vacinaGeral.nome)
        lista_aux_pd.append(l.data)
        lista_proximas_vacinas.append(lista_aux_pd)

    return render_template('historico.html', title='HISTÓRICO', paciente=paciente, idade_mes=idade_mes, vacinas_geral=lista_vacinas_geral, historico=lista_historico, proximas=lista_proximas_vacinas, faixas=lista_vacinas_geral_num_dose, dadosvacina=zip(lista_vacinas_geral,lista_vacinas_geral_num_dose))


@app.route('/vacinacao', methods=['GET', 'POST'])
def vacinacao_paciente():
    '''Realiza a vacinacao de um paciente'''

    # Vacina Geral
    session['idVacinaGeral'] = request.args['idVacinaGeral']

    # Vacinas da Vacina Geral
    vacinas = db.session.query(Vacina).join(Vacina_Doenca).join(Vacina_Geral).filter(Vacina_Geral.id == request.args['idVacinaGeral'])
    lista_vacinas_disponiveis = []
    for v in vacinas:
        e = db.session.query(Estoque).filter(Estoque.idVacina == v.id).first()
        if e.dosesTotal > (e.vacAplicadas + e.vacDescartadas): # Essa vacina ainda está em estoque
            lista_vacinas_disponiveis.append(v)

    # Unidades de saude
    unidades_saude = []
    unidade = db.session.query(Unidade_Saude).all()
    for u in unidade:
        unidades_saude.append(u)

    form = VacinarPaciente()
    form.vacina.choices = [(v.id, v.nome) for v in lista_vacinas_disponiveis]
    form.unidadeSaude.choices = [(u.id, u.nome) for u in unidades_saude]

    if request.method == 'GET':
        return render_template('vacinacao.html', title='VACINAÇÃO', form=form,)

    if form.validate_on_submit():

        vacina_aplicada = db.session.query(Vacina).filter(Vacina.id == request.form['vacina']).first()
        doseAtual = int(request.form['doseAtual'])

        # Buscando id do ano atual
        now = datetime.now()
        ano = db.session.query(Ano).filter(Ano.ano == str(now.year)).first()

        intervalo = db.session.query(Intervalo).join(Vacina).filter(Vacina.id == vacina_aplicada.id).first()
        periodo_dias = intervalo.periodo

        # Próxima dose
        if doseAtual < vacina_aplicada.nDose: # Não está na última dose da vacina
            aux = datetime.now()
            proximaDose = aux + timedelta(days=periodo_dias)
            proximaDose = proximaDose.strftime('%Y-%m-%d')
            session['proximaDose'] = proximaDose
        else:
            session['proximaDose'] = 'ultima'

        hoje = date.today()
        dataHoje = hoje.strftime("%Y-%m-%d")

        h = Historico()
        h.idVacinaGeral = session['idVacinaGeral']
        h.idFaixaEtaria = session['idFaixaEtaria']
        h.idAno = session['idAnoAtual']
        h.idPessoa = session['idPaciente']
        h.data = dataHoje
        h.idUnidadeSaude = request.form['unidadeSaude']
        h.doseAtual = doseAtual
        h.idVacina = vacina_aplicada.id
        db.session.add(h)

        # Alterando estoque (incrementando vacina utilizada)
        est = db.session.query(Estoque).filter(Estoque.idVacina == vacina_aplicada.id).first()
        est.vacAplicadas = est.vacAplicadas + 1

        # Povoando proxima dose
        if session['proximaDose'] is not 'ultima':
            pDose_max_id = db.session.query(func.max(Proxima_Dose.id)).scalar()
            pDose = Proxima_Dose()
            pDose.id = pDose_max_id+1
            pDose.data = session['proximaDose']
            pDose.idPessoa = session['idPaciente']
            pDose.idVacinaGeral = session['idVacinaGeral']
            db.session.add(pDose)

        db.session.commit()
        db.session.close()

        return redirect(url_for('historico_paciente'))


@app.route('/calendario', methods=['GET', 'POST'])
def listar_calendario():
    '''Lista um determinado calendário de vacinas'''

    form = PesquisarCalendario()
    anos = db.session.query(Ano).order_by(Ano.ano)
    form.calendario.choices = [(a.id, a.ano) for a in anos]

    if request.method == 'GET':
        return render_template('calendario.html', title='CALENDÁRIO', form=form)
    if form.validate_on_submit():
        # Vacinas Gerais do calendário
        vacinas_calendario = db.session.query(Vacina_Geral).join(Vacinacao).filter(Vacinacao.idAno == request.form['calendario'])

        # Doencas de cada Vacina Geral
        doencas_vacinas_lista = [] # Lista com doencas de cada Vacina Geral
        for vg in vacinas_calendario:
            doencas_vacina_geral = db.session.query(Doenca).join(Vacina_Doenca).filter(Vacina_Doenca.idVacinaGeral == vg.id)
            doencas = ''
            for dvg in doencas_vacina_geral:
                doencas = doencas + dvg.nome + ', '
            doencas = doencas[:-2]
            doencas_vacinas_lista.append(doencas)

        # Faixas Etárias de cada Vacina
        faixa_vacinas_lista = []
        for vg in vacinas_calendario:
            faixas = ''
            faixas_vacina_geral = db.session.query(Faixa_Etaria).join(Vacinacao).filter(Vacinacao.idVacinaGeral == vg.id).all()
            for i in faixas_vacina_geral:

                if i.faixa > 24:
                    faixa_ano = int(math.floor(i.faixa / 12))
                    frac, full = math.modf((i.faixa/12))
                    if frac > 0.0:
                        sobra_mes = int(frac * 12)
                        faixas = faixas + str(faixa_ano) + ' anos e ' + str(sobra_mes) + ' meses, '
                    else:
                        faixas = faixas + str(faixa_ano) + ' anos, '
                elif (i.faixa == 0) or (i.faixa == 1):
                    faixas = faixas + str(i.faixa) + ' mês, '
                else:
                    faixas = faixas + str(i.faixa) + ' meses, '

            faixas = faixas[:-2]
            faixa_vacinas_lista.append(faixas)

        return render_template('calendario.html', title='SICOVAC', form=form, dados=zip(vacinas_calendario,doencas_vacinas_lista,faixa_vacinas_lista))


@app.errorhandler(404)
def page_not_found(e):
    '''
    Para tratar erros de páginas não encontradas - HTTP 404
    :param e:
    :return:
    '''
    return render_template('404.html'), 404


if __name__ == '__main__':
    app.run(debug=True)
