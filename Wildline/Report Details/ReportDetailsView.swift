//
//  ReportDetailsView.swift
//  Wildline
//
//  Created by Max Grotstein on 11/13/25.
//

import UIKit
import MapKit

let ACCENT_COLOR = UIColor(red: 0.2, green: 0.6, blue: 0.35, alpha: 1.0)

class ReportDetailsView: UIView {
    
    var titleLabel: UILabel!
    var updateButton: UIButton!
    
    var reporterInfoLabel: UILabel!
    var reporterNameLabel: UILabel!
    var reporterPhoneLabel: UILabel!
    
    var descriptionLabel: UILabel!
    var descriptionTextView: UITextView!
    
    var timelineLabel: UILabel!
    var timelineStackView: UIStackView!
    
    var actionButton: UIButton!
    
    var scrollView: UIScrollView!
    var contentView: UIView!
    
    var mapPreview: MKMapView!
    var mapButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 0.95, green: 0.98, blue: 0.95, alpha: 1.0)
        
        setupScrollView()
        setupHeader()
        setupReporterInfo()
        setupDescription()
        setupTimeline()
        setupActionButton()
        
        setupMapPreview()
        setupMapButton()
        
        
        initConstraints()
    }
    
    func setupMapPreview() {
        mapPreview = MKMapView()
        mapPreview.isUserInteractionEnabled = false
        mapPreview.layer.cornerRadius = 12
        mapPreview.layer.borderWidth = 1.5
        mapPreview.layer.borderColor = UIColor(red: 0.5, green: 0.75, blue: 0.5, alpha: 1.0).cgColor
        mapPreview.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mapPreview)
    }
    
    func setupMapButton() {
        mapButton = UIButton(type: .system)
        mapButton.setTitle("", for: .normal)
        mapButton.backgroundColor = .clear
        
        mapButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mapButton)
    }
    
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
        
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
    }
    
    func setupHeader() {
        titleLabel = createStyledTitleLabel(title: "Title")
        titleLabel.lineBreakMode = .byWordWrapping
        contentView.addSubview(titleLabel)
        
        updateButton = UIButton(type: .system)
        updateButton.setTitle("Delete", for: .normal)
        updateButton.setTitleColor(.white, for: .normal)
        updateButton.backgroundColor = ACCENT_COLOR
        updateButton.layer.borderWidth = 0
        updateButton.layer.cornerRadius = 10
        updateButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        updateButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
        updateButton.layer.shadowColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 0.2).cgColor
        updateButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        updateButton.layer.shadowRadius = 4
        updateButton.layer.shadowOpacity = 1.0
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(updateButton)
    }
    
    func setupReporterInfo() {
        reporterInfoLabel = UILabel()
        reporterInfoLabel.text = "Reporter Info"
        reporterInfoLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        reporterInfoLabel.textColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 1.0)
        reporterInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(reporterInfoLabel)
        
        reporterNameLabel = UILabel()
        reporterNameLabel.text = "Alice A."
        reporterNameLabel.font = .preferredFont(forTextStyle: .body)
        reporterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(reporterNameLabel)
        
        reporterPhoneLabel = UILabel()
        reporterPhoneLabel.text = "012-345-6789"
        reporterPhoneLabel.font = .preferredFont(forTextStyle: .body)
        reporterPhoneLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(reporterPhoneLabel)
    }
    
    func setupDescription() {
        descriptionLabel = UILabel()
        descriptionLabel.text = "Description of the report"
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        descriptionLabel.textColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 1.0)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionLabel)
        
        descriptionTextView = UITextView()
        descriptionTextView.font = .preferredFont(forTextStyle: .body)
        descriptionTextView.isEditable = false
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.backgroundColor = UIColor(red: 0.98, green: 0.99, blue: 0.98, alpha: 1.0)
        descriptionTextView.layer.cornerRadius = 8
        descriptionTextView.textContainer.lineFragmentPadding = 0
        descriptionTextView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionTextView)
    }
    
    func setupTimeline() {
        timelineLabel = UILabel()
        timelineLabel.text = "Live Updates"
        timelineLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        timelineLabel.textColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 1.0)
        timelineLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(timelineLabel)
        
        timelineStackView = UIStackView()
        timelineStackView.axis = .vertical
        timelineStackView.spacing = 4
        timelineStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(timelineStackView)
    }
    
    func setupActionButton() {
        actionButton = createStyledPrimaryButton(title: "action")
        contentView.addSubview(actionButton)
    }
    
    func configureForRehabber(nextActionTextLabel: String) {
        actionButton.isHidden = false
        actionButton.setTitle(nextActionTextLabel, for: .normal)
        
        updateButton.setTitle("Withdraw Claim", for: .normal)
        updateButton.isHidden = false
    }
    
    func configureForReporter() {
        // TODO
        updateButton.setTitle("Delete Report", for: .normal)
        actionButton.isHidden = true
        updateButton.isHidden = false
    }
    
    func configureForViewer() {
        actionButton.isHidden = true
        updateButton.isHidden = true
    }
    
