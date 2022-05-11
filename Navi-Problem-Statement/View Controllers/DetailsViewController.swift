//
//  ViewController.swift
//  Navi-Problem-Statement
//
//  Created by Lakshay Saini on 11/05/22.
//

import UIKit
import ProgressHUD

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var detailsTableView: UITableView!
    
    private var viewModel = DetailsViewModel()
    private var index: Int = 0
    private var data: [Section]? {
        didSet {
            DispatchQueue.main.async {
                self.detailsTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.delegate = self
        setuptableView()
    }
    
    func setuptableView() {
        detailsTableView.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.identifier)
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        detailsTableView.estimatedRowHeight = 50
        detailsTableView.rowHeight = UITableView.automaticDimension
    }

    @IBAction func searchPressed(_ sender: UIBarButtonItem) {
        setupProgressHUD()
        viewModel.searchPullRequests(index)
    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            index = 0
        case 1:
            index = 1
        case 2:
            index = 2
        default:
            break
        }
    }
}

// MARK: - DetailsViewDelegate
extension DetailsViewController: DetailsViewDelegate {
    func fetchedData(_ data: [Section]) {
        self.data = data
        if data.count != 0 {
            ProgressHUD.showSucceed()
        } else {
            ProgressHUD.showFailed()
            showToast(message: "Either failed to fetch data or No pull requests for the given repo", font: .systemFont(ofSize: 12.0))
        }
    }
}

// MARK: - TableView Delegate and TableView DataSource
extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        guard let rowData = data?[indexPath.row] else {
            print("failed to fetch row data in didSelectRowAt function")
            return UITableViewCell()
        }
        cell.configure(with: rowData.result, and: rowData.isHidden)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let rowData = data?[indexPath.row] else {
            print("failed to fetch row data in didSelectRowAt function")
            return
        }
        rowData.isHidden = !rowData.isHidden
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
}

// MARK: - Progress HUD
extension DetailsViewController {
    func setupProgressHUD() {
        ProgressHUD.animationType = .horizontalCirclesPulse
        ProgressHUD.show()
    }
}
