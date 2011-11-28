package org.liekkas.bradypod.views
{
	import flash.display.DisplayObject;
	
	import mx.containers.Canvas;
	import mx.core.ClassFactory;
	
	import org.liekkas.bradypod.models.ElementBox;
	import org.liekkas.bradypod.models.Node;
	import org.liekkas.bradypod.models.interfaces.IElement;
	import org.liekkas.bradypod.views.ui.ElementUI;
	import org.liekkas.bradypod.views.ui.NodeUI;

	/**
	 * 拓扑主视图
	 * @author liekkas.zeng
	 * */
	public class Topo extends Canvas
	{
		//------------------------------------------------------
		//                   图层区
		//------------------------------------------------------
		protected var _topLayer:Canvas;
		
		/**
		 * 顶部图层 -- 用于框选之类的操作
		 * */
		public function get topLayer():Canvas
		{
			return _topLayer;
		}
		
		
		protected var _graphLayer:Canvas;
		
		/**
		 * 数据图层
		 * */
		public function get graphLayer():Canvas
		{
			return _graphLayer;
		}
		
		
		protected var _backgroundLayer:Canvas;
		
		/**
		 * 背景图层  -- 背景图片、背景颜色
		 * */
		public function get backgroundLayer():Canvas
		{
			return _backgroundLayer;
		}
		
		protected var _elementBox:ElementBox;
		
		public function get elementBox():ElementBox
		{
			return _elementBox;
		}
		
		public function set elementBox(value:ElementBox):void
		{
			_elementBox = value;
			invalidateProperties();
		}
		
		public function Topo()
		{
			super();
			this.percentHeight = 100;
			this.percentWidth = 100;
		}
		
		override protected function createChildren():void
		{
			if(!_graphLayer)
			{
				_graphLayer = new Canvas();
				_graphLayer.setStyle("backgroudColor",0xff00ff);
				_graphLayer.percentWidth = 100;
				_graphLayer.percentHeight = 100;
				this.addChild(_graphLayer);
			}
			super.createChildren();
		}
		
		override protected function commitProperties():void
		{
			if(elementBox)
			{
				for each(var ele:IElement in elementBox.elements)
				{
					_graphLayer.addChild(ele.elementUI);
				}
				invalidateDisplayList();
			}
			super.commitProperties();
		}
	}
}