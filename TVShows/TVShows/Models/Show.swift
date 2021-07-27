//
//  Show.swift
//  TVShows
//
//  Created by Bernard Ibrovic on 27.07.2021..
//

import Foundation


struct Show: Decodable {
    let id: String
    let title: String
    let averageRating: Int?
    let description: String?
    let imageUrl: String
    let noOfReviews: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case averageRating = "average_rating"
        case description
        case imageUrl = "image_url"
        case noOfReviews = "no_of_reviews"
    }
}


struct ShowResponse: Decodable {
    let shows: [Show]
}
