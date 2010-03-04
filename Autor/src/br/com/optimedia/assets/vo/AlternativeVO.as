package br.com.optimedia.assets.vo {
	
	public class AlternativeVO {
		
		[Bindable]
		public var text:String;
		
		[Bindable]
		public var correct:Boolean;
		
		public function AlternativeVO(text:String = null, correct:Boolean = false) {
			this.text = text;
			this.correct = correct;			
		}

	}
}