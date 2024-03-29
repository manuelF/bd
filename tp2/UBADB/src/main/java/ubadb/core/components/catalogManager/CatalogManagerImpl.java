package ubadb.core.components.catalogManager;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;
import ubadb.core.common.TableId;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

public class CatalogManagerImpl implements CatalogManager {
	private String catalogFilePath;
	private String filePathPrefix;
	public Catalog catalog;

	public CatalogManagerImpl(String catalogFilePath, String filePathPrefix) {
		this.catalogFilePath = catalogFilePath;
		this.filePathPrefix = filePathPrefix;
	}

	public void loadCatalog() throws CatalogManagerException{
		String fp = filePathPrefix + catalogFilePath;
		File inputFile = new File(fp);
        catalog = new Catalog();

		Element root = processCatalogFile(fp, inputFile);
		addTableDescriptors(root);
	}

	private Element processCatalogFile(String fp, File inputFile)
			throws CatalogManagerException {
		try {
			return getXMLRootElement(fp, inputFile);
		} catch (FileNotFoundException e) {
			throw new CatalogManagerException(fp + " cannot be found");
		} catch (JDOMException e) {
			throw new CatalogManagerException(fp + 
				" is not a valid XML document");
		} catch (IOException e) {
			throw new CatalogManagerException(fp + " could not be read");
		}
	}

	private Element getXMLRootElement(String fp, File inputFile)
			throws JDOMException, IOException,
			CatalogManagerException {
		SAXBuilder builder = new SAXBuilder();
		Document doc = builder.build(new FileInputStream(inputFile));
		Element root = doc.getRootElement();
		if (!root.getName().equals("catalog"))
			throw new CatalogManagerException(fp
					+ " is not a valid catalog");
		return root;
	}

	private void addTableDescriptors(Element root) {
        for (Object oTableElement : root.getChildren("table")) {
			Element tableElement = (Element) oTableElement;
			TableId tableId = 
				new TableId(tableElement.getChildText("tableId"));
            String tName= tableElement.getChildText("tableName");
            String tPath= tableElement.getChildText("tablePath");
            String tablePoolText = tableElement.getChildText("tablePool");
            if(tablePoolText == null) tablePoolText = "DEFAULT";
            String tPool= tablePoolText.toUpperCase();
        	TableDescriptor tableDesc = 
        		new TableDescriptor(tableId,tName,tPath,tPool);
			catalog.addTableDescriptor(tableDesc);
		}
	}

	public TableDescriptor getTableDescriptorByTableId(TableId tableId) {
		return catalog.getTableDescriptorByTableId(tableId);
	}
}
