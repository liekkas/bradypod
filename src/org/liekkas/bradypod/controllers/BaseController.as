package org.liekkas.bradypod.controllers
{
	import mx.managers.CursorManager;
	
	import org.liekkas.bradypod.views.Topo;
	
	/**
	 * 基本控制类
	 * @author liekkas.zeng
	 * @date 2011-11-28 18:00:45
	 * */
	public class BaseController implements IController
	{
		/**
		 * topo实例
		 * */
		protected var _topo:Topo;
		
		/**
		 * 是否激活该控制器
		 * */
		protected var _active:Boolean;
		
		/**
		 * 当前手势光标
		 * */
		protected var cursor:Class;
		
		/**
		 * 当前光标id
		 * */
		protected var cursorId:int;
		
		public function BaseController(topo:Topo = null,active:Boolean = false,cursor:Class = null)
		{
			this.topo = topo;
			this.active = active;
			this.cursor = cursor;
		}
		
		public function get topo():Topo
		{
			return _topo;
		}
		
		public function set topo(value:Topo):void
		{
			//如果已经关联了拓扑直接返回
			if(topo == value)
				return;
			
			//先注销以前的侦听器
			if(_active)
				unregister();
			
			//移除以前的控制器
			if(_topo)
				_topo.removeController(this);
			
			//重新关联
			_topo = value;
			if(_topo)
				_topo.addController(this);
			
			//如果控制器激活则注册相关侦听器
			if(_active)
				register();
		}
		
		public function get active():Boolean
		{
			return _active;
		}
		
		/**
		 * 是否激活 --然后设置不同的光标手势，如果有的话
		 * */
		public function set active(value:Boolean):void
		{
			_active = value;
			
			if(_topo)
			{
				if(_active)
				{
//					if(cursor)
//						cursorId = CursorManager.setCursor(cursor);
					register();
				}
					
				else
				{
//					if(cursor)
//						CursorManager.removeCursor(cursorId) ;
					unregister();
				}
					
			}
		}
		
		/**
		 * 销毁操作
		 * */
		public function destory():Boolean
		{
			active = false;
			topo = null;
			return true;
		}
		
		/**
		 * 向topo注册相关的侦听器
		 * */
		protected function register():void
		{
			//TODO
		}
		
		/**
		 * 从topo中注销相关的侦听器
		 * */
		protected function unregister():void
		{
			//TODO
		}
	}
}