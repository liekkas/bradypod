package org.liekkas.bradypod.models
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	import org.liekkas.bradypod.events.ElementBoxEvent;
	import org.liekkas.bradypod.models.interfaces.IElement;
	
	/**
	 * 数据容器
	 * @author liekkas.zeng
	 * @date 2011-11-25 15:53:24
	 * */
	public class ElementBox extends EventDispatcher
	{
		protected var _elements:ArrayCollection = new ArrayCollection();

		public var nodes:Array = [];
		public var nodesNum:int;
		public var nodesLen:Number = 0;		
		public var edges:int;
		
		public function get elements():ArrayCollection
		{
			return _elements;
		}

		public function set elements(value:ArrayCollection):void
		{
			_elements = value;
			
			for each(var ele:IElement in _elements)
			{
				counts(ele);
			}
		}

		
		public function ElementBox(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		/**
		 * 添加单个元素
		 * */
		public function add(element:IElement):void
		{
			counts(element);	
			elements.addItem(element);
			
			var evt:ElementBoxEvent = new ElementBoxEvent(ElementBoxEvent.ELEMENT_ADDED);
			evt.elementAdded = element;
			this.dispatchEvent(evt);
		}
		
		/**
		 * 统计数量
		 * */
		private function counts(element:IElement):void
		{
			if(element is Node)
			{
				nodes.push(Node(element));
				nodesNum ++;
				nodesLen += Node(element).w;
			}
			else if(element is Edge)
				edges ++;
		}
		
		/**
		 * 清空
		 * */
		public function clear():void
		{
			elements.removeAll();
		}
	}
}