package br.com.flexbrasilia.whiteboard.tools
{
	import br.com.flexbrasilia.whiteboard.WhitePaper;
	
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.display.Graphics;
	
	public class MyPen extends DrawingTool
	{
		
		private var shape:Shape;
		
		override public function beginDrawing(event:MouseEvent):void
		{
			super.beginDrawing( event );
			
			shape = new Shape();
			shape.graphics.lineStyle(lineStroke, lineColor, lineAlpha);
			shape.graphics.moveTo(startX, startY);
			WhitePaper(target).rawChildren.addChild( shape );
		}
		
		override public function moveDrawing(event:MouseEvent):void
		{
			super.moveDrawing( event );
			shape.graphics.lineTo(endX, endY);
		}
		
		override public function stopDrawing(event:MouseEvent):void
		{
			super.stopDrawing( event );
		}
		
	}
}