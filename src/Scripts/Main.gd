extends Control


var APP_NAME = "TextEditor"
var file_path = "untitled"
var current_file = "untitled"


func _ready():
	update_window_title()
	$FileMenu.get_popup().connect("id_pressed", self, "_on_fileitem_pressed")
	$HelpMenu.get_popup().connect("id_pressed", self, "_on_helpitem_pressed")
	
	
func update_window_title():
	OS.set_window_title(APP_NAME + " - " + current_file)

func new_file():
	current_file = "untitled"
	update_window_title()
	$TextEditor.text = ""
	


func _on_fileitem_pressed(id):
	var item_name = $FileMenu.get_popup().get_item_text(id)
	match item_name:
		"New File":new_file()
		"Open File":$openFileDialog.popup()
		"Open Folder(inop)":pass
		"Save":save_file()
		"Save As":$saveAsFileDialog.popup()
		"Quit":get_tree().quit()



func _on_helpitem_pressed(id):
	var item_name = $HelpMenu.get_popup().get_item_text(id)
	match item_name:
		"About":$AboutDialog.popup()
		"Godot":OS.shell_open("https://godotengine.org/")





func _on_OpenFileButton_pressed() -> void:
	$openFileDialog.popup()


func _on_SaveAsFileButton_pressed() -> void:
	$saveAsFileDialog.popup()


func _on_openFileDialog_file_selected(path: String):
	print(path)
	var f = File.new()
	f.open(path, 1)
	$TextEditor.text = f.get_as_text()
	file_path = path
	update_window_title()
	f.close()


func _on_saveAsFileDialog_file_selected(path: String):
	save_file()
	
func save_file():
	var path = file_path
	if path == "untitled":
		$saveAsFileDialog.popup()
	else:
		var f = File.new()
		f.open(path, 2)
		f.store_string($TextEditor.text)
		f.close()
		file_path = path
		update_window_title()
		
