//
//  HouseplantsData.swift
//  PlantEd
//
//  Created by Jacqueline Palevich on 1/7/21.
//

struct HouseplantInfo : Codable {
  var description: String
}

// The key is a houseplant name.
typealias HouseplantInfoDictionary = [String:HouseplantInfo]

// The key is a category name.
typealias HouseplantCategoryDictionary = [String:HouseplantInfoDictionary]

