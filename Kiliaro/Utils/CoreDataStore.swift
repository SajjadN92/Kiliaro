//
//  CoreDataStore.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 8/1/22.
//

import CoreData

class CoreDataStore<T: ManagedObject> {
    func getItems() async throws -> [T] {
        let fetchRequest = T.createFetchRequest()
        let context = CoreDataStack.viewContext
        
        return try await withCheckedThrowingContinuation { continuation in
            context.perform {
                do {
                    let objects = try context.fetch(fetchRequest) as! [T]
                    continuation.resume(with: .success(objects))
                } catch {
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
    
    func removeAll() async throws {
        let fetchRequest = T.createFetchRequest()
        let context = CoreDataStack.backgroundContext
        
        return try await withCheckedThrowingContinuation { continuation in
            context.perform {
                let request = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                request.resultType = .resultTypeObjectIDs

                do {
                    let batchDelete = try context.execute(request) as? NSBatchDeleteResult

                    guard let deleteResult = batchDelete?.result as? [NSManagedObjectID] else {
                        return continuation.resume(with: .failure(CacheError.deleteError))
                    }

                    let deletedObjects: [AnyHashable: Any] = [NSDeletedObjectsKey: deleteResult]
                    NSManagedObjectContext.mergeChanges(fromRemoteContextSave: deletedObjects,
                                                        into: [context])
                    continuation.resume(with: .success(()))
                } catch {
                    continuation.resume(with: .failure(CacheError.deleteError))
                }
            }
        }
    }
    
    @discardableResult func save<U: Decodable>(items: [U]) async throws -> [T] {
        let context = CoreDataStack.backgroundContext
        return try await withCheckedThrowingContinuation { continuation in
            context.perform {
                var objects = [T]()
                for index in 0 ..< items.count {
                    objects.append(T(with: items[index], in: context))
                }
                do {
                    try context.save()
                    continuation.resume(with: .success(objects))
                } catch {
                    continuation.resume(with: .failure(CacheError.saveError))
                }
            }
        }
    }
}

enum CacheError: Error {
    case fetchError
    case saveError
    case deleteError
}

open class ManagedObject: NSManagedObject {
    
    public required convenience init<T: Decodable>(with model: T, in context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
        update(with: model)
    }
    
    open func update<T: Decodable>(with model: T) { }
    
    public static var entityName: String {
        return String(describing: self)
    }
    
    public class func createFetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        return NSFetchRequest(entityName: entityName)
    }
}
