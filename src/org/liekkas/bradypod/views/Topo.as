package org.liekkas.bradypod.views
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedClassName;
	
	import mx.containers.Canvas;
	import mx.core.ClassFactory;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.managers.CursorManager;
	
	import org.liekkas.bradypod.controllers.DefaultController;
	import org.liekkas.bradypod.controllers.DragController;
	import org.liekkas.bradypod.controllers.EditController;
	import org.liekkas.bradypod.controllers.IController;
	import org.liekkas.bradypod.events.ElementBoxEvent;
	import org.liekkas.bradypod.models.ElementBox;
	import org.liekkas.bradypod.models.Node;
	import org.liekkas.bradypod.models.SelectionModel;
	import org.liekkas.bradypod.models.interfaces.IElement;
	import org.liekkas.bradypod.models.ui.ElementUI;
	import org.liekkas.bradypod.models.ui.NodeUI;
	import org.liekkas.bradypod.utils.CursorImage;

	/**
	 * 拓扑主视图
	 * @author liekkas.zeng
	 * */
	public class Topo extends Canvas
	{
		//----控制器
		[ArrayElementType("org.liekkas.bradypod.controllers.controllers.IController")]
		protected var _controllers:Array = [];
		
		//------------------------------------------------------
		//                   图层区
		//------------------------------------------------------
		protected var _topLayer:Canvas;
		
		protected var _selectionModel:SelectionModel;

		public function get selectionModel():SelectionModel
		{
			return _selectionModel;
		}

		public function set selectionModel(value:SelectionModel):void
		{
			_selectionModel = value;
		}

		
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
		
		protected var _elementBox:ElementBox = new ElementBox();
		
		public function get elementBox():ElementBox
		{
			return _elementBox;
		}
		
		public function set elementBox(value:ElementBox):void
		{
			_elementBox.elements = value.elements;
			invalidateProperties();
		}
		
		public function Topo()
		{
			super();
			
			init();
		}
		
		protected function init():void
		{
			this.percentHeight = 100;
			this.percentWidth = 100;
			
			_selectionModel = new SelectionModel();
			this.addEventListener(FlexEvent.CREATION_COMPLETE,onCreationComplete);
			elementBox.addEventListener(ElementBoxEvent.ELEMENT_ADDED,onElementAdded);
		}
		
//		/**
//		 * 安装绘制控制器
//		 * */
//		public function install
		
		protected function onCreationComplete(evt:FlexEvent):void
		{
			new DefaultController(this,true);
		}
		
		protected function onElementAdded(evt:ElementBoxEvent):void
		{
			var ele:IElement = evt.elementAdded;
			if(ele)
				_graphLayer.addChild(ele.elementUI);
		}
		
		override protected function createChildren():void
		{
			if(!_backgroundLayer)
			{
				_backgroundLayer = new Canvas();
				_backgroundLayer.percentWidth = 100;
				_backgroundLayer.percentHeight = 100;
				this.addChild(_backgroundLayer);
			}
			
			if(!_graphLayer)
			{
				_graphLayer = new Canvas();
				_graphLayer.percentWidth = 100;
				_graphLayer.percentHeight = 100;
				this.addChild(_graphLayer);
			}
			
			if(!_topLayer)
			{
				_topLayer = new Canvas();
				_topLayer.percentWidth = 100;
				_topLayer.percentHeight = 100;
				this.addChild(_topLayer);
			}
			super.createChildren();
		}
		
		override protected function commitProperties():void
		{
			if(elementBox)
			{
				for each(var ele:IElement in elementBox.elements)
				{
					if(ele)
						_graphLayer.addChild(ele.elementUI);
				}
				invalidateDisplayList();
			}
			super.commitProperties();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			trace(this.width + "," +this.height);
			super.updateDisplayList(unscaledWidth,unscaledHeight);
		}
		
		/**
		 * 添加一个控制器
		 * */
		public function addController(c:IController):void
		{
			if(!c)
			{
				trace("Topo.addController >>> controller为空");
				return;
			}
			
			if(!c.topo)
			{
				c.topo = this;
			}
			else if(c.topo != this)
			{
				trace("Topo.addController >>> 该controller已经关联到了另外一个topo实例！");
				return;
			}
			
			//检查该controller是否已经注册或者是否被其他controller注册
			var i:int;
			for(i = 0;i < _controllers.length; i++)
			{
				if(c == _controllers[i])
				{
					trace("Topo.addController >>> 该controller已经注册了(" + getQualifiedClassName(c) + ")");
					return;
				}
				
				if(getQualifiedClassName(c) == getQualifiedClassName(_controllers[i]))
				{
					trace("Topo.addController >>> 另一个controller已经注册了(" + getQualifiedClassName(c) + ")");
					return;
				}
			}
			
			//这个是一个新的c
			if(i == _controllers.length)
			{
				trace("Topo.addController >>> 注册成功(" + getQualifiedClassName(c) + ")");
				_controllers.push(c);
			}
				
		}
		
		/**
		 * 移除相关的控制器
		 * */
		public function removeController(c:IController):void
		{
			var arr:Array = [];
			for each (var item:IController in this._controllers) 
			{
				if (item == c) 
					c.destory();
				else 
					arr.push(item);
			}
			this._controllers = arr;
		}
		
		/**
		 * 使用拖拽模式
		 * */
		public function useDrag():void
		{
			if(!changeMode(DragController))
				new DragController(this,true,CursorImage.CURSOR_DRAG);
		}
		
		/**
		 * 使用编辑模式
		 * */
		public function useEdit():void
		{
			if(!changeMode(EditController))
				new EditController(this,true);
		}
		
		/**
		 * 使用默认模式
		 * */
		public function useDefault():void
		{
			if(!changeMode(DefaultController))
				new DefaultController(this,true);
		}
		
		/**
		 * 模式切换  --切换到选择的控制器，同时把其他的控制器取消激活
		 * */
		protected function changeMode(mode:Class):Boolean
		{
			var success:Boolean;
			for each(var c:IController in _controllers)
			{
				if(c is mode)
				{
					if(!c.active)
						c.active = true;
					success = true;
				}
				else
				{
					if(c.active)
						c.active = false;
				}
			}
			return success;
		}
		
		public function layout():void
		{
//			LayoutController(layoutController).regionLayout();
		}
		
		/**
		 * 获得某点下的元素节点
		 * */
		public function getElementUnderPoint(x:Number,y:Number):Node
		{
			return elementBox.getElementUnderPoint(x,y);
		}
		
		/**
		 * 获得某区域下元素节点
		 * */
		public function getElementsUnderRect(rect:Rectangle):Array
		{
			return elementBox.getElementsUnderRect(rect);
		}
	}
}