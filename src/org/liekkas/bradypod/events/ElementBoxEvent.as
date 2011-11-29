package org.liekkas.bradypod.events
{
	import flash.events.Event;
	
	import org.liekkas.bradypod.models.interfaces.IElement;
	
	/**
	 * 元素容器事件
	 * @author liekkas.zeng
	 * @date 2011-11-28 15:10:54
	 * */
	public class ElementBoxEvent extends Event
	{
		public static const ELEMENT_ADDED:String = "ElementBoxEvent.elementAdded";
		
		public static const ELEMENT_REMOVED:String = "ElementBoxEvent.elementRemoved";
		
		public var elementAdded:IElement;
		
		public var elementRemoved:IElement;
		
		public function ElementBoxEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new ElementBoxEvent(type,bubbles,cancelable);
		}
	}
}