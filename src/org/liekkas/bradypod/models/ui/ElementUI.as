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
		protected var _element:IElement;

		public function get element():IElement
		{
			return _element;
		}

		
		public function ElementUI(element:IElement)
		{
			super();
			_element = element;
		}
	}
}