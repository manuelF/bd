package ubadb.core.components.bufferManager.bufferPool.pools.multiple;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

import java.util.HashMap;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;

import ubadb.core.common.Page;
import ubadb.core.common.PageId;
import ubadb.core.common.TableId;
import ubadb.core.components.bufferManager.bufferPool.BufferFrame;
import ubadb.core.components.bufferManager.bufferPool.BufferPool;
import ubadb.core.components.bufferManager.bufferPool.BufferPoolException;
import ubadb.core.components.bufferManager.pools.multiple.MultipleBufferPool;
import ubadb.core.testDoubles.DummyObjectFactory;


public class MultipleBufferPoolTest {
	private MultipleBufferPool bufferPool;
	private static final int DEFAULT_POOL_MAX_SIZE = 3;
	private static final int RECYCLE_POOL_MAX_SIZE = 1;
	private static final int KEEP_POOL_MAX_SIZE = 2;
	private static final Page PAGE_0 = new Page(new PageId(0, DummyObjectFactory.TABLE_ID), "abc".getBytes());
	private static final Page PAGE_1 = new Page(new PageId(1, DummyObjectFactory.TABLE_ID), "abc".getBytes());
	private static final Page PAGE_2 = new Page(new PageId(2, DummyObjectFactory.TABLE_ID), "abc".getBytes());
	private static final Page PAGE_3 = new Page(new PageId(3, DummyObjectFactory.TABLE_ID), "abc".getBytes());
	
	private static final Page PAGE_RECYCLE_0 = new Page(new PageId(0, DummyObjectFactory.TABLE_ID_RECYCLE), "abc".getBytes());
	private static final Page PAGE_RECYCLE_1 = new Page(new PageId(1, DummyObjectFactory.TABLE_ID_RECYCLE), "abc".getBytes());
	private static final Page PAGE_RECYCLE_2 = new Page(new PageId(2, DummyObjectFactory.TABLE_ID_RECYCLE), "abc".getBytes());
	private static final Page PAGE_RECYCLE_3 = new Page(new PageId(3, DummyObjectFactory.TABLE_ID_RECYCLE), "abc".getBytes());
	
	private static final Page PAGE_KEEP_0 = new Page(new PageId(0, DummyObjectFactory.TABLE_ID_KEEP), "abc".getBytes());
	private static final Page PAGE_KEEP_1 = new Page(new PageId(1, DummyObjectFactory.TABLE_ID_KEEP), "abc".getBytes());
	private static final Page PAGE_KEEP_2 = new Page(new PageId(2, DummyObjectFactory.TABLE_ID_KEEP), "abc".getBytes());
	private static final Page PAGE_KEEP_3 = new Page(new PageId(3, DummyObjectFactory.TABLE_ID_KEEP), "abc".getBytes());
	
	@Before
	public void setUp()
	{
		Map<String, Integer> pools = new HashMap<String, Integer>();
		pools.put("RECYCLE", RECYCLE_POOL_MAX_SIZE);
		pools.put("KEEP", KEEP_POOL_MAX_SIZE);
		pools.put("DEFAULT",DEFAULT_POOL_MAX_SIZE);        
        bufferPool = new MultipleBufferPool(pools,"DEFAULT",DummyObjectFactory.CATALOG);
	}
	
	@Test
	public void testIs12PageInPoolTrue() throws Exception
	{
		bufferPool.addNewPage(PAGE_0);
		
		assertTrue(bufferPool.isPageInPool(PAGE_0.getPageId()));
	}
	
	@Test
	public void testIsPageInRecyclePoolFalse() throws Exception
	{
		bufferPool.addNewPage(PAGE_RECYCLE_1);
		
		assertFalse(bufferPool.isPageInPool(PAGE_RECYCLE_0.getPageId()));
	}
	
