package br.com.optimedia.sinase.vo
{
	
	[Bindable] 
	[RemoteClass(alias="br.com.optimedia.sinase.vo.AlunoVO")]
	
	public class AlunoVO
	{
		// Pessoa
		public var id_pessoa:uint; 			// int
		public var cod_aprov:uint;
		public var idram_atuac:uint; 		// int
		public var area_atuac_qual:String	//String
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
		
		public var complemento:String		//String
		
		public var email:String; 			// String
		public var dddfixo:String; 			// String
		public var tel_fixo:String; 		// String
		public var ddd_cel:String; 			// String
		public var tel_cel:String; 			// String
		public var registro:String;			// String
		public var naturalidade:String;		// String
		public var orgao_expeditor:String;	// String
		
		
		public var nome_pai:String;			
		public var nome_mae:String;
		
		
		// Aluno
		public var idaluno:uint; 				// int
		public var idtec_ead:uint;          	//int
		public var idbanda_larga:uint; 			// int
		public var idcapacitacao_sinase:uint; 	// int
		public var idatua_org:uint; 			// int
		public var idcarga_hora:uint; 			// int
		public var idinternet:uint; 			// int
		public var idpart_webcon:uint; 			// int
		public var exp_ead:String; 				// String
		public var deficiente:String; 			// String
		public var material_esp:String; 		// String
		public var computador:uint; 			// int
		public var webcam:uint; 				// int
		public var headset:uint; 				// int
		public var disp_sem:uint; 				// int
		public var disp_fds:uint; 				// int
		public var presenca_ead:uint; 			// int
		public var just_presenca:String; 			// String
		public var pontuacao:uint; 				// int
		public var respostas:Array;           	//array
		
		public var ind_moodle:uint;
		public var selecionado:uint;
	}
}