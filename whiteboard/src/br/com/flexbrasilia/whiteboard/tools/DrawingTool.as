package br.com.flexbrasilia.whiteboard.tools
{
	import br.com.flexbrasilia.whiteboard.WhitePaper;
	import br.com.flexbrasilia.whiteboard.interfaces.IDrawingTool;
	
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	

	public class DrawingTool implements IDrawingTool
	{
		public var target:UIComponent;
		
		public var startX:Number;
		public var startY:Number;
		
		public var endX:Number;
		public var endY:Number;
		
		public var lineColor:Number = 0x000000;
		public var lineStroke:Number = 1;
		public var lineAlpha:Number = 1;
		
		public var fillColor:Number = 0x000000;
		public var fillAlpha:Number = 1;
		
		public function beginDrawing(event:MouseEvent):void {
			this.startX = event.localX;
			this.startY = event.localY;
			this.target = event.currentTarget as UIComponent;
		}
		
		public function moveDrawing(event:MouseEvent):void {
			if(event.localX >= WhitePaper(event.currentTarget).width) {
				this.endX = WhitePaper(event.currentTarget).width-1;
			}
			else {
				this.endX = event.localX;
			}
			if(event.localY <= 0) {
				this.endY = 0;
			}
			else {
				this.endY = event.localY;
			}
		}
		
		public function stopDrawing(event:MouseEvent):void {
			this.endX = event.localX;
			this.endY = event.localY;
		}
		
	}
}