package org.liekkas.bradypod.models
{
	import org.liekkas.bradypod.models.interfaces.IElement;

	/**
	 * 选择模型
	 * @author liekkas.zeng
	 * @date 2011-11-29 17:50:13
	 * */
	public class SelectionModel
	{
		protected var _selectionElements:Array = [];

		public function get selectionElements():Array
		{
			return _selectionElements;
		}

		public function set selectionElements(value:Array):void
		{
			_selectionElements = value;
		}
		
		/**
		 * 当前是否选中了元素
		 * */
		public function size():int
		{
			return selectionElements.length;
		}
		
		/**
		 * 如果有元素，获得第一个选中的元素
		 * */
		public function getFirstElement():IElement
		{
			return selectionElements[0];
		}
		
		/**
		 * 加入一个元素
		 * */
		public function add(ele:IElement):void
		{
			selectionElements.push(ele);
			trace("新增一个选中元素 >>> 总长度：" + selectionElements.length);
		}
		
		/**
		 * 删除一个元素
		 * */
		public function remove(ele:IElement):void
		{
			for(var i:int = 0;i < size();i++)
			{
				if(selectionElements[i] == ele)
				{
					selectionElements.splice(i,1);
					break;
				}
			}
		}
		
		/**
		 * 清空
		 * */
		public function clear():void
		{
			for each(var ele:IElement in selectionElements)
			{
				Node(ele).selected = false;
			}
			
			selectionElements = [];
		}
		
		public function SelectionModel()
		{
		}
	}
}