using Godot;
using System;

public class Main : Control
{
	// private int a = 2;
	// private string b = "text";
	// Called when the node enters the scene tree for the first time.
	
	/*
	public override void _Ready()
	{
		
	}
	

	//  // Called every frame. 'delta' is the elapsed time since the previous frame.
	//  public override void _Process(float delta)
	//  {
	//      
	//  }
	*/

	/// OPEN FILE

	private void openFileButtonPressed()
	{
		GetNode<FileDialog>("openFileDialog").Popup_();
	}


	private void openFileDialogFileSelected(String path)
	{
		GD.Print(path);
		var f = new File();
		
		f.Open(path , File.ModeFlags.Read);
		GetNode<TextEdit>("TextEditor").Text = f.GetAsText();
		f.Close();

	}

	/// SAVE AS FILE
	
	private void saveAsFileButtonPressed()
	{
		GetNode<FileDialog>("saveAsFileDialog").Popup_();
	}
	private void saveAsFileDialogFileSelected(String path)
	{
		var f = new File();
		f.Open(path, File.ModeFlags.Write);
		f.StoreString(GetNode<TextEdit>("TextEditor").Text);
		f.Close();
	}
}
