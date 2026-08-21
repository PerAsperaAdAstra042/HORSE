package ecs;

final class Entity
{
	private var _id:Int = 0;

	public var id (get, never) : Int;
	function get_id() : Int
	{
		return this._id;
	}

	public function new(id:Int)
	{
		this._id = id;
	}

	public function addComponent(component:Component) : Bool
	{
		return EntityMemoryPool.instance.addComponent(this._id, component);
	}

	public function getComponent(type:Class<Component>) : Component
	{
		return EntityMemoryPool.instance.getComponent(this._id, type);
	}

	public function hasComponent(type:Class<Component>) : Bool
	{
		return EntityMemoryPool.instance.hasComponent(this._id, type);
	}

	public  function removeComponent(type:Class<Component>) : Bool
	{
		return EntityMemoryPool.instance.removeComponent(this._id, type);
	}

	public function destroy() : Void
	{
		return EntityMemoryPool.instance.removeEntity(this._id);
	}
}