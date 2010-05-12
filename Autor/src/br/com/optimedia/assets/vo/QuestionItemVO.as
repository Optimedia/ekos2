package br.com.optimedia.assets.vo
{
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	
	[Bindable] [RemoteClass(alias="br.com.optimedia.assets.vo.QuestionItemVO")]
	
	public class QuestionItemVO
	{
		public var question_item_id:uint;
		public var body:String;
		public var correct_answer:Boolean;
		
		public function clone():* {
			var copier:ByteArray = new ByteArray();
			copier.writeObject(this);
			copier.position = 0;
			return copier.readObject() as QuestionItemVO;
		}
	}
}