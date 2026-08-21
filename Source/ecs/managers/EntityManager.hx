package ecs.managers;

class EntityManager
{
	private var _entities:Array<Entity> = null;
	private var _entitiesToRemove:Array<Entity> = null;
	private var _entityMap:Map<EntityTag, Array<Entity>> = null;
	private var _totalEntities:Int = 0;

	public function new()
	{
		this._entities = new Array<Entity>();
		this._entitiesToRemove = new Array<Entity>();
		this._entityMap = new Map<EntityTag, Array<Entity>>();	

		for (tag in Type.allEnums(EntityTag)) {
			this._entityMap[tag] = new Array<Entity>();
		}
	}

	public function update() : Void
	{
		_removeInactiveEntities();
	}

	public function addEntity(tag:EntityTag) : Entity
	{
		var e = EntityMemoryPool.instance.addEntity(tag);
		this._entities.push(e);
		this._entityMap[tag].push(e);
		return e;
	}

	public function getAllEntities() : Array<Entity>
	{
		return this._entities;
	}

	public function getEntitiesByTag(tag:EntityTag) : Array<Entity>
	{
		return this._entityMap[tag];
	}


	private function _removeInactiveEntities() : Void
	{
		for (e in this._entities) {
			if (!EntityMemoryPool.instance.isActive(e.id)) {
				this._entitiesToRemove.push(e);
			}
		}

		var e:Entity = null;
		while (this._entitiesToRemove.length > 0) {
			e = this._entitiesToRemove.pop();
			this._entities.remove(e);
		}
	}
}