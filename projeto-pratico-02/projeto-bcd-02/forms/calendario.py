from flask_wtf import FlaskForm
from wtforms import SubmitField, StringField, PasswordField, validators, SelectField


class PesquisarCalendario(FlaskForm):
    calendario = SelectField('Ano', coerce=int)
    submit = SubmitField('Pesquisar')