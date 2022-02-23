//
//  CatIngrList.swift
//  Restaurangular
//
//  Created by m1 on 23/02/2022.
//

import Foundation

class CatIngrList : ObservableObject{
    
    var cat_ingr_list : [CatIngr] = []{
        didSet{
            objectWillChange.send()
        }
    }

    init() {
        self.cat_ingr_list = [CatIngr()]
    }
}
