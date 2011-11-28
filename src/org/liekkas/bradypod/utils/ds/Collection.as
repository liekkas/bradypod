package org.liekkas.bradypod.utils.ds
{
	/**
	 * @author liekkas.zeng
	 * @date 2011-11-25 15:45:45
	 * */
	public class Collection implements ICollection
	{
		public function Collection()
		{
		}
		
		public function get size():int
		{
			return 0;
		}
		
		public function add(item:*):void
		{
		}
		
		public function addAt(item:*, index:int):void
		{
		}
		
		public function addAll(collection:ICollection):void
		{
		}
		
		public function clear():void
		{
		}
		
		public function contains(item:*):Boolean
		{
			return false;
		}
		
		public function getItem(index:int):*
		{
			return null;
		}
		
		public function getIndex(item:*):int
		{
			return 0;
		}
		
		public function remove(item:*):int
		{
			return 0;
		}
		
		public function removeAt(index:int):*
		{
			return null;
		}
		
		public function forEach(callbackFunc:Function, reverse:Boolean=false):void
		{
		}
		
		public function sort(sortFunc:Function):ICollection
		{
			return null;
		}
	}
}