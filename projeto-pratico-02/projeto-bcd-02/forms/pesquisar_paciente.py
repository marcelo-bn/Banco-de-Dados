from flask_wtf import FlaskForm
from wtforms import SubmitField, StringField, PasswordField, validators


class PesquisarPaciente(FlaskForm):
    cpf = StringField('CPF',[validators.DataRequired()])
    pesquisar = SubmitField('Pesquisar')