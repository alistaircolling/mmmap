/**
 * This is a generated class and is not intended for modfication.  To customize behavior
 * of this service wrapper you may modify the generated sub-class of this class - CustomersService.as.
 */
package services.customersservice
{
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.services.wrapper.RemoteObjectServiceWrapper;
import com.adobe.serializers.utility.TypeUtility;
import mx.data.ItemReference;
import mx.data.ManagedAssociation;
import mx.data.ManagedOperation;
import mx.data.ManagedQuery;
import mx.data.RPCDataManager;
import mx.rpc.AbstractOperation;
import mx.rpc.AsyncToken;
import mx.rpc.remoting.Operation;
import mx.rpc.remoting.RemoteObject;
import valueObjects.Customers;

import mx.collections.ItemResponder;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

[ExcludeClass]
internal class _Super_CustomersService extends com.adobe.fiber.services.wrapper.RemoteObjectServiceWrapper
{      
    private var _customersRPCDataManager : mx.data.RPCDataManager;
    private var managersArray : Array = new Array();
        
    public const DATA_MANAGER_CUSTOMERS : String = "Customers";         
        
    public function getDataManager(dataManagerName:String) : mx.data.RPCDataManager
    {
        switch (dataManagerName)
        {
             case (DATA_MANAGER_CUSTOMERS):
                return _customersRPCDataManager;      
            default:
                return null;
        }
    }
    
    /**
     * Commit all of the pending changes for this DataService, as well as all of the pending changes of all DataServices
     * sharing the same DataStore.  By default, a DataService shares the same DataStore with other DataServices if they have 
     * managed association properties and share the same set of channels. 
     *
     * @see mx.data.DataManager
     * @see mx.data.DataStore
     *
     * @param itemsOrCollections:Array This is an optional parameter which defaults to null when
     *  you want to commit all pending changes.  If you want to commit a subset of the pending
     *  changes use this argument to specify a list of managed ListCollectionView instances
     *  and/or managed items.  ListCollectionView objects are most typically ArrayCollections
     *  you have provided to your fill method.  The items appropriate for this method are
     *  any managed version of the item.  These are any items you retrieve from getItem, createItem
     *  or using the getItemAt method from a managed collection.  Only changes for the
     *  items defined by any of the values in this array will be committed.
     *
     * @param cascadeCommit if true, also commit changes made to any associated
     *  items supplied in this list.
     *
     *  @return AsyncToken that is returned in <code>call</code> property of
     *  either the <code>ResultEvent.RESULT</code> or in the
     *  <code>FaultEvent.FAULT</code>.
     *  Custom data can be attached to this object and inspected later
     *  during the event handling phase.  If no changes have been made
     *  to the relevant items, null is returned instead of an AsyncToken.
     */
    public function commit(itemsOrCollections:Array=null, cascadeCommit:Boolean=false):mx.rpc.AsyncToken
    {
    	return _customersRPCDataManager.dataStore.commit(itemsOrCollections, cascadeCommit);
    }
    
    /**
     *  Reverts all pending (uncommitted) changes for this DataService, as well as all of the pending changes of all DataServics
     *  sharing the same DataStore.  By default, a DataService shares the same DataStore with other DataServices if they have 
     * managed association properties and share the same set of channels. 
     *
     * @see mx.data.DataManager
     * @see mx.data.DataStore
     *
     *  @return true if any changes were reverted.
     *  
     */
    public function revertChanges():Boolean
    {
        return _customersRPCDataManager.dataStore.revertChanges();
    }    
       
    // Constructor
    public function _Super_CustomersService()
    {
        // initialize service control
        _serviceControl = new mx.rpc.remoting.RemoteObject();
        
        var operations:Object = new Object();
        var operation:mx.rpc.remoting.Operation;
         
        operation = new mx.rpc.remoting.Operation(null, "getAllCustomers");
		 operation.resultElementType = valueObjects.Customers;
        operations["getAllCustomers"] = operation;

        valueObjects.Customers._initRemoteClassAlias();
        operation = new mx.rpc.remoting.Operation(null, "getCustomersByID");
		 operation.resultType = valueObjects.Customers; 		 
        operations["getCustomersByID"] = operation;

        valueObjects.Customers._initRemoteClassAlias();
        operation = new mx.rpc.remoting.Operation(null, "createCustomers");
		 operation.resultType = int; 		 
        operations["createCustomers"] = operation;

        operation = new mx.rpc.remoting.Operation(null, "updateCustomers");
        operations["updateCustomers"] = operation;

        operation = new mx.rpc.remoting.Operation(null, "deleteCustomers");
        operations["deleteCustomers"] = operation;

        operation = new mx.rpc.remoting.Operation(null, "count");
		 operation.resultType = int; 		 
        operations["count"] = operation;

        operation = new mx.rpc.remoting.Operation(null, "getCustomers_paged");
		 operation.resultElementType = valueObjects.Customers;
        operations["getCustomers_paged"] = operation;

        valueObjects.Customers._initRemoteClassAlias();
    
        _serviceControl.operations = operations;   
		_serviceControl.convertResultHandler = com.adobe.serializers.utility.TypeUtility.convertResultHandler;
        _serviceControl.source = "CustomersService";
        _serviceControl.endpoint = "gateway.php";
		destination = "CustomersService";
        
        var managedAssociation : mx.data.ManagedAssociation;
    	var managedAssocsArray : Array;
        // initialize Customers data manager     
        _customersRPCDataManager = new mx.data.RPCDataManager();
        managersArray.push(_customersRPCDataManager);
        
        managedAssocsArray = new Array();
        
        _customersRPCDataManager.destination = "customersRPCDataManager";
        _customersRPCDataManager.service = _serviceControl;        
        _customersRPCDataManager.identities =  "id";      
        _customersRPCDataManager.itemClass = valueObjects.Customers; 
        
                   
    
        var dmOperation : mx.data.ManagedOperation;
        var dmQuery : mx.data.ManagedQuery;
         
        dmQuery = new mx.data.ManagedQuery("getCustomers_paged");
        dmQuery.propertySpecifier = "id,name";
        dmQuery.countOperation = "count";
        dmQuery.pagingEnabled = true;
        dmQuery.positionalPagingParameters = true;
        dmQuery.parameters = "startIndex,numItems";
        _customersRPCDataManager.addManagedOperation(dmQuery);                 

        dmOperation = new mx.data.ManagedOperation("deleteCustomers", "delete");
        dmOperation.parameters = "id";
        _customersRPCDataManager.addManagedOperation(dmOperation);     
            
        dmOperation = new mx.data.ManagedOperation("updateCustomers", "update");
        dmOperation.parameters = "item";
        _customersRPCDataManager.addManagedOperation(dmOperation);     
            
        dmOperation = new mx.data.ManagedOperation("createCustomers", "create");
        dmOperation.parameters = "item";
        _customersRPCDataManager.addManagedOperation(dmOperation);     
            
        dmOperation = new mx.data.ManagedOperation("getCustomersByID", "get");
        dmOperation.parameters = "id";
        _customersRPCDataManager.addManagedOperation(dmOperation);     
            
        _serviceControl.managers = managersArray;
                      
         model_internal::initialize();
    }

	/**
	  * This method is a generated wrapper used to call the 'getAllCustomers' operation. It returns an mx.rpc.AsyncToken whose 
	  * result property will be populated with the result of the operation when the server response is received. 
	  * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
	  * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
	  */          
	public function getAllCustomers() : mx.rpc.AsyncToken
	{
		var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("getAllCustomers");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send() ;

		return _internal_token;
	}   
	 
	/**
	  * This method is a generated wrapper used to call the 'getCustomersByID' operation. It returns an mx.data.ItemReference whose 
	  * result property will be populated with the result of the operation when the server response is received. 
	  * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
	  * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.data.ItemReference
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.data.ItemReference whose result property will be populated with the result of the operation when the server response is received.
	  */          
	public function getCustomersByID(itemID:int) : mx.data.ItemReference
	{
		var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("getCustomersByID");
		var _internal_token:mx.data.ItemReference = _internal_operation.send(itemID) as mx.data.ItemReference;

		return _internal_token;
	}   
	 
	/**
	  * This method is a generated wrapper used to call the 'createCustomers' operation. It returns an mx.data.ItemReference whose 
	  * result property will be populated with the result of the operation when the server response is received. 
	  * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
	  * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.data.ItemReference
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.data.ItemReference whose result property will be populated with the result of the operation when the server response is received.
	  */          
	public function createCustomers(item:valueObjects.Customers) : mx.data.ItemReference
	{
		var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("createCustomers");
		var _internal_token:mx.data.ItemReference = _internal_operation.send(item) as mx.data.ItemReference;

		return _internal_token;
	}   
	 
	/**
	  * This method is a generated wrapper used to call the 'updateCustomers' operation. It returns an mx.data.ItemReference whose 
	  * result property will be populated with the result of the operation when the server response is received. 
	  * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
	  * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.data.ItemReference
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.data.ItemReference whose result property will be populated with the result of the operation when the server response is received.
	  */          
	public function updateCustomers(item:valueObjects.Customers) : mx.data.ItemReference
	{
		var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("updateCustomers");
		var _internal_token:mx.data.ItemReference = _internal_operation.send(item) as mx.data.ItemReference;

		return _internal_token;
	}   
	 
	/**
	  * This method is a generated wrapper used to call the 'deleteCustomers' operation. It returns an mx.rpc.AsyncToken whose 
	  * result property will be populated with the result of the operation when the server response is received. 
	  * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
	  * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
	  */          
	public function deleteCustomers(itemID:int) : mx.rpc.AsyncToken
	{
		var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("deleteCustomers");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(itemID) ;

		return _internal_token;
	}   
	 
	/**
	  * This method is a generated wrapper used to call the 'count' operation. It returns an mx.rpc.AsyncToken whose 
	  * result property will be populated with the result of the operation when the server response is received. 
	  * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
	  * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
	  */          
	public function count() : mx.rpc.AsyncToken
	{
		var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("count");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send() ;

		return _internal_token;
	}   
	 
	/**
	  * This method is a generated wrapper used to call the 'getCustomers_paged' operation. It returns an mx.rpc.AsyncToken whose 
	  * result property will be populated with the result of the operation when the server response is received. 
	  * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
	  * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
	  */          
	public function getCustomers_paged() : mx.rpc.AsyncToken
	{
		var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("getCustomers_paged");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send() ;

		return _internal_token;
	}   
	 
}

}
