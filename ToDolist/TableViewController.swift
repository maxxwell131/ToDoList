//
//  TableViewController.swift
//  ToDolist
//
//  Created by maxxwell131 on 6/3/18.
//  Copyright © 2018 maxxwell131. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var dataArray:[[String: Any]] {
        set {
            UserDefaults.standard.set(newValue, forKey: "dataArrayKey")
            UserDefaults.standard.synchronize()
        }
        get {
            if let array = UserDefaults.standard.array(forKey: "dataArrayKey") as? [[String: Any]] {
                return array
            } else {
                return []
            }
        }
    }
    // "Позвонить маме", "Купить хлеба", "Что то сделать"
   
    
    @IBAction func PushAddButton(_ sender: UIBarButtonItem) {
        let allertController = UIAlertController(title: "Новая запись", message: "", preferredStyle: UIAlertControllerStyle.alert)
        allertController.addTextField { (textField) in
            textField.placeholder = "Новая запись"
        }
        
        let allertAdd = UIAlertAction(title: "Добавить", style: UIAlertActionStyle.default) { (alert) in
            if allertController.textFields?[0].text != "" {
                let newDictonary = ["name":allertController.textFields![0].text!, "isDone": false, "color": "white"] as [String : Any]
                
                self.dataArray.append(newDictonary)
                self.tableView.reloadData()
            }
        }
        
        let allertCancel = UIAlertAction(title: "Отмена", style: UIAlertActionStyle.default) { (alert) in
        }
        allertController.addAction(allertAdd)
        allertController.addAction(allertCancel)
        
        present(allertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let itemDictonary = dataArray[indexPath.row]
        cell.textLabel?.text = itemDictonary["name"] as! String?
        let isDone = itemDictonary["isDone"] as! Bool
        
        if isDone {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let itemDictonary = dataArray[indexPath.row]
        let isDone = itemDictonary["isDone"] as! Bool
        
        if isDone {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            dataArray[indexPath.row]["isDone"] = false
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            dataArray[indexPath.row]["isDone"] = true

        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            dataArray.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade) //удаляем из таблицы столбец
        }
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
