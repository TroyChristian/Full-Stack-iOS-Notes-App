//
//  AddNoteViewController.swift
//  Note-App
//
//  Created by Lambda_School_Loaner_219 on 8/27/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {
    var note: Note?
    var update: Bool = false 
    
    @IBOutlet weak var titleTextField: UITextField!
    
    
    @IBOutlet weak var bodyTextView: UITextView!
    
    @IBOutlet weak var SaveButton: UIBarButtonItem!
    
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    
    @IBAction func deleteClicked(_ sender: Any) {
        if update == true {
        APIFunctions.functions.deleteNote(id: note!._id)
    }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func SaveClicked(_ sender: Any) {
        
        if update == true {
               APIFunctions.functions.updateNote(date: "UPDATE", title: titleTextField.text!, note: bodyTextView.text!, id:note!._id)
                  
            
        } else
        {
            APIFunctions.functions.addNote(date: "CREATE", title: titleTextField.text!, note: bodyTextView.text!)
        }
        self.navigationController?.popViewController(animated: true)
      
    }
        
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if update == true {
            titleTextField.text = note!.title
            bodyTextView.text = note!.note
        }
    }
        
     
        
        
        

   
    
    override func viewWillAppear(_ animated: Bool) {
        if update == false {
            deleteButton.isEnabled = false
            self.deleteButton.title = ""
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
