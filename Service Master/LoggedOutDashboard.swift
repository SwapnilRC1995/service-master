//
//  LoggedOutDashboard.swift
//  Service Master
//
//  Created by Swapnil Roy Chowdhury on 2022-12-02.
//

import UIKit
import Firebase
import SwiftyJSON

class LoggedOutDashboard: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {

    @IBOutlet var collectionView: UICollectionView!
    private var mainServices: [Service] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collectionView.setCollectionViewLayout(layout, animated: true)
        let ref: DatabaseReference! = Database.database().reference()
        ref.observe(.value, with: { snapshot in
            
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                    let service = Service().parseJSON(JSON(child.value ?? []))
                    self.mainServices.append(service)
                }
            self.collectionView.register(ServiceCollectionViewCell.self, forCellWithReuseIdentifier: ServiceCollectionViewCell.reuseIdentifier)
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            self.collectionView.reloadData()
                
        })
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(!self.mainServices.isEmpty){
            return self.mainServices.count
        }else{
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceCollectionViewCell.reuseIdentifier, for: indexPath) as! ServiceCollectionViewCell
        
        if(!self.mainServices.isEmpty){
            
            let title: [String] = self.mainServices.map({(service: Service) -> String in service.mainService})
            if(cell.service != nil){
                cell.service.setTitle(title[indexPath.row], for: .normal)
                cell.service.setTitleColor(.black, for: .normal)
                cell.service.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
                cell.data = self.mainServices[indexPath.row]
                
                cell.addButtonTapAction = { [self] in
                    performSegue(withIdentifier: "gotoSignIn", sender: self)
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 360, height: 49)
    }

}
