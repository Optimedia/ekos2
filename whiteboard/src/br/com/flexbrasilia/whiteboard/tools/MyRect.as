package br.com.flexbrasilia.whiteboard.tools
{
	import br.com.flexbrasilia.whiteboard.WhitePaper;
	
	import flash.display.Shape;
	import flash.events.MouseEvent;
	
	public class MyRect extends DrawingTool
	{
		private var shape:Shape;
		
		override public function beginDrawing(event:MouseEvent):void
		{
			super.beginDrawing( event );
			
			shape = new Shape();
			WhitePaper(target).rawChildren.addChild( shape );
		}
		
		override public function moveDrawing(event:MouseEvent):void
		{
			super.moveDrawing( event );
			shape.graphics.clear();
			shape.graphics.lineStyle(lineStroke, lineColor, lineAlpha);
			shape.graphics.beginFill(fillColor, fillAlpha);
			//se estiver segurando Shift, faz um quadrado perfeito
			if( event.shiftKey ) {
				var dif:Number;
				var xDif:Number = endX - startX;
				var yDif:Number = endY - startY;
				
				//se estiver no quadrante +x +y
				if( xDif >= 0 && yDif >= 0 ) {
					if( xDif > yDif ) {
						dif = xDif;
					}
					else {
						dif = yDif;
					}
					shape.graphics.drawRect(startX, startY, dif, dif);
				}
				
				//se estiver no quadrante +x -y
				if( xDif >= 0 && yDif < 0 ) {
					yDif = yDif * -1;
					if( xDif > yDif ) {
						dif = xDif;
					}
					else {
						dif = yDif;
					}
					shape.graphics.drawRect(startX, startY, dif, -dif);
				}
				//se estiver no quadrante -x -y
				else if( xDif < 0 && yDif < 0 ) {
					yDif = yDif * -1;
					xDif = xDif * -1;
					if( xDif > yDif ) {
						dif = xDif;
					}
					else {
						dif = yDif;
					}
					shape.graphics.drawRect(startX, startY, -dif, -dif);
				}
				//se estiver no quadrante -x +y
				else if( xDif < 0 && yDif > 0 ) {
					xDif = xDif * -1;
					if( xDif > yDif ) {
						dif = xDif;
					}
					else {
						dif = yDif;
					}
					shape.graphics.drawRect(startX, startY, -dif, dif);
				}
			}
			//se nao estiver segurando o Shift
			else {
				shape.graphics.drawRect(startX, startY, endX-startX, endY-startY);
			}
		}
		
		override public function stopDrawing(event:MouseEvent):void
		{
			super.stopDrawing( event );
			shape.graphics.endFill();
		}
	}
}