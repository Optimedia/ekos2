package br.com.optimedia.interactive.view
{
	import br.com.optimedia.interactive.assets.ApplicationConstants;
	import br.com.optimedia.interactive.assets.vo.SlideVO;
	import br.com.optimedia.interactive.view.components.SlideView;
	
	import flash.display.Sprite;
	
	import mx.controls.Alert;
	import mx.core.Application;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class SlideMediator extends Mediator{
		
		public static const NAME:String = 'SlideMediator';
		
		public var lineTitle:uint = 0x000000;
		public var bgTitle:uint = 0xFFFFFF;
		//private var interactiveProxy:InteractiveProxy = new InteractiveProxy();
		
		public function SlideMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
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
			Application.application.slideView.textTitle.visible=false;
			Application.application.slideView.textContent.visible=false;
			if (vo.type_slide_id == SlideVO.TYPE_PAGE) {
				Application.application.slideView.slideVO = vo;
				layout(vo.type_slide_id,20,"titleTYPEPAGE","contentTYPEPAGE");
			} else if (vo.type_slide_id == SlideVO.TYPE_TITLE) {
				Application.application.slideView.slideVO = vo;
				layout(vo.type_slide_id, 140,"titleTITLE","contentTITLE");
			} else {
				Alert.show("Erro!");
			}
		}
		
		public function layout (type:uint, yTitle:Number ,styleTITLE:String,stlyeText:String):void {
			Application.application.slideView.textTitle.visible=false;
			Application.application.slideView.textTitle.x=20;
			Application.application.slideView.textTitle.y=yTitle;
			Application.application.slideView.textTitle.styleName = styleTITLE;
			
			var bg:Sprite=new Sprite ();
			bg.graphics.lineStyle(1,lineTitle);
			bg.graphics.beginFill(bgTitle,0.5);
			bg.graphics.drawRoundRect(0,0,760,Application.application.slideView.textTitle.height+10,10,10);
			bg.graphics.endFill();
			bg.x=10;
			bg.y=yTitle-10;
			Application.application.slideView.rawChildren.addChildAt(bg,0);
		
			
			Application.application.slideView.textContent.x=10;
			Application.application.slideView.textContent.y=Application.application.slideView.textTitle.y+Application.application.slideView.textTitle.height+10;
			
			if (type==SlideVO.TYPE_TITLE) {
				Application.application.slideView.textContent.y+=40;
			}
			Application.application.slideView.textContent.styleName = stlyeText;
			
			Application.application.slideView.textTitle.visible=true;
			Application.application.slideView.textContent.visible=true;
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
	}
}