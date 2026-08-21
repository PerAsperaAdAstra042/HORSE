import openfl.Assets;
import starling.core.Starling;
import ecs.managers.StarlingAssetManager;
import starling.textures.Texture;
import starling.textures.TextureAtlas;
import starling.display.MovieClip;
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
		StarlingAssetManager.createInstance();

		var balls = Assets.getBitmapData("assets/texture.png");
		StarlingAssetManager.instance.enqueue([Assets.getPath("assets/texture.xml")]);
		StarlingAssetManager.instance.enqueue([Assets.getPath("assets/texture.png")]);
		StarlingAssetManager.instance.loadQueue(() -> {
			var atlas:TextureAtlas = StarlingAssetManager.instance.getTextureAtlas("texture");
			var mc:MovieClip = new MovieClip(atlas.getTextures("stand/frame_"), 30);
			var e = this._entityManager.addEntity(EntityTag.DEFAULT);
			e.addComponent(new CSprite(mc));
			var c = new CTransform();
			c.x = 100; c.y = 100;
			e.addComponent(c);

			addChild(mc);
			Starling.currentJuggler.add(mc);
			mc.play();
		});

		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}

	private function onEnterFrame(event:Event, dt:Float) : Void
	{
		var entities = this._entityManager.getAllEntities();
		this._starlingRenderer.update(entities);
	}
}