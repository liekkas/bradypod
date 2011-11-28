package org.liekkas.bradypod.models
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	import org.liekkas.bradypod.models.interfaces.IElement;
	
	/**
	 * 数据容器
	 * @author liekkas.zeng
	 * @date 2011-11-25 15:53:24
	 * */
	public class ElementBox extends EventDispatcher
	{
		protected var _elements:ArrayCollection = new ArrayCollection();

		public function get elements():ArrayCollection
		{
			return _elements;
		}

		public function set elements(value:ArrayCollection):void
		{
			_elements = value;
		}

		
		public function ElementBox(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function add(element:IElement):void
		{
			elements.addItem(element);
		}
	}
}