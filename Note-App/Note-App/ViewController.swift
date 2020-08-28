//
//  ViewController.swift
//  Note-App
//
//  Created by Lambda_School_Loaner_219 on 8/27/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import UIKit

protocol DataDelegate {
    func updateArray(newArray:String)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var notesArray = [Note]()
    
    @IBOutlet weak var notesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIFunctions.functions.delegate = self
       
        notesTableView.delegate = self
        notesTableView.dataSource = self
    }
    
  
    
    override func viewDidAppear(_ animated: Bool) {
        APIFunctions.functions.fetchNotes()
    }
    
    
    
    //MARK: SEGUES
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddNoteViewController
        
        if segue.identifier == "updateNoteSegue" {
            vc.update = true 
            vc.note = notesArray[notesTableView.indexPathForSelectedRow!.row]
            
        }
    }
    
  
    
    
    // MARK: TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        
        cell.textLabel?.text = notesArray[indexPath.row].title
        
        return cell
    }


}

extension ViewController: DataDelegate {
    func updateArray(newArray: String) {
        do {
            let decoder = JSONDecoder()
            notesArray = try decoder.decode([Note].self, from: newArray.data(using: .utf8)!)
            print("This is in the updateArray func: \(notesArray)")
        } catch {
            print("Failed to decode!")
            
        }
        self.notesTableView?.reloadData() 
    }
    
    
}

