package br.com.optimedia.autor.assets.vo
{
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	
	[Bindable] [RemoteClass(alias="br.com.optimedia.assets.vo.PresentationVO")]
	
	public class PresentationVO
	{
		public var presentation_id:uint;
		public var subject_id:uint;
		public var skin_id:uint;
		public var user_id:uint;
		public var locked_at:String;
		public var title:String;
		public var description:String;
		public var status:uint;
		private var _slidesArray:ArrayCollection;
		
		public function clone():* {
			var copier:ByteArray = new ByteArray();
			copier.writeObject(this);
			copier.position = 0;
			return copier.readObject() as PresentationVO;
		}
		
		public function set slidesArray(value:*):void {
			if( value is ArrayCollection) _slidesArray = value;
			else _slidesArray = new ArrayCollection( value );
		}
		public function get slidesArray():* {
			return _slidesArray;
		}
	}
}