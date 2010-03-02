package br.com.optimedia.interactive.view
{
	import br.com.optimedia.autor.assets.vo.SlideVO;
	import br.com.optimedia.interactive.assets.ApplicationConstants;
	import br.com.optimedia.interactive.model.InteractiveProxy;
	import br.com.optimedia.interactive.view.components.SlideView;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	
	import mx.controls.Image;
	import mx.controls.Text;
	import mx.controls.TextArea;
	import mx.managers.CursorManager;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class SlideMediator extends Mediator{
		
		public static const NAME:String = 'SlideMediator';
		
		public var lastBg:Sprite;
		public var pag:Number;
		
		public var lineTitle:uint = 0x000000;
		public var bgTitle:uint = 0xFFFFFF;
		public var title:Text;
		public var content:TextArea;
		public var imgContent:Image;
		
		private var interactiveProxy:InteractiveProxy;
		
		
		public function SlideMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			
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
			return [ApplicationConstants.IGET_SLIDE_OK];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case ApplicationConstants.IGET_SLIDE_OK:
					show( note.getBody() as SlideVO );
					break;
				default:
					break;
			}
		}
		
		public function show(vo: SlideVO): void {
			
			view.slide.removeAllChildren();
			if (lastBg) {
				view.slide.rawChildren.removeChild(lastBg);
			}
			interactiveProxy.getLinks(vo);
			
			title = new Text();
			title.x=20;
			title.percentWidth = 90;
			//title.width = 740;
			title.height = 42;
			title.selectable = false;
			//title.wordWrap = true;
			//title.setStyle("backgroundAlpha",0);
			//title.setStyle("borderThickness",0);
			
			
			content = new TextArea();
			content.x=20;
			content.percentWidth = 90;
			//content.width = 740;
			//content.selectable = false;

			content.wordWrap = true;
			content.editable = false;
			content.setStyle("backgroundAlpha",0);
			content.setStyle("borderThickness",0);
		
			if (vo.type_slide_id == 1) {
				title.htmlText = "<span class='titleTITLE'>"+vo.title + "</span>";
				content.htmlText = "<span class='contentTITLE'>"+vo.text_body + "</span>";
			}else {
				title.htmlText = "<span class='titleTYPEPAGE'>"+vo.title + "</span>";
				content.htmlText ="<span class='contentTYPEPAGE'>"+ vo.text_body + "</span>";
			}
			
			content.addEventListener(TextEvent.LINK,openlink);
			
			title.styleSheet = view.styleSh;
			
			content.styleSheet= view.styleSh;
			content.styleName = "corpo";
		//	title.autoSize = "center";

			
			if (vo.type_slide_id == 2) {
				layout(vo.type_slide_id,20);
			} else if (vo.type_slide_id == 1) {
				layout(vo.type_slide_id, 140);
			} else if (vo.type_slide_id == 3) {
				lastBg=new Sprite ();
				lastBg.visible = false;
				view.slide.rawChildren.addChildAt(lastBg,0);
				
				imgContent = new Image();
				imgContent.source = vo.text_body;
				imgContent.autoLoad = true;
				imgContent.setStyle("horizontalCenter",0);
				imgContent.setStyle("verticalCenter",0);
				view.slide.addChild(imgContent);
				
			} else {
				layout(vo.type_slide_id, 20);
			}
			
		}
		
		public function layout (type:uint, yTitle:Number):void {
			title.y = yTitle;
			view.slide.addChild(title);
			
			lastBg=new Sprite ();
			lastBg.graphics.lineStyle(1,lineTitle);
			lastBg.graphics.beginFill(bgTitle,0.5);
			lastBg.graphics.drawRoundRect(0,0,view.width*0.95,title.height + 12 ,20,20);
			lastBg.graphics.endFill();
			lastBg.x=15;
			lastBg.y=yTitle-10;
			view.slide.rawChildren.addChildAt(lastBg,0);
			
			
			content.y=title.y + title.height + 12;
			if (type==1) {
				content.y+=30;
				content.height = view.height - title.y - title.height - 90 - 40 ;
			}else {
				content.height = view.height - title.y - title.height - 90;
			}
			view.slide.addChild(content);
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