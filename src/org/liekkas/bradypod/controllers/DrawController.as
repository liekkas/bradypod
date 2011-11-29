package org.liekkas.bradypod.controllers
{
	import org.liekkas.bradypod.utils.CursorImage;
	import org.liekkas.bradypod.views.Topo;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.liekkas.bradypod.models.Node;
	
	/**
	 * 绘制控制器
	 * @author liekkas.zeng
	 * @date 2011-11-29 13:23:06
	 * */
	public class DrawController extends BaseController
	{
		public function DrawController(topo:Topo=null, active:Boolean=false ,cursor:Class = null)
		{
			super(topo, active, cursor?cursor:CursorImage.CURSOR_DRAW);
		}
		
		override protected function register():void
		{
			if(topo)
			{
				topo.graphLayer.addEventListener(MouseEvent.CLICK,onClick);
			}
		}
		
		override protected function unregister():void
		{
			if(topo)
			{
				topo.graphLayer.removeEventListener(MouseEvent.CLICK,onClick);
			}
		}
		
		protected function onClick(evt:MouseEvent):void
		{
//			var conArr:Array = topo.graphLayer.getObjectsUnderPoint(new Point(evt.localX,evt.localY));   
//			var len:int = conArr.length;
//			if(len > 1)
//			{
//				for(var i:int = 0;i < len;i++)
//				{  
//					if(conArr[i] is Node)
//					{
//						trace(conArr[i]);  
//					}  
//				}   
//			}  
//			else
//			{
				var e:Node = new Node("111");
				e.w = 50;
				e.h = 50;
				e.x = evt.localX;
				e.y = evt.localY;
				e.icon = "icon";
				e.name = "sss";
				topo.elementBox.add(e);
//			}
		}
	}
}