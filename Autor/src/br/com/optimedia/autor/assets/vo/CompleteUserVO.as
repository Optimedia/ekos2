package br.com.optimedia.autor.assets.vo
{
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	
	[Bindable] [RemoteClass(alias="br.com.optimedia.assets.vo.CompleteUserVO")]
	
	public class CompleteUserVO
	{
		//UserVO
		public var user_id:uint;
		public var role_id:uint;
		public var first_name:String;
		public var last_name:String;
		public var password:String;

		//ProfileVO
		public var profile_id:uint;
		public var nickname:String;
		public var small_avatar:String;
		public var large_avatar:String;
		public var sex:int;
		public var birthday:String;
		
		//AccountVO
		public var account_id:uint;
		public var email:String;
		public var name:String;
		public var status:int;
		
		//Profile Details
		private var _addressArray:ArrayCollection = new ArrayCollection();
		private var _educationArray:ArrayCollection = new ArrayCollection();
		private var _languageArray:ArrayCollection = new ArrayCollection();
		private var _professionArray:ArrayCollection = new ArrayCollection();
		
		//usado para copiar o VO sem criar assuciação entre as variáveis
		//uso: newVO = oldVO.clone();
		public function clone():* {
			var copier:ByteArray = new ByteArray();
			copier.writeObject(this);
			copier.position = 0;
			return copier.readObject() as CompleteUserVO;
		}
		
		public function set educationArray(value:*):void {
			if( value is ArrayCollection) _educationArray = value;
			else _educationArray = new ArrayCollection( value );
		}
		public function get educationArray():* {
			return _educationArray;
		}
		
		public function set addressArray(value:*):void {
			if( value is ArrayCollection) _addressArray = value;
			else _addressArray = new ArrayCollection( value );
		}
		public function get addressArray():* {
			return _addressArray;
		}
		
		public function set professionArray(value:*):void {
			if( value is ArrayCollection) _professionArray = value;
			else _professionArray = new ArrayCollection( value );
		}
		public function get professionArray():* {
			return _professionArray;
		}
		
		public function set languageArray(value:*):void {
			if( value is ArrayCollection) _languageArray = value;
			else _languageArray = new ArrayCollection( value );
		}
		public function get languageArray():* {
			return _languageArray;
		}
	}
}