package br.com.optimedia.interactive.view
{
	import br.com.optimedia.interactive.model.vo.SlideVO;
	
	import flash.display.Sprite;
	
	import mx.controls.Alert;
	import mx.core.Application;
	
	public class SlideMediator {
		
		public var lineTitle:uint = 0x000000;
		public var bgTitle:uint = 0xFFFFFF;
		
		public function SlideMediator() {
		}
		
		public function show(vo: SlideVO): void {
			Application.application.slideView.textTitle.visible=false;
			Application.application.slideView.textContent.visible=false;
			if (vo.type == SlideVO.TYPE_PAGE) {
				Application.application.slideView.slideVO = vo;
				layout(vo.type,20,"titleTYPEPAGE","contentTYPEPAGE");
			} else if (vo.type == SlideVO.TYPE_TITLE) {
				Application.application.slideView.slideVO = vo;
				layout(vo.type, 140,"titleTITLE","contentTITLE");
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