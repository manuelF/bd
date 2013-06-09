package ubadb.core.components.catalogManager;

import java.util.List;

import ubadb.core.common.TableId;

import com.thoughtworks.xstream.annotations.XStreamAlias;
import com.thoughtworks.xstream.annotations.XStreamImplicit;

/**
 * Serializable class that represents the catalog
 */
public class Catalog
{
	private List<TableDescriptor> tableDescriptors;

	public TableDescriptor getTableDescriptorByTableId(TableId tableId)
	{
		for(TableDescriptor t : tableDescriptors ){
			if(t.getTableId().equals(tableId)) 
				return t;
		}
		return null;
	}
}