//    func addTimelineEvent(title: String, description: String, isExpanded: Bool = false) {
//        let eventView = TimelineEventView(title: title, description: description, isExpanded: isExpanded)
//        timelineStackView.addArrangedSubview(eventView)
//    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            updateButton.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            updateButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: updateButton.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            reporterInfoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            reporterInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            reporterNameLabel.topAnchor.constraint(equalTo: reporterInfoLabel.bottomAnchor, constant: 4),
            reporterNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            reporterPhoneLabel.topAnchor.constraint(equalTo: reporterNameLabel.bottomAnchor, constant: 2),
            reporterPhoneLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            descriptionLabel.topAnchor.constraint(equalTo: reporterPhoneLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            descriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            mapPreview.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 16),
            mapPreview.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            mapPreview.widthAnchor.constraint(equalToConstant: 250),
            mapPreview.heightAnchor.constraint(equalToConstant: 150),
            
            mapButton.topAnchor.constraint(equalTo: mapPreview.topAnchor),
            mapButton.leadingAnchor.constraint(equalTo: mapPreview.leadingAnchor),
            mapButton.trailingAnchor.constraint(equalTo: mapPreview.trailingAnchor),
            mapButton.bottomAnchor.constraint(equalTo: mapPreview.bottomAnchor),
            
            timelineLabel.topAnchor.constraint(equalTo: mapButton.bottomAnchor, constant: 24),
            timelineLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            timelineStackView.topAnchor.constraint(equalTo: timelineLabel.bottomAnchor, constant: 12),
            timelineStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            timelineStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            actionButton.topAnchor.constraint(equalTo: timelineStackView.bottomAnchor, constant: 24),
            actionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            actionButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TimelineEventView: UIView {
    
    var circleView: UIView!
    var lineView: UIView!
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    var timestampLabel: UILabel!
    var expandButton: UIButton!
    var isLastItem: Bool = false
    
    init(status: Status, isExpanded: Bool = false, isLastItem: Bool = false) {
        self.isLastItem = isLastItem
        super.init(frame: .zero)
        
        setupCircleView()
        setupLineView()
        setupTitleLabel(title: status.type.rawValue)
        setupTimestampLabel(date: status.createdAt)
        setupDescriptionLabel(description: status.message, isExpanded: isExpanded)
        
        if needsExpandButton(description: status.message) {
            setupExpandButton()
        }
        
        initConstraints()
    }
    
    func setupCircleView() {
        circleView = UIView()
        circleView.backgroundColor = ACCENT_COLOR
        circleView.layer.cornerRadius = 8
        circleView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(circleView)
    }
    
    func setupLineView() {
        lineView = UIView()
        lineView.backgroundColor = UIColor(red: 0.5, green: 0.75, blue: 0.5, alpha: 0.4)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        if !isLastItem {
            self.addSubview(lineView)
        }
    }
    
    func setupTitleLabel(title: String) {
        titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        titleLabel.textColor = UIColor(red: 0.2, green: 0.4, blue: 0.25, alpha: 1.0)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
    }
    
    func setupTimestampLabel(date: Date) {
        timestampLabel = UILabel()
        timestampLabel.text = Utilities.relativeString(from: date)
        timestampLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        timestampLabel.textColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        timestampLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(timestampLabel)
    }
    
    func setupDescriptionLabel(description: String, isExpanded: Bool) {
        descriptionLabel = UILabel()
        descriptionLabel.text = description
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = UIColor(red: 0.3, green: 0.35, blue: 0.3, alpha: 1.0)
        descriptionLabel.numberOfLines = isExpanded ? 0 : 2
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(descriptionLabel)
    }
    
    func needsExpandButton(description: String) -> Bool {
        // Check if description is long enough to need expansion
        let maxLength = 100
        return description.count > maxLength
    }
    
    func setupExpandButton() {
        expandButton = UIButton(type: .system)
        expandButton.setTitle("More details ✓", for: .normal)
        expandButton.setTitleColor(ACCENT_COLOR, for: .normal)
        expandButton.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        expandButton.addTarget(self, action: #selector(toggleExpand), for: .touchUpInside)
        expandButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(expandButton)
    }
    
    @objc func toggleExpand() {
        let isExpanded = descriptionLabel.numberOfLines == 0
        descriptionLabel.numberOfLines = isExpanded ? 2 : 0
        expandButton.setTitle(isExpanded ? "Show more" : "Show less", for: .normal)
        
        // Animate the change
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    func initConstraints() {
//        NSLayoutConstraint.activate([
//            circleView.topAnchor.constraint(equalTo: self.topAnchor),
//            circleView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            circleView.widthAnchor.constraint(equalToConstant: 16),
//            circleView.heightAnchor.constraint(equalToConstant: 16),
//            
//            lineView.topAnchor.constraint(equalTo: circleView.bottomAnchor),
//            lineView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
//            lineView.widthAnchor.constraint(equalToConstant: 2),
//            lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            
//            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
//            titleLabel.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 12),
//            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            
//            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
//            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
//            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            
//            expandButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 2),
//            expandButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
//            expandButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
//        ])
        var constraints = [
            circleView.topAnchor.constraint(equalTo: self.topAnchor),
            circleView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            circleView.widthAnchor.constraint(equalToConstant: 16),
            circleView.heightAnchor.constraint(equalToConstant: 16),
            
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            timestampLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            timestampLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            timestampLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: timestampLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ]
        
        // Add line constraints if not last item
        if !isLastItem {
            constraints.append(contentsOf: [
                lineView.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 2),
                lineView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
                lineView.widthAnchor.constraint(equalToConstant: 2),
                lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        }
        
        // Add expand button constraints if it exists
        if expandButton != nil {
            constraints.append(contentsOf: [
                expandButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 2),
                expandButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                expandButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4)
            ])
        } else {
            constraints.append(
                descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4)
            )
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
