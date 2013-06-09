package ubadb.core.components.bufferManager.pools.multiple;

import java.util.HashMap;
import java.util.Map;

import ubadb.core.common.Page;
import ubadb.core.common.PageId;
import ubadb.core.common.TableId;
import ubadb.core.components.bufferManager.bufferPool.BufferFrame;
import ubadb.core.components.bufferManager.bufferPool.BufferPool;
import ubadb.core.components.bufferManager.bufferPool.BufferPoolException;
import ubadb.core.components.bufferManager.bufferPool.pools.single.SingleBufferPool;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.fifo.FIFOReplacementStrategy;

public class MultipleBufferPool implements BufferPool {
	BufferPool keepPool,recyclePool,defaultPool;
	Map<TableId,BufferPool> tableMapper;
	public MultipleBufferPool(int keepPoolSize,int recyclePoolSize, int defaultPoolSize){
		keepPool = new SingleBufferPool(keepPoolSize,new FIFOReplacementStrategy());
		recyclePool = new SingleBufferPool(recyclePoolSize,new FIFOReplacementStrategy());
		defaultPool = new SingleBufferPool(defaultPoolSize,new FIFOReplacementStrategy());
		tableMapper = new HashMap<TableId,BufferPool>();
	}
	
	@Override
	public boolean isPageInPool(PageId pageId) {
		return 	keepPool.isPageInPool(pageId) ||
				recyclePool.isPageInPool(pageId) ||
				defaultPool.isPageInPool(pageId);
	}

	@Override
	public BufferFrame getBufferFrame(PageId pageId) throws BufferPoolException {
		if(keepPool.isPageInPool(pageId)) return keepPool.getBufferFrame(pageId);
		if(recyclePool.isPageInPool(pageId)) return recyclePool.getBufferFrame(pageId);
		if(defaultPool.isPageInPool(pageId)) return defaultPool.getBufferFrame(pageId);
		return null;
	}
	
	private void setTableBuffer(TableId tableId,BufferPool pool){
		tableMapper.put(tableId,pool);
	}

	public void setTableAsKeep(TableId t){ setTableBuffer(t, keepPool); }
	public void setTableAsRecycle(TableId t){ setTableBuffer(t, recyclePool); }
	public void setTableAsDefault(TableId t){ setTableBuffer(t, defaultPool); }

	private BufferPool getPool(TableId t){
		BufferPool bp = tableMapper.get(t);
		if(bp == null) bp = defaultPool;
		return bp;
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
		return 	keepPool.countPagesInPool() +
				recyclePool.countPagesInPool() +
				defaultPool.countPagesInPool();
	}

}
