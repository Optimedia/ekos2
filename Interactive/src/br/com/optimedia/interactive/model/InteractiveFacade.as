package br.com.optimedia.interactive.model
{
	import br.com.optimedia.interactive.controller.SlideMediator;
	import br.com.optimedia.interactive.model.vo.SlideVO;
	
	public class InteractiveFacade {
		
		public var slideMediator: SlideMediator = new SlideMediator();
			
		public function InteractiveFacade() {
		}
		
		public function show(slideVO: SlideVO): void {
			slideMediator.show(slideVO);
		}
	}
}