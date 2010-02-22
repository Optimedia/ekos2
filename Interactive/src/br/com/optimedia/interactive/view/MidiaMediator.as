package br.com.optimedia.interactive.view {
	
	import br.com.optimedia.interactive.assets.ApplicationConstants;
	import br.com.optimedia.interactive.assets.vo.LinkVO;
	import br.com.optimedia.interactive.view.components.MidiaView;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import mx.controls.Image;
	import mx.controls.SWFLoader;
	import mx.controls.TextArea;
	import mx.controls.VideoDisplay;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class MidiaMediator extends Mediator {
		
		public static const NAME:String = 'MidiaMediator';
		
		public var text:TextArea;
		public var imagem:Image;
		public var swfLoad:SWFLoader;
		public var movie:VideoDisplay; 
		
		
		public function MidiaMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
		}
		
		override public function onRemove():void {
			trace(NAME+".onRemove()");
		}
		
		public function get view():MidiaView
		{
			return viewComponent as MidiaView;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
					ApplicationConstants.CREAT_MIDIA,
					ApplicationConstants.CLOSE_MIDIA,
					ApplicationConstants.OPEN_MIDIA
					];
		}
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case ApplicationConstants.CREAT_MIDIA:
						openMidia (note.getBody() as LinkVO);
					break;
				case ApplicationConstants.OPEN_MIDIA:
						openMidia (note.getBody() as LinkVO);
					break;
				case ApplicationConstants.CLOSE_MIDIA:
						closeMidia ();
					break;
				default:
					break;
			}
		}
		public function closeMidia():void {
			view.visible = false;
		}
		public function openMidia(midia:LinkVO):void {
			if (text) {
				try{
					view.titleWindow.removeChild(text);	
				}catch (e:Error) {	
				}
			}
			if (imagem) {
				try{
					view.titleWindow.removeChild(imagem);
				}catch (e:Error) {	
				}
			}
			if (swfLoad) {
				try{
					view.titleWindow.removeChild(swfLoad);
				}catch (e:Error) {	
				}
			}
			if (movie) {
				try{
					view.titleWindow.removeChild(movie);
				}catch (e:Error) {
					
				}
			}
			var midia:LinkVO = midia;
			if (midia.category_id==6){
				text = new TextArea();
				text.setStyle("backgroundAlpha", 0);
				text.setStyle("borderSides",0);
				text.htmlText = midia.body_midia;
				text.wordWrap = true;
				text.editable=false;
				text.enabled=true;
				//text.addEventListener(TextEvent.LINK, teste);				
				view.titleWindow.addChild(text);
				
			}else if (midia.category_id<=3) {
				var arq:Array = midia.body_midia.split(".");
				if (arq[1]=="swf") {
					swfLoad = new SWFLoader();
					swfLoad.source = midia.body_midia;
					swfLoad.autoLoad = true;
					swfLoad.scaleContent = true;
					view.titleWindow.addChild(swfLoad);
				}else {
					imagem = new Image();
					imagem.source = midia.body_midia;
					imagem.autoLoad = true;
					imagem.scaleContent = true;
					view.titleWindow.addChild(imagem);
				}
			}else if (midia.category_id==4){
					movie = new VideoDisplay();
					movie.source = midia.body_midia;
					movie.autoPlay=true;
					movie.autoRewind = false;
					view.titleWindow.addChild(movie);
			}else if (midia.category_id==5) {
					var url:URLRequest = new URLRequest( midia.body_midia);
					navigateToURL(url,"_blank");
				
			}
			sendNotification(ApplicationConstants.OPEN_MIDIA_VIEW);
		}
	}
}