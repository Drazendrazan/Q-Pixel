local QBCore = exports['qb-core']:GetCoreObject()

local function showInfo(data)
     local selected_oilrig = data.metadata
     local header = "Name: " .. data.name
     local partInfoString = "Belt: " .. selected_oilrig.part_info.belt .. " Polish: " .. selected_oilrig.part_info.polish .. " Clutch: " .. selected_oilrig.part_info.clutch
     local duration = math.floor(selected_oilrig.duration / 60)
     -- header
     local openMenu = {
          {
               header = header,
               isMenuHeader = true,
               icon = 'fa-solid fa-oil-well'
          }, {
               header = 'Speed',
               isMenuHeader = true,
               icon = 'fa-solid fa-gauge',
               txt = "" .. selected_oilrig.speed .. " RPM",
          },
          {
               header = 'Duration',
               isMenuHeader = true,
               icon = 'fa-solid fa-clock',
               txt = "" .. duration .. " Min",
          },
          {
               header = 'Temperature',
               isMenuHeader = true,
               icon = 'fa-solid fa-temperature-high',
               txt = "" .. selected_oilrig.temp .. " °C",
          },
          {
               header = 'Oil Storage',
               isMenuHeader = true,
               icon = 'fa-solid fa-oil-can',
               txt = "" .. selected_oilrig.oil_storage .. "/Gal"
          },
          {
               header = 'Part Info',
               isMenuHeader = true,
               icon = 'fa-solid fa-oil-can',
               txt = partInfoString,
          },
          {
               header = 'Pump oil to storage',
               icon = 'fa-solid fa-arrows-spin',
               params = {
                    event = 'keep-oilrig:storage_menu:PumpOilToStorage',
                    args = {
                         oilrig_hash = data.oilrig_hash
                    }
               }
          },
          {
               header = 'Close',
               icon = 'fas fa-x',
               params = {
                    event = "qb-menu:closeMenu"
               }
          }
     }

     exports['qb-menu']:openMenu(openMenu)
end

-- Events
AddEventHandler('keep-oilrig:storage_menu:PumpOilToStorage', function(data)
     QBCore.Functions.TriggerCallback('keep-oilrig:server:PumpOilToStorageCallback', function(result)

     end, data.oilrig_hash)
end)
AddEventHandler('keep-oilrig:client:viewPumpInfo', function(qbtarget)
     -- ask for updated data
     OilRigs:startUpdate(function()
          showInfo(OilRigs:getByEntityHandle(qbtarget.entity))
     end)
end)
