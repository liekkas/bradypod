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
	 * */
	public class EditController extends AbstractController
	{
		/**
		 * 鼠标按下的位置
		 * */
		protected var downPoint:Point;
		
		/**
		 * 鼠标click标志 --有时在mouse_down和mouse_up后不希望还有click事件，可以在mouse_move里设为false不让click
		 * */
		protected var allowClick:Boolean = true;
		
		/**
		 * 鼠标按下时的节点
		 * */
		protected var downNode:Node;
		
		public function EditController(topo:Topo=null, active:Boolean=false, cursor:Class=null)
		{
			super(topo, active, cursor);
		}
		
		override protected function register():void
		{
			if(topo)
			{
				installPlugins([
					 new SelectNodePlugin(topo)
					,new SelectRectPlugin(topo)
					,new DrawEdgePlugin(topo)
					,new AddNodePlugin(topo)
				]);

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
			
			super.unregister();
		}
		
		/**
		 * 鼠标按下事件
		 * 并记住落下的位置以及去获取这个位置上的拓扑元素
		 * */
		protected function onMouseDown(evt:MouseEvent):void
		{
			downPoint = new Point(evt.currentTarget.mouseX,evt.currentTarget.mouseY);
			
			downNode = topo.getElementUnderPoint(downPoint.x,downPoint.y);
			
			topo.topLayer.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		
		/**
		 * 鼠标移动事件
		 * 如果落点处有元素则以该点为起点开始绘制边，反之则进行框选操作
		 * */
		protected function onMouseMove(evt:MouseEvent):void
		{
			if(downNode)
			{
				topo.dispatchEvent(new InteractionEvent(
					InteractionEvent.DRAW_EDGE_START,downNode,topo,evt));
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
		 * 同上，根据起始点是否有拓扑元素派发不同的额事件
		 * */
		protected function onMouseUp(evt:MouseEvent):void
		{
			if(!allowClick)
			{
				if(downNode)
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
				trace("EditController >>> onClick");
				
				var x:Number = evt.currentTarget.mouseX;
				var y:Number = evt.currentTarget.mouseY;
				
				topo.selectionModel.clear();
				
				if(downNode)
				{
					topo.dispatchEvent(new InteractionEvent(
						InteractionEvent.CLICK_ELEMENT,downNode));
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