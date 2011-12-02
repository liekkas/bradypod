package org.liekkas.bradypod.events
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.liekkas.bradypod.models.interfaces.IElement;
	import org.liekkas.bradypod.views.Topo;
	
	/**
	 * 交互事件
	 * @author liekkas.zeng
	 * */
	public class InteractionEvent extends Event
	{
		/**
		 * 添加一个节点 -- 鼠标单击添加一个拓扑节点
		 * */
		public static const CLICK_ADD_NODE:String = "InteractionEvent.clickAddNode";
		
		/**
		 * 添加一个节点 -- 鼠标双击添加一个拓扑节点
		 * */
		public static const DOUBLE_CLICK_ADD_NODE:String = "InteractionEvent.doubleClickAddNode";
		
		/**
		 * 点击元素事件 --鼠标点击的地方是个拓扑元素
		 * */
		public static const CLICK_ELEMENT:String = "InteractionEvent.clickElement";
		
		/**
		 * 点击空白事件 --鼠标点击的地方是背景空白处
		 * */
		public static const CLICK_BACKGROUND:String = "InteractionEvent.clickBackground";
		
		/**
		 * 绘制边开始 -- 鼠标从一个节点move出来一条直线
		 * */
		public static const DRAW_EDGE_START:String = "InteractionEvent.drawEdgeStart";
		
		/**
		 * 绘制边结束 -- 鼠标从一个节点move出来一条直线
		 * */
		public static const DRAW_EDGE_END:String = "InteractionEvent.drawEdgeEEnd";
		
		/**
		 * 框选开始 -- 鼠标按下开始进行矩形框选
		 * */
		public static const SELECT_START:String = "InteractionEvent.selectStart";
		
		/**
		 * 框选结束 -- 鼠标释放结束矩形框选
		 * */
		public static const SELECT_END:String = "InteractionEvent.selectEnd";
		
		/**
		 * 拖拽整个拓扑开始 --拖拽模式下启用
		 * */
		public static const DRAG_TOPO_START:String = "InteractionEvent.dragTopoStart";
		
		/**
		 * 拖拽整个拓扑结束 --拖拽模式下启用
		 * */
		public static const DRAG_TOPO_END:String = "InteractionEvent.dragTopoEnd";
		
		/**
		 * 绑定拓扑
		 * */
		public var topo:Topo;
		
		/**
		 * 绑定原鼠标事件
		 * */
		public var mouseEvent:MouseEvent;
		
		/**
		 * 当前元素
		 * */
		public var element:IElement;
		
		/**
		 * 额外信息
		 * */
		public var payload:*;
		
		public function InteractionEvent(type:String,payload:* = null,topo:Topo = null,mouseEvent:MouseEvent = null,element:IElement = null)
		{
			super(type);
			this.payload = payload;
			this.topo = topo;
			this.mouseEvent = mouseEvent;
			this.element = element;
		}
		
		override public function clone():Event
		{
			return new InteractionEvent(type,payload,topo,mouseEvent,element);
		}
	}
}