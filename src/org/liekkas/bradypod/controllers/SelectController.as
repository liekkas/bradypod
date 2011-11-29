package org.liekkas.bradypod.controllers
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.managers.CursorManager;
	
	import org.liekkas.bradypod.utils.CursorImage;
	import org.liekkas.bradypod.views.Topo;
	
	/**
	 * 选择控制器
	 * @author liekkas.zeng
	 * @date 2011-11-29 13:23:32
	 * */
	public class SelectController extends BaseController
	{
		/**
		 * 鼠标按下的位置
		 * */
		protected var downPoint:Point;
		
		/**
		 * 框选颜色
		 * */
		protected var color:uint = 0x00ffff;
		
		/**
		 * 框选透明度
		 * */
		protected var alpha:Number = .1;
		
		public function SelectController(topo:Topo=null, active:Boolean=false, cursor:Class = null)
		{
			super(topo, active, null);
		}
		
		override protected function register():void
		{
			if(topo)
			{
				topo.topLayer.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
				topo.topLayer.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			}
		}
		
		override protected function unregister():void
		{
			if(topo)
			{
				topo.topLayer.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
				topo.topLayer.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			}
		}
		
		protected function onMouseDown(evt:MouseEvent):void
		{
			downPoint = new Point(evt.currentTarget.mouseX,evt.currentTarget.mouseY);
			topo.topLayer.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		
		/**
		 * 绘制框选区域
		 * */
		protected function onMouseMove(evt:MouseEvent):void
		{
			CursorManager.setCursor(CursorImage.CURSOR_SELECT);
			
			var x : Number = Math.min ( downPoint.x,evt.currentTarget.mouseX )  ; 
			var y : Number = Math.min ( downPoint.y,evt.currentTarget.mouseY )  ; 
			var w : Number = Math.abs ( downPoint.x-evt.currentTarget.mouseX )  ; 
			var h : Number = Math.abs ( downPoint.y-evt.currentTarget.mouseY )  ; 
			
			var rect:Rectangle = new Rectangle(x, y, w, h);
			
			topo.topLayer.graphics.clear();
			topo.topLayer.graphics.lineStyle(1);
			topo.topLayer.graphics.beginFill(color,alpha);
			topo.topLayer.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
			topo.topLayer.graphics.endFill();
		}
		
		protected function onMouseUp(evt:MouseEvent):void
		{
			CursorManager.removeAllCursors();
			topo.topLayer.graphics.clear();
			topo.topLayer.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
		}
	}
}