package ubadb.external.bufferManagement.traceGenerators;

import java.util.*;

import ubadb.core.common.PageId;
import ubadb.core.common.TransactionId;
import ubadb.external.bufferManagement.etc.PageReferenceTrace;

public class IndexScanTraceGenerator extends PageReferenceTraceGenerator
{
	public PageReferenceTrace generateIndexScanClustered(long transactionNumber, String tableName, int indexHeight, int referenceStart, int referenceCount)
	{
		List<PageId> indexPages = generateSequentialPages(tableName + "_index", 0, indexHeight);
		List<PageId> filePages = generateSequentialPages(tableName, referenceStart, referenceStart+referenceCount);
		
		indexPages.addAll(filePages);
		
		return buildRequestAndRelease(new TransactionId(transactionNumber), indexPages);
	}
	
	/**
	 *	Generates an index scan trace that reads just a single leaf and its pointers (with an unclustered index, this is not always the case as more leaves may be needed)
	 *	@param referenceCount How many pages are accessed from an index pointer
	 *	@param filePageCount  Total pages of the file being accessed by the index 
	 */
	public PageReferenceTrace generateIndexScanUnclusteredForASingleLeaf(long transactionNumber, String tableName, int indexHeight, int referenceCount, int filePageCount)
	{
		List<PageId> indexPages = generateSequentialPages(tableName + "_index", 0, indexHeight);
		List<PageId> filePages = generateRandomPages(tableName, referenceCount, filePageCount);
		
		indexPages.addAll(filePages);
		
		return buildRequestAndRelease(new TransactionId(transactionNumber), indexPages);
	}
    /**
     *	Generates an index scan trace that reads just a single leaf and its pointers (with an unclustered index, this is not always the case as more leaves may be needed)
     *	@param referenceCount How many pages are accessed from an index pointer
     *	@param filePageCount  Total pages of the file being accessed by the index
     */
    public PageReferenceTrace generateMultipleIndexScanUnclusteredForASingleLeaf(long transactionNumber, String tableName, int indexHeight, int referenceCount, int filePageCount, int accessCount)
    {
        List<PageId> indexPages = generateSequentialPages(tableName + "_index", 0, indexHeight);
        List<PageId> filePages;
        List<PageId> completeAcceses= new ArrayList<>();
        Random random = new Random(System.currentTimeMillis());
        for (int i=0;i<accessCount; i++)
        {
            filePages = generateRandomPages(tableName, referenceCount, filePageCount);

            completeAcceses.addAll(indexPages);
            completeAcceses.addAll(filePages);
        }

        return buildRequestAndRelease(new TransactionId(transactionNumber), completeAcceses);
    }


    public PageReferenceTrace generateWeird(long transactionNumber, String smallTableName, int smallTableSize, int smallTableAccesses, String bigTableName, int bigTableSize, int bigTableAccesses)
    {
        List<PageId> smallPages = generateRandomPages(smallTableName, smallTableSize, (int)(smallTableAccesses));
        List<PageId> largePages = generateRandomPages(bigTableName, bigTableSize, (int)(bigTableAccesses));
        List<PageId> filePages;
        List<PageId> completeAcceses= new ArrayList<>();

        Random random = new Random(System.currentTimeMillis());
        int si,li; si=li=0;
        for(int i=0;i<bigTableSize+smallTableSize;i++)
        {
            if(li==bigTableSize)
            {
                for(int j=si;j<smallTableSize;j++)
                {
                    completeAcceses.add(smallPages.get(j));
                }
                break;
            }
            if(si==smallTableSize)
            {
                for(int j=li;j<bigTableSize;j++)
                {
                    completeAcceses.add(largePages.get(j));
                }
                break;
            }
            if(random.nextInt(100)>20)
                completeAcceses.add(largePages.get(li++));
            else
                completeAcceses.add(smallPages.get(si++));
        }



        return buildRequestAndRelease(new TransactionId(transactionNumber), completeAcceses);
    }
}
