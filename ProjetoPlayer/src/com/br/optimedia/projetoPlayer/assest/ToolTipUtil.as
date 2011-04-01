package com.br.optimedia.projetoPlayer.assest{	
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import mx.controls.Image;
	import mx.controls.ToolTip;
	import mx.core.FlexVersion;
	import mx.core.IInvalidating;
	import mx.core.IUIComponent;
	import mx.core.UIComponent;
	import mx.effects.Zoom;
	import mx.events.EffectEvent;
	import mx.managers.IFocusManagerComponent;
	import mx.managers.ISystemManager;
	import mx.managers.ToolTipManager;
	import mx.styles.IStyleClient;
	
	public class ToolTipUtil
	{	
		public static var toolTip:ToolTip = null;
		private static var hideTimer:Timer;
		private static var focusColor:Number;
		private static var currentTarget:UIComponent;
		
		public static const BOTTOM:String="errorTipBelow";
		public static const RIGHT:String="errorTipRight";
		public static const TOP:String="errorTipAbove";
				
		public static function createToolTip(target:UIComponent,msg:String,icon:Class=null,isError:Boolean=false,position:String=BOTTOM,timerHide:Number=5000):void{
			destroyToolTip();
			currentTarget = target;
			focusColor = currentTarget.getStyle("focusColor");//Armazena a cor atual do focus do componente
			//Cria o tooltip,
			toolTip = ToolTipManager.createToolTip(msg, 0, 0,position,currentTarget) as ToolTip;
			
			positionTip(position);
			currentTarget.addEventListener(FocusEvent.FOCUS_OUT,destroyToolTip);

			//Estilos
			toolTip.setStyle("backgroundAlpha",0.8);
			toolTip.setStyle("dropShadowEnabled",true);
			toolTip.setStyle("shadowColor",0x723E05);
			toolTip.setStyle("fontWeight","bold");			
			toolTip.setStyle("paddingBottom",4);
			toolTip.setStyle("paddingLeft",4);
			toolTip.setStyle("paddingRight",4);
			toolTip.setStyle("paddingTop",4);

			//Estou trabalhando apenas com dois temas, um pra erro outra pra informações,
			//é possível criar um tema para cada tipo de mensagem exemplo(Ajuda, Informação,Aviso,Pergunta etc)
			if(isError){
				//Verifica se é a versão do sdk é menor que o Flex 4
				if (FlexVersion.CURRENT_VERSION < 0x04000000){
					currentTarget.setStyle("themeColor", currentTarget.getStyle("errorColor"));//Flex 3
				}else{
					currentTarget.setStyle("focusColor", currentTarget.getStyle("errorColor"));//Flex 4 agora é focusColor! 
				}

				toolTip.setStyle("color",0xFFFFFF);
			}else{
				toolTip.setStyle("color",0x774401);//Cor do Texto
				toolTip.setStyle("borderColor",0xFFD63E);//Cor do Fundo da caixa
			}
			
			if(icon){//Insere o ícone
				var img:Image = new Image();
				img.source = icon;
				var _textField:TextField = toolTip.getChildAt(1) as TextField;
				toolTip.addChild(img);
				_textField.text = "       "+msg;//Espaço para o texto não ficar sobre a ícone
				img.width = 25;
				img.height = 25;
				img.x =  _textField.x-2;
				img.y = _textField.y-2;
			}
			startHideTimer(timerHide);//Inicializa o contador que irá remover o tooltip
			currentTarget.setFocus();
		}
		public static function destroyToolTip(event:Event=null):void{
			if(toolTip != null){
				ToolTipManager.destroyToolTip(toolTip);
				toolTip = null;
				hideTimer.stop();
				
				//Volta a cor normal do componente
				if (FlexVersion.CURRENT_VERSION < 0x04000000){
					currentTarget.setStyle("themeColor", focusColor);
				}else{
					currentTarget.setStyle("focusColor", focusColor);
				}
				//Remove o listener
				currentTarget.removeEventListener(FocusEvent.FOCUS_OUT,destroyToolTip);
			}
		}
		public static function startHideTimer(timer:Number):void{
			
			if(hideTimer != null)
				hideTimer.stop();
			
			hideTimer = new Timer(timer,1);
			hideTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onHideTimerComplete);			
			hideTimer.start();
		}
		//Faz uma animação com o tooltip antes de destrui-lo
		private static function onHideTimerComplete(event:TimerEvent=null):void{
			var _zoom:Zoom = new Zoom(toolTip);
			_zoom.zoomHeightTo = 0;
			_zoom.zoomWidthTo = 0;
			_zoom.originX = 0;
			_zoom.originY = 0;
			_zoom.play();
			toolTip.text = String(toolTip.text).slice(toolTip.text.length/2,toolTip.text.length);
			_zoom.addEventListener(EffectEvent.EFFECT_END,destroyToolTip);			
		}
		//Posiciona o tooltip.
		private static function positionTip(position:String):void
		{
			var x:Number;
			var y:Number;
			
			var targetGlobalBounds:Rectangle = getGlobalBounds(currentTarget, toolTip.root);
			
			switch(position){
				case BOTTOM:
					x = targetGlobalBounds.x + 1;
					y = targetGlobalBounds.bottom - 3;
				break;
				case TOP:
					x = targetGlobalBounds.x + 1;
					y = targetGlobalBounds.top - toolTip.height+3;
				break;
				case RIGHT:
					x = targetGlobalBounds.right + 1;
					y = targetGlobalBounds.top - 3;	
				break;
			}

			toolTip.move(x, y);
		}
		private static function getGlobalBounds(obj:DisplayObject, parent:DisplayObject):Rectangle{
			var upperLeft:Point = new Point(0, 0);
			upperLeft = obj.localToGlobal(upperLeft);
			upperLeft = parent.globalToLocal(upperLeft);
			return new Rectangle(upperLeft.x, upperLeft.y, obj.width, obj.height);
		}
		
	}
}