package br.com.optimedia.interactive.view
{
	import br.com.optimedia.interactive.assets.ApplicationConstants;
	import br.com.optimedia.interactive.assets.ApplicationMyAssets;
	import br.com.optimedia.interactive.assets.vo.MediaVO;
	import br.com.optimedia.interactive.assets.vo.SlideVO;
	import br.com.optimedia.interactive.view.components.NavigatorView;
	
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.controls.Image;
	import mx.core.Application;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class NavigatorMediator extends Mediator {
		
		public static const NAME:String = 'NavigatorMediator';
		
		public var btn:Image;
		public var medias:Array;
		public var btEnd:Image;
		
	//	private var interactiveProxy:InteractiveProxy = new InteractiveProxy();
		
		public function NavigatorMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			view.btMenu.addEventListener(MouseEvent.CLICK,showMenu);
			view.btNext.addEventListener(MouseEvent.CLICK,nextPage);
			view.btBack.addEventListener(MouseEvent.CLICK,backPage);
			
			//ignoreManagerProxy = facade.retrieveProxy( IgnoreManagerProxy.NAME ) as IgnoreManagerProxy;
		}
		
		override public function onRemove():void {
			trace(NAME+".onRemove()");
		}
		
		public function get view():NavigatorView
		{
			return viewComponent as NavigatorView;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
					ApplicationConstants.PAGE,
					ApplicationConstants.CONTRUCT_LINKS
					];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				
				case ApplicationConstants.PAGE:
						display (note.getBody() as Array);
					break;
				case ApplicationConstants.CONTRUCT_LINKS:
						constructionLink (note.getBody() as Array);
					break;
				default:
					break;
			}
		}
		 public function nextPage(event:MouseEvent):void {
		 	sendNotification(ApplicationConstants.NEXT_PAGE);
		 	
		 }
		 public function backPage (event:MouseEvent):void {
		 	sendNotification(ApplicationConstants.BACK_PAGE);
		 	
		 }
		 public function showMenu(event:MouseEvent):void {
		 	sendNotification( ApplicationConstants.TOGGLE_MENUVIEW_VISIBILITY );
		 }
		 public function display (note:Array):void {
		 	if (note[0]==1 && note[1]>1) {
		 		view.btBack.visible = false;
		 		view.btNext.visible = true;
		 	}else if (note[0]==1 && note[1]==1) {
		 		view.btBack.visible = false;
		 		view.btNext.visible = false;
		 	}else if (note[0] == note[1]) {
		 		view.btBack.visible = true;
		 		view.btNext.visible = false;
		 	} else {
		 		view.btBack.visible = true;
		 		view.btNext.visible = true;
		 	}
		 	
		 	//if (note[0]<=9) {
		 	//	note[0] = "0"+note[0];
		 	//}
		 	view.display.htmlText ="<span class='display'>"+ note[0] + " / " +  note[1] + "</span>";
		 	view.display.styleSheet = Application.application.styleSh;
		 	
		 }
		 public function constructionLink(note:Array):void {
		 	view.links.removeAllChildren();
		 	
		 	var vo:SlideVO = Application.application.menuView.menuList.selectedItem as SlideVO;
		 		
		 	if (vo.type_slide_id !=3) {
		 		btEnd = new Image();
		 		btEnd.width = 24;
		 		btEnd.height = 24;
		 		btEnd.data = Application.application.end.url;
		 		btEnd.addEventListener(MouseEvent.CLICK,clickEnd);
		 		btEnd.source = ApplicationMyAssets.btRef_tabela;
		 		view.links.addChild(btEnd);
		 	}
		 	
		 	medias = note;		 	
		 	for (var i:int=0 ; i<note.length; i++) {
		 		var media:MediaVO = note[i] as MediaVO;
		 		
		 		btn = new Image();
		 		btn.width = 24;
		 		btn.height = 24;
		 		btn.data = media;
		 		btn.addEventListener(MouseEvent.CLICK,clickLink);
		 		var categoriaId:uint = media.category_id;
		 		
		 		switch (categoriaId)
				{
					case 1:
						btn.source = ApplicationMyAssets.btRef_tabela;
						break;
					case 2:
						btn.source = ApplicationMyAssets.btRef_grafico;
						break;
					case 3:
						btn.source = ApplicationMyAssets.btRef_imagem;
						break;
					case 4:
						btn.source = ApplicationMyAssets.btRef_video;
						break;
					case 5:
						btn.source = ApplicationMyAssets.btRef_hiperlink;
						break;
					case 6:
						btn.source = ApplicationMyAssets.btRef_notas;
						break;
					case 7:
						btn.source = ApplicationMyAssets.btRef_file;
						break;
					default:
						btn.source = ApplicationMyAssets.btRef_imagem;
						break;
				}
		 		view.links.addChild(btn);
		 	}
		 }
		public function clickLink(event:MouseEvent):void {
		 	var media:MediaVO = event.currentTarget.data as MediaVO;
		 	sendNotification(ApplicationConstants.CREAT_MIDIA,media);
		 	
		 }
		public function clickEnd (event:MouseEvent):void {
			var end:String = event.currentTarget.data as String;
			
			var url:Array = end.split("?");
			
			var urlModulo:* = end.split("id=");
			var url1:String = urlModulo[1];
			var idModulo:Array = url1.split("&");
			
			//var id:uint = Application.application.idPresentation;
				 
			var vo:SlideVO = Application.application.menuView.menuList.selectedItem as SlideVO;
			
			Alert.show("Endereço da apresentação: \n " + url[0] +"?id=" + idModulo[0] + "&s=" + vo.slide_id );
		}
		 
	}
}