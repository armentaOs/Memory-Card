//
//  MemoryCardTests.swift
//  MemoryCardTests
//
//  Created by Oscar A on 27/05/20.
//  Copyright © 2020 Oscar A. All rights reserved.
//

import XCTest
@testable import MemoryCard

class MemoryCardTests: XCTestCase {
    
//    var firstVC: MenuViewController!

    override func setUpWithError() throws {
//        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        firstVC = storyBoard.instantiateInitialViewController() as? MenuViewController
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMainViewController() -> Void {
        let text = MenuViewController.segues.delicioso.rawValue
        XCTAssert(text == "toViewControllerdelicioso", "rawValue for the case delicioso in the segue enum, is incorrect.")
        
        let textTwo = MenuViewController.segues.brujas.rawValue
        XCTAssert(textTwo == "toViewControllerbrujas", "rawValue for the case brujas in the segue enum, is incorrect.")
        
        let textTree = MenuViewController.segues.animales.rawValue
        XCTAssert(textTree == "toViewControlleranimales", "rawValue for the case animales in the segue enum, is incorrect.")
    }
    
    func testLocalServer() -> Void {
        let localData = LocalData.init()
        let emojisDelicioso = localData.delicioso.count
        XCTAssert(emojisDelicioso == 8, "The number of elements in the array delicioso from the LocalData struct, is incorrect.")
        
        let emojisBrujas = localData.brujas.count
        XCTAssert(emojisBrujas == 8, "The number of elements in the array brujas from the LocalData struct, is incorrect.")
        
        let emojisAnimales = localData.animales.count
        XCTAssert(emojisAnimales == 8, "The number of elements in the array animales from the LocalData struct, is incorrect.")
    }
}
