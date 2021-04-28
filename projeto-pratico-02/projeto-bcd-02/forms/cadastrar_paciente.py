from flask_wtf import FlaskForm
from wtforms import SubmitField, StringField, PasswordField, validators, DateField, SelectField


class CadastrarPaciente(FlaskForm):
    cpf = StringField('CPF',[validators.DataRequired()])
    nome = StringField('Nome', [validators.DataRequired()])
    dataNasc = DateField('Data de nascimento',[validators.DataRequired()],format='%d/%m/%Y')
    cidade = SelectField('Cidade', coerce=int)
    rua = StringField('Rua', [validators.DataRequired()])
    telefone = StringField('Telefone', [validators.DataRequired()])
    submit = SubmitField('Cadastrar')