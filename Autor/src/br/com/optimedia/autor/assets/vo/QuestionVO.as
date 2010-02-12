package br.com.optimedia.interactive.model.vo {
	
	import mx.collections.ArrayCollection;
		
	public class QuestionVO {
		
		[Bindable]
		public var question:String;
		
		[Bindable]
		public var type:String;
		
		[Bindable]
		public var arrayAlternative:ArrayCollection;
		
		public function QuestionVO(question:String = null, type:String = null, arrayAlternative:ArrayCollection = null) {
			this.question = question;
			this.type = type;
			this.arrayAlternative = arrayAlternative;
		}

	}
}