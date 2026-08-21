package ecs.systems.rendering;


import ecs.components.CSprite;
import ecs.components.CTransform;
import ecs.components.CTransform3D;

import starling.display.DisplayObject;
import starling.display.Sprite;
import starling.display.Sprite3D;


class StarlingRenderer implements ISystem
{
	private var _world:Sprite;

	public function new(world:Sprite)
	{
		this._world = world;
	}

	public function update(entities:Array<Entity>) : Void
	{
		var csprite:CSprite = null;

		for (e in entities) {
			csprite = cast e.getComponent(CSprite);
			if (csprite == null || csprite.sprite == null) {
				continue;
			}

			_handleTransforms(csprite, e);
		}
	}	

	private function _handleTransforms(csprite:CSprite, e:Entity) : Void
	{
		if (csprite.sprite is Sprite3D) {
			_set3DTransform(cast csprite.sprite, cast e.getComponent(CTransform3D));
		} else {
			_set2DTransform(cast csprite.sprite, cast e.getComponent(CTransform));
		}
	}

	private function _set3DTransform(sprite:Sprite3D, transform:CTransform3D) : Void
	{
		if (transform == null) {
			return;
		}

		sprite.x = transform.x;
		sprite.y = transform.y;
		sprite.z = transform.z;
		sprite.scaleX = transform.scaleX;
		sprite.scaleY = transform.scaleY;
		sprite.scaleZ = transform.scaleZ;
		sprite.rotationX = transform.rotationX;
		sprite.rotationY = transform.rotationY;
		sprite.rotationZ = transform.rotationZ;
		sprite.skewX = transform.skewX;
		sprite.skewY = transform.skewY;
	}
	
	private function _set2DTransform(sprite:DisplayObject, transform:CTransform) : Void
	{
		if (transform == null) {
			return;
		}

		sprite.x = transform.x;
		sprite.y = transform.y;
		sprite.scaleX = transform.scaleX;
		sprite.scaleY = transform.scaleY;
		sprite.rotation = transform.rotation;
		sprite.skewX = transform.skewX;
		sprite.skewY = transform.skewY;
	}
}