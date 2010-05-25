package br.com.optimedia.assets.vo
{
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	
	[Bindable] [RemoteClass(alias="br.com.optimedia.assets.vo.QuestionVO")]
	
	public class QuestionVO
	{
		public var question_id:uint;
		public var title:String;
		private var _itemArray:ArrayCollection = new ArrayCollection();
		public var comment:String;
		
		public function clone():* {
			var copier:ByteArray = new ByteArray();
			copier.writeObject(this);
			copier.position = 0;
			return copier.readObject() as QuestionVO;
		}
		
		public function set itemArray(value:*):void {
			if( value is ArrayCollection) _itemArray = value;
			else _itemArray = new ArrayCollection( value );
		}
		public function get itemArray():* {
			return _itemArray;
		}
	}
}