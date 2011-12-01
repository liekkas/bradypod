package org.liekkas.bradypod.models.ui
{
	import mx.controls.Image;
	import mx.controls.Label;
	
	import org.liekkas.bradypod.models.Node;
	import org.liekkas.bradypod.models.interfaces.IElement;
	
	public class NodeUI extends ElementUI
	{
		[Embed(source="assets/imgs/cursor/BSC.png")]
		public static const LEAF:Class;
		
		protected var _node:Node;
		
		protected var img:Image;
		
		protected var label:Label;

		public function get node():Node
		{
			return _node;
		}

		public function NodeUI(node:Node)
		{
			super(node);
			_node = node;
			img = new Image();
			img.source = LEAF;
			img.width = node.w;
			img.height = node.h;
			img.x = node.x;
			img.y = node.y;
			this.addChild(img);
//			label = new Label();
//			label.text = node.name;
//			label.x = img.x + img.width;
//			label.y = img.y + img.height;
//			this.addChild(label);
		}
		
		override protected function drawSelectedStyle():void
		{
			this.graphics.lineStyle(2,0xff0000);
			this.graphics.drawRect(img.x, img.y, img.width, img.height);
			this.graphics.endFill();
		}
		
		override protected function drawMovedStyle():void
		{
			img.x = node.x;
			img.y = node.y;
			img.width = node.w;
			img.height = node.h;
		}
	}
}