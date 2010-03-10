package br.com.optimedia.interactive.view {
	
	import br.com.optimedia.interactive.assets.ApplicationConstants;
	import br.com.optimedia.interactive.assets.ImageWithProgressBar;
	import br.com.optimedia.interactive.assets.SwfWithProgressBar;
	import br.com.optimedia.interactive.assets.vo.MediaVO;
	import br.com.optimedia.interactive.view.components.MidiaView;
	
	import fl.video.*;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import mx.controls.ProgressBar;
	import mx.controls.TextArea;
	import mx.core.Application;
	import mx.events.CloseEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class MidiaMediator extends Mediator {
		
		public static const NAME:String = 'MidiaMediator';
		
		public var text:TextArea;
		//public var imagem:Image;
		public var imagem:ImageWithProgressBar;
		//public var swfLoad:SWFLoader;
		public var swfLoad:SwfWithProgressBar;
		public var movie:FLVPlayback; 
		
		private var loadBar:ProgressBar;
		
		
		public function MidiaMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			view.addEventListener(CloseEvent.CLOSE, closepop);
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
						closepop (null);
					break;
				default:
					break;
			}
		}
		public function openMidia(media:MediaVO):void {
			view.removeAllChildren();
			try{
				movie.stop();
				view.rawChildren.removeChild(movie);	
			}catch (e:Error) {
			}
			
			switch(media.category_id) {
					case 4:
						movie = new FLVPlayback();
						movie.play('http://www.educar.tv/amf/services/autor/mediafiles/'+media.body);
						//movie.autoPlay = true;
						movie.autoRewind = false;
						//movie.setStyle("horizontalCenter",0);
						//movie.setStyle("verticalCenter",0);
						movie.skin="br/com/optimedia/interactive/assets/skinOverPlaySeekMute.swf"
						movie.width=300;
						movie.height = 300;
						movie.x=20;
						movie.skinBackgroundColor = 0x666666;
            			movie.skinAutoHide = true;
            			//movie.scaleMode = true
						view.rawChildren.addChild(movie as FLVPlayback);
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
						text.styleSheet = Application.application.styleSh;
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
							swfLoad = new SwfWithProgressBar();
							swfLoad.source = 'http://www.educar.tv/amf/services/autor/mediafiles/'+ media.body;
							swfLoad.autoLoad = true;
							swfLoad.scaleContent = true;
							view.addChild(swfLoad);
							
						}else {
							imagem = new ImageWithProgressBar();
							imagem.autoLoad = true;
							imagem.width = view.width*0.9;
							imagem.height = view.height*0.9;
							imagem.scaleContent = true;
							imagem.setStyle("horizontalCenter",0);
							imagem.setStyle("verticalCenter",0);
							imagem.source = 'http://www.educar.tv/amf/services/autor/mediafiles/'+media.body;
							view.addChild(imagem);
						}
						sendNotification(ApplicationConstants.OPEN_MIDIA_VIEW, media.category_id);
						break;
				}
		}
		private function closepop (event:CloseEvent):void {
			try{
				movie.stop();
				view.rawChildren.removeChild(movie);	
			}catch (e:Error) {
			}		
			view.removeAllChildren();
			view.visible = false;
			
		}
	}
}