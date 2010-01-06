package br.com.optimedia.assets.vo
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
		public var small_avatar:String = "br/com/optimedia/assets/imgs/defaultAvatar.png";
		public var large_avatar:String = "br/com/optimedia/assets/imgs/defaultAvatar.png";
		public var sex:int;
		public var birthday:String;
		
		//AccountVO
		public var account_id:uint;
		public var email:String;
		public var name:String;
		public var status:int;
		
		//Profile Details
		public var addressArray:ArrayCollection = new ArrayCollection();
		public var educationArray:ArrayCollection = new ArrayCollection();
		public var languageArray:ArrayCollection = new ArrayCollection();
		public var professionArray:ArrayCollection = new ArrayCollection();
		
		//usado para copiar o VO sem criar assuciação entre as variáveis
		//uso: newVO = oldVO.clone();
		public function clone():* {
		    var copier:ByteArray = new ByteArray();
		    copier.writeObject(this);
		    copier.position = 0;
		    return copier.readObject() as CompleteUserVO;
		}
	}
}