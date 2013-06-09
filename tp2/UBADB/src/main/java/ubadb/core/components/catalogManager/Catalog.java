package ubadb.core.components.catalogManager;

import java.util.ArrayList;
import java.util.List;

import ubadb.core.common.TableId;

/**
 * Serializable class that represents the catalog
 */
public class Catalog
{
	private List<TableDescriptor> tableDescriptors;
	public Catalog(){
		tableDescriptors = new ArrayList<TableDescriptor>();
	}
	public void addTableDescriptor(TableDescriptor td){
		tableDescriptors.add(td);		
	}
	public TableDescriptor getTableDescriptorByTableId(TableId tableId)
	{
		for(TableDescriptor t : tableDescriptors ){
			if(t.getTableId().equals(tableId)) 
				return t;
		}
		return null;
	}
}
