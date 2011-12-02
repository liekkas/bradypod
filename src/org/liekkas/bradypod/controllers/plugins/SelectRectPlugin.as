package org.liekkas.bradypod.controllers.plugins
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.managers.CursorManager;
	
	import org.liekkas.bradypod.events.InteractionEvent;
	import org.liekkas.bradypod.models.Node;
	import org.liekkas.bradypod.models.interfaces.IElement;
	import org.liekkas.bradypod.utils.CursorImage;
	import org.liekkas.bradypod.views.Topo;
	
	/**
	 * 区域框选插件
	 * @author liekkas.zeng
	 * */
	public class SelectRectPlugin extends AbstractPlugin
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
		
		/**
		 * 框选矩形
		 * */
		protected var rect:Rectangle;
		
		/**
		 * 是否用框选光标
		 * */
		protected var cursorFlag:Boolean = true;
		
		public function SelectRectPlugin(topo:Topo)
		{
			super(topo);
		}
		
		override public function install():void
		{
			if(topo)
			{
				topo.addEventListener(InteractionEvent.SELECT_START,onSelectStart);
				topo.addEventListener(InteractionEvent.SELECT_END,onSelectEnd);
				trace("安装插件成功  >>> SelectRectPlugin");
			}
			else
			{
				trace("安装插件失败  >>> topo为空!!!");
			}
		}
		
		override public function uninstall():void
		{
			if(topo)
			{
				topo.removeEventListener(InteractionEvent.SELECT_START,onSelectStart);
				topo.removeEventListener(InteractionEvent.SELECT_END,onSelectEnd);
				trace("卸载插件成功  >>> SelectRectPlugin");
			}
			else
			{
				trace("卸载插件失败  >>> topo为空!!!");
			}
		}
		
		/**
		 * 框选进行中
		 * */
		protected function onSelectStart(evt:InteractionEvent):void
		{
			downPoint = evt.payload; //获得鼠标按下的起始位置
			if(cursorFlag)
			{
				CursorManager.setCursor(CursorImage.CURSOR_SELECT,2,-10,-10);
				cursorFlag = false; //避免移动过程中多次设置
			}
				
			//计算矩形
			var curX:Number = evt.mouseEvent.currentTarget.mouseX;
			var curY:Number = evt.mouseEvent.currentTarget.mouseY;
			var x : Number = Math.min ( downPoint.x, curX )  ; 
			var y : Number = Math.min ( downPoint.y, curY )  ; 
			var w : Number = Math.abs ( downPoint.x- curX )  ; 
			var h : Number = Math.abs ( downPoint.y- curY )  ; 
			
			rect = new Rectangle(x, y, w, h);
			
			topo.topLayer.graphics.clear();
			topo.topLayer.graphics.lineStyle(1);
			topo.topLayer.graphics.beginFill(color,alpha);
			topo.topLayer.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
			topo.topLayer.graphics.endFill();
		}
		
		/**
		 * 完成框选，落在此区域内的元素标为选中样式
		 * */
		protected function onSelectEnd(evt:InteractionEvent):void
		{
			topo.selectionModel.clear();
			
			topo.selectionModel.selectionElements = topo.getElementsUnderRect(rect);

			cursorFlag = true;
			CursorManager.removeCursor(CursorManager.currentCursorID);
			topo.topLayer.graphics.clear();
		}
	}
}