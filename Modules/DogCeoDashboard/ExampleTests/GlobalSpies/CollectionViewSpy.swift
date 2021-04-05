//
//  CollectionViewSpy.swift
//  ExampleTests
//
//  Created by Vitor on 04-04-21.
//

import UIKit

class CollectionViewSpy: UICollectionView {

    // MARK: - Expectations
    var expectedNumberOfItems = 0

    // MARK: - Called properties
    private(set) var reloadDataCalled = false
    private(set) var reloadSectionsCalled = false
    private(set) var deselectItemnCalled = false

    // MARK: - Methods
    override func reloadData() {
        reloadDataCalled = true
    }

    override func reloadSections(_ sections: IndexSet) {
        reloadSectionsCalled = true
    }

    override func deselectItem(at indexPath: IndexPath, animated: Bool) {
        deselectItemnCalled = true
    }
    override func numberOfItems(inSection section: Int) -> Int {
        expectedNumberOfItems
    }
}
