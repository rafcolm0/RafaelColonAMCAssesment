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
        self.mainTableView.dataSource = self;
        self.mainTableView.delegate = self;
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

extension MainViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mainViewModel.numberOfGalleries();
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?;
        let gallery = self.mainViewModel.galleries![indexPath.row];
        if(indexPath.row == 0){
            cell = tableView.dequeueReusableCell(withIdentifier: "HeroesTableCell", for: indexPath) as! HeroesTableCell;
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "PostersTableCell", for: indexPath) as! PostersTableCell;
            (cell as! PostersTableCell).postersTittleLabel.text = gallery.name;
        }
        (cell as! HeroesTableCell).generateFlickrCollectionCarousel(gallery:gallery);
        return cell!;
    }
}

extension MainViewModel:UITableViewDelegate{
    
}

