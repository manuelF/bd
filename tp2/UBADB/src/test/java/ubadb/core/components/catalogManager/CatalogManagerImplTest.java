package ubadb.core.components.catalogManager;

import org.junit.BeforeClass;
import org.junit.Test;
import ubadb.core.common.TableId;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;

import static org.junit.Assert.*;

public class CatalogManagerImplTest {
	public static String currentPath;
    @BeforeClass
    public static void loadPath() throws IOException{
        currentPath = new File(".").getCanonicalPath() + "/src/test/resources/catalogs/";
    }
    @Test
	public void testCatalog(){
		CatalogManager c = new CatalogManagerImpl("testCatalog.catalog",currentPath);
		try {
			c.loadCatalog();
			TableId td = new TableId("test.table");
			TableDescriptor t = c.getTableDescriptorByTableId(td);
			
			assertEquals(t.getTableId(),td);
			assertEquals(t.getTableName(),"A Test Table");
			assertEquals(t.getTablePath(),"testTable.table");
			assertEquals(t.getTablePool(),"KEEP");
			TableDescriptor t2 = c.getTableDescriptorByTableId(new TableId("notPresent.table"));
			assertNull(t2);
		} catch(CatalogManagerException e) {
			e.printStackTrace();
			assertTrue(false);
		}
        catch(FileNotFoundException e){
            assertTrue(false);
            e.printStackTrace();
        }
	}
	
	@Test
	public void testCatalogSeveralTables(){
		CatalogManager c = new CatalogManagerImpl("testCatalog2.catalog",currentPath);
		try {
			c.loadCatalog();
			TableId td = new TableId("test.table");
			TableDescriptor t = c.getTableDescriptorByTableId(td);
			
			assertEquals(t.getTableId(),td);
			assertEquals(t.getTableName(),"A Test Table");
			assertEquals(t.getTablePath(),"testTable.table");
			assertEquals(t.getTablePool(),"RECYCLE");
			
			td = new TableId("test2.table");
			t = c.getTableDescriptorByTableId(td);

			assertEquals(t.getTableId(),td);
			assertEquals(t.getTableName(),"Another Test Table");
			assertEquals(t.getTablePath(),"testTable2.table");
			assertEquals(t.getTablePool(),"DEFAULT");

            TableDescriptor t2 = c.getTableDescriptorByTableId(new TableId("notPresent.table"));
            assertNull(t2);
		} catch(Exception e) {
			e.printStackTrace();
            assertTrue(false);
        }
	}
}
