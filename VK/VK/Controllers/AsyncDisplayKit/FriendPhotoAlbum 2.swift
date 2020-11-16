//
//  FriendPhotoAlbum.swift
//  VK
//
//  Created by Антон Васильченко on 08.10.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import Foundation
import UIKit
import AsyncDisplayKit
import Kingfisher

class FriendPhotoAlbumAsync: ASDKViewController<ASDisplayNode>, ASTableDelegate, ASTableDataSource {
    var photos: [Photos] = []
    var person : Users!
    let service = VKService()

   var tableNode: ASTableNode {
       return node as! ASTableNode
   }
  
   override init() {
       super.init(node: ASTableNode())
       self.tableNode.delegate = self
       self.tableNode.dataSource = self
       self.tableNode.allowsSelection = false
   }
  
   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {

        return photos.count
    }
   
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {

        return photos.count
    }


    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let item = photos[indexPath.row]
        let cellNodeBlock =  { () -> ASCellNode in
            return PhotoNode(item: item)
        }
            return cellNodeBlock
           
        }
    
    
    }


