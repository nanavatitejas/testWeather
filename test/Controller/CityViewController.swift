//
//  CityViewController.swift
//  test
//
//  Created by Tejas Nanavati on 03/07/20.
//  Copyright © 2020 Tejas Nanavati. All rights reserved.
//

import UIKit
import TagListView

protocol selectedCityWeatherDetails {
    func getDetails(ids:[Int])
}

class CityViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tagView: TagListView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tblView: UITableView!
    var objCityModel = CityViewModel()
    
    var ids = [Int]()
    
    var delegate : selectedCityWeatherDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        
        
        
        tblView.tableFooterView = UIView()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnDonePressed(_ sender: Any) {
        if tagView.tagViews.count < 3{
            let alert = UIAlertController(title: "Opps", message: "Please select atleast three cities to proceed", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        delegate?.getDetails(ids: ids)
        
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            
            self.objCityModel.cityList = self.objCityModel.loadJson(filename: "cityList") as! [WelcomeElement] 
            //   self.objCityModel.loadJson(filename: "cityList")
            self.tblView.delegate = self
            self.tblView.dataSource = self
            self.searchBar.delegate = self
            self.spinner.stopAnimating()
            self.tblView.reloadData()
        })
        
    }
    
}


extension CityViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.objCityModel.filtercityList.count > 0{
            return self.objCityModel.filtercityList.count
        }
        return self.objCityModel.cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var city : WelcomeElement?
        if self.objCityModel.filtercityList.count > 0{
            city = objCityModel.filtercityList[indexPath.row]
            
        } else{
            city = objCityModel.cityList[indexPath.row]
        }
        cell.textLabel?.text = city?.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tagView.tagViews.count >= 7{
            let alert = UIAlertController(title: "Opps", message: "Please select atleast three cities to proceed", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        var city : WelcomeElement?
        if self.objCityModel.filtercityList.count > 0{
            city = objCityModel.filtercityList[indexPath.row]
            
        } else{
            city = objCityModel.cityList[indexPath.row]
        }
        
        for i in self.tagView.tagViews{
            if i.tag == city?.id{
                return
            }
            
        }
        
        ids.append(city?.id ?? 0)
        
        tagView.addTag(city?.name ?? "")
        tagView.tagViews.last?.tag = city?.id ?? 0
        
    }
    
}

extension CityViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty == false {
            self.objCityModel.filtercityList = self.objCityModel.cityList.filter({ ($0.name?.contains(searchText))! })
        }else {
            self.objCityModel.filtercityList = []
        }
        
        self.tblView.reloadData()
        
        
    }
}




extension CityViewController:TagListViewDelegate{
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print(sender.tag)

        self.ids = self.ids.filter { $0 != tagView.tag }
        
        self.tagView.removeTagView(tagView)
        
        
        
    }
}
