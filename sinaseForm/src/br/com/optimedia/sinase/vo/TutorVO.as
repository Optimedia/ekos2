package br.com.optimedia.sinase.vo
{
	import mx.collections.ArrayCollection;
	
	[Bindable] 
	[RemoteClass(alias="br.com.optimedia.sinase.vo.TutorVO")]
	
	public class TutorVO
	{
		// Pessoa
		public var id_pessoa:uint; 			// int
		public var idram_atuac:uint; 		// int
		public var idescolaridade:uint; 	// int
		public var iduf:uint; 				// int
		public var nome:String; 			// String
		public var cpf:String; 				// String
		public var data_nasc:String; 		// String
		public var sexo:String; 			// String
		public var cidade:String;			// String
		public var logradouro:String; 		// String
		public var numero:String; 			// String
		public var bairro:String; 			// String
		public var cep:String; 				// String
		public var email:String; 			// String
		public var dddfixo:String; 			// String
		public var tel_fixo:String; 		// String
		public var ddd_cel:String; 			// String
		public var tel_cel:String; 			// String
		
		// Tutor
		public var idmod_sinase:uint;
		public var idtutor:uint; 			// int
		public var idbanda_larga:uint; 		// int
		public var idtec_mdl:uint; 			// int
		public var idtec_ead:uint; 			// int
		public var ativ_sinase:String; 		// String
		public var atua_sinase:uint; 		// int
		public var tutor_ead:uint; 			// int
		public var aluno_ead:uint; 			// int
		public var cont_ead:uint; 			// int
		public var org_prom_ead:String; 	// String
		public var idpart_webcon:uint; 		// int
		public var tec_webcon:String; 		// String
		public var art_publ:uint; 			// int
		public var art1:String; 			// String
		public var art2:String; 			// String
		public var art3:String; 			// String
		public var out_prog:String; 		// String
		public var pos_webcam:uint; 		// int
		public var pos_headset:uint; 		// int
		public var disp_semana:uint; 		// int
		public var disp_fds:uint; 			// int
		public var expec_curso:String; 		// String
		public var idoffice:uint;
		public var pontuacao:uint;
		public var rel_coleta_dados:uint;	//int
		
		public var participou_sinase:int;
		public var tutoria_webconference:String;
		
		public var tutoria_moodle:Boolean;
		public var instituicao_tutoria1:String;
		public var modalidade_tutoria1:int;
		public var natureza_tutoria1:int;
		public var periodo_tutoria1:int;
		public var instituicao_tutoria2:String;
		public var modalidade_tutoria2:int;
		public var natureza_tutoria2:int;
		public var periodo_tutoria2:int;
		public var instituicao_tutoria3:String;
		public var modalidade_tutoria3:int;
		public var natureza_tutoria3:int;
		public var periodo_tutoria3:int;
		
		public var lattes:String;
		
		
		public var regiao:String;
		public var selecionado:String;
		
		public var exp_prof:Array;
		
	}
}

