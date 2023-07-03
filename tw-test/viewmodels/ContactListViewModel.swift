//
//  ContactListViewModel.swift
//  tw-test
//
//  Created by Krisnandika Aji on 03/07/23.
//

import Foundation

class ContactListViewModel {
    
    var data: [Contact] = []
    var filteredData: [Contact] = []
    var keyword: String = ""
    var selectionHandler: ((Contact) -> Void)?
    
    init() {
        data = []
        filteredData = []
    }
}
