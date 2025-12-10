//
//  ReportRef.swift
//  Wildline
//
//  Created by Student on 12/9/25.
//

import Foundation
import FirebaseFirestore

struct ReportRef: Codable{
    @DocumentID var id: String?
    var reportId: String
    
    init(reportId: String) {
        self.reportId = reportId
    }
}
