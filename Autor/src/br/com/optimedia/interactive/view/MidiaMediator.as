package br.com.optimedia.interactive.view {
	
	import br.com.optimedia.autor.assets.vo.MediaVO;
	import br.com.optimedia.interactive.assets.ApplicationConstants;
	import br.com.optimedia.interactive.view.components.MidiaView;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import mx.controls.Image;
	import mx.controls.SWFLoader;
	import mx.controls.TextArea;
	import mx.controls.VideoDisplay;
	import mx.core.Application;
	
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
						openMidia (note.getBody() as MediaVO);
					break;
				case ApplicationConstants.OPEN_MIDIA:
						openMidia (note.getBody() as MediaVO);
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
		public function openMidia(media:MediaVO):void {
			if (text) {
				try{
					view.removeChild(text);	
				}catch (e:Error) {	
				}
			}
			if (imagem) {
				try{
					view.removeChild(imagem);
				}catch (e:Error) {	
				}
			}
			if (swfLoad) {
				try{
					view.removeChild(swfLoad);
				}catch (e:Error) {	
				}
			}
			if (movie) {
				try{
					view.removeChild(movie);
				}catch (e:Error) {
					
				}
			}
			var media:MediaVO = media;
			switch(media.category_id) {
				case 4:
					movie = new VideoDisplay();
					movie.source = 'http://www.educar.tv/amf/services/autor/mediafiles/'+media.body;
					movie.autoPlay=true;
					movie.autoRewind = false;
					movie.setStyle("horizontalCenter",0);
					movie.setStyle("verticalCenter",0);
					view.addChild(movie);
					sendNotification(ApplicationConstants.OPEN_MIDIA_VIEW, media.category_id);
					break;
				case 5:
					var url:URLRequest = new URLRequest( media.body);
					navigateToURL(url,"_blank");
					break;
				case 6:
					text = new TextArea();
					text.setStyle("backgroundAlpha", 0);
					text.setStyle("borderSides",0);
					text.htmlText = "<span class='media'>" + media.body + "</span>";
					text.wordWrap = true;
					text.editable=false;
					text.enabled=true;
					text.percentWidth = 100;
					text.percentHeight = 100;
					//text.addEventListener(TextEvent.LINK, teste);	
					text.styleSheet = view.styleSh		
					view.addChild(text);
					sendNotification(ApplicationConstants.OPEN_MIDIA_VIEW, media.category_id);
					break;
				case 7:
					var url1:URLRequest = new URLRequest( 'http://www.educar.tv/amf/services/autor/mediafiles/'+media.body);
					navigateToURL(url1,"_blank");
					break;
				default:
					var arq:Array = media.body.split(".");
					if (arq[1]=="swf") {
						swfLoad = new SWFLoader();
						swfLoad.source = 'http://www.educar.tv/amf/services/autor/mediafiles/'+media.body;
						swfLoad.autoLoad = true;
						swfLoad.scaleContent = true;
						view.addChild(swfLoad);
					}else {
						imagem = new Image();
						imagem.autoLoad = true;
						imagem.maxWidth = view.width*0.9;
						imagem.maxHeight = view.height*0.9;
						imagem.scaleContent = true;
						imagem.setStyle("horizontalCenter",0);
						imagem.setStyle("verticalCenter",0);
						imagem.source = 'http://www.educar.tv/amf/services/autor/mediafiles/'+media.body;
						view.addChild(imagem);
					}
					sendNotification(ApplicationConstants.OPEN_MIDIA_VIEW, media.category_id);
					break;
			}
			
			/* if (media.category_id==6){
				text = new TextArea();
				text.setStyle("backgroundAlpha", 0);
				text.setStyle("borderSides",0);
				text.htmlText = "<span class='media'>" + media.body + "</span>";
				text.wordWrap = true;
				text.editable=false;
				text.enabled=true;
				text.styleSheet = view.styleSh		
				view.titleWindow.addChild(text);
				
			}else if (media.category_id<=3) {
				var arq:Array = media.body.split(".");
				if (arq[1]=="swf") {
					swfLoad = new SWFLoader();
					swfLoad.source = media.body;
					swfLoad.autoLoad = true;
					swfLoad.scaleContent = true;
					view.titleWindow.addChild(swfLoad);
				}else {
					imagem = new Image();
					imagem.source = 'http://www.educar.tv/amf/autor/mediafiles/'+media.body;
					imagem.autoLoad = true;
					imagem.scaleContent = true;
					imagem.setStyle("horizontalCenter",0);
					imagem.setStyle("verticalCenter",0);
					view.titleWindow.addChild(imagem);
				}
			}else if (media.category_id==4){
					movie = new VideoDisplay();
					movie.source = 'http://www.educar.tv/amf/autor/mediafiles/'+media.body;
					movie.autoPlay=true;
					movie.autoRewind = false;
					movie.setStyle("horizontalCenter",0);
					movie.setStyle("verticalCenter",0);
					view.titleWindow.addChild(movie);
			}else if (media.category_id==5) {
					var url:URLRequest = new URLRequest( media.body);
					navigateToURL(url,"_blank");
				
			} */
		}
	}
}