//
//  DetailNoteVC.swift
//  cft_notes
//
//  Created by Zakirov Tahir on 13.03.2021.
//

import UIKit
import CoreData

class DetailNoteVC: UIViewController, UITextViewDelegate {

    var titleField = UITextField()
    var contentTextView = UITextView()
    var currentDate = Date()
    var dateLabel = String()
    var forSorted = Date()
    var editNotes: Notes?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = true

        configureUI()
        configureDate()
        
    }
    
    fileprivate func configureUI() {
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(contentTextView)
        view.addSubview(titleField)
        
        self.title = editNotes?.titleNote
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action: #selector(backAndSave))
        if editNotes != nil {
            titleField.text = editNotes?.titleNote
            contentTextView.text = editNotes?.contentNote
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(menuAction))
        }

        titleField.placeholder = "Новая запись"
        titleField.backgroundColor = .systemGray6
        titleField.layer.cornerRadius = 12
        titleField.font = UIFont(name: "Avenir Next", size: 16)
        titleField.font = UIFont.boldSystemFont(ofSize: 16)
        titleField.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 16, bottom: 16, right: 16), size: .init(width: 0, height: 50))
        
        contentTextView.delegate = self
        contentTextView.backgroundColor = .systemGray6
        contentTextView.layer.cornerRadius = 12
        contentTextView.font = UIFont(name: "Avenir Next", size: 14)
        contentTextView.font = UIFont.boldSystemFont(ofSize: 14)
        contentTextView.anchor(top: titleField.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 16, bottom: 16, right: 16))
        
    }
    
    @objc fileprivate func backAndSave() {
        saveNote(with: titleField.text!, content: contentTextView.text!, date: dateLabel, sorted: forSorted)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func menuAction() {
        let alert = UIAlertController(title: "Выберите действие", message: "", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { (action) in
             
            context.delete(self.editNotes!)
            
            do {
                try context.save()
            } catch let error as NSError {
                print("failed", error.localizedDescription)
            }
            
            self.navigationController?.popViewController(animated: true)
            
        }
        
        let cancelAction = UIAlertAction(title: "Назад", style: .cancel, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate func configureDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateLabel = dateFormatter.string(from: currentDate)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    fileprivate func saveNote(with title: String, content: String, date: String, sorted: Date) {
        
        // Проверяем, есть ли значения в editNotes
        if editNotes == nil {
            // Если нет, добавляем новые данные
            guard let entity = NSEntityDescription.entity(forEntityName: "Notes", in: context) else { return }
            let noteObjects = Notes(entity: entity, insertInto: context)
            noteObjects.titleNote = title
            noteObjects.contentNote = content
            noteObjects.dateNote = date
            noteObjects.createAt = sorted
            do {
                try context.save()
            } catch {
                print("Не получилось сохранить в базу данных")
            }
        } else {
            // Если есть, заменяем
            let newTitle = title
            let newContent = content
            let newDate = date
            
            editNotes?.titleNote = newTitle
            editNotes?.contentNote = newContent
            editNotes?.dateNote = newDate
            editNotes?.createAt = sorted
            
            do {
                try context.save()
               }
            catch {
                print("Saving Core Data Failed: \(error)")
            }
        }
        
    }

}
