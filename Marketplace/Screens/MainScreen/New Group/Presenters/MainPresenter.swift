//
//  MainPresenter.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 24.01.2024.
//

import Foundation
import UIKit

protocol MainViewProtocol: AnyObject {
    func setGreeting(greeting: String)
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, publiсation: Publication)
    func showGreeting()
}


class MainPresenter: MainViewPresenterProtocol {
    let view: MainViewProtocol
    let publication: Publication
    
    required init(view: MainViewProtocol, publiсation: Publication) {
        self.view = view
        self.publication = publiсation
    }
    
    func showGreeting() {
        let greeting = self.publication.title
        self.view.setGreeting(greeting: greeting)
    }
}
