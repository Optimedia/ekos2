package br.com.optimedia.assets.generalcomponents
{
	import mx.validators.StringValidator;

	public class EkosStringValidator extends StringValidator
	{
		public function EkosStringValidator() {
			super();
			
			requiredFieldError = "Este campo é obrigatório.";
			tooLongError = "Este campo permite no máximo " + maxLength + " caracteres.";
			tooShortError = "Este campo deve ter no mínimo " + minLength + " caracteres.";
		}
	}
}