package ubadb.external.bufferManagement.traceGenerators;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import ubadb.core.common.PageId;
import ubadb.core.common.TableId;
import ubadb.core.common.TransactionId;
import ubadb.external.bufferManagement.etc.PageReferenceTrace;
import ubadb.external.bufferManagement.etc.PageReferenceType;

public class INLJTraceGenerator  extends PageReferenceTraceGenerator {
	public PageReferenceTrace generateINLJ(long transactionNumber, String tableNameOuter, int pageCountOuter, int tuplasPerPageOuter,
			String tableNameInner, int pageCountInner, int indexSize, int indexHeight, int minReadPagesPerSearch, int maxReadPagesPerSearch)
	{
		PageReferenceTrace ret = new PageReferenceTrace();
		Random random = new Random();
		for(int i=0; i < pageCountOuter; i++)
		{
			List<PageId> outer = generateSequentialPages(tableNameOuter, i, i+1);
			// REQUEST pagina de outer
			ret.concatenate(build(new TransactionId(transactionNumber), outer,PageReferenceType.REQUEST));
			// por cada pagina, se buscan para cada tupla la posicion y la pagina en el inner
			for (int j = 0; j < tuplasPerPageOuter; j++){
				List<PageId> IndexRoot = generateSequentialPages(tableNameInner +"_index", 0, 1);
				List<PageId> SinglePageSearchIndex = generateRandomPages(tableNameInner +"_index",indexHeight-1, indexSize);
				ret.concatenate(buildRequestAndRelease(new TransactionId(transactionNumber), IndexRoot));
				ret.concatenate(buildRequestAndRelease(new TransactionId(transactionNumber), SinglePageSearchIndex));
				
				
				List<PageId> InnerBlock = new ArrayList<>();
				int numPageFound = random.nextInt(maxReadPagesPerSearch - minReadPagesPerSearch) + minReadPagesPerSearch;
						
				for(int k = 0; k < numPageFound; k++){
					InnerBlock.addAll(generateRandomPages(tableNameInner, 1, pageCountInner));
				}
				ret.concatenate(buildRequestAndRelease(new TransactionId(transactionNumber), InnerBlock));
			}
			ret.concatenate(build(new TransactionId(transactionNumber), outer,PageReferenceType.RELEASE));

		}
		return ret;
	}
}
