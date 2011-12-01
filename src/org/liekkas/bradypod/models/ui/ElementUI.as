package org.liekkas.bradypod.models.ui
{
	import mx.core.UIComponent;
	
	import org.liekkas.bradypod.models.interfaces.IElement;
	
	/**
	 * 元素UI界面
	 * @author liekkas.zeng
	 * @date 2011-11-25 17:22:02
	 * */
	public class ElementUI extends UIComponent
	{
		/**
		 * 持有元素
		 * */
		protected var _element:IElement;

		public function get element():IElement
		{
			return _element;
		}

		protected var _selected:Boolean;

		/**
		 * 选中标志
		 * */
		public function set selected(value:Boolean):void
		{
			_selected = value;
			this.graphics.clear();
			invalidateDisplayList();
		}

		/**
		 * 移动标志
		 * */
		protected var _moved:Boolean;

		public function set moved(value:Boolean):void
		{
			_moved = value;
			invalidateDisplayList();
		}
		
		
		public function ElementUI(element:IElement)
		{
			super();
			_element = element;
		}
		
		/**
		 * 选中时绘制样式
		 * */
		protected function drawSelectedStyle():void
		{
			
		}
		
		protected function drawMovedStyle():void
		{
		
		}
		
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			
			if(_selected)
				drawSelectedStyle();
			
			if(_moved)
				drawMovedStyle();
		}
	}
}