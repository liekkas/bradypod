package org.liekkas.bradypod.controllers
{
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	
	import org.liekkas.bradypod.models.interfaces.IElement;
	import org.liekkas.bradypod.views.Topo;
	
	public class DragNodeController extends BaseController
	{
		public function DragNodeController(topo:Topo=null, active:Boolean=false, cursor:Class=null)
		{
			super(topo, active, cursor);
		}
		
		override protected function register():void
		{
			if(topo)
			{
				for each(var ele:IElement in topo.elementBox.elements)
				{
					ele.elementUI.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
					ele.elementUI.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
				}
			}
		}
		
		override protected function unregister():void
		{
			if(topo)
			{
				for each(var ele:IElement in topo.elementBox.elements)
				{
					ele.elementUI.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
					ele.elementUI.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
				}
			}
		}
		
		protected function onMouseDown(evt:MouseEvent):void
		{
			trace(">>DragNodeController.onMouseDown");
			UIComponent(evt.currentTarget).startDrag();
		}
		
		protected function onMouseUp(evt:MouseEvent):void
		{
			trace(">>DragNodeController.onMouseUp");
			UIComponent(evt.currentTarget).stopDrag();
		}
	}
}