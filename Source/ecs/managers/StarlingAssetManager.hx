package ecs.managers;


import starling.assets.AssetManager;


final class StarlingAssetManager extends AssetManager
{
	public static var instance:StarlingAssetManager;

	private function new()
	{
		super();
	}

	public static function createInstance() : Void
	{
		if (instance != null) {
			return;
		}

		StarlingAssetManager.instance = new StarlingAssetManager();
	}
}