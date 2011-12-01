package org.liekkas.bradypod.models.ui
{
	import org.liekkas.bradypod.models.Edge;
	import org.liekkas.bradypod.models.Node;
	import org.liekkas.bradypod.models.interfaces.IElement;
	import org.liekkas.bradypod.models.vos.XY;
	import org.liekkas.bradypod.utils.DrawUtils;
	
	/**
	 * 边UI界面
	 * @author liekkas.zeng
	 * */
	public class EdgeUI extends ElementUI
	{
		//箭头的大小
		public var radius:int=6;
		
		protected var edge:Edge;
		
		public function EdgeUI(edge:Edge)
		{
			super(edge);
			this.edge = edge;
			drawMovedStyle();
		}
		
		override protected function drawSelectedStyle():void
		{
		}
		
		override protected function drawMovedStyle():void
		{
			var f:Node = edge.fromNode;
			var t:Node = edge.toNode;
			
			var startXY:XY = new XY(f.x+f.w*.5,f.y+f.h*.5);
			var endXY:XY = new XY(t.x+t.w*.5,t.y+t.h*.5);
			
			DrawUtils.drawArrowLine(this.graphics,startXY,endXY,radius);
		}
	}
}