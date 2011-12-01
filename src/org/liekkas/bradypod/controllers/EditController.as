package org.liekkas.bradypod.controllers
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.managers.CursorManager;
	
	import org.liekkas.bradypod.controllers.plugins.AddNodePlugin;
	import org.liekkas.bradypod.controllers.plugins.DrawEdgePlugin;
	import org.liekkas.bradypod.controllers.plugins.SelectNodePlugin;
	import org.liekkas.bradypod.controllers.plugins.SelectRectPlugin;
	import org.liekkas.bradypod.events.InteractionEvent;
	import org.liekkas.bradypod.models.Edge;
	import org.liekkas.bradypod.models.Node;
	import org.liekkas.bradypod.models.interfaces.IElement;
	import org.liekkas.bradypod.models.ui.EdgeUI;
	import org.liekkas.bradypod.models.vos.XY;
	import org.liekkas.bradypod.utils.CursorImage;
	import org.liekkas.bradypod.utils.DrawUtils;
	import org.liekkas.bradypod.views.Topo;
	
	/**
	 * 编辑控制器
	 * 功能： 1、鼠标点击就能添加一个新的node
	 * 	   2、从一个node做鼠标move操作视为连线
	 *     3、在空白处框做鼠标Move视为框选
	 * @authro liekkas.zeng
	 * @date 2011-11-29 15:13:07
	 * */
	public class EditController extends BaseController
	{
		protected var _elements:Array;

		/**
		 * 拓扑元素
		 * */
		public function get elements():Array
		{
			return _elements ? _elements : topo.elementBox.elements.source;
		}

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
		 * 鼠标click标志 --有时在mouse_down和mouse_up后不希望还有click事件，可以在mouse_move里设为false不让click
		 * */
		protected var allowClick:Boolean = true;
		
		/**
		 * 框选矩形
		 * */
		protected var rect:Rectangle;
		
		/**
		 * 绘制边时的起始node
		 * */
		protected var fromNode:Node;
		
		/**
		 * 绘制边时的终止node
		 * */
		protected var toNode:Node;
		
		/**
		 * 绘制边时沿途碰撞过的node数组
		 * */
		protected var collides:Array = [];
		
		public function EditController(topo:Topo=null, active:Boolean=false, cursor:Class=null)
		{
			super(topo, active, cursor);
		}
		
		override protected function register():void
		{
			if(topo)
			{
				new SelectNodePlugin(topo).install();
				new SelectRectPlugin(topo).install();
				new DrawEdgePlugin(topo).install();
				new AddNodePlugin(topo).install();
				
				topo.addEventListener(MouseEvent.CLICK,onClick);
				topo.topLayer.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
				topo.topLayer.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			}
		}
		
		override protected function unregister():void
		{
			if(topo)
			{
				topo.removeEventListener(MouseEvent.CLICK,onClick);
				topo.topLayer.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
				topo.topLayer.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			}
		}
		
		protected function onMouseDown(evt:MouseEvent):void
		{
			trace(">>> EditController.onMouseDown");
			downPoint = new Point(evt.currentTarget.mouseX,evt.currentTarget.mouseY);
			
			fromNode = topo.getElementUnderPoint(downPoint.x,downPoint.y);
			
			topo.topLayer.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		
		/**
		 * 绘制框选区域
		 * */
		protected function onMouseMove(evt:MouseEvent):void
		{
			if(fromNode)
			{
				topo.dispatchEvent(new InteractionEvent(
					InteractionEvent.DRAW_EDGE_START,fromNode,topo,evt,fromNode));
			}
			else
			{
				topo.dispatchEvent(new InteractionEvent(
					InteractionEvent.SELECT_START,downPoint,topo,evt));
			}
			allowClick = false;
		}
		
		/**
		 * 鼠标释放事件
		 * */
		protected function onMouseUp(evt:MouseEvent):void
		{
			if(!allowClick)
			{
				if(fromNode)
				{
					topo.dispatchEvent(new InteractionEvent(InteractionEvent.DRAW_EDGE_END));
				}
				else
				{
					topo.dispatchEvent(new InteractionEvent(InteractionEvent.SELECT_END));
				}
			}
			topo.topLayer.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		
		/**
		 * 鼠标点击会出现两种情况：
		 * 	1、所点击的地方是空的，这时把拓扑选中模型清空，然后new一个节点
		 *  2、所点击的地方已经有了一个节点，把这个节点加入到选中模型中，然后高亮这个节点，同时把以前高亮过的节点都恢复到正常状态
		 * */
		protected function onClick(evt:MouseEvent):void
		{
			if(allowClick)
			{
				var x:Number = evt.currentTarget.mouseX;
				var y:Number = evt.currentTarget.mouseY;
				
				topo.selectionModel.clear();
				
				var selectedEle:Node = topo.getElementUnderPoint(x,y);
				
				if(selectedEle)
				{
					topo.dispatchEvent(new InteractionEvent(
						InteractionEvent.CLICK_ELEMENT,selectedEle));
				}
				else
				{
					topo.dispatchEvent(new InteractionEvent(
						InteractionEvent.CLICK_ADD_NODE));
				}
			}
			else
			{
				allowClick = true;
			}
		}
	}
}