RENNICKS INTERACTIVE SALES MAP

Please see Rennicks Interactive Sales Map Specification.doc in 'docs' for the specifications of this app.

This application was created using Flex 4, specifically the Adobe Flash Builder IDE.

---------------------------------------------------------------------------


Here is a brief summary of the contents of this directory:

deploy-  compiled SWF and supporting files (including PHP) to be placed on web directory

docs- dataflow diagram, spefications document and miscellaneous notes

libs- swcs used

sql dumps- databases used for development
	
src- all MXML and AS3 classes used to compile the app

----------------------------------------------------------------------------

///////////////   MAIN CLASSES


MMMap_FB4.mxml
Application class, contains all elements of the view, buttons, map, etc.

MapDisplay.mxml
Custom component containing the map and slider

HListRenderer.mxml
Custom itemRenderer for the horizontal list that is the key

markers.SignMarker.as
Custom Marker class

mode.Model
Handles all requests for data. The Model listens for when the proxies have returned data then passes received data to relevant view components/bound data objects.

PROXIES
CustomersProxy.as		
UpdateEmailProxy.as
PreferencesProxy.as		
UpdatePasswordProxy.as
ProductsProxy.as		
UserProxy.as
WritingPreferencesProxy.as
ResultsProxy.as

Each type of request to the database is handled by it's own proxy. This means that it's easy to swap-out the connection type and the rest of the app will not be affected. 

utils.CustomEvent
Used to pass data
