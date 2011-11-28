package org.liekkas.bradypod.models
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.core.UIComponent;
	
	import org.liekkas.bradypod.models.interfaces.IElement;
	import org.liekkas.bradypod.utils.ds.ICollection;
	
	/**
	 * 基本拓扑元素
	 * */
	public class Element extends EventDispatcher implements IElement
	{
		protected var _id:String;
		protected var _name:String;
		protected var _icon:String;
		
		public function Element(id:String=null)
		{
			_id = id;
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function set name(value:String):void
		{
			_name = value;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function set icon(value:String):void
		{
			_icon = value;
		}
		
		public function get icon():String
		{
			return _icon;
		}
		
		public function get elementUI():UIComponent
		{
			return null;
		}
		
		public function get attributes():ICollection
		{
			return null;
		}
		
		public function getAttribute(key:String):*
		{
			return null;
		}
		
		public function setAttribute(key:String, value:*)
		{
			
		}
	}
}