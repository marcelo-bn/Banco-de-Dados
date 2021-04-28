from flask_wtf import FlaskForm
from wtforms import SubmitField, StringField, PasswordField, validators, DateField, SelectField


class VacinarPaciente(FlaskForm):
    vacina = SelectField('Vacina', coerce=int)
    doseAtual = StringField('Número da dose',[validators.DataRequired()])
    unidadeSaude = SelectField('Unidade de Saúde', coerce=int)
    submit = SubmitField('Confirmar')