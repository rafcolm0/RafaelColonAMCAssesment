//
//  ViewController.swift
//  RafaelColonAMCAssesment
//
//  Created by Rafael Colon on 11/2/18.
//  Copyright © 2018 rafaelColon. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    let mainViewModel:MainViewModel = MainViewModel();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.mainTableView.dataSource = self.mainViewModel;
        self.mainTableView.delegate = self.mainViewModel;
        self.mainViewModel.loadFlickUserGalleries(completion:{
            error in
            if(error == nil){
                self.mainTableView.reloadData();
                self.mainTableView.isHidden = false;
            } else {
                //show msg
            }
        });
    }

}

