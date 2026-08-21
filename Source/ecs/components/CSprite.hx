package ecs.components;

import starling.display.DisplayObject;


class CSprite extends Component
{
	public var sprite:Any = null; //To allow for multiple renderers.

	public function new(sprite:Any)
	{
		this.sprite = sprite;
	}
}