package ubadb.core.components.catalogManager;

import ubadb.core.common.TableId;

import java.io.FileNotFoundException;

public interface CatalogManager
{
	void loadCatalog() throws CatalogManagerException, FileNotFoundException;
	TableDescriptor getTableDescriptorByTableId(TableId tableId);
}