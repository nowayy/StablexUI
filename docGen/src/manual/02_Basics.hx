/**
@manual Creating UI elements

For StablexUI widgets are objects wich can be used in gui. These are buttons,
panels, text fields, etc. All widgets' classes extend <type>ru.stablex.ui.widgets.Widget</type> wich extends <type>nme.display.Sprite</type>.

To create our first gui, let's write xml like this:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<Text left="50" top="100" text="'My first widget!'"/>
</xml>

Please, notice that it's necessary to use double quotes and single quotes simultaneously
for string properties. Call this file 'first.xml' and place it wherever to your project.
You don't need to include this file in your assets managed by NME.
Let's analyze content of the file:
    Line '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' must be the first line of any xml file;
    <type>ru.stablex.ui.widgets.Text</type> - class of widget we want to create;
    left, top - properties of Text widget class inherited from <type>ru.stablex.ui.widgets.Widget</type>.
                These properties define widget position by x and y coordinates respectively.
                Of course,  instead of .left and .top you can assign .x and .y properties
                directly in xml since these properties are inherited from <type>nme.display.Sprite</type>.
                And in this example you will get the same result using .x and .y,
                but it is recommended to always use .left and .top for widgets.
    text - own property of <type>ru.stablex.ui.widgets.Text</type> class (click to see api for that class).
StablexUI will create text field based on first.xml with text 'My first widget!'.
This field will be placed with .x=50 and .y=100.
Here is the haxe code wich will do the job:

<haxe>
nme.Lib.current.addChild( ru.stablex.ui.UIBuilder.buildFn('first.xml')() );
</haxe>

Don't forget empty parentheses after 'first.xml'. That's all! You've just created your first UI :)
Build your project to any target or see result in <a href="/ui/demo/01_first.swf" target="_blank">flash</a> or in <a href="/ui/demo/01_first" target="_blank">html5</a>.
Full project code is included in samples on <a href="https://github.com/RealyUniqueName/StablexUI" target="_blank">GitHub</a>.
*/

/**
@manual Under the hood

Remember double and single quotes and empty parentheses? I bet you think: "What for?".
It's because <type>ru.stablex.ui.UIBuilder</type>.buildFn() is a macro function wich generates a closure for gui creation.
To make it clear, next code does the same thing as code above:

<haxe>
var fn : Dynamic->ru.stablex.ui.Widgets.Text = ru.stablex.ui.UIBuilder.buildFn('first.xml');
nme.Lib.current.addChild( fn() );
</haxe>

Type of closure is <type>Dynamic</type>-&gt;<type>ru.stablex.ui.Widgets.Text</type> because the type of root element in xml
is <type>ru.stablex.ui.widgets.Text</type>. To see what does StablexUI actualy do, look at next code. This is how your code
is translated by StablexUI for haxe compiler when you build project:

<haxe>
var fn : Dynamic->ru.stablex.ui.Widgets.Text = function(arguments:Dynamic = null) : ru.stablex.ui.widgets.Text {
    var widget : ru.stablex.ui.widgets.Text = ... // UIBuilder actions to create widget object
    widget.left = 50;
    widget.top  = 100;
    widget.text = 'My first widget!';
    return widget;
};
nme.Lib.current.addChild( fn() );
</haxe>

I guess, you understand about parentheses now. And single quotes are required for string
properties in xml because otherwise StablexUI will generate code

<haxe>
widget.text = My first widget!;
</haxe>

wich of course breaks Haxe syntax.

*/