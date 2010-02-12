package br.com.optimedia.interactive.model.vo
{
	import mx.collections.ArrayCollection;
	
	public class SlideVO {
		
		public static const TYPE_TITLE:uint = 1;
		public static const TYPE_PAGE:uint = 2;
		
		[Bindable]
		public var id: uint;
		
		[Bindable]
		public var type: uint;
		
		[Bindable]
		public var title: String;
		
		[Bindable]
		public var body: String;
		
		[Bindable]
		public var complements: ArrayCollection;
		
		[Bindable]
		public var question: ArrayCollection;
		 
		public function SlideVO(id: uint = 0, type: uint = 0, title: String = null, body: String = null, 
		complements: ArrayCollection = null,question: ArrayCollection = null) {
			this.id = id;
			this.type = type; 
			this.title = title;
			this.body = body;
			this.complements = complements; 
			this.question = question; 
		}
	}
}