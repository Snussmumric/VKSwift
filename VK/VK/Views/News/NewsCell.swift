//
//  NewsPostCell.swift
//  VK
//
//  Created by Антон Васильченко on 02.07.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit
import Kingfisher

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var viewButton: UIButton!
    @IBOutlet weak var repostButton: UIButton!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var newsText: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageContainerView: UIView!
    lazy var nextImageView = UIImageView()
    
    lazy var service = VKService()
    var user: [Users] = []
    var group: [Groups] = []
    
    
    let images = (1...Int.random(in: 6...10))
        .map({$0 % 6})
        .shuffled()
        .compactMap({String($0)})
        .compactMap({UIImage(named: $0)})
    
    var currentIndex = 0
    
    //    var animator: UIViewPropertyAnimator!
    //
    //    enum Direction {
    //        case left, right
    //
    //        init(x: CGFloat) {
    //            self = x > 0 ? .right : .left
    //        }
    //    }
    //
    //    override func awakeFromNib() {
    //                mainImageView.image = images.first
    //        nextImageView.contentMode = .scaleAspectFit
    //
    //        let pan = UIPanGestureRecognizer(target: self, action: #selector(onPan))
    //        imageContainerView.addGestureRecognizer(pan)
    //    }
    //
    //    @objc func onPan(_ sender: UIPanGestureRecognizer) {
    //            guard let panView = sender.view else { return }
    //
    //            let translation = sender.translation(in: panView)
    //            print(translation.x)
    //            let direction = Direction(x: translation.x)
    //            print(direction)
    //
    //            switch sender.state {
    //
    //            case .began:
    //    //            print("began")
    //                animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeIn, animations: {
    //                    self.mainImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    //                    self.mainImageView.alpha = 0
    //                })
    //
    //                if canSlide(direction) {
    //                    let nextIndex = direction == .left ? currentIndex + 1 : currentIndex - 1
    //                    nextImageView.image = images[nextIndex]
    //                    imageContainerView.addSubview(nextImageView)
    //                    let offsetX = direction == .left ? imageContainerView.bounds.width : -imageContainerView.bounds.width
    //                    nextImageView.frame = imageContainerView.bounds.offsetBy(dx: offsetX, dy: 0)
    //
    //                    animator.addAnimations({
    //                        self.nextImageView.center = self.mainImageView.center
    //                        self.nextImageView.alpha = 1
    //                    }, delayFactor: 0.15)
    //                }
    //
    //                animator.addCompletion { (position) in
    //                    guard position == .end else { return }
    //                    self.currentIndex = direction == .left ? self.currentIndex + 1 : self.currentIndex - 1
    //                    self.mainImageView.alpha = 1
    //                    self.mainImageView.transform = .identity
    //                    self.mainImageView.image = self.images[self.currentIndex]
    //                    self.nextImageView.removeFromSuperview()
    //                }
    //                animator.pauseAnimation()
    //
    //            case .changed:
    //    //            print("changed")
    //                animator.fractionComplete = abs(translation.x) / panView.frame.width
    //
    //            case .ended:
    //    //            print("ended")
    //                if canSlide(direction), animator.fractionComplete > 0.6 {
    //                    animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
    //                } else {
    //                    animator.stopAnimation(true)
    //                    UIView.animate(withDuration: 0.25) {
    //                        self.mainImageView.transform = .identity
    //                        self.mainImageView.alpha = 1
    //                        let offsetX = direction == .left ? self.imageContainerView.bounds.width : -self.imageContainerView.bounds.width
    //                        self.nextImageView.frame = self.imageContainerView.bounds.offsetBy(dx: offsetX, dy: 0)
    //                    }
    //                }
    //
    //            default:
    //                break
    //            }
    //        }
    //
    //        func canSlide(_ direction: Direction) -> Bool {
    //            if direction == .left {
    //                return currentIndex < images.count - 1
    //            } else {
    //                return currentIndex > 0
    //            }
    //        }
    
    
    func configure(model: NewsItems) {
        
        authorImage.image = UIImage(systemName: "paperplane.fill")
        //        mainImageView.image = model.images.first
//        let date = Date(timeIntervalSince1970: model.date)
//        dateLabel.text = NewsCell.dateFormatter.string(from: date)
        
        
        authorLabel.text = model.author
        newsText.text = model.text
        likeButton.setTitle(String(model.likeCount!), for: .normal)
        commentButton.setTitle(String(model.commentCount!), for: .normal)
        viewButton.setTitle(String(model.viewCount!), for: .normal)
        repostButton.setTitle(String(model.repostCount!), for: .normal)

        
        
        if let imageUrl = model.authorImageURL, let url = URL(string: imageUrl) {
            let resource = ImageResource(downloadURL: url)
            authorImage?.kf.setImage(with: resource)
        }
    }
    
    func setCollectionDelegate (_ delegate: UICollectionViewDataSource & UICollectionViewDelegate, for row: Int) {
        collectionView.dataSource = delegate
        collectionView.delegate = delegate
        collectionView.tag = row
        collectionView.reloadData()
    }
    
    
    
}

