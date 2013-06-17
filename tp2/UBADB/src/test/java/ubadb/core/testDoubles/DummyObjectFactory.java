package ubadb.core.testDoubles;

import java.util.ArrayList;
import java.util.List;

import ubadb.core.common.Page;
import ubadb.core.common.PageId;
import ubadb.core.common.TableId;
import ubadb.core.components.catalogManager.CatalogManager;
import ubadb.core.components.catalogManager.TableDescriptor;

public class DummyObjectFactory
{
	public static final TableId TABLE_ID = new TableId("a");
	public static final PageId PAGE_ID = new PageId(0, TABLE_ID);
	public static final Page PAGE = new Page(PAGE_ID, "abc".getBytes());
	public static final TableId TABLE_ID_RECYCLE = new TableId("b");
	public static final TableId TABLE_ID_KEEP = new TableId("c");
	
	public static final CatalogManager CATALOG = new CatalogManager(){
        public List<TableDescriptor> tableDescr;
        public void loadCatalog() {
            tableDescr = new ArrayList<TableDescriptor>();
            tableDescr.add(new TableDescriptor(TABLE_ID_KEEP,"hello","1.txt","KEEP"));
            tableDescr.add(new TableDescriptor(TABLE_ID,"hello2","2.txt","DEFAULT"));
            tableDescr.add(new TableDescriptor(TABLE_ID_RECYCLE,"hello3","2.txt","RECYCLE"));
        }

        public TableDescriptor getTableDescriptorByTableId(TableId tableId) {
            loadCatalog();
            for(TableDescriptor td : tableDescr)
                if(td.getTableId().equals(tableId))
                    return td;
            return null;
        }
    };
	
}
