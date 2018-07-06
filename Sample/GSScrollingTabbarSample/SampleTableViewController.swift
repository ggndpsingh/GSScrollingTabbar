//
//  SampleTableViewController.swift
//  GSScrollingTabbarSample
//
//  Created by Gagandeep Singh on 5/7/18.
//  Copyright © 2018 Gagandeep Singh. All rights reserved.
//

import UIKit

class SampleTableViewController: UITableViewController, StoryboardLoading {
    
    var cellColor: UIColor = .white
    var rowCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = "\(indexPath.row)"
        cell.contentView.backgroundColor = cellColor
        cell.selectionStyle = .none
        return cell
    }
}
