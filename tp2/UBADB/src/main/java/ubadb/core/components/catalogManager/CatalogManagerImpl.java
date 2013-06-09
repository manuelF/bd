package ubadb.core.components.catalogManager;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;

import ubadb.core.common.TableId;

import com.thoughtworks.xstream.XStream;

public class CatalogManagerImpl implements CatalogManager
{
	private String catalogFilePath;
	private String filePathPrefix;
	public Catalog catalog;
	
	public CatalogManagerImpl(String catalogFilePath, String filePathPrefix) 
	{
		this.catalogFilePath = catalogFilePath;
		this.filePathPrefix = filePathPrefix;
	}

	public void loadCatalog() throws CatalogManagerException
	{
		XStream catalogStream = getXStreamInstance();

		String fp = filePathPrefix + catalogFilePath;
		File inputFile = new File(fp);
		try {
			catalog = (Catalog) catalogStream.fromXML(new FileInputStream(inputFile));
			if(catalog == null)  
				throw new CatalogManagerException("Could not read " + fp);
		} catch (FileNotFoundException e) {
			throw new CatalogManagerException(fp + " cannot be found");			
		}
	}

	private XStream getXStreamInstance() {
		XStream catalogStream = new XStream();
		catalogStream.alias("catalog",Catalog.class);
		catalogStream.alias("table",TableDescriptor.class);
		catalogStream.addImplicitCollection(Catalog.class, "tableDescriptors");
		return catalogStream;
	}

	public TableDescriptor getTableDescriptorByTableId(TableId tableId)
	{
		return catalog.getTableDescriptorByTableId(tableId);
	}
}
