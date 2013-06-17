package ubadb.core.components.bufferManager.pools.multiple;

import ubadb.core.common.Page;
import ubadb.core.common.PageId;
import ubadb.core.common.TableId;
import ubadb.core.components.bufferManager.bufferPool.BufferFrame;
import ubadb.core.components.bufferManager.bufferPool.BufferPool;
import ubadb.core.components.bufferManager.bufferPool.BufferPoolException;
import ubadb.core.components.bufferManager.bufferPool.pools.single.SingleBufferPool;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.fifo.FIFOReplacementStrategy;
import ubadb.core.components.catalogManager.CatalogManager;
import ubadb.core.components.catalogManager.TableDescriptor;

import java.util.HashMap;
import java.util.Map;

public class MultipleBufferPool implements BufferPool {
	Map<String,BufferPool> poolNameMapper;
    CatalogManager catalogManager;
    BufferPool defaultPool;

    public MultipleBufferPool(Map<String,Integer> poolSizeByName, String defaultPoolName, CatalogManager manager){
		poolNameMapper = new HashMap<>();
        for(Map.Entry<String, Integer> s : poolSizeByName.entrySet()){
            poolNameMapper.put(s.getKey(),
                    new SingleBufferPool(s.getValue(),
                            new FIFOReplacementStrategy()));
        }
        this.catalogManager = manager;
        this.defaultPool = poolNameMapper.get(defaultPoolName);
    }

	
	@Override
	public boolean isPageInPool(PageId pageId) {
		return getPool(pageId.getTableId()).isPageInPool(pageId);
	}

	@Override
	public BufferFrame getBufferFrame(PageId pageId) throws BufferPoolException {
		return getPool(pageId.getTableId()).getBufferFrame(pageId);
	}

	private BufferPool getPool(TableId t){
        TableDescriptor tableDesc = catalogManager.getTableDescriptorByTableId(t);
        if(tableDesc == null || !poolNameMapper.containsKey(tableDesc.getTablePool()))
            return defaultPool;
        return poolNameMapper.get(tableDesc.getTablePool());
    }
	
	@Override
	public boolean hasSpace(PageId pageToAddId) {
		return getPool(pageToAddId.getTableId()).hasSpace(pageToAddId);
	}

	@Override
	public BufferFrame addNewPage(Page page) throws BufferPoolException {
		return getPool(page.getPageId().getTableId()).addNewPage(page);
	}

	@Override
	public void removePage(PageId pageId) throws BufferPoolException {
		getPool(pageId.getTableId()).removePage(pageId);
	}

	@Override
	public BufferFrame findVictim(PageId pageIdToBeAdded)
			throws BufferPoolException {
		return getPool(pageIdToBeAdded.getTableId()).findVictim(pageIdToBeAdded);
	}

	@Override
	public int countPagesInPool() {
		int result = 0;
        for(BufferPool bp : poolNameMapper.values())
            result += bp.countPagesInPool();
        return result;
	}

}
