package ubadb.core.components.catalogManager;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

import ubadb.core.common.TableId;
import ubadb.core.components.bufferManager.pools.multiple.BufferPoolId;

public class CatalogManagerImplTest {
	@Test
	public void testCatalog(){
		CatalogManager c = new CatalogManagerImpl("testCatalog.catalog","src/test/resources/catalogs/");
		try {
			c.loadCatalog();
			TableId td = new TableId("test.table");
			TableDescriptor t = c.getTableDescriptorByTableId(td);
			
			assertEquals(t.getTableId(),td);
			assertEquals(t.getTableName(),"A Test Table");
			assertEquals(t.getTablePath(),"testTable.table");
			assertEquals(t.getTablePool(),BufferPoolId.KEEP);
			TableDescriptor t2 = c.getTableDescriptorByTableId(new TableId("notPresent.table"));
			assertNull(t2);
		} catch(CatalogManagerException e) {
			e.printStackTrace();
			assertTrue(false);
		}
	}
	
	@Test
	public void testCatalogSeveralTables(){
		CatalogManager c = new CatalogManagerImpl("testCatalog2.catalog","src/test/resources/catalogs/");
		try {
			c.loadCatalog();
			TableId td = new TableId("test.table");
			TableDescriptor t = c.getTableDescriptorByTableId(td);
			
			assertEquals(t.getTableId(),td);
			assertEquals(t.getTableName(),"A Test Table");
			assertEquals(t.getTablePath(),"testTable.table");
			assertEquals(t.getTablePool(),BufferPoolId.RECYCLE);
			
			td = new TableId("test2.table");
			t = c.getTableDescriptorByTableId(td);

			assertEquals(t.getTableId(),td);
			assertEquals(t.getTableName(),"Another Test Table");
			assertEquals(t.getTablePath(),"testTable2.table");
			assertEquals(t.getTablePool(),BufferPoolId.DEFAULT);

		} catch(CatalogManagerException e) {
			assertTrue(false);
			e.printStackTrace();
		}		
	}
}
