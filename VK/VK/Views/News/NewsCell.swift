//
//  NewsPostCell.swift
//  VK
//
//  Created by Антон Васильченко on 02.07.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

protocol NewsPostCellDelegate: class {
    func didTapShowMore(cell: NewsCell)
}

final class NewsCell: UITableViewCell {
    
    weak var delegate: NewsPostCellDelegate?
    
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
    @IBOutlet weak var showMoreButton: UIButton!
    
    lazy var service = VKService()
    var user: [Users] = []
    var group: [Groups] = []
    
    var isExpanded = false {
        didSet {
            updatePostLabel()
            updateShowMoreButton()
        }
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        selectionStyle = .none
        updatePostLabel()
        showMoreButton.addTarget(self, action: #selector(showMoreTapped), for: .touchUpInside)
        updateShowMoreButton()
    }
    
    @objc private func showMoreTapped() {
        delegate?.didTapShowMore(cell: self )
    }
    
    private func updatePostLabel() {
        newsText.numberOfLines = isExpanded ? 0 : 10
    }
    
    private func updateShowMoreButton() {
        let title = isExpanded ? "Show less..." : "Show more..."
        showMoreButton.setTitle(title, for: .normal)
    }
    
    private func getLabelSize(text: String, font: UIFont) -> CGSize {
        let maxWidth = frame.width
        let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        let width = Double(rect.size.width)
        let height = Double(rect.size.height)
         
        let size = CGSize(width: ceil(width), height: ceil(height))
        return size
    }
    
    
    func configure(item: NewsItems) {
        
        authorLabel.text = item.profile?.name
        likeButton.setTitle(String(item.likeCount), for: .normal)
        commentButton.setTitle(String(item.commentCount), for: .normal)
        viewButton.setTitle(String(item.viewCount), for: .normal)
        repostButton.setTitle(String(item.repostCount), for: .normal)

        let labelSize = getLabelSize(text: item.text ?? "", font: newsText.font)
        showMoreButton.isHidden = labelSize.height < 200
        newsText.text = item.text
        
        if let imageUrl = item.profile?.imageURL, let url = URL(string: imageUrl) {
            let resource = ImageResource(downloadURL: url)
            authorImage?.kf.setImage(with: resource)
        }
    }
    
//    func setCollectionDelegate (_ delegate: UICollectionViewDataSource & UICollectionViewDelegate, for row: Int) {
//        collectionView.dataSource = delegate
//        collectionView.delegate = delegate
//        collectionView.tag = row
//        collectionView.reloadData()
//    }
    
    
    
}

