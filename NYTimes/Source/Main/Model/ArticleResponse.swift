//
//  ArticleResponse.swift
//  NYTimes
//
//  Created by Adithya Bhat on 14/01/2022.
//

import Foundation

struct ArticleResponse: Codable {
    let status, copyright: String
    let numResults: Int
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }
}

// MARK: - Result
struct Result: Codable {
    let uri: String
    let url: String
    let id, assetID: Int
    let source, publishedDate, updated, section: String
    let subsection, nytdsection, adxKeywords, byline: String
    let type, title, abstract: String
    let desFacet, perFacet: [String]
    let media: [Media]
    let etaID: Int

    enum CodingKeys: String, CodingKey {
        case uri, url, id
        case assetID = "asset_id"
        case source
        case publishedDate = "published_date"
        case updated, section, subsection, nytdsection
        case adxKeywords = "adx_keywords"
        case byline, type, title, abstract
        case desFacet = "des_facet"
        case perFacet = "per_facet"
        case media
        case etaID = "eta_id"
    }
    
    func thumbnailImageURLString() -> String {
        return media.first?.mediaMetadata.first(where: { $0.format == "Standard Thumbnail" })?.url ?? ""
    }
}

// MARK: - Media
struct Media: Codable {
    let type, subtype, caption, copyright: String
    let approvedForSyndication: Int
    let mediaMetadata: [MediaMetadatum]

    enum CodingKeys: String, CodingKey {
        case type, subtype, caption, copyright
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetadata = "media-metadata"
    }
}

// MARK: - MediaMetadatum
struct MediaMetadatum: Codable {
    let url: String
    let format: String
    let height, width: Int
}
