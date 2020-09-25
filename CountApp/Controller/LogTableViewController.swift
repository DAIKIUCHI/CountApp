//
//  LogTableViewController.swift
//  CountApp
//
//  Created by Daiki Uchiyama on 2020/09/20.
//  Copyright © 2020 Daiki Uchiyama. All rights reserved.
//

import UIKit

class LogTableViewController: UITableViewController {
    
    /*-- それぞれの配列にMainViewControllerの情報を入れていく --*/
    var dateArray : [String] = []
    var progressArray : [String] = []
    var targetArray : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let dateArray = UserDefaults.standard.array(forKey: "dateArray") as? [String],
              let progressArray = UserDefaults.standard.array(forKey: "progressArray"),
              let targetArray = UserDefaults.standard.array(forKey: "targetArray") else {
            return
        }
        
        print(dateArray)
        print(progressArray)
        print(targetArray)
        
        tableView.reloadData()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let progressArray = UserDefaults.standard.array(forKey: "progressArray")
        return progressArray!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        /*-- tableViewのセル内の項目(UserDefaults)を取得 --*/
        let dateArray = UserDefaults.standard.array(forKey: "dateArray")
        let progressArray = UserDefaults.standard.array(forKey: "progressArray")
        let targetArray = UserDefaults.standard.array(forKey: "targetArray")
        
        /*-- 各項目をラベルへ反映 --*/
        let date = cell.viewWithTag(1) as! UILabel
        date.text = (dateArray![indexPath.row] as! String)
        let progress = cell.viewWithTag(2) as! UILabel
        progress.text = ((progressArray![indexPath.row]) as! String)
        let target = cell.viewWithTag(3) as! UILabel
        target.text = (targetArray![indexPath.row] as! String)
        
        return cell

    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 6
    }
    

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

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