	@Test
	public void testIsPageInRecyclePoolTrue() throws Exception
	{
		bufferPool.addNewPage(PAGE_RECYCLE_0);
		bufferPool.addNewPage(PAGE_KEEP_0);
		bufferPool.addNewPage(PAGE_KEEP_1);
		bufferPool.addNewPage(PAGE_0);
		bufferPool.addNewPage(PAGE_1);
		bufferPool.addNewPage(PAGE_2);
		assertTrue(bufferPool.isPageInPool(PAGE_RECYCLE_0.getPageId()));
	}
	
	@Test
	public void testIsPageInPoolFalse() throws Exception
	{
		assertFalse(bufferPool.isPageInPool(PAGE_0.getPageId()));
	}
	
	@Test
	public void testGetExistingPage() throws Exception
	{
		BufferFrame expectedFrame1 = bufferPool.addNewPage(PAGE_0);
		assertEquals(expectedFrame1, bufferPool.getBufferFrame(PAGE_0.getPageId()));
		BufferFrame expectedFrame2 = bufferPool.addNewPage(PAGE_RECYCLE_0);
		assertEquals(expectedFrame2, bufferPool.getBufferFrame(PAGE_RECYCLE_0.getPageId()));
		BufferFrame expectedFrame3 = bufferPool.addNewPage(PAGE_KEEP_0);
		assertEquals(expectedFrame3, bufferPool.getBufferFrame(PAGE_KEEP_0.getPageId()));
	}
	
	@Test(expected=BufferPoolException.class)
	public void testGetUnexistingPage() throws Exception
	{
		bufferPool.addNewPage(PAGE_0);
		

		assertNull(bufferPool.getBufferFrame(new PageId(99, new TableId("bbbb"))));
		assertNull(bufferPool.getBufferFrame(new PageId(99, DummyObjectFactory.TABLE_ID_KEEP)));
		assertNull(bufferPool.getBufferFrame(new PageId(99, DummyObjectFactory.TABLE_ID)));
		assertNull(bufferPool.getBufferFrame(new PageId(99, DummyObjectFactory.TABLE_ID_RECYCLE)));
	}
	
	@Test
	public void testHasSpaceTrue() throws Exception
	{
		bufferPool.addNewPage(PAGE_0);
		bufferPool.addNewPage(PAGE_1);
		assertTrue(bufferPool.hasSpace(PAGE_2.getPageId()));
		bufferPool.addNewPage(PAGE_2);
		assertTrue(bufferPool.hasSpace(PAGE_RECYCLE_0.getPageId()));
		bufferPool.addNewPage(PAGE_KEEP_0);
		assertTrue(bufferPool.hasSpace(PAGE_KEEP_1.getPageId()));
	}
	
	@Test
	public void testHasSpaceFalse() throws Exception
	{
		bufferPool.addNewPage(PAGE_0);
		bufferPool.addNewPage(PAGE_1);
		bufferPool.addNewPage(PAGE_2);
		
		assertFalse(bufferPool.hasSpace(PAGE_3.getPageId()));

		bufferPool.addNewPage(PAGE_KEEP_0);
		bufferPool.addNewPage(PAGE_KEEP_1);
		assertFalse(bufferPool.hasSpace(PAGE_KEEP_3.getPageId()));
		bufferPool.addNewPage(PAGE_RECYCLE_3);
		assertFalse(bufferPool.hasSpace(PAGE_RECYCLE_2.getPageId()));
		
	}
	
	@Test
	public void testAddNewPageWithSpace() throws Exception
	{

		bufferPool.addNewPage(PAGE_KEEP_0);
		bufferPool.addNewPage(PAGE_KEEP_1);
		bufferPool.addNewPage(PAGE_0);
		bufferPool.addNewPage(PAGE_1);
		
		assertEquals(4,bufferPool.countPagesInPool());
	}
	
	@Test(expected=BufferPoolException.class)
	public void testAddNewPageWithoutSpace() throws Exception
	{
		bufferPool.addNewPage(PAGE_0);
		bufferPool.addNewPage(PAGE_1);
		bufferPool.addNewPage(PAGE_2);
		bufferPool.addNewPage(PAGE_3);
	}
	
