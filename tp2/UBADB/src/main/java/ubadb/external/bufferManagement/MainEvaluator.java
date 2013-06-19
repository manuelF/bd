package ubadb.external.bufferManagement;

import ubadb.core.components.bufferManager.BufferManager;
import ubadb.core.components.bufferManager.BufferManagerException;
import ubadb.core.components.bufferManager.BufferManagerImpl;
import ubadb.core.components.bufferManager.bufferPool.BufferPool;
import ubadb.core.components.bufferManager.bufferPool.pools.single.SingleBufferPool;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.PageReplacementStrategy;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.fifo.FIFOReplacementStrategy;
import ubadb.core.components.bufferManager.pools.multiple.MultipleBufferPool;
import ubadb.core.components.catalogManager.CatalogManager;
import ubadb.core.components.catalogManager.CatalogManagerImpl;
import ubadb.core.components.diskManager.DiskManager;
import ubadb.external.bufferManagement.etc.*;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

public class MainEvaluator {
	private static final int PAUSE_BETWEEN_REFERENCES = 0;

	public static void main(String[] args) {
		try {
			PageReplacementStrategy pageReplacementStrategy = new FIFOReplacementStrategy();
            //String  traceFileName = "generated/mixed-filescans-clustered.trace";
            //String traceFileName2 = "generated/mixed-filescans.trace";
            //String traceFileName3 = "generated/BNLJ-Colors-Gadgets.trace";
            //String traceFileName4 = "generated/Index-Colors-Gadgets.trace";
            String traceFileName5 = "generated/Index-tp-tg.trace";

            String currentPath = new File(".").getAbsoluteFile() + "/src/test/resources/catalogs/";
            CatalogManager catalogManager = new CatalogManagerImpl("salesCatalog.catalog",currentPath);

            Map<String,Integer> pages = new HashMap<>();
            pages.put("KEEP",30);
            pages.put("DEFAULT",150);
            pages.put("RECYCLE",1);

            BufferPool bp = createMultipleBufferPool(catalogManager,pageReplacementStrategy,pages);
            System.out.print("Multiple Buffer Pool ");
            evaluate(traceFileName5, catalogManager, bp);
            System.out.print("Single Buffer Pool ");
            int singleBufferPoolSize=101;
            bp = new SingleBufferPool(singleBufferPoolSize,pageReplacementStrategy);

            evaluate(traceFileName5, catalogManager, bp);

		} catch (Exception e) {
			System.out.println("FATAL ERROR (" + e.getMessage() + ")");
			e.printStackTrace();
		}
	}

	private static void evaluate(String traceFileName,
                                 CatalogManager catalogManager,
                                 BufferPool bufferPool) throws Exception {
        FaultCounterDiskManagerSpy faultCounterDiskManagerSpy = new FaultCounterDiskManagerSpy();

        BufferManager bufferManager = createBufferManager(faultCounterDiskManagerSpy,
                catalogManager,bufferPool);
		PageReferenceTrace trace = getTrace(traceFileName);

		for (PageReference pageReference : trace.getPageReferences()) {
			// Pause references to have different dates in LRU and MRU
			Thread.sleep(PAUSE_BETWEEN_REFERENCES);

			switch (pageReference.getType()) {
				case REQUEST: {
					try {
						bufferManager.readPage(pageReference.getPageId());
					} catch (BufferManagerException e) {
						System.out.println("NO MORE SPACE AVAILABLE, MEMORY FULL");
						throw e;
					}
					break;
				}
				case RELEASE: {
					bufferManager.releasePage(pageReference.getPageId());
					break;
				}
			}
		}

        BufferManagementMetrics metrics = new BufferManagementMetrics(trace,
				faultCounterDiskManagerSpy.getFaultsCount());
		metrics.showSummary();
	}

	private static PageReferenceTrace getTrace(String traceFileName)
			throws Exception {
		PageReferenceTraceSerializer serializer = new PageReferenceTraceSerializer();
		return serializer.read(traceFileName);
	}

	private static BufferManager createBufferManager(DiskManager diskManager,
			CatalogManager catalogManager,BufferPool bufferPool) {

        try
        {
            catalogManager.loadCatalog();
        }
        catch (Exception e)
        {
            System.err.println("Cannot load catalog!");
        }

		return new BufferManagerImpl(diskManager,catalogManager, bufferPool);
	}

    private static BufferPool createMultipleBufferPool(CatalogManager catalogManager,
                                                       PageReplacementStrategy pageReplacementStrategy,
                                                       Map<String, Integer> pages) {
        return new MultipleBufferPool(pages,"DEFAULT",
                    pageReplacementStrategy,catalogManager);
    }
}
