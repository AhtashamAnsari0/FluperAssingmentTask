//
//  ViewController.swift
//  FluperTask
//
//  Created by Ahtasham Ansari on 10/05/20.
//  Copyright © 2020 AhtashamAnsari. All rights reserved.
//

struct IKCOCellIdentifiers {
    static let IKNewsHeadlineTableViewCell = "NewsHeadlineTableViewCell"
}

import UIKit

class NewsHeadLineViewController: UIViewController {

    /**UILabel for showing the top headline */
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var viewModal: NewsHeadlineViewModal = {
        let viewModal = NewsHeadlineViewModal()
        return viewModal
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         //Do any additional setup after loading the view.
        self.initialSetup()
    }

    private func initialSetup() {
        self.tableView.register(UINib(nibName: String (describing: NewsHeadlineTableViewCell.self), bundle: Bundle.main), forCellReuseIdentifier: IKCOCellIdentifiers.IKNewsHeadlineTableViewCell)
        
        self.viewModal.shouldUpdateViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
                self?.tableView.reloadData()
            }
        }
        self.viewModal.fetchNewsArticle()
        self.activityIndicator.startAnimating()
    }
    
}

//MARK:- UITableViewDataSoure Mathod
extension NewsHeadLineViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModal.numberOfRowInSection()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: IKCOCellIdentifiers.IKNewsHeadlineTableViewCell, for: indexPath) as? NewsHeadlineTableViewCell else {
            print("cell not found")
            return NewsHeadlineTableViewCell()
        }
        let newsHeadline = self.viewModal.newsAarticleAtIndex(index: indexPath.row)
        cell.configureCell(newsArticle: newsHeadline)
        return cell 
    }
    
}
