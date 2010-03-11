package br.com.optimedia.interactive.view {
	
	import br.com.optimedia.assets.vo.MediaVO;
	import br.com.optimedia.interactive.assets.ApplicationConstants;
	import br.com.optimedia.interactive.view.components.MidiaView;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import mx.controls.Image;
	import mx.controls.SWFLoader;
	import mx.controls.TextArea;
	import mx.controls.VideoDisplay;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import mx.events.CloseEvent;
	import fl.video.FLVPlayback;

	public class MidiaMediator extends Mediator {
		
		public static const NAME:String = 'MidiaMediator';
		
		public var text:TextArea;
		public var imagem:Image;
		public var swfLoad:SWFLoader;
		public var movie:FLVPlayback; 
		
		
		public function MidiaMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			view.addEventListener(CloseEvent.CLOSE, closeMidia);
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
						closeMidia( null );
					break;
				default:
					break;
			}
		}
		public function closeMidia(e:CloseEvent):void {
			try{
				movie.stop();
				view.rawChildren.removeChild(movie);	
			}catch (e:Error) {
			}		
			view.removeAllChildren();
			view.visible = false;
		}
		public function openMidia(media:MediaVO):void {
			view.removeAllChildren();
			try{
				movie.stop();
				view.rawChildren.removeChild(movie);	
			}catch (e:Error) {
			}
			
			var media:MediaVO = media;
			switch(media.category_id) {
				case 4:
					movie = new FLVPlayback();
					movie.play('http://www.educar.tv/amf/services/autor/mediafiles/'+media.body);
					movie.autoRewind = false;
					movie.skin="http://www.educar.tv/sinase.moodle/interactive/br/com/optimedia/interactive/assets/skinOverPlaySeekMute.swf"
					movie.scaleMode = "maintainAspectRatio";
					movie.x=view.width/2 -movie.width/2;
					movie.y=view.height/2 -movie.height/2;
					movie.skinBackgroundColor = 0x666666;
        			movie.skinAutoHide = true;
					
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
					text.percentWidth = 100;
					text.percentHeight = 100;
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
			
		}
	}
}