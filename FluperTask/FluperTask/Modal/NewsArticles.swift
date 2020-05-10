//
//  File.swift
//  FluperTask
//
//  Created by Ahtasham Ansari on 10/05/20.
//  Copyright © 2020 AhtashamAnsari. All rights reserved.
//

import UIKit
import CoreData

class NewsHeadline: NSManagedObject, Codable {
   
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case newsDescription = "description"
        case urlToImage = "urlToImage"
    }

    // MARK: - Core Data Managed Object
    @NSManaged var title: String?
    @NSManaged var newsDescription: String?
    @NSManaged var urlToImage: Data?

    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "NewsHeadline", in: managedObjectContext) else {
            fatalError("Failed to decode User")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.newsDescription = try container.decodeIfPresent(String.self, forKey: .newsDescription)
        let imgurl = try container.decodeIfPresent(String.self, forKey: .urlToImage)
        if let data = imgurl?.data(using: .utf8) {
            self.urlToImage = data
        }
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(newsDescription, forKey: .newsDescription)
        try container.encode(urlToImage, forKey: .urlToImage)
    }
}

//Helper property to retrieve the Core Data managed object context
public extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
