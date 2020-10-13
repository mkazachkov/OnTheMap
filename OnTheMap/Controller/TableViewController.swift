//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Mikhail on 9/30/20.
//  Copyright © 2020 112358dev. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UdacityClient.getStudentLocations { (studentLocations, error) in
            OnTheMapModel.studentLocations = studentLocations
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    @IBAction
    func refreshTapped(_ sender: UIBarButtonItem) {
        UdacityClient.getStudentLocations { (studentLocations, error) in
            OnTheMapModel.studentLocations = studentLocations
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OnTheMapModel.studentLocations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let studentLocation = OnTheMapModel.studentLocations[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        cell.textLabel?.text = "\(studentLocation.firstName) \(studentLocation.lastName)"
        cell.detailTextLabel?.text = studentLocation.mediaURL

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentLocation = OnTheMapModel.studentLocations[indexPath.row]
        if let url = URL(string: studentLocation.mediaURL) {
            UIApplication.shared.open(url)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
