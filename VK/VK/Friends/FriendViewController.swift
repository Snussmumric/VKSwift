//
//  FriendViewController.swift
//  VK
//
//  Created by Антон Васильченко on 28.06.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

class FriendViewController: UIViewController, UICollectionViewDelegate {
    
    
    @IBOutlet weak var personMainImage: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personSurname: UILabel!
    @IBOutlet weak var personAge: UILabel!
    @IBOutlet weak var personCity: UILabel!
    @IBOutlet weak var personalInfoView: UIView!
    @IBOutlet weak var personalInfoDataView: UIView!
    
    var photos: [UIImage?] = []
    var person : User!
    
    @IBOutlet weak var friendCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personalInfoDataView.backgroundColor = UIColor(rgb: 0x92D5F9)
        
        
            
//            UIColor(displayP3Red: 146, green: 213, blue: 249, alpha: 1)
        
        personMainImage.image = person.image
        personName.text = person.name
        personSurname.text = person.surname
        personCity.text = person.city
        personAge.text = String(person.age)
        
        friendCollectionView.backgroundColor = .white
        
        friendCollectionView.delegate = self
        friendCollectionView.dataSource = self
        
    }
    
}

extension FriendViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCell", for: indexPath) as! FriendCell
        cell.friendBigPhotos.image = person.photos[indexPath.row]
        
        
        return cell
    }
    
}


