import ecs.components.CTransform;
import ecs.components.CSprite;
import ecs.systems.rendering.StarlingRenderer;
import ecs.managers.EntityManager;
import ecs.EntityTag;
import starling.events.Event;
import starling.display.Quad;
import starling.display.Sprite;
import starling.utils.Color;

class Game extends Sprite
{
	private var _entityManager:EntityManager;
	private var _starlingRenderer:StarlingRenderer;

	public function new()
	{
		super();

		this._entityManager = new EntityManager();
		this._starlingRenderer = new StarlingRenderer(this);

		var quad:Quad = new Quad(200, 200, Color.RED);
		var e = this._entityManager.addEntity(EntityTag.DEFAULT);
		var c = new CTransform();
		c.x = 100;
		c.y = 200;
		e.addComponent(new CSprite(quad));
		e.addComponent(c);

		addChild(quad);
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}

	private function onEnterFrame(event:Event, dt:Float) : Void
	{
		var entities = this._entityManager.getAllEntities();

		this._starlingRenderer.update(entities);
	}
}