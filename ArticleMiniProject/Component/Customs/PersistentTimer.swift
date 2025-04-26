//
//  timme.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 26/04/25.
//

import Foundation
import UserNotifications
import BackgroundTasks
import Auth0
import RxSwift
import RxRelay


class PersistentTimer {
    static let shared = PersistentTimer()
    
    private let userDefaults = UserDefaults.standard
    private let timerKey = "persistentTimerEndDate"
    private let notificationIdentifier = "sessionExpiredNotification"
    private var timer: Timer?
    private let disposeBag = DisposeBag()
    
    var isTimerCompleteRelay =  BehaviorSubject<Bool>(value: false)
    var isTimerCompleted: Observable<Bool> {
        return isTimerCompleteRelay.asObservable()
    }
    
    // Callback for when timer completes
    var onTimerComplete: (() -> Void)?
    
    // Start a 10-minute countdown
    func startCountdown() {
        // Calculate end time (10 minutes from now)
        let endDate = Date().addingTimeInterval(10 * 60)
        
        // Save end time to UserDefaults
        userDefaults.set(endDate.timeIntervalSince1970, forKey: timerKey)
        
        // Schedule local notification for when timer ends
        scheduleLogoutNotification(at: endDate)
        
        // Start in-memory timer
        startInMemoryTimer(endDate: endDate)
        isTimerCompleteRelay.onNext(false)
        print("Session timer started, will expire at: \(endDate)")
    }
    
    // Cancel the countdown
    func cancelCountdown() {
        timer?.invalidate()
        timer = nil
        
        // Remove saved end date
        userDefaults.removeObject(forKey: timerKey)
        
        // Remove scheduled notification
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationIdentifier])
        
        print("Session timer cancelled")
    }
    
    // Check timer status when app launches
    func resumeTimerIfNeeded() {
        guard let endTimeInterval = userDefaults.object(forKey: timerKey) as? TimeInterval else {
            // No timer was running
            return
        }
        
        let endDate = Date(timeIntervalSince1970: endTimeInterval)
        
        // Check if timer has already expired
        if Date() >= endDate {
            // Timer already completed while app was closed
            handleTimerCompletion()
            return
        }
        
        // Timer still running, restart in-memory component
        startInMemoryTimer(endDate: endDate)
        
        print("Session timer resumed, will expire at: \(endDate)")
    }
    
    // Get remaining time in seconds
    func getRemainingTime() -> TimeInterval? {
        guard let endTimeInterval = userDefaults.object(forKey: timerKey) as? TimeInterval else {
            return nil
        }
        
        let endDate = Date(timeIntervalSince1970: endTimeInterval)
        let remainingTime = endDate.timeIntervalSince(Date())
        
        return remainingTime > 0 ? remainingTime : 0
    }
    
    // Private methods
    private func startInMemoryTimer(endDate: Date) {
        // Cancel any existing timer
        timer?.invalidate()
        
        // Create a new timer that fires every second to update UI
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            let currentDate = Date()
            
            if currentDate >= endDate {
                self?.handleTimerCompletion()
            }
        }
    }
    
    private func scheduleLogoutNotification(at date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Session Expired"
        content.body = "You have been logged out due to inactivity."
        content.sound = .default
        
        // Create trigger from date
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        // Create request
        let request = UNNotificationRequest(identifier: notificationIdentifier, content: content, trigger: trigger)
        
        // Schedule notification
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
    
    private func handleTimerCompletion() {
        // Clean up
        timer?.invalidate()
        timer = nil
        userDefaults.removeObject(forKey: timerKey)
        
        // Perform logout
        logout()
        
        // Also trigger callback for any UI updates
        onTimerComplete?()
        
        print("Session expired, user logged out!")
    }
    
    private func logout() {
        // Call your authentication service to logout
        
        isTimerCompleteRelay.onNext(true)
        // Show notification if app is in background
        if UIApplication.shared.applicationState != .active {
            let content = UNMutableNotificationContent()
            content.title = "Session Expired"
            content.body = "You have been logged out due to inactivity."
            content.sound = .default
            
            let request = UNNotificationRequest(identifier: UUID().uuidString,
                                               content: content,
                                               trigger: nil)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
    
}
