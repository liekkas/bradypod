package org.liekkas.bradypod.controllers
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.managers.CursorManager;
	
	import org.liekkas.bradypod.models.Node;
	import org.liekkas.bradypod.models.interfaces.IElement;
	import org.liekkas.bradypod.utils.CursorImage;
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
		
		public function EditController(topo:Topo=null, active:Boolean=false, cursor:Class=null)
		{
			super(topo, active, cursor);
		}
		
		override protected function register():void
		{
			if(topo)
			{
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
			topo.topLayer.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		
		/**
		 * 绘制框选区域
		 * */
		protected function onMouseMove(evt:MouseEvent):void
		{
			trace(">>> EditController.onMouseMove");
			CursorManager.setCursor(CursorImage.CURSOR_SELECT,2,-10,-10);
			
			var x : Number = Math.min ( downPoint.x,evt.currentTarget.mouseX )  ; 
			var y : Number = Math.min ( downPoint.y,evt.currentTarget.mouseY )  ; 
			var w : Number = Math.abs ( downPoint.x-evt.currentTarget.mouseX )  ; 
			var h : Number = Math.abs ( downPoint.y-evt.currentTarget.mouseY )  ; 
			
			rect = new Rectangle(x, y, w, h);
			
			topo.topLayer.graphics.clear();
			topo.topLayer.graphics.lineStyle(1);
			topo.topLayer.graphics.beginFill(color,alpha);
			topo.topLayer.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
			topo.topLayer.graphics.endFill();
			
			allowClick = false;
		}
		
		protected function onMouseUp(evt:MouseEvent):void
		{
			trace(">>> EditController.onMouseUp");
			
			if(!allowClick)
			{
				for each(var ele:IElement in elements)
				{
					if(ele is Node)
					{
						if(Node(ele).containedByRect(rect))
						{
							Node(ele).selected = true;
							topo.selectionModel.add(ele);
						}
						else
						{
							Node(ele).selected = false;
							topo.selectionModel.remove(ele);
						}
					}
				}
			}
			
			
			CursorManager.removeAllCursors();
			topo.topLayer.graphics.clear();
			topo.topLayer.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		
		/**
		 * 鼠标点击会出现两种情况：
		 * 	1、所点击的地方是空的，这时把拓扑选中模型清空，然后new一个节点
		 *  2、所点击的地方已经有了一个节点，把这个节点加入到选中模型中，然后高亮这个节点，同时把以前高亮过的节点都恢复到正常状态
		 * */
		protected function onClick(evt:MouseEvent):void
		{
			trace(">>> EditController.onClick");
			if(allowClick)
			{
				trace(">>> EditController.onClick >>> allowClick");
				var x:Number = evt.currentTarget.mouseX;
				var y:Number = evt.currentTarget.mouseY;
				
				topo.selectionModel.clear();
				
				/**
				 * 有种情况是多个元素叠在一起，这时以最上面的为准，在数组里就是后面的为准，
				 * 因此倒转数组，只要找到第一个就break
				 * */
				for each(var ele:IElement in elements.reverse())
				{
					if(ele is Node && Node(ele).containXY(x,y))
					{
						Node(ele).selected = true;
						topo.selectionModel.add(ele);
						break;
					}
				}
				
				if(topo.selectionModel.size() == 0)
				{
					var e:Node = new Node("111");
					e.w = 50;
					e.h = 50;
					e.x = evt.currentTarget.mouseX - e.w * .5;
					e.y = evt.currentTarget.mouseY - e.h * .5;
					e.icon = "icon";
					e.name = "sss";
					topo.elementBox.add(e);
				}
			}
			else
			{
				allowClick = true;
			}
		}
	}
}