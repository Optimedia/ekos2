package br.com.optimedia.sinase.selecaoaluno.vo
{
	import flash.utils.ByteArray;
	
	[Bindable]
	[RemoteClass(alias="br.com.optimedia.sinase.vo.AlunoVO")]
	
	public class AlunoVO
	{
		
		//Revisor e Aluno: Pessoa
		public var id_pessoa:int; 
		public var idram_atuac:*; 
		public var idescolaridade:int;
		public var iduf:int; 
		public var nome:String;
		public var sobrenome:String;
		public var cpf:String = "";
		public var data_nasc:*; 
		public var sexo:String; 
		public var cidade:String;
		public var logradouro:String; 
		public var numero:String; 
		public var bairro:String; 
		public var cep:String; 
		public var email:String; 
		public var dddfixo:String; 
		public var tel_fixo:String;
		public var ddd_cel:String;
		public var tel_cel:String;
		public var lattes:String;
		
		
		// Aluno
		public var idaluno:int;
		public var idbanda_larga:int;
		public var idcapacitacao_sinase:int;
		public var idatua_org:int;
		public var idcarga_hora:int;
		public var exp_ead:int;
		public var idinternet:int;
		public var idpart_webcon:int;
		public var curso_ead:int;
		public var deficiente:String;
		public var material_esp:int;
		public var idtec_ead:int;
		public var computador:int;
		public var webcam:int;
		public var headset:int;
		public var disp_sem:int;
		public var disp_fds:int;
		public var presenca_ead:int;
		public var just_presenca:String;
		public var data_atualizacao:String;
		public var pontuacao:int;
		public var respostas:Array;
		
		public var ind_moodle:int;
		public var selecionado:int;
		
		
		public function clone():* {
			var copier:ByteArray = new ByteArray();
			copier.writeObject( this );
			copier.position = 0;
			return copier.readObject() as AlunoVO;
		}
	}
}