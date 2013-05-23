package ubadb.core.components.catalogManager;

import ubadb.core.common.TableId;

public class CatalogManagerImpl implements CatalogManager
{
	private String catalogFilePath;
	private String filePathPrefix;
	private Catalog catalog;
	
	public CatalogManagerImpl(String catalogFilePath, String filePathPrefix) 
	{
		this.catalogFilePath = catalogFilePath;
		this.filePathPrefix = filePathPrefix;
	}

	@Override
	public void loadCatalog() throws CatalogManagerException
	{
		//TODO Completar levantando desde un XML el catálogo
	}


	@Override
	public TableDescriptor getTableDescriptorByTableId(TableId tableId)
	{
		return catalog.getTableDescriptorByTableId(tableId);
	}
}
