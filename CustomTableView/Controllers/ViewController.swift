//
//  ViewController.swift
//  CustomTableView
//
//  Created by 2B on 11/13/17.
//  Copyright © 2017 Automata. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ViewControllerViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(ViewControllerTableViewCell.nib, forCellReuseIdentifier: ViewControllerTableViewCell.identifer)
        viewModel = ViewControllerViewModel()
        viewModel.getHeroes {
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ViewControllerTableViewCell.identifer, for: indexPath) as? ViewControllerTableViewCell {
            cell.item = self.viewModel.items[indexPath.row]
            
            return cell
        }
        
        return UITableViewCell()
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
}

