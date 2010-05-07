package br.com.optimedia.assets.vo
{
	import flash.utils.ByteArray;
	
	[Bindable] [RemoteClass(alias="br.com.optimedia.assets.vo.SlideCommentVO")]
	
	public class SlideCommentVO
	{
		
		public var slide_comment_id:uint;
		public var slide_id:uint;
		public var user_id:uint;
		public var body:String;
		public var date:String;
		
		public var user_name:String;
		
		public function clone():* {
			var copier:ByteArray = new ByteArray();
			copier.writeObject(this);
			copier.position = 0;
			return copier.readObject() as SlideVO;
		}
		
	}
}