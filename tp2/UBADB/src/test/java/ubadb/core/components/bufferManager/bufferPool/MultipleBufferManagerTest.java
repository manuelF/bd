package ubadb.core.components.bufferManager.bufferPool;

import org.junit.Test;
import ubadb.core.common.Page;
import ubadb.core.common.PageId;
import ubadb.core.common.TableId;
import ubadb.core.components.bufferManager.pools.multiple.MultipleBufferPool;
import ubadb.core.components.catalogManager.CatalogManager;
import ubadb.core.components.catalogManager.TableDescriptor;
import ubadb.core.testDoubles.DummyObjectFactory;

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
        BufferPool bm = new MultipleBufferPool(sizes,"DEFAULT", DummyObjectFactory.CATALOG);

        bm.addNewPage(new Page(new PageId(1,new TableId("hello")),new byte[] {1,2,3,4,5}));
        assertEquals(1, bm.countPagesInPool());
        assertTrue(bm.isPageInPool(new PageId(1,new TableId("hello"))));
        bm.addNewPage(new Page(new PageId(2,new TableId("hello2")),new byte[] {1,2,3,4,5}));
        assertEquals(2, bm.countPagesInPool());
    }

}
