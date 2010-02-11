package br.com.optimedia.interactive.controller
{
	import br.com.optimedia.interactive.model.vo.SlideVO;
	
	import mx.controls.Alert;
	import mx.core.Application;
	
	public class SlideMediator {
		public function SlideMediator() {
		}
		
		public function show(vo: SlideVO): void {
			
			if (vo.type == SlideVO.TYPE_PAGE) {
				Application.application.slideView.textContent.visible = true;
				Application.application.slideView.slideVO = vo;
			} else if (vo.type == SlideVO.TYPE_TITLE) {
				Application.application.slideView.textContent.visible = false;
				Application.application.slideView.slideVO = vo;
			} else {
				Alert.show("Erro!");
			}
		}
	}
}