package ecs;

interface ISystem
{
	public function update(entities:Array<Entity>) : Void;
}