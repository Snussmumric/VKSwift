//
//  FriendViewController.swift
//  VK
//
//  Created by Антон Васильченко on 28.06.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

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

class FriendViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var personMainImage: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personSurname: UILabel!
    @IBOutlet weak var personAge: UILabel!
    @IBOutlet weak var personCity: UILabel!
    @IBOutlet weak var personalInfoView: UIView!
    @IBOutlet weak var personalInfoDataView: UIView!
    
    let transitionController = TransitionController()
    //    let startView: UIImageView? = nil
    
    var photos: [Photos] = []
    var person : Users!
    lazy var service = VKService()
    lazy var realm = try! Realm()
    
    
    @IBOutlet weak var friendCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        personName.text = person.firstName
        personSurname.text = person.lastName
        
        loadFromCache()
        loadFromNetwork()
        


        

        
        personalInfoDataView.backgroundColor = UIColor(rgb: 0x92D5F9)
        
        if let imageUrl = person.imageUrl100, let url = URL(string: imageUrl) {
            let resource = ImageResource(downloadURL: url)
            personMainImage?.kf.setImage(with: resource)
        }
        
        friendCollectionView.backgroundColor = .white
        
        friendCollectionView.delegate = self
        friendCollectionView.dataSource = self
        
        personMainImage.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        personMainImage.addGestureRecognizer(tap)
        
        
        
        
    }
    
    func loadFromCache() {
        let object = realm.objects(Photos.self).filter("ownerID == %@", person.id)
        
        photos = Array(object)
        friendCollectionView?.reloadData()
    }
    
    func loadFromNetwork() {
        service.getData(.photos(id: person.id), Photos.self) { [weak self] _ in
            self?.loadFromCache()
        }
    }
    
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        print ("You tapped more")
        performSegue(withIdentifier: "segue", sender: UITapGestureRecognizer.self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ZoomedPictureController {
            viewController.photo = personMainImage.image
            viewController.transitioningDelegate = transitionController
            transitionController.startView = personMainImage
            
        }
        
        if
            let controller = segue.destination as? SliderViewController,
            let indexPath = friendCollectionView.indexPathsForSelectedItems?.first
        {
            controller.title = title
            controller.photos = photos
            controller.currentIndex = indexPath.row
            controller.transitioningDelegate = transitionController
            if let imageUrl = person.imageUrl100, let url = URL(string: imageUrl) {
                let resource = ImageResource(downloadURL: url)
                transitionController.startView?.kf.setImage(with: resource) 
            }
//            transitionController.startView = person.imageUrl100

        }
        
    }
}

extension FriendViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCell", for: indexPath) as! FriendCell
        cell.configure(photo: photos[indexPath.row])
        return cell
    }
    
}


