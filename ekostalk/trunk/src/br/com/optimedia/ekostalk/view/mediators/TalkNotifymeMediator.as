package br.com.optimedia.ekostalk.view.mediators
{
	import br.com.optimedia.ekostalk.view.components.TalkNotifymeView;
	import br.com.optimedia.notifyme.controller.base.BaseNotifymeMediator;
	
	import flash.events.MouseEvent;

	public class TalkNotifymeMediator extends BaseNotifymeMediator
	{
		public function TalkNotifymeMediator(viewComponent:TalkNotifymeView)
		{
			super(viewComponent);
			viewComponent.btnPrior.addEventListener(MouseEvent.CLICK, onPriorClicked);
			viewComponent.btnNext.addEventListener(MouseEvent.CLICK, onNextClicked);
			viewComponent.lblTitle.addEventListener(MouseEvent.CLICK, onOpenPage);
		}
		
	}
}