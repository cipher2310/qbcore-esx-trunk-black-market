Config = {
   vehiclename = "primo",
   npcmodel = "g_m_m_armboss_01",
   carlicenseplate = "DARKWEB",
   esx = false,
   qbcore = true,
   custominventory = true, -- put this as true if you dont use qb-inventory for qbcore or esx_inventoryhud for esx
   drawmarker = true, -- drawmarker under vehicle
   itemneeded = true; -- if this is enabled the players will need to use the darkweb tablet to get the car to you
   marker = {
        type = 20,
        r = 0.55,
        g = 0.55,
        b = 0.55,
   },
    DistanceOpen = 4, -- distance to open the menu
    CalledNotification = "~g~ Dealer SucessFully called and cleared tor browser history & cookies",
    Notification = "~g~ Press E to open and ~b~ BACKSPACE to close the Criminal trunk",
    NotOnRoadNotification = "~y~ You Need to be on the road to do this",
    OpenKey = 38, -- E  
    CloseKey = 194, -- BackSpace make sure its not the same as the open key
    TimeToDeleteVehicle =  10000, -- time to delete the vehicle after the player closes the trunk
    CarSpeed = 100.0, -- speed of the car
    CarBehaviour = 537133886, -- dont touch it if you dont know what you are doing
    RequiredItemName = "darkwebtablet", -- item name that the player needs to use to call the dealer
    AmountOfItemToRemove = 1,
    TimeForCooldown = 1000 * 60, -- time in ms to wait before the player can use the item again
    UseCooldown = false, -- if this is enabled the player will need to wait TimeForCooldown variable ms to use the item again
    
    --- ESX ---
    ESXObject = 'esx:getSharedObject', -- dont touch it if you dont use a custom esx object
    FullInventory = "Your inventory is full", -- message when the player inventory is full
    WeaponsAreItems = false, -- use this if you use an inventory with weapons as items [turn it off if you use esx_inventoryhud]
    InventoryLabelESX = "Darkweb", -- label of the inventory shop
    NotEnoughMoney = "You dont have enough money", -- message when the player doesnt have enough money
    ItemsESX = {
     {
          name = "bread",
          label = "Bread",
          type = "item",
          price = 120
     },
     {
          name = "weapon_pistol",
          label = "Pistol",
          type = "weapon",
          price = 100
     }
    },


    --- QBCORE ---
    FrameworkName = "qb-core", -- dont touch it if you dont use a custom qbcore object
    InventoryLabel = "Darkweb", -- label of the inventory shop
    ItemsQB = { 
     [1] = {
          name = "weapon_pistol",
          price = 2000,
          amount = 5,
          info = {},
          type = "item",
          slot = 1,
      },
      [2] = {
          name = "weapon_assaultsmg",
          price = 2000,
          amount = 5,
          info = {},
          type = "item",
          slot = 2,
      },
      [3] = {
          name = "pistol_ammo",
          price = 200,
          amount = 5,
          info = {},
          type = "item",
          slot = 3,
      },
      [4] = {
          name = "smg_ammo",
          price = 200,
          amount = 5,
          info = {},
          type = "item",
          slot = 4,
      },
    },
}


function CustomBuyFunc()
-- your code here
end
