import Bool "mo:base/Bool";
import Func "mo:base/Func";
import List "mo:base/List";

import Array "mo:base/Array";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";

actor ShoppingList {
  // Define the structure for a shopping list item
  public type Item = {
    id: Nat;
    text: Text;
    completed: Bool;
  };

  // Stable variable to store the shopping list items
  stable var items : [Item] = [];
  stable var nextId : Nat = 0;

  // Function to add a new item to the list
  public func addItem(text: Text) : async Nat {
    let id = nextId;
    nextId += 1;
    let newItem : Item = {
      id = id;
      text = text;
      completed = false;
    };
    items := Array.append(items, [newItem]);
    id
  };

  // Function to mark an item as completed or uncompleted
  public func toggleItem(id: Nat) : async Bool {
    items := Array.map<Item, Item>(items, func (item) {
      if (item.id == id) {
        return {
          id = item.id;
          text = item.text;
          completed = not item.completed;
        };
      };
      item
    });
    true
  };

  // Function to delete an item from the list
  public func deleteItem(id: Nat) : async Bool {
    let newItems = Array.filter<Item>(items, func (item) { item.id != id });
    if (newItems.size() < items.size()) {
      items := newItems;
      true
    } else {
      false
    }
  };

  // Function to get all items
  public query func getItems() : async [Item] {
    items
  };
}
