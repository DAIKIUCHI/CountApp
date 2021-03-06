//
//  LogTableViewController.swift
//  CountApp
//
//  Created by Daiki Uchiyama on 2020/09/20.
//  Copyright © 2020 Daiki Uchiyama. All rights reserved.
//

import UIKit
import RealmSwift

class LogTableViewController: UITableViewController {
    
    let MV = MainViewController()
    
    var items: Results<TableItem>!
    
    /* --   基本背景色  -- */
    let backGroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        
        let realm = try! Realm()
        self.items = realm.objects(TableItem.self)
        print(items.count)
        
        //背景色設定
        self.view.backgroundColor = backGroundColor

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        var date = cell.viewWithTag(1) as! UILabel
        var progress = cell.viewWithTag(2) as! UILabel
        var target = cell.viewWithTag(3) as! UILabel
        
        let tableItem: TableItem = self.items[indexPath.row]
        
        date.text = tableItem.date
        progress.text = tableItem.progress
        target.text = tableItem.target
        
        return cell

    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 8
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        // 先にデータを削除しないと、エラーが発生します。
//        self.tableData.remove(at: indexPath.row)
//        tableView.deleteRows(at: [indexPath], with: .automatic)
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let realm = try! Realm()
            self.items = realm.objects(TableItem.self)
            
            try! realm.write {
                realm.delete(items[indexPath.row])
            }
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
