package;

import ecs.components.*;
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

		balls.addComponent(new CTransform());
		balls.addComponent(new CTransform3D());
		balls.removeComponent(CTransform);
		balls.addComponent(new CLifespan());

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
