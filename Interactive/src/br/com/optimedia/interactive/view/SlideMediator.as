package br.com.optimedia.interactive.view
{
	import br.com.optimedia.interactive.assets.ApplicationConstants;
	import br.com.optimedia.interactive.assets.vo.SlideVO;
	import br.com.optimedia.interactive.model.InteractiveProxy;
	import br.com.optimedia.interactive.view.components.SlideView;
	
	import flash.display.Sprite;
	import flash.events.TextEvent;
	
	import mx.controls.Alert;
	import mx.core.Application;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class SlideMediator extends Mediator{
		
		public static const NAME:String = 'SlideMediator';
		
		public var lastBg:Sprite;
		public var pag:Number;
		
		public var lineTitle:uint = 0x000000;
		public var bgTitle:uint = 0xFFFFFF;
		
		private var interactiveProxy:InteractiveProxy;
		
		
		public function SlideMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			view.textContent.addEventListener(TextEvent.LINK,openlink);
			
			interactiveProxy = facade.retrieveProxy( InteractiveProxy.NAME ) as InteractiveProxy;
			
			//ignoreManagerProxy = facade.retrieveProxy( IgnoreManagerProxy.NAME ) as IgnoreManagerProxy;
		}
		
		override public function onRemove():void {
			trace(NAME+".onRemove()");
		}
		
		public function get view():SlideView
		{
			return viewComponent as SlideView;
		}
		
		override public function listNotificationInterests():Array
		{
			return [ApplicationConstants.GET_SLIDE_OK];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case ApplicationConstants.GET_SLIDE_OK:
					show( note.getBody() as SlideVO );
					break;
				default:
					break;
			}
		}
		
		public function show(vo: SlideVO): void {
	
			interactiveProxy.getLinks(vo.slide_id);
			
			if (vo.type_slide_id == SlideVO.TYPE_PAGE) {
				Application.application.slideView.slideVO = vo;
				layout(vo.type_slide_id,20,"titleTYPEPAGE","contentTYPEPAGE");
			
			} else if (vo.type_slide_id == SlideVO.TYPE_TITLE) {
				Application.application.slideView.slideVO = vo;
				layout(vo.type_slide_id, 140,"titleTITLE","contentTITLE");
			
			} else {
				Application.application.slideView.slideVO = vo;
				layout(vo.type_slide_id, 20,"titleTYPEPAGE","contentTYPEPAGE");
			}
		}
		
		public function layout (type:uint, yTitle:Number ,styleTITLE:String,stlyeText:String):void {
			
			
			view.textTitle.visible=false;
			view.textTitle.x=20;
			view.textTitle.y=yTitle;
			view.textTitle.styleName = styleTITLE;
			if (lastBg)
				view.rawChildren.removeChild(lastBg);

			lastBg=new Sprite ();
			lastBg.graphics.lineStyle(1,lineTitle);
			lastBg.graphics.beginFill(bgTitle,0.5);
			lastBg.graphics.drawRoundRect(0,0,760,view.textTitle.height+10,20,20);
			lastBg.graphics.endFill();
			lastBg.x=10;
			lastBg.y=yTitle-10;
			view.rawChildren.addChildAt(lastBg,0);
			
			view.textContent.x=10;
			view.textContent.y=view.textTitle.y + view.textTitle.height + 10;
			
			if (type==SlideVO.TYPE_TITLE) {
				view.textContent.y+=40;
			}
			view.textContent.styleName = stlyeText;
						
			view.textTitle.visible=true;
			view.textContent.visible=true;
		}
		
		public function getLineTitle ():uint {
			return this.lineTitle;
		}

		public function setLineTitle (lineTitle:uint):void {
			this.lineTitle = lineTitle;
		}
		public function getBgTitle ():uint {
			return this.bgTitle;
		}
		public function setBgTitle (bgTitle:uint):void {
			this.bgTitle = bgTitle;
		}
		
		public function openlink(e:TextEvent):void {
			
			var id:* = e.text as String;
			interactiveProxy.getMidia(id);
		}
	}
}