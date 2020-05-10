//
//  NewsHeadlineViewModal.swift
//  FluperTask
//
//  Created by Ahtasham Ansari on 10/05/20.
//  Copyright © 2020 AhtashamAnsari. All rights reserved.
//

import Foundation

class NewsHeadlineViewModal {
    
    var shouldUpdateViewClosure: ((Bool) -> Void)?
    var newsHeadline: [NewsHeadline]?
    
    func fetchNewsArticle() {
       let newsArticle =  DatabaseHelper.shareInstance.fetchNewsHeadline()
        if newsArticle.count > 0 {
            self.newsHeadline = newsArticle
            self.shouldUpdateViewClosure?(true)
        }else {
            WebServices.sharedInstance.getNewsHeadlineList { (isSuccess) in
                if isSuccess {
                    let newsArticle =  DatabaseHelper.shareInstance.fetchNewsHeadline()
                    self.newsHeadline = newsArticle
                    self.shouldUpdateViewClosure?(isSuccess)
                }else {
                    // Show Alert
                    self.shouldUpdateViewClosure?(isSuccess)
                    print("something went wrong please try again")
                }
            }
        }
    }
}

extension NewsHeadlineViewModal {
 
    func numberOfRowInSection()-> Int {
        return self.newsHeadline?.count ?? 0
    }
    
    func newsAarticleAtIndex(index: Int) -> TopHeadlineViewModal {
        let newsHeadline = self.newsHeadline![index]
        return TopHeadlineViewModal(newsList: newsHeadline)
    }
}

struct TopHeadlineViewModal {
    let newsList: NewsHeadline
}

extension TopHeadlineViewModal {
    init(_ newsList: NewsHeadline) {
        self.newsList = newsList
    }
}

extension TopHeadlineViewModal {
    var title: String {
        return self.newsList.title ?? ""
    }
    
    var newsDescription: String {
        return self.newsList.newsDescription ?? ""
    }
    
    var imageUrl: String? {
        if let data = newsList.urlToImage {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}

