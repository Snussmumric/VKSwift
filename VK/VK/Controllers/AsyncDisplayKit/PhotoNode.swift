//
//  PhotoNode.swift
//  VK
//
//  Created by Антон Васильченко on 08.10.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit
import AsyncDisplayKit

final class PhotoNode: ASCellNode {
    
    private let item: Photos
    
    fileprivate let imageNode = ASNetworkImageNode()

    init(item: Photos) {
        self.item = item
        
        super.init()
        setupNode()
    }
    
    private func setupNode() {
        imageNode.url = URL(string: (item.imageURL ?? "" ))
        imageNode.contentMode = .scaleAspectFill
        addSubnode(imageNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let photoWidth = constrainedSize.max.width
        imageNode.style.preferredSize = CGSize(width: photoWidth, height: photoWidth)
        let photoSpec = ASWrapperLayoutSpec(layoutElement: imageNode)
        return photoSpec
    }
    
    
}
