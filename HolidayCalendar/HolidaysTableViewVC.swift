//
//  HolidaysTableViewVC.swift
//  HolidayCalendar
//
//  Created by admin on 12/21/19.
//  Copyright © 2019 admin. All rights reserved.
//

//
//  HolidaysTableViewController.swift
//  HolidayCalendar
//
//  Created by admin on 12/21/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class HolidaysTableViewVC: UITableViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var listOfHOlidays = [HolidayDetail](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listOfHOlidays.count) Holidays Found"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfHOlidays.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let holiday = listOfHOlidays[indexPath.row]
        cell.textLabel?.text = holiday.name
        cell.detailTextLabel?.text = holiday.date.iso
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem
    ) {
        self.searchBar.resignFirstResponder()
        self.searchBar.text = ""
        self.listOfHOlidays = []
        tableView.reloadData()
        
    }
    
}
extension HolidaysTableViewVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else {return}
        let holidayRequest = HolidayRequest(countryCode: searchBarText)
        holidayRequest.getHolidays { [weak self] result in
            switch result{
            case .failure(let error): print(error)
            case .success(let holidays): self?.listOfHOlidays = holidays
                
            }
        }

    }
}


