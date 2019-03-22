//
//  HomeViewModel.swift
//  Tiki-Home-Test
//
//  Created by HUYNH Hoc Luan on 3/21/19.
//  Copyright © 2019 Luan Huynh. All rights reserved.
//

import UIKit

struct HomeViewModel {
    
    // MARK: - Properties
    var listKeywords: [Keyword] = []
    var listColors: [String] = ["#16702e", "#005a51", "#996c00", "#5c0a6b", "#006d90", "#974e06", "#99272e", "#89221f", "#00345d"]
    var colorIndex: Int = 0
    
    // MARK: - Functions
    mutating func initKeywordCellModel(keyword: Keyword, index: Int) -> KeywordCellModel {
        colorIndex = index
        if colorIndex > listColors.count - 1 {
            colorIndex = index - listColors.count
        }
        
        let containViewColor = UIColor(hexString: listColors[colorIndex])
        let keywordString = handleKeyword(withString: keyword.value ?? "")
        let model = KeywordCellModel(keyword: keywordString.value, cellName: keywordString.value, imageUrl: keyword.icon ?? "", containViewColor: containViewColor, object: keyword, keywordLines: keywordString.lines)
        
        return model
    }
    
    private func handleKeyword(withString string: String) -> (value: String, lines: Int) {
        var result = ""
        var chars = Array(string)
        let middleIndex = chars.count/2
        var lines = 1
        
        let stride1 = stride(from: middleIndex, to: 0, by: -1)
        let stride2 = stride(from: middleIndex, to: chars.count, by: 1)
        for (i, j) in zip(stride1, stride2) {
            if chars[i] == Character(" ") {
                chars.insert(Character("\n"), at: i)
                lines = 2
                break
            } else if chars[j] == Character(" ") {
                chars.insert(Character("\n"), at: j)
                lines = 2
                break
            }
        }
        
        result = String(chars)
        return (value: result, lines: lines)
    }
}
