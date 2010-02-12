package br.com.optimedia.interactive
{
	
	public class InteractiveFacade {
		
		public var slideMediator: SlideMediator = new SlideMediator();
			
		public function InteractiveFacade() {
		}
		
		public function show(slideVO: SlideVO): void {
			slideMediator.show(slideVO);
		}
	}
}