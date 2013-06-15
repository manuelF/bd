package ubadb.core.components.bufferManager.bufferPool;

import org.junit.Test;
import ubadb.core.common.Page;
import ubadb.core.common.PageId;
import ubadb.core.common.TableId;
import ubadb.core.components.bufferManager.pools.multiple.MultipleBufferPool;
import ubadb.core.components.catalogManager.CatalogManager;
import ubadb.core.components.catalogManager.TableDescriptor;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static junit.framework.Assert.assertEquals;
import static junit.framework.Assert.assertTrue;

public class MultipleBufferManagerTest {
    @Test
    public void testMultipleBufferPool() throws BufferPoolException {
        Map<String,Integer> sizes = new HashMap<String,Integer>();
        sizes.put("KEEP",150);
        sizes.put("DEFAULT",150);
        sizes.put("RECYCLE",120);
        BufferPool bm = new MultipleBufferPool(sizes,"DEFAULT",new CatalogManager(){
            public List<TableDescriptor> tableDescr;
            public void loadCatalog() {
                tableDescr = new ArrayList<TableDescriptor>();
                tableDescr.add(new TableDescriptor(new TableId("hello"),"hello","1.txt","KEEP"));
                tableDescr.add(new TableDescriptor(new TableId("hello2"),"hello2","2.txt","DEFAULT"));
                tableDescr.add(new TableDescriptor(new TableId("hello3"),"hello3","2.txt","RECYCLE"));
            }

            public TableDescriptor getTableDescriptorByTableId(TableId tableId) {
                loadCatalog();
                for(TableDescriptor td : tableDescr)
                    if(td.getTableId().equals(tableId))
                        return td;
                return null;
            }
        });

        bm.addNewPage(new Page(new PageId(1,new TableId("hello")),new byte[] {1,2,3,4,5}));
        assertEquals(1, bm.countPagesInPool());
        assertTrue(bm.isPageInPool(new PageId(1,new TableId("hello"))));
        bm.addNewPage(new Page(new PageId(2,new TableId("hello2")),new byte[] {1,2,3,4,5}));
        assertEquals(2, bm.countPagesInPool());
    }

}
