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
	
	import org.liekkas.bradypod.controllers.DragController;
	import org.liekkas.bradypod.controllers.DrawController;
	import org.liekkas.bradypod.controllers.EditController;
	import org.liekkas.bradypod.controllers.IController;
	import org.liekkas.bradypod.controllers.LayoutController;
	import org.liekkas.bradypod.controllers.SelectController;
	import org.liekkas.bradypod.events.ElementBoxEvent;
	import org.liekkas.bradypod.models.ElementBox;
	import org.liekkas.bradypod.models.Node;
	import org.liekkas.bradypod.models.SelectionModel;
	import org.liekkas.bradypod.models.interfaces.IElement;
	import org.liekkas.bradypod.models.ui.ElementUI;
	import org.liekkas.bradypod.models.ui.NodeUI;

	/**
	 * 拓扑主视图
	 * @author liekkas.zeng
	 * */
	public class Topo extends Canvas
	{
		//----控制器
		[ArrayElementType("org.liekkas.bradypod.controllers.controllers.IController")]
		protected var _controllers:Array = [];
		
		/**
		 * 拖拽控制器
		 * */
		protected var dragController:IController;
		
		/**
		 * 选择控制器
		 * */
		protected var selectController:IController;
		
		/**
		 * 绘制控制器
		 * */
		protected var drawController:IController;
		
		/**
		 * 编辑控制器
		 * */
		protected var editController:IController;
		
		/**
		 * 布局控制器
		 * */
		protected var layoutController:IController;
		
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
			editController = new EditController(this,true);
			layoutController = new LayoutController(this);
//			selectController = new SelectController(this,true);
//			drawController = new DrawController(this,true);
//			dragController = new DragController(this);
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
		public function addController(controller:IController):void
		{
			if(!controller)
			{
				trace("Topo.addController >>> controller为空");
				return;
			}
			
			if(!controller.topo)
			{
				controller.topo = this;
			}
			else if(controller.topo != this)
			{
				trace("Topo.addController >>> 该controller已经关联到了另外一个topo实例！");
				return;
			}
			
			//检查该controller是否已经注册或者是否被其他controller注册
			var i:int;
			for(i = 0;i < _controllers.length; i++)
			{
				if(controller == _controllers[i])
				{
					trace("Topo.addController >>> 该controller已经注册了(" + getQualifiedClassName(controller) + ")");
					return;
				}
				
				if(getQualifiedClassName(controller) == getQualifiedClassName(_controllers[i]))
				{
					trace("Topo.addController >>> 另一个controller已经注册了(" + getQualifiedClassName(controller) + ")");
					return;
				}
			}
			
			//这个是一个新的controller
			if(i == _controllers.length)
			{
				trace("Topo.addController >>> 注册成功(" + getQualifiedClassName(controller) + ")");
				_controllers.push(controller);
			}
				
		}
		
		/**
		 * 移除相关的控制器
		 * */
		public function removeController(controller:IController):void
		{
			var arr:Array = [];
			for each (var item:IController in this._controllers) 
			{
				if (item == controller) 
					controller.destory();
				else 
					arr.push(item);
			}
			this._controllers = arr;
		}
		
		/**
		 * 使用拖拽模式
		 * enableOthers -是否也启用其他模式
		 * */
		public function useDrag(enableOthersFlag:Boolean = false):void
		{
			changeMode(DragController,enableOthersFlag);
		}
		
		/**
		 * 使用绘制模式
		 * enableOthers -是否也启用其他模式
		 * */
		public function useDraw(enableOthersFlag:Boolean = false):void
		{
			changeMode(DrawController,enableOthersFlag);
		}
		
		/**
		 * 使用选择模式
		 * enableOthers -是否也启用其他模式
		 * */
		public function useSelect(enableOthersFlag:Boolean = false):void
		{
			changeMode(SelectController,enableOthersFlag);
		}
		
		/**
		 * 模式切换
		 * */
		protected function changeMode(mode:Class,enableOthersFlag:Boolean):void
		{
			_controllers.forEach(
				function(item:IController,...args):void
				{
					if(item is mode)
						item.active = true;
					else
						item.active = enableOthersFlag;
				});
		}
		
		public function layout():void
		{
			LayoutController(layoutController).regionLayout();
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
			for each(var ele:IElement in elementBox.elements.source.reverse())
			{
				if(ele is Node && Node(ele).containXY(x,y))
				{
					return Node(ele);
				}
			}
			
			return null;
		}
	}
}