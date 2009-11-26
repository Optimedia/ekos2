package br.com.optimedia.assets.generalcomponents
{
	import mx.validators.EmailValidator;

	public class EkosEmailValidator extends EmailValidator {
	
		public function EkosEmailValidator() {
			super();
			
			invalidCharError = "Há caracteres inválidos.";
			invalidDomainError = "E-mail inválido.";
			invalidIPDomainError = "E-mail inválido.";
			invalidPeriodsInDomainError = "E-mail inválido.";
			tooManyAtSignsError = "Existe mais de uma '@'.";
			missingAtSignError = "Está faltando o '@' no e-mail.";
			missingPeriodInDomainError = "E-mail inválido.";
			missingUsernameError = "E-mail inválido.";
			requiredFieldError = "Este campo é obrigatório.";
		}

	}
}