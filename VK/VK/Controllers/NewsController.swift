//
//  NewsController.swift
//  VK
//
//  Created by Антон Васильченко on 02.07.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit
import RealmSwift

final class NewsController: UITableViewController, UITableViewDataSourcePrefetching, NewsPostCellDelegate {
    
    lazy var loadImage = LoadImage()
    lazy var newsService = VKNewsService()
    var news: [NewsItems] = []
    
    
    // MARK: - dateFormatter
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM HH:mm"
        return formatter
    }()
    
    var dateTextCache: [IndexPath: String] = [:]
    
    func getCellDateText(forIndexPath indexPath: IndexPath, andTimestamp timestamp: Double) -> String {
        if let stringDate = dateTextCache[indexPath] {
            return stringDate
        } else {
            let date = Date(timeIntervalSince1970: timestamp)
            let stringDate = dateFormatter.string(from: date)
            dateTextCache[indexPath]  = stringDate
            return stringDate
        }
    }
    
    // MARK: - main
    
    var nextNewsItemID = ""
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        //        getData()
        setupRefreshControl()
        
        
    }
    
    private func setup() {
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        tableView.register(UINib(nibName: "NewsWallPhotoCell", bundle: nil), forCellReuseIdentifier: "NewsWallPhotoCell")
        tableView.tableFooterView = UIView()
        tableView.prefetchDataSource = self
    }
    
    private func getData() {
        newsService.get { [weak self] (items, _) in
            self?.news = items
            self?.tableView.reloadData()
        }
        
    }
    // MARK: - RefreshControll
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "loading")
        refreshControl?.tintColor = .blue
        refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
    }
    
    @objc private func refreshNews() {
        
        let mostFreshTime = news.first?.date ?? Date().timeIntervalSince1970
        
        newsService.get(fromTime: mostFreshTime + 1) { [weak self] (freshNews, next) in
            guard let strongSelf = self else {return}
            strongSelf.refreshControl?.endRefreshing()
            guard freshNews.count > 0 else { return }
            strongSelf.news = freshNews + strongSelf.news
            strongSelf.nextNewsItemID = next
            //            strongSelf.tableView.reloadData()
            
            let indexPaths = (0..<freshNews.count).map{IndexPath(row: $0, section: 0)}
            strongSelf.tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
    
    // MARK: - tableview
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if news.count == 0 {
            tableView.showEmptyMessage("Pull to refresh")
        } else {
            tableView.hideEmptyMessage()
        }
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = news[indexPath.row]
        
        switch item.type {
        
        case .post:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
            cell.configure(item: item)
            cell.delegate = self
            cell.dateLabel.text = getCellDateText(forIndexPath: indexPath, andTimestamp: item.date)
            
            loadImage.downloadImage(with: item.profile?.imageURL ?? "") { (image) in
                            guard let image = image else { return }
                            cell.authorImage.image = image
                        }
            
            return cell
        case .photo:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsWallPhotoCell", for: indexPath) as! NewsWallPhotoCell
            cell.configure(model: item)
            cell.dateLabel.text = getCellDateText(forIndexPath: indexPath, andTimestamp: item.date)
            
            loadImage.downloadImage(with: item.profile?.imageURL ?? "") { (image) in
                            guard let image = image else { return }
                            cell.authorImage.image = image
                        }
            
            loadImage.downloadImage(with: item.photo?.url ?? "") { (image) in
                            guard let image = image else { return }
                            cell.postPhoto.image = image
                        }
            
            return cell
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = news[indexPath.row]
        switch item.type {
        case .photo:
            let tableWidth = tableView.bounds.width
            let news = self.news[indexPath.section]
            let cellHeight = tableWidth * (news .photo?.aspectRatio ?? 1) 
            return cellHeight
        default:
            return UITableView.automaticDimension
        }
    }
    
    // MARK: - UITableViewDataSourcePrefetching
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard
            let maxRow = indexPaths.map({$0.row}).max(),
            maxRow > news.count - 3,
            isLoading == false
        else { return }
        
        isLoading = true
        newsService.get(fromID: nextNewsItemID) { [weak self] (fetchedNews, nextFrom) in
            guard let strongSelf = self else { return }
            let newsCount = strongSelf.news.count
            strongSelf.news.append(contentsOf: fetchedNews)
            strongSelf.nextNewsItemID = nextFrom
            
            let indexPaths = (newsCount..<(newsCount+fetchedNews.count)).map{IndexPath(row: $0, section: 0)}
            strongSelf.tableView.insertRows(at: indexPaths, with: .automatic)
            strongSelf.isLoading = false
        }
    }
    
    // MARK: -  NewsPostCellDelegate
    
    func didTapShowMore(cell: NewsCell) {
        tableView.beginUpdates()
        cell.isExpanded.toggle()
        tableView.endUpdates()
    }

}
