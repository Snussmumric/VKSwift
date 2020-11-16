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

class FriendViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var personMainImage: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personSurname: UILabel!
    @IBOutlet weak var personalInfoView: UIView!
    @IBOutlet weak var personalInfoDataView: UIView!
    @IBOutlet weak var showPhotos: UIButton!
    
    @IBAction func showPhotosTapped (_ sender: UIButton) {
        let vc = FriendPhotoAlbumAsync()
        vc.photos = photos
        vc.person = person
        navigationController?.pushViewController(vc, animated: true)
    }
    
    var friendCell = FriendCell()
    
    let transitionController = TransitionController()
    
    var photos: [Photos] = []
    var person : Users!
    lazy var service = VKService()
    lazy var photoService = PhotoService(container: friendCollectionView)
    lazy var realm = try! Realm()
    var notificationToken: NotificationToken?
    var items: Results<Photos>!
    
    @IBOutlet weak var friendCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        personName.text = person.firstName
        personSurname.text = person.lastName
        
        bindViewToRealm()
        loadFromNetwork()
        
        personalInfoDataView.backgroundColor = UIColor.startColor
        
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
    
    func loadFromNetwork() {
        service.getData(.photos(id: person.id), Photos.self, shouldCache: false) { [weak self] (photos) in
            self?.photos = photos
            self?.friendCollectionView.reloadData()

        }

    }

    private func bindViewToRealm () {
        items = realm.objects(Photos.self).filter("ownerID == %@", person.id)
        notificationToken = items.observe({ [weak self] (changes) in
            switch changes {
            case .initial(let items):
                self?.photos = Array(items)
                self?.friendCollectionView.reloadData()
            case .update:
                self?.photos = Array((self?.items)!)
                self?.friendCollectionView.reloadData()
            case .error(let error):
                fatalError("\(error)")
            }
        })
    }

    
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "segue", sender: UITapGestureRecognizer.self)
    }
    
    @objc func tappedCell(_ sender: UITapGestureRecognizer) {
        print ("You tapped cell")
        performSegue(withIdentifier: "slider", sender: UITapGestureRecognizer.self)
    }    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ZoomedPictureController {
            viewController.photo = personMainImage.image
            viewController.transitioningDelegate = transitionController
            transitionController.startView = personMainImage
        }
        
        if let controller = segue.destination as? FriendPhotoAlbumAsync {
            controller.photos = photos
            controller.person = person
        }
        
        if
            let controller = segue.destination as? SliderViewController,
            let indexPath = friendCollectionView.indexPathsForSelectedItems?.first,
            let cell = friendCollectionView.cellForItem(at: indexPath) as? FriendCell
        {
            controller.title = title
            controller.photos = photos
            controller.currentIndex = indexPath.row
            controller.transitioningDelegate = transitionController
            transitionController.startView = cell.friendBigPhotos
        }
    }
}

// MARK: - Collection View


extension FriendViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCell", for: indexPath) as! FriendCell
        cell.friendBigPhotos.image = photoService.photo(at: indexPath, url: photos[indexPath.row].imageURL)
        return cell
    }
    
}
