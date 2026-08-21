package;

import openfl.display.Sprite;
import starling.core.Starling;

class Main extends Sprite
{
	private var _starling:Starling;

	public function new()
	{
		super();
		_starling = new Starling(Game, stage);
        _starling.start();
		_starling.showStats = true;
		_starling.skipUnchangedFrames = true;
	}
}
