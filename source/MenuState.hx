package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import haxe.xml.Parser;
import openfl.Assets;

class MenuState extends FlxState {

    var player:FlxSprite;
    var tilemap:FlxTilemap;
    var reloadedCamera = false;

	override public function create():Void {
		super.create();

        // We create a tilemap, and display it on a half width camera
        tilemap = new FlxTilemap();
        var mapData = Assets.getText("assets/data/map1.csv");
        tilemap.loadMapFromCSV(mapData, "assets/images/tiles.png", 64, 64);
        add(tilemap);

        player = new FlxSprite(100, 100);
        player.makeGraphic(64, 64, FlxColor.BLUE);
        add(player);

        var camera = new FlxCamera(0, 0, Std.int(FlxG.width/2), Std.int(FlxG.height));
        camera.follow(player);
        FlxG.cameras.reset(camera);
	}

	override public function update(elapsed:Float):Void
	{
        if (!reloadedCamera) {
            reloadedCamera = true;
            var camera2 = new FlxCamera(0, 0, FlxG.width, FlxG.height);
            camera2.follow(player);
            FlxG.cameras.reset(camera2);
        }
        
        if (FlxG.keys.pressed.W) {
            player.y -= 10;
        }
        if (FlxG.keys.pressed.A) {
            player.x -= 10;
        }
        if (FlxG.keys.pressed.S) {
            player.y += 10;
        }
        if (FlxG.keys.pressed.D) {
            player.x += 10;
        }
		super.update(elapsed);
	}
}
