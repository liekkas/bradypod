package org.liekkas.bradypod.utils
{
	import flash.display.Graphics;
	
	import org.liekkas.bradypod.models.vos.XY;

	/**
	 * 绘制工具类
	 * @author liekkas.zeng
	 * @date 2011-11-30 15:49:43
	 * */
	public class DrawUtils
	{
		/**
		 * 画一条带箭头的线条
		 * */
		public static function drawArrowLine(g:Graphics,startXY:XY,endXY:XY,radius:int=6,edgeColor:uint=0,fillColor:uint=0):void
		{
			var angle:int = getAngle(startXY,endXY);
			g.clear();
			g.lineStyle(1,edgeColor);
			g.moveTo(startXY.x,startXY.y);
			g.lineTo(endXY.x,endXY.y);
			
			var centerX:int=endXY.x - radius * Math.cos(angle *(Math.PI/180)) ;
			var centerY:int=endXY.y + radius * Math.sin(angle *(Math.PI/180)) ;
			var topX:int=endXY.x ;
			var topY:int=endXY.y ;
			
			var leftX:int=centerX + radius * Math.cos((angle +120) *(Math.PI/180))  ;
			var leftY:int=centerY - radius * Math.sin((angle +120) *(Math.PI/180))  ;
			
			var rightX:int=centerX + radius * Math.cos((angle +240) *(Math.PI/180))  ;
			var rightY:int=centerY - radius * Math.sin((angle +240) *(Math.PI/180))  ;
			
			g.beginFill(fillColor,1);
			
			g.lineStyle(1,edgeColor,1);
			
			g.moveTo(topX,topY);
			g.lineTo(leftX,leftY);
			
			g.lineTo(centerX,centerY);
			
			g.lineTo(rightX,rightY);
			g.lineTo(topX,topY);
			
			g.endFill();
		}
		
		private static function getAngle(startXY:XY, endXY:XY):int
		{
			var x:int = endXY.x - startXY.x;
			var y:int = startXY.y -endXY.y;
			return Math.atan2(y,x)*(180/Math.PI);
		}
	}
}