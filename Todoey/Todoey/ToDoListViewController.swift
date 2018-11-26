//
//  ViewController.swift
//  Todoey
//
//  Created by testeroo on 2018-11-20.
//  Copyright © 2018 Daniel Sadavoy. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController{
    
    let encoder = PropertyListEncoder()


    var arrayItems: Array<Item> = []
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
//        if let items = decoder.decode(from: dataFilePath){
//            arrayItems = items
//        }
//
        
        
        
//        if let items = defaults.array(forKey: "items"){
//            self.arrayItems = items as! [Item]
//        }
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tableviewTapped))
//        self.tableView.addGestureRecognizer(tap)
        //TODO: Register your MessageCell.xib file here:
//        self.register(UINib(nibName: "ToDoItemSell", bundle: nil), forCellReuseIdentifier: "ToDoItemSell")
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemSell", for: indexPath)
        cell.textLabel!.text = self.arrayItems[indexPath.row].title
        
        cell.accessoryType = self.arrayItems[indexPath.row].done == true ? .checkmark : .none
        return cell
    }
    
    
    
//    @objc func tableviewTapped(recognizer: UIGestureRecognizer){
//        let touchLocation = recognizer.location(in: self.tableView)
//        if let touchIndexPath = self.tableView.indexPathForRow(at: touchLocation){
//            if let touchedCell = self.tableView.cellForRow(at: touchIndexPath){
//                print("Cell contents: \(touchedCell.textLabel?.text ?? "NO CELL")")
//            }
//            else{
//                print("Touchlocation: \(touchLocation.debugDescription)")
//            }
//        }
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("Touched this row: \(arrayItems[indexPath.row])")
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        arrayItems[indexPath.row].done = !arrayItems[indexPath.row].done
        saveData()
        tableView.deselectRow(at: indexPath, animated: true)
        

    }
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        var newItemText = UITextField()
        alert.addTextField { (local) in
            local.placeholder = "Put it here"
            newItemText = local
        }
        let newItem = Item()
        let okAction = UIAlertAction(title: "Add", style: .default) { (action) in
            newItem.title = newItemText.text!
            self.arrayItems.append(newItem)
            self.saveData()
        }
        alert.addAction(okAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
        //self.showDetailViewController(alert, sender: self)
        //print(newItem.text)
    }
    
    func saveData(){
        
        do{
            let data = try encoder.encode(arrayItems)
            try data.write(to: dataFilePath!)
            tableView.reloadData()
        }
        catch{
            
        }
    }
    
    func loadData(){
        do{
            let data = try Data(contentsOf: dataFilePath!)
            let decoder = PropertyListDecoder()
            let items = try decoder.decode([Item].self, from: data)
            arrayItems = items
        }
        catch{
            print("Error loading data: \(error.localizedDescription)")
        }
    }
}

