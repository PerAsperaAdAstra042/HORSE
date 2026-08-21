package;

import ecs.components.CTransform;
import openfl.display.Sprite;
import ecs.*;

class Main extends Sprite
{
	public function new()
	{
		super();
		var em:EntityManager = new EntityManager();
		var balls = em.addEntity(EntityTag.DEFAULT);
		em.addEntity(EntityTag.DEFAULT);
		em.addEntity(EntityTag.DEFAULT);

		var ents = em.getAllEntities();
		balls.destroy();
		em.update();
		trace(ents.length);

		for (e in em.getAllEntities()) {
			trace(e);
		}

		trace(ents.length);
		//trace(em)
	}
}
