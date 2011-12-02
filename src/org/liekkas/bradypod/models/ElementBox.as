package org.liekkas.bradypod.models
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Rectangle;
	
	import mx.collections.ArrayCollection;
	
	import org.liekkas.bradypod.events.ElementBoxEvent;
	import org.liekkas.bradypod.models.interfaces.IElement;
	
	/**
	 * 拓扑数据容器
	 * @author liekkas.zeng
	 * */
	public class ElementBox extends EventDispatcher
	{
		/**
		 * 数据源
		 * */
		protected var _elements:ArrayCollection = new ArrayCollection();

		/**
		 * 节点集合
		 * */
		public var nodes:Array = [];
		
		/**
		 * 节点个数
		 * */
		public var nodesNum:int;
		
		/**
		 * 节点总长度
		 * */
		public var nodesLen:Number = 0;
		
		/**
		 * 边的个数
		 * */
		public var edges:int;
		
		/**
		 * 反转的数据集合
		 * */
		protected var _reverseElements:Array;
		
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
		 * 获得某点下的元素节点
		 * */
		public function getElementUnderPoint(x:Number,y:Number):Node
		{
			/**
			 * 有种情况是多个元素叠在一起，这时以最上面的为准，在数组里就是后面的为准，
			 * 因此倒转数组，只要找到第一个就break
			 * */
			for each(var ele:IElement in reverseElemes)
			{
				if(ele is Node && Node(ele).containXY(x,y))
				{
					return Node(ele);
				}
			}
			
			return null;
		}
		
		/**
		 * 获得某个框选区域内的元素节点
		 * */
		public function getElementsUnderRect(rect:Rectangle):Array
		{
			var result:Array = [];
			
			for each(var ele:IElement in elements)
			{
				if(ele is Node)
				{
					if(Node(ele).containedByRect(rect))
					{
						result.push(ele);
					}
				}
			}
			
			return result;
		}
		
		/**
		 * 获得反转数据集合
		 * */
		private function get reverseElemes():Array
		{
			if(!_reverseElements)
				_reverseElements = _elements.source.reverse();
			return _reverseElements;
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