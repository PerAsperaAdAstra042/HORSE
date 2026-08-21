package ecs;

class Entity
{
	private var _id:Int = 0;
	private var _tag:EntityTag = EntityTag.DEFAULT;
	private var _isAlive:Bool = true;
	private var _components:Array<Component> = null;

	public var id (get, never) : Int;
	function get_id() : Int
	{
		return this._id;
	}

	public var tag (get, never) : EntityTag;
	function get_tag() : EntityTag
	{
		return this._tag;	
	}

	public var isAlive (get, never) : Bool;
	function get_isAlive() : Bool
	{
		return this._isAlive;	
	}

	public function new(tag:EntityTag, id:Int)
	{
		this._components = new Array<Component>();
		this._tag = tag;
		this._id = id;
	}

	public function addComponent(component:Component) : Bool
	{
		if (hasComponent(Type.getClass(component))) {
			return false;
		}

		this._components.push(component);
		return true;
	}

	public function getComponent(type:Class<Component>) : Component
	{
		for (c in this._components) {
			if (Std.isOfType(c, type)) {
				return c;
			}
		}

		return null;
	}

	public function hasComponent(type:Class<Component>) : Bool
	{
		return (getComponent(type) != null);
	}

	public  function removeComponent(type:Class<Component>) : Bool
	{
		var c = getComponent(type);
		if (c == null) {
			return false;
		}

		c = null;
		return true;
	}

	public function destroy() : Void
	{
		this._isAlive = false;	
	}
}