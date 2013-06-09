package ubadb.core.components.catalogManager;

import static org.junit.Assert.*;

import org.junit.Test;

import ubadb.core.common.TableId;

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
			
			td = new TableId("test2.table");
			t = c.getTableDescriptorByTableId(td);

			assertEquals(t.getTableId(),td);
			assertEquals(t.getTableName(),"Another Test Table");
			assertEquals(t.getTablePath(),"testTable2.table");

		} catch(CatalogManagerException e) {
			assertTrue(false);
			e.printStackTrace();
		}		
	}
}
