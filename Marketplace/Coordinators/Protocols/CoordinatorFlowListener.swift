//
//  CoordinatorFlowListener.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 23.03.2024.
//

import Foundation

protocol CoordinatorFlowListener: AnyObject {
    func onFlowFinished(coordinator: Coordinator)
}
