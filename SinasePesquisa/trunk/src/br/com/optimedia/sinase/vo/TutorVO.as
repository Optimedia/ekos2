package br.com.optimedia.sinase.vo {
	
	[RemoteClass(alias="br.com.optimedia.sinase.vo.TutorVO")] 
	
	[Bindable]
	public class TutorVO {
		
		// Pessoa
		public var id_pessoa:int;
		public var idram_atuac:int;
		public var idescolaridade:int;
		public var iduf:int;
		public var nome:String;
		public var cpf:String;
		public var data_nasc:String;
		public var sexo:String;
		public var cidade:String;
		public var logradouro:String;
		public var numero:int;
		public var bairro:String;
		public var cep:String;
		public var email:String;
		public var dddfixo:String;
		public var tel_fixo:String;
		public var ddd_cel:String;
		public var tel_cel:String;
		
		// Tutor
		public var idtutor:int;
		public var idbanda_larga:int;
		public var idtec_mdl:int;
		public var idtec_ead:int;
		public var ativ_sinase:String;
		public var atua_sinase:int;
		public var tutor_ead:int;
		public var aluno_ead:int;
		public var cont_ead:int;
		public var org_prom_ead:String;
		public var idpart_webcon:int;
		public var tec_webcon:String;
		public var art_publ:int;
		public var art1:String;
		public var art2:String;
		public var art3:String;
		public var out_prog:String;
		public var pos_webcam:int;
		public var pos_headset:int;
		public var disp_semana:int;
		public var disp_fds:int;
		public var expec_curso:String;
		public var idoffice:int;
		public var rel_coleta_dados:int;
		public var idmod_sinase:int;
		
		public var uf:String;
		
		// Array Expericiaas proficionais
		public var exp_prof:Array;
		
	}
}