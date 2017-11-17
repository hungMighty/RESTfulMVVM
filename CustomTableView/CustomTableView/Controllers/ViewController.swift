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
    
    fileprivate var strLabel: UILabel?
    fileprivate var activityIndicator: UIActivityIndicatorView?
    fileprivate var effectView: UIView?
    
    fileprivate var viewModel = ViewControllerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(ViewControllerTableViewCell.nib, forCellReuseIdentifier: ViewControllerTableViewCell.identifer)
        self.tableView.tableFooterView = UIView()
        
        self.activityIndicator("Loading API")
        self.viewModel.getHeroes { [unowned self] in
            self.stopIndicator()
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: Utilities
    func activityIndicator(_ title: String) {
        strLabel?.removeFromSuperview()
        activityIndicator?.removeFromSuperview()
        effectView?.removeFromSuperview()
        
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        guard let strLabel = self.strLabel else {
            return
        }
        strLabel.text = title
        strLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        strLabel.textColor = UIColor.white
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        guard let activityIndicator = self.activityIndicator else {
            return
        }
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()
        
        effectView = UIView(frame: CGRect(x: view.frame.midX - strLabel.frame.width / 2,
                                          y: view.frame.midY - strLabel.frame.height / 2,
                                          width: 160, height: 46))
        guard let effectView = self.effectView else {
            return
        }
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        effectView.backgroundColor = UIColor.black.withAlphaComponent(0.25)

        effectView.addSubview(strLabel)
        effectView.addSubview(activityIndicator)
        view.addSubview(effectView)
    }
    
    func stopIndicator() {
        self.activityIndicator?.stopAnimating()
        strLabel?.removeFromSuperview()
        activityIndicator?.removeFromSuperview()
        effectView?.removeFromSuperview()
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

