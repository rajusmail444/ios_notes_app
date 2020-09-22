//
//  NoteStorage.swift
//  Notes
//
//  Created by Rajesh Billakanti on 21/9/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import CoreData

class NoteStorage {
    static let storage : NoteStorage = NoteStorage()
    private var noteIndexToIdDict : [Int:UUID] = [:]
    private var currentIndex : Int = 0
    private(set) var managedObjectContext : NSManagedObjectContext
    private var managedContextHasBeenSet : Bool = false

    private init() {
        managedObjectContext = NSManagedObjectContext(
            concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
    }

    func setManagedContext(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        self.managedContextHasBeenSet = true
        let notes = NoteCoreDataHelper.readNotesFromCoreData(fromManagedObjectContext: self.managedObjectContext)
        currentIndex = NoteCoreDataHelper.count
        for (index, note) in notes.enumerated() {
            noteIndexToIdDict[index] = note.noteId
        }
    }

    func addNote(noteToBeAdded: NoteDataModel) {
        if managedContextHasBeenSet {
            noteIndexToIdDict[currentIndex] = noteToBeAdded.noteId
            NoteCoreDataHelper.createNoteInCoreData(noteToBeCreated: noteToBeAdded,
                                                    intoManagedObjectContext: self.managedObjectContext)
            currentIndex += 1
        }
    }

    func removeNote(at: Int) {
        if managedContextHasBeenSet {
            if at < 0 || at > currentIndex-1 {
                return
            }
            let noteUUID = noteIndexToIdDict[at]
            NoteCoreDataHelper.deleteNoteFromCoreData(noteIdToBeDeleted: noteUUID!,
                                                      fromManagedObjectContext: self.managedObjectContext)
            if (at < currentIndex - 1) {
                /*
                 currentIndex - 1 is the index of the last element
                 but we will remove the last element, so the loop goes only
                 until the index of the element before the last element
                 which is currentIndex - 2
                 */
                for i in at ... currentIndex - 2 {
                    noteIndexToIdDict[i] = noteIndexToIdDict[i+1]
                }
            }
            noteIndexToIdDict.removeValue(forKey: currentIndex)
            currentIndex -= 1
        }
    }

    func readNote(at: Int) -> NoteDataModel? {
        if managedContextHasBeenSet {
            if at < 0 || at > currentIndex-1 {
                return nil
            }
            let noteUUID = noteIndexToIdDict[at]
            let noteReadFromCoreData: NoteDataModel?
            noteReadFromCoreData = NoteCoreDataHelper
                .readNoteFromCoreData(noteIdToBeRead: noteUUID!,
                                      fromManagedObjectContext: self.managedObjectContext)
            return noteReadFromCoreData
        }
        return nil
    }

    func changeNote(noteToBeChanged: NoteDataModel) {
        if managedContextHasBeenSet {
            var noteToBeChangedIndex : Int?
            noteIndexToIdDict.forEach { (index: Int, noteId: UUID) in
                if noteId == noteToBeChanged.noteId {
                    noteToBeChangedIndex = index
                    return
                }
            }
            if noteToBeChangedIndex != nil {
                NoteCoreDataHelper.changeNoteInCoreData(noteToBeChanged: noteToBeChanged,
                                                        inManagedObjectContext: self.managedObjectContext)
            }
        }
    }


    func count() -> Int {
        return NoteCoreDataHelper.count
    }
}
