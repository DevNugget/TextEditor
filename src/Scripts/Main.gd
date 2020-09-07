extends Control


var APP_NAME = "TextEditor"
var file_path = "untitled"
var current_file = file_path


func _ready():
	update_window_title()
	$FileMenu.get_popup().connect("id_pressed", self, "_on_fileitem_pressed")
	$HelpMenu.get_popup().connect("id_pressed", self, "_on_helpitem_pressed")
	$FontSize.text = "Font Size"
	
	
#func shortcut_generate1(id:int, key:int, boolean:bool ):
#	var shortcut = ShortCut.new()
#	var input_event_key = InputEventKey.new()
#	input_event_key.set_scancode(key)
#	input_event_key.control= true
#	shortcut.set_shortcut(input_event_key)
#	$FileMenu.get_popup().set_item_shortcut(id, shortcut, boolean)
	
func update_window_title():
	OS.set_window_title(APP_NAME + " - " + current_file)

func new_file():
	current_file = "untitled"
	update_window_title()
	$TextEditor.text = ""
	


func _on_fileitem_pressed(id):
	var item_name = $FileMenu.get_popup().get_item_id(id)
	match item_name:
		0:new_file()
		1:$openFileDialog.popup()
		3:save_file()
		4:$saveAsFileDialog.popup()
		5:get_tree().quit()



func _on_helpitem_pressed(id):
	var item_name = $HelpMenu.get_popup().get_item_id(id)
	var _some_int:int 
	match item_name:
		0:$AboutDialog.popup()
# warning-ignore:return_value_discarded
		1:OS.shell_open("https://godotengine.org/")





func _on_OpenFileButton_pressed():
	$openFileDialog.popup()


func _on_SaveAsFileButton_pressed():
	$saveAsFileDialog.popup()


func _on_openFileDialog_file_selected(path: String):
	print(path)
	var f = File.new()
	f.open(path, 1)
	$TextEditor.text = f.get_as_text()
	current_file = path.get_file()
	update_window_title()
	f.close()
	


func _on_saveAsFileDialog_file_selected(path: String):
	file_path = path
	save_file()
	
func save_file():
	var path = file_path
	if path == "untitled":
		$saveAsFileDialog.popup()
	else:
		var f = File.new()
		f.open(path, 2)
		f.store_string($TextEditor.text)
		file_path = path
		update_window_title()
		f.close()
		


# Syntax coloring in GDQuest Discord server info
# https://discordapp.com/channels/245092069415190528/366496657681940482/730108743198441533





func _on_FontSize_item_selected(index: int) -> void:
	match index:
		0:$TextEditor.get("custom_fonts/font").set("size", 20)
		1:$TextEditor.get("custom_fonts/font").set("size", 25)
		2:$TextEditor.get("custom_fonts/font").set("size", 30)
		3:$TextEditor.get("custom_fonts/font").set("size", 35)
		4:$TextEditor.get("custom_fonts/font").set("size", 40)
		5:$TextEditor.get("custom_fonts/font").set("size", 45)
		6:$TextEditor.get("custom_fonts/font").set("size", 50)
		7:$TextEditor.get("custom_fonts/font").set("size", 55)
		8:$TextEditor.get("custom_fonts/font").set("size", 60)
	$FontSize.text = "Font Size"

func _on_TextEditor_text_changed() -> void:
	$BottomLabel.text = "Lin " + String($TextEditor.cursor_get_line() + 1) + " Col " + String($TextEditor.cursor_get_column() + 1)
	$TextEditor.auto_complete()
