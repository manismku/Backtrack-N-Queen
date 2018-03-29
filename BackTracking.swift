//
//  BackTracking.swift
//  CountSortProject
//
//  Created by manish kumar on 13/03/18.
//  Copyright © 2018 manish kumar. All rights reserved.
//

import Foundation


struct Position {
    var x: Int
    var y: Int
    
    init(x:Int, y:Int) {
        self.x = x
        self.y = y
    }
    
    mutating func reset() {
        self.x = 0
        self.y = 0
    }
}

struct Board {
    var row: Int
    var col: Int
    var positionMatrix: [[Int]]
    var queenPositions: [Position]
    var N: Int
    
    init(row: Int, col: Int, queens: Int) {
        self.row = row
        self.col = col
        self.positionMatrix = Array(repeating: Array(repeating: 0, count: col), count: row)
        self.N = queens
        self.queenPositions = [Position]()
    }
    
    
    subscript(row: Int, col: Int) -> Int {
     
        get {
            return positionMatrix[row][col]
        }
        
        set {
            positionMatrix[row][col] = newValue
        }
    }
    
    func canAttack(_ x:Int,_ y:Int) -> Bool {
        return (positionMatrix[y][x] == 1) ? true : false
    }
    
    func checkAttack(_ row: Int, _ col: Int) -> Bool {
        
        var x = col
        var y = row
        
        while y >= 0  {
            if canAttack(x, y) {return true}
            y -= 1
        }
        
        //reset
        y = row
        
        while x >= 0  && y >= 0 {
            if canAttack(x, y) {return true}
            x -= 1
            y -= 1
        }
        
        //Reset
        x = col
        y = row
        
        while y >= 0 && x < self.positionMatrix.count {
            if canAttack(x, y) {return true}
            x += 1
            y -= 1
        }
        
        return false
    }
    

    mutating func PlaceQueenOptimised(queen: Int, row: Int) -> Bool {
        
        if queen == 0 {
            return true
        }
        
        if row > (self.row - 1) {
            return false
        }
        
        var curCol = 0
        while curCol < self.col {
            
            if !checkAttack(row, curCol) {
                positionMatrix[row][curCol] = 1
                if PlaceQueenOptimised(queen: queen - 1, row: row + 1) {
                    return true
                }
                positionMatrix[row][curCol] = 0 //This is where we backtrack
            }
            
            curCol += 1
        }
        return false
    }
    
}




