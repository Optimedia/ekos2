package br.com.flexbrasilia.whiteboard.interfaces
{
	import flash.events.MouseEvent;
	
	public interface IDrawingTool
	{
		function beginDrawing(event:MouseEvent):void
		
		function moveDrawing(event:MouseEvent):void
		
		function stopDrawing(event:MouseEvent):void
	}
}