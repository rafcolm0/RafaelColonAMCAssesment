//
//  ViewController.swift
//  RafaelColonAMCAssesment
//
//  Created by Rafael Colon on 11/2/18.
//  Copyright © 2018 rafaelColon. All rights reserved.
//

import UIKit
import JGProgressHUD

class MainViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    let mainViewModel:MainViewModel = MainViewModel();
    let loadingHud:JGProgressHUD = JGProgressHUD();

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.mainTableView.dataSource = self;
        self.mainTableView.delegate = self;
        //note: JGProgressHUD is a HUD progress indicator library that normally use on my projects.  Loading it here to imitate Shudder's "Please Wait" loading indicator that shows on the table view.
        self.loadingHud.textLabel.text = NSLocalizedString("Please Wait...", comment: "");
        self.loadingHud.show(in:self.view);
        self.mainViewModel.loadFlickUserGalleries(completion:{
            error in
            //hide HUD indicator, and handle completion results
            self.loadingHud.dismiss();
            if(error == nil){
                self.mainTableView.reloadData();
            } else {
                //if error: for the purpose of the test, we are just setting mainTableView background to red. In real case scenario, here we could detect enum type of PhotoDownloadHandlerError returned, and show some error message, exit the app, use historial data (backups), send error logs back to the app stat analytics, etc. accordingly.
                self.mainTableView.backgroundColor = UIColor.red;
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
        /*
         NOTE: As we are sorting galleries alphabetically by name on the view model, our Flickr gallery (called "Banners") containing the top large banners (Heroes UICollectionView) will always be at position 0.
         
         On a real case scenario, we would have a better gallery type distinction system, so that we could take advantance of this dynamic cell tableview, and possibly have multiple (Heroes UICollectionView) throughtout the table view.
         */
        if(indexPath.row == 0){
            cell = tableView.dequeueReusableCell(withIdentifier: "HeroesTableCell", for: indexPath) as! HeroesTableCell;
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "PostersTableCell", for: indexPath) as! PostersTableCell;
            (cell as! PostersTableCell).postersTittleLabel.text = gallery.name;
        }
        //ok to force-unwrap here are the cell should be initialized here
        (cell as! HeroesTableCell).generateFlickrCollectionCarousel(gallery:gallery);
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //dummy functionality to imitate on cell click 
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
        feedbackGenerator.impactOccurred()
    }
}

extension MainViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 150;
        }
        return 140;
    }
}