	@Test(expected=BufferPoolException.class)
	public void testAddNewPageWithoutSpaceKEEP() throws Exception
	{
		bufferPool.addNewPage(PAGE_KEEP_0);
		bufferPool.addNewPage(PAGE_KEEP_1);
		bufferPool.addNewPage(PAGE_KEEP_2);
	}
	@Test(expected=BufferPoolException.class)
	public void testAddNewPageWithoutSpaceRECYCLE() throws Exception
	{
		bufferPool.addNewPage(PAGE_RECYCLE_2);
		bufferPool.addNewPage(PAGE_RECYCLE_3);
	}

	@Test(expected=BufferPoolException.class)
	public void testAddNewPageWithExisting() throws Exception
	{
		bufferPool.addNewPage(PAGE_0);
		bufferPool.addNewPage(PAGE_0);
	}
	
	@Test(expected=BufferPoolException.class)
	public void testAddNewPageWithExistingKEEP() throws Exception
	{
		bufferPool.addNewPage(PAGE_KEEP_0);
		bufferPool.addNewPage(PAGE_KEEP_0);
	}
	
	@Test(expected=BufferPoolException.class)
	public void testAddNewPageWithExistingRECYCLE() throws Exception
	{
		bufferPool.addNewPage(PAGE_RECYCLE_3);
		bufferPool.addNewPage(PAGE_RECYCLE_3);
	}
	
	@Test
	public void testNewPageIsUnpinnedAndNotDirtyByDefault() throws Exception
	{
		BufferFrame bufferFrame = bufferPool.addNewPage(PAGE_0);

		assertEquals(0,bufferFrame.getPinCount());
		assertFalse(bufferFrame.isDirty());
		
		bufferFrame = bufferPool.addNewPage(PAGE_KEEP_0);

		assertEquals(0,bufferFrame.getPinCount());
		assertFalse(bufferFrame.isDirty());
		
		bufferFrame = bufferPool.addNewPage(PAGE_RECYCLE_3);

		assertEquals(0,bufferFrame.getPinCount());
		assertFalse(bufferFrame.isDirty());
	}
	
	@Test
	public void testRemoveExistingPage() throws Exception
	{
		bufferPool.addNewPage(PAGE_0);
		bufferPool.addNewPage(PAGE_1);
		bufferPool.addNewPage(PAGE_2);
		assertEquals(3,bufferPool.countPagesInPool());
		bufferPool.removePage(PAGE_0.getPageId());
		assertEquals(2,bufferPool.countPagesInPool());
		
		
		bufferPool.addNewPage(PAGE_KEEP_0);
		bufferPool.addNewPage(PAGE_KEEP_1);
		
		bufferPool.addNewPage(PAGE_RECYCLE_3);;
		
		assertEquals(5,bufferPool.countPagesInPool());
		

		bufferPool.removePage(PAGE_RECYCLE_3.getPageId());

		assertEquals(4,bufferPool.countPagesInPool());
		
		
	}
	
	@Test(expected=BufferPoolException.class)
	public void testRemoveUnexistingPage() throws Exception
	{
		bufferPool.addNewPage(PAGE_0);
		bufferPool.addNewPage(PAGE_1);
		bufferPool.addNewPage(PAGE_2);
		
		bufferPool.removePage(PAGE_3.getPageId());
	}
	
	@Test(expected=BufferPoolException.class)
	public void testRemoveUnexistingPageKEEP() throws Exception
	{		
		bufferPool.removePage(PAGE_KEEP_3.getPageId());
	}
	
	@Test(expected=BufferPoolException.class)
	public void testRemoveUnexistingPageRECYCLE() throws Exception
	{
		bufferPool.removePage(PAGE_RECYCLE_3.getPageId());
	}
	
	@Test
	public void countPagesEmptyPool()
	{
		assertEquals(0, bufferPool.countPagesInPool());
	}
	
	@Test
	public void countPagesNonEmptyPool() throws Exception
	{
		bufferPool.addNewPage(PAGE_0);
		bufferPool.addNewPage(PAGE_1);
		bufferPool.addNewPage(PAGE_2);
		
		assertEquals(3, bufferPool.countPagesInPool());
	}
}
