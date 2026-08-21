package ecs.components;

import ecs.managers.StarlingAssetManager;
import starling.display.Sprite;


class CSprite extends Component
{
	public var sprite:Any = null; //To allow for multiple renderers.

	public function new(sprite:Any)
	{
		this.sprite = sprite;
	}

	public function createEmptyStarlingSprite() : Void
	{
	}
}