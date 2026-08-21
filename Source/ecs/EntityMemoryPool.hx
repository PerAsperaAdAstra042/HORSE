package ecs;

import haxe.ds.Vector;


class EntityMemoryPool
{
	// SINGLETON!!!!
	public static final instance:EntityMemoryPool = new EntityMemoryPool(143675);

	private var _pool:Vector<Array<Component>> = null;
	private var _tags:Vector<EntityTag> = null;
	private var _actives:Vector<Bool> = null;

	private function new(maxEntities:Int)
	{
		this._pool = new Vector(maxEntities, new Array<Component>());
		this._tags = new Vector(maxEntities, null);
		this._actives = new Vector(maxEntities, false);
	}

	public function addEntity(tag:EntityTag) : Entity
	{
		var index:Int = _getNextEntityIndex();
		if (index == -1) {
			return null;
		}

		/* There's a chance old components exist at this ID; we should clean them up. */
		_cleanUpComponentsAtIndex(index);

		this._tags[index] = tag;
		this._actives[index] = true;

		/* I don't like the fact that we're creating new objects like this. */
		return new Entity(index);
	}

	public function removeEntity(entityID:Int) : Void
	{
		this._actives[entityID] = false;
	}

	public function addComponent(entityID:Int, component:Component) : Bool
	{
		if (hasComponent(entityID, Type.getClass(component))) {
			return false;
		}

		this._pool[entityID].push(component);
		return true;
	}

	/* Please do not remove components manually unless you know what you're doing. */
	public function removeComponent(entityID:Int, type:Class<Component>) : Bool
	{
		var i:Int = _getComponentIndex(entityID, type);
		if (i == -1) {
			return false;
		}

		this._pool[entityID][i] = null;
		return true;
	}

	public function getComponent(entityID:Int, type:Class<Component>) : Component
	{
		for (c in this._pool[entityID]) {
			if (Std.isOfType(c, type)) {
				return c;
			}
		}

		return null;
	}

	public function hasComponent(entityID:Int, type:Class<Component>) : Bool
	{
		return (getComponent(entityID, type) != null);
	}

	public function getTag(entityID:Int) : EntityTag
	{
		return this._tags[entityID];	
	}

	public function isActive(entityID:Int) : Bool
	{
		return this._actives[entityID];
	}


	private function _getComponentIndex(entityID:Int, type:Class<Component>) : Int
	{
		for (i in 0 ... this._pool[entityID].length) {
			if (Std.isOfType(this._pool[entityID][i], type)) {
				return i;
			}
		}

		return -1;
	}

	/* Unused. */
	private function _getNextComponentIndex(entityID:Int) : Int
	{
		var i:Int = 0;
		while (i < this._pool[entityID].length) {
			if (this._pool[entityID][i] == null) {
				return i;
			}

			i++;
		}

		/* By now we should reach the length of the array. */
		return i;
	}

	private function _getNextEntityIndex() : Int
	{
		for (i in 0 ... this._actives.length) {
			if (!this._actives[i]) {
				return i;
			}
		}

		return -1;	
	}

	private function _cleanUpComponentsAtIndex(entityID:Int) : Void
	{
		for (c in this._pool[entityID]) {
			c = null;
		}
	}
}